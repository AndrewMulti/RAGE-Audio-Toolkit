program IVAudioConv;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.Classes, System.JSON, RageAudio, IniFiles,
  Vcl.Forms, Vcl.Dialogs, Utils, IMAADPCM, Bass, BassEnc, BassMix,
  WinApi.Windows, Vcl.Controls, System.IOUtils, BassEnc_mp3;

var
  f, s, quote, fs, s1, tempPath: string;
  audio: TRAGEAudio;
  actAudio, animFile, wave: TMemoryStream;
  temp, tempStates, anim: array of TMemoryStream;
  json: TJSONObject;
  jsonStr: TStringList;
  jArr, jArrAnim: TJSONArray;
  jArrObj: TJSONObject;
  i, j, l, m, b1, b2, wavOffset, FullBSize, Params: integer;
  hashes: TMemIniFile;
  numb, k, size: uint64;
  zero: byte;
  DataSize, TrueSize, AvgBytesPerSec: cardinal;

function ExecAndWait(const FileName, Params: ShortString; const WinState: Word): boolean; export;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: ShortString;
begin
  CmdLine:='"'+Filename+'" '+Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do begin
    cb:=SizeOf(StartInfo);
    dwFlags:=STARTF_USESHOWWINDOW;
    wShowWindow:=WinState;
  end;
  Result:=CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
  if Result then begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;

function GetSysTempPath: string;
const
  BufferSize = 256;
var
  Buffer: PChar;
begin
  Buffer:=AllocMem(BufferSize);
  try
    if GetTempPath(BufferSize, Buffer) <> 0 then
      Result:=Buffer;
  finally
    FreeMem(Buffer, BufferSize);
  end;
end;

function SplitWav(source, dest: string): boolean;
var
  SourceChannel, Split: DWORD;
  Buffer: array [0..10000] of DWORD;
  int: array[0..1] of integer;
  i: integer;
  ci: BASS_CHANNELINFO;
begin
  SourceChannel:=BASS_StreamCreateFile(false, PChar(source), 0, 0, BASS_MUSIC_DECODE {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  BASS_ChannelGetInfo(SourceChannel, &ci);
  BASS_StreamFree(SourceChannel);
  int[1]:=-1;
  for i:=0 to ci.chans-1 do begin
    SourceChannel:=BASS_StreamCreateFile(false, PChar(source), 0, 0, BASS_MUSIC_DECODE {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
    BASS_ChannelGetInfo(SourceChannel, &ci);
    int[0]:=i;
    Split:=BASS_Split_StreamCreate(SourceChannel, BASS_STREAM_DECODE, @int);
    try
      BASS_Encode_Start(Split, PChar(dest+'\'+ChangeFileExt(ExtractFileName(source), '')+'_'+IntToStr(i)+'.wav'), BASS_ENCODE_PCM {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF}, nil, 0);
      BASS_ChannelPlay(SourceChannel, false);
      while BASS_ChannelIsActive(SourceChannel)<>0 do begin
        BASS_ChannelGetData(Split, @Buffer, 10000);
        if BASS_ChannelIsActive(SourceChannel)=0 then Break;
      end;
    finally
      BASS_Encode_Stop(Split);
      BASS_StreamFree(SourceChannel);
      BASS_StreamFree(Split);
    end;
  end;
end;

function Convert2Wav(source, target: string; toMono: boolean): boolean;
var
  SourceChannel, Mixer: DWORD;
  ci: BASS_CHANNELINFO;
  Buffer: array [0..10000] of DWORD;
begin
  SourceChannel:=BASS_StreamCreateFile(false, PChar(source), 0, 0, BASS_MUSIC_DECODE {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  BASS_ChannelGetInfo(SourceChannel, &ci);
  if toMono then
    Mixer:=BASS_Mixer_StreamCreate(ci.freq, 1, BASS_MIXER_END or BASS_STREAM_DECODE)
  else Mixer:=BASS_Mixer_StreamCreate(ci.freq, ci.chans, BASS_MIXER_END or BASS_STREAM_DECODE);
  try
    BASS_Mixer_StreamAddChannel(Mixer, SourceChannel, BASS_MIXER_NORAMPIN);
    BASS_Encode_Start(Mixer, PChar(target), BASS_ENCODE_PCM {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF}, nil, 0);
    BASS_ChannelPlay(SourceChannel, false);
    while BASS_ChannelIsActive(SourceChannel)<>0 do begin
      Application.ProcessMessages;
      BASS_ChannelGetData(Mixer, @Buffer, 10000);
      if BASS_ChannelIsActive(SourceChannel)=0 then Break;
    end;
  finally
    BASS_Encode_Stop(Mixer);
    BASS_StreamFree(SourceChannel);
    BASS_StreamFree(Mixer);
  end;
end;

procedure DoFile(f: string);
begin
  if ExtractFileExt(f)='.oaf' then begin
    WriteLn('Packing ', f, '..');
    ForceDirectories(GetSysTempPath+'RAGEAT\');
    audio:=TRAGEAudio.Create;
    actAudio:=TMemoryStream.Create;
    actAudio.Position:=0;
    jsonStr:=TStringList.Create;
    jsonStr.LoadFromFile(f);
    json:=TJSONObject.Create;
    json.Parse(TEncoding.UTF8.GetBytes(jsonStr.Text), 0);
    if json.Values['isStream'].Value='false' then begin
      audio.headerSize:=28;
      audio.header.audioCount:=StrToInt(json.Values['audioCount'].Value);
      audio.header.animCount:=StrToInt(json.Values['animCount'].Value);
      SetLength(audio.infoTables, audio.header.audioCount);
      jArr:=TJSONArray.Create;
      jArr:=json.Values['entries'] as TJSONArray;
      SetLength(temp, audio.header.audioCount);
      SetLength(tempStates, audio.header.audioCount);
      for i:=0 to audio.header.audioCount-1 do begin
        jArrObj:=jArr.Items[i] as TJSONObject;
        s:=jArrObj.Values['name'].Value;
        if s.StartsWith('0x') then begin
          s:=StringReplace(s, '0x', '$', [rfReplaceAll]);
          audio.infoTables[i].elem.hash:=StrToInt(s);
        end else
          audio.infoTables[i].elem.hash:=GetHash(s);
        audio.infoTables[i].elem.headroom:=StrToInt(jArrObj.Values['headroom'].Value);
        if jArrObj.Values['compression'].Value='PCM' then
          audio.infoTables[i].elem.compression:=PCM
        else if jArrObj.Values['compression'].Value='ADPCM' then
          audio.infoTables[i].elem.compression:=ADPCM
        else if jArrObj.Values['compression'].Value='XMA' then begin
          audio.infoTables[i].elem.compression:=XMA;
          WriteLn('XMA encoding is not supported');
          Exit;
        end else if jArrObj.Values['compression'].Value='Vorbis' then begin
          audio.infoTables[i].elem.compression:=Vorbis;
          //WriteLn('Vorbis encoding is not supported');
          //Exit;
        end;
        fs:=ExtractFilePath(f)+jArrObj.Values['file'].Value;
        temp[i]:=TMemoryStream.Create;
        temp[i].Position:=0;
        if audio.infoTables[i].elem.compression=PCM then begin
          Convert2Wav(fs, GetSysTempPath+'RAGEAT\tempwav.wav', true);
          wave:=TMemoryStream.Create;
          wave.LoadFromFile(GetSysTempPath+'RAGEAT\tempwav.wav');
          wave.Position:=16;
          wave.Read(wavOffset, 4);
          wave.Position:=wave.Position+4;
          wave.Read(audio.infoTables[i].elem.freq, 2);
          wave.Position:=wavOffset+24;
          wave.Read(audio.infoTables[i].elem.size, 4);
          audio.infoTables[i].elem.size2:=audio.infoTables[i].elem.size div 2;
          temp[i].CopyFrom(wave, audio.infoTables[i].elem.size);
          wave.Free;
        end else if audio.infoTables[i].elem.compression=Vorbis then begin
          Convert2Wav(fs, GetSysTempPath+'RAGEAT\tempwav.wav', true);
          ExecAndWait(ExtractFilePath(Application.ExeName)+'data\utils\oggenc2.exe', GetSysTempPath+'RAGEAT\tempwav.wav -o '+GetSysTempPath+'RAGEAT\tempwav.ogg', SW_HIDE);
          wave:=TMemoryStream.Create;
          wave.LoadFromFile(GetSysTempPath+'RAGEAT\tempwav.wav');
          wave.Position:=16;
          wave.Read(wavOffset, 4);
          wave.Position:=wave.Position+4;
          wave.Read(audio.infoTables[i].elem.freq, 2);
          wave.LoadFromFile(GetSysTempPath+'RAGEAT\tempwav.ogg');
          audio.infoTables[i].elem.size:=wave.Size;
          wave.Position:=0;
          audio.infoTables[i].elem.size2:=audio.infoTables[i].elem.size-33;
          temp[i].CopyFrom(wave, audio.infoTables[i].elem.size);
          wave.Free;
        end else if audio.infoTables[i].elem.compression=ADPCM then begin
          Convert2Wav(fs, GetSysTempPath+'RAGEAT\tempwav.wav', true);
          wave:=TMemoryStream.Create;
          wave.LoadFromFile(GetSysTempPath+'RAGEAT\tempwav.wav');
          tempStates[i]:=TMemoryStream.Create;
          wave.Position:=16;
          wave.Read(wavOffset, 4);
          wave.Position:=wave.Position+4;
          wave.Read(audio.infoTables[i].elem.freq, 2);
          wave.Position:=wavOffset+24;
          wave.Read(audio.infoTables[i].elem.size, 4);
          audio.infoTables[i].elem.size2:=audio.infoTables[i].elem.size div 2;
          wave.Position:=wavOffset+28;
          EncodeAudio(wave, temp[i], tempStates[i], audio.infoTables[i].elem.size);
          audio.infoTables[i].elem.size:=temp[i].Size;
          audio.infoTables[i].elem.size2:=audio.infoTables[i].elem.size*2;
          wave.Free;
        end;
      end;
      actAudio.Write(audio.headerSize, 8);
      audio.header.infoOffset:=28;
      for i:=0 to audio.header.audioCount-1 do begin
        Inc(audio.header.infoOffset, 48);
        if audio.infoTables[i].elem.compression=ADPCM then
          Inc(audio.header.infoOffset, 24+tempStates[i].Size)
        else if audio.infoTables[i].elem.compression=Vorbis then
          Inc(audio.header.infoOffset, 56)
      end;
      actAudio.Write(audio.header.infoOffset, 8);
      actAudio.Write(audio.header.audioCount, 4);
      actAudio.Write(audio.header.animCount, 4);
      audio.header.dataOffset:=Mod2048(audio.header.infoOffset);
      if audio.header.animCount>0 then begin
        audio.header.dataOffset:=audio.header.infoOffset;
        Inc(audio.header.dataOffset, 16*audio.header.animCount);
        SetLength(anim, audio.header.animCount);
        SetLength(audio.animTables, audio.header.animCount);
        jArr:=json.Values['animations'] as TJSONArray;
        for i:=0 to audio.header.animCount-1 do begin
          jArrObj:=jArr.Items[i] as TJSONObject;
          s:=jArrObj.Values['name'].Value;
          if s.StartsWith('0x') then begin
            s:=StringReplace(s, '0x', '$', [rfReplaceAll]);
            audio.animTables[i].hash:=StrToInt(s);
          end else
            audio.animTables[i].hash:=GetHash(s);
          anim[i]:=TMemoryStream.Create;
          anim[i].LoadFromFile(ExtractFilePath(f)+jArrObj.Values['file'].Value);
          Inc(audio.header.dataOffset, anim[i].Size);
        end;
        audio.header.dataOffset:=Mod2048(audio.header.dataOffset);
      end;
      actAudio.Write(audio.header.dataOffset, 4);
      k:=0;
      for i:=0 to audio.header.audioCount-1 do begin
        actAudio.Write(k, 8);
        actAudio.Write(audio.infoTables[i].elem.hash, 4);
        audio.infoTables[i].size:=32;
        if audio.infoTables[i].elem.compression=ADPCM then
          Inc(audio.infoTables[i].size, 24+tempStates[i].Size)
        else if audio.infoTables[i].elem.compression=Vorbis then
          Inc(audio.infoTables[i].size, 56);
        actAudio.Write(audio.infoTables[i].size, 4);
        Inc(k, audio.infoTables[i].size);
      end;
      k:=0;
      for i:=0 to audio.header.audioCount-1 do begin
        actAudio.Write(k, 8);
        actAudio.Write(audio.infoTables[i].elem.hash, 4);
        actAudio.Write(audio.infoTables[i].elem.size, 4);
        actAudio.Write(audio.infoTables[i].elem.size2, 4);
        audio.infoTables[i].elem.unk:=-1;
        actAudio.Write(audio.infoTables[i].elem.unk, 4);
        actAudio.Write(audio.infoTables[i].elem.freq, 2);
        actAudio.Write(audio.infoTables[i].elem.headroom, 2);
        actAudio.Write(audio.infoTables[i].elem.compression, 4);
        if audio.infoTables[i].elem.compression=ADPCM then begin
          audio.infoTables[i].elem2.offset:=56;
          actAudio.Write(audio.infoTables[i].elem2.offset, 8);
          actAudio.Write(audio.infoTables[i].elem.size2, 4);
          numb:=318912488914623744;
          actAudio.Write(numb, 8);
          audio.infoTables[i].elem2.numStates:=tempStates[i].Size div 3;
          actAudio.Write(audio.infoTables[i].elem2.numStates, 4);
          tempStates[i].Position:=0;
          actAudio.CopyFrom(tempStates[i], tempStates[i].Size);
        end else if audio.infoTables[i].elem.compression=Vorbis then begin
          audio.infoTables[i].elem2.offset:=56;
          actAudio.Write(audio.infoTables[i].elem2.offset, 8);
          numb:=8975961513010458136;
          actAudio.Write(numb, 8);
          WriteValue(actAudio, 4294967295, 4);
          WriteValue(actAudio, 2, 4);
          WriteValue(actAudio, 0, 4);
          WriteValue(actAudio, 0, 4);
          WriteValue(actAudio, 0, 4);
          WriteValue(actAudio, Round(audio.infoTables[i].elem.size / 1.77), 4);
          WriteValue(actAudio, Round(audio.infoTables[i].elem.size / 1.77), 4);
          WriteValue(actAudio, 0, 4);
          WriteValue(actAudio, audio.infoTables[i].elem.size2, 4);
          WriteValue(actAudio, audio.infoTables[i].elem.size-Round(audio.infoTables[i].elem.size / 1.77), 4);
        end;
        Inc(k, Mod2048(audio.infoTables[i].elem.size));
      end;
      if audio.header.animCount>0 then begin
        k:=0;
        for i:=0 to audio.header.animCount-1 do begin
          actAudio.Write(k, 8);
          actAudio.Write(audio.animTables[i].hash, 4);
          size:=anim[i].Size;
          actAudio.Write(size, 4);
          Inc(k, anim[i].Size);
        end;
        for i:=0 to audio.header.animCount-1 do begin
          anim[i].Position:=0;
          actAudio.CopyFrom(anim[i], anim[i].Size);
        end;
      end;
      actAudio.Position:=audio.header.dataOffset;
      for i:=0 to audio.header.audioCount-1 do begin
        temp[i].Position:=0;
        actAudio.CopyFrom(temp[i], temp[i].Size);
        actAudio.Position:=actAudio.Position+Mod2048(temp[i].Size)-temp[i].Size;
      end;
    end else begin
      audio.waveHeader.channelsCount:=StrToInt(json.Values['channelsCount'].Value);
      fs:=ExtractFilePath(f)+json.Values['file'].Value;
      SplitWav(fs, GetSysTempPath+'RAGEAT\');
      jArr:=TJSONArray.Create;
      jArr:=json.Values['channels'] as TJSONArray;
      SetLength(temp, audio.waveHeader.channelsCount);
      SetLength(audio.blockHeader, audio.waveHeader.channelsCount);
      for i:=0 to audio.waveHeader.channelsCount-1 do begin
        jArrObj:=jArr.Items[i] as TJSONObject;
        s:=jArrObj.Values['name'].Value;
        if s.StartsWith('0x') then begin
          s:=StringReplace(s, '0x', '$', [rfReplaceAll]);
          audio.blockHeader[i].hash:=StrToInt(s);
        end else
          audio.blockHeader[i].hash:=GetHash(s);
        audio.blockHeader[i].channel.headroom:=StrToInt(jArrObj.Values['headroom'].Value);
        if jArrObj.Values['compression'].Value='PCM' then begin
          audio.blockHeader[i].channel.compression:=PCM;
          WriteLn('PCM encoding is not supported, use ADPCM');
          Exit;
        end else if jArrObj.Values['compression'].Value='ADPCM' then
          audio.blockHeader[i].channel.compression:=ADPCM
        else if jArrObj.Values['compression'].Value='XMA' then begin
          audio.blockHeader[i].channel.compression:=XMA;
          WriteLn('XMA encoding is not supported, use ADPCM');
          Exit;
        end else if jArrObj.Values['compression'].Value='Vorbis' then begin
          audio.blockHeader[i].channel.compression:=Vorbis;
          WriteLn('Vorbis encoding is not supported, use ADPCM');
          Exit;
        end;
        if audio.blockHeader[i].channel.compression=ADPCM then
          SetLength(tempStates, audio.waveHeader.channelsCount);
        wave:=TMemoryStream.Create;
        wave.LoadFromFile(GetSysTempPath+'RAGEAT\'+ChangeFileExt(ExtractFileName(fs), '')+'_'+IntToStr(i)+'.wav');
        wave.Position:=16;
        wave.Read(wavOffset, 4);
        wave.Position:=wave.Position+4;
        wave.Read(audio.blockHeader[i].channel.frequency, 2);
        wave.Position:=wavOffset+24;
        wave.Read(audio.blockHeader[i].channel.size, 4);
        temp[i]:=TMemoryStream.Create;
        temp[i].Position:=0;
        if audio.blockHeader[i].channel.compression=ADPCM then begin
          tempStates[i]:=TMemoryStream.Create;
          EncodeAudio(wave, temp[i], tempStates[i], audio.blockHeader[i].channel.size);
        end else
          temp[i].CopyFrom(wave, audio.blockHeader[i].channel.size);
        wave.Free;
      end;
      if json.Values['hasTimestamps'].Value='true' then begin
        jArr:=json.Values['timestamps'] as TJSONArray;
        SetLength(audio.timeStamps.timeStamps, jArr.Count);
        for i:=0 to jArr.Count-1 do begin
          jArrObj:=jArr.Items[i] as TJSONObject;
          audio.timeStamps.timeStamps[i].djHash:=StrToUInt(jArrObj.Values['eventTypeHash'].Value);
          audio.timeStamps.timeStamps[i].parameter:=StrToUInt(jArrObj.Values['parameter'].Value);
          audio.timeStamps.timeStamps[i].flags:=StrToUInt(jArrObj.Values['flags'].Value);
          audio.timeStamps.timeStamps[i].time:=StrToUInt(jArrObj.Values['time'].Value);
        end;
      end;
      audio.headerSize:=48+16*audio.waveHeader.channelsCount+32*audio.waveHeader.channelsCount;
      if audio.blockHeader[0].channel.compression=ADPCM then begin
        Inc(audio.headerSize, 24*audio.waveHeader.channelsCount);
        for i:=0 to audio.waveHeader.channelsCount-1 do
          Inc(audio.headerSize, tempStates[i].Size);
      end;
      audio.waveHeader.blInfoOffset:=audio.headerSize;
      if Length(audio.timeStamps.timeStamps)>0 then
        Inc(audio.headerSize, 24+Length(audio.timeStamps.timeStamps)*16);
      actAudio.Write(audio.headerSize, 8);
      audio.waveHeader.blockSize:=509952;
      if audio.waveHeader.channelsCount>4 then
        FullBSize:=1003520
      else FullBSize:=1007616;
      audio.waveHeader.blocksCount:=temp[0].Size div ((FullBSize div audio.waveHeader.channelsCount) div 2)+1;
      actAudio.Write(audio.waveHeader.blocksCount, 4);
      actAudio.Write(audio.waveHeader.blockSize, 4);
      audio.waveHeader.unk:=0;
      actAudio.Write(audio.waveHeader.unk, 4);
      audio.waveHeader.chInfoOffset:=48;
      actAudio.Write(audio.waveHeader.chInfoOffset, 8);
      actAudio.Write(audio.waveHeader.blInfoOffset, 8);
      actAudio.Write(audio.waveHeader.channelsCount, 4);
      if Length(audio.timeStamps.timeStamps)>0 then
        WriteValue(actAudio, 1, 4)
      else WriteValue(actAudio, 0, 4);
      audio.waveHeader.dataOffset:=Mod2048(audio.headerSize+8*audio.waveHeader.blocksCount);
      actAudio.Write(audio.waveHeader.dataOffset, 4);
      k:=0;
      for i:=0 to audio.waveHeader.channelsCount-1 do begin
        actAudio.Write(k, 8);
        actAudio.Write(audio.blockHeader[i].hash, 4);
        if audio.blockHeader[i].channel.compression=ADPCM then
          audio.blockHeader[i].size:=56+tempStates[i].Size
        else audio.blockHeader[i].size:=32;
        actAudio.Write(audio.blockHeader[i].size, 4);
        Inc(k, audio.blockHeader[i].size);
      end;
      for i:=0 to audio.waveHeader.channelsCount-1 do begin
        audio.blockHeader[i].channel._unk1:=0;
        actAudio.Write(audio.blockHeader[i].channel._unk1, 8);
        actAudio.Write(audio.blockHeader[i].hash, 4);
        audio.blockHeader[i].channel.size:=temp[i].Size;
        actAudio.Write(audio.blockHeader[i].channel.size, 4);
        audio.blockHeader[i].channel.length:=audio.blockHeader[i].channel.size*2;
        actAudio.Write(audio.blockHeader[i].channel.length, 4);
        audio.blockHeader[i].channel.iUnknown:=-1;
        actAudio.Write(audio.blockHeader[i].channel.iUnknown, 4);
        actAudio.Write(audio.blockHeader[i].channel.frequency, 2);
        actAudio.Write(audio.blockHeader[i].channel.headroom, 2);
        actAudio.Write(audio.blockHeader[i].channel.compression, 4);
        if audio.blockHeader[i].channel.compression=ADPCM then begin
          audio.blockHeader[i].channel.offsetStates:=56;
          actAudio.Write(audio.blockHeader[i].channel.offsetStates, 8);
          audio.blockHeader[i].channel.samples:=audio.blockHeader[i].channel.length;
          actAudio.Write(audio.blockHeader[i].channel.samples, 4);
          audio.blockHeader[i].channel._unk2:=1945273839196904712;
          actAudio.Write(audio.blockHeader[i].channel._unk2, 8);
          audio.blockHeader[i].channel.statesCount:=tempStates[i].Size div 3;
          actAudio.Write(audio.blockHeader[i].channel.statesCount, 4);
          tempStates[i].Position:=0;
          actAudio.CopyFrom(tempStates[i], tempStates[i].Size);
        end;
      end;
      if Length(audio.timeStamps.timeStamps)>0 then begin
        audio.timeStamps.offset:=0;
        audio.timeStamps.hash:=audio.blockHeader[0].hash;
        audio.timeStamps.size:=8+16*Length(audio.timeStamps.timeStamps);
        audio.timeStamps.hash2:=2112813239;
        audio.timeStamps.size2:=16*Length(audio.timeStamps.timeStamps);
        actAudio.Write(audio.timeStamps.offset, 8);
        actAudio.Write(audio.timeStamps.hash, 4);
        actAudio.Write(audio.timeStamps.size, 4);
        actAudio.Write(audio.timeStamps.hash2, 4);
        actAudio.Write(audio.timeStamps.size2, 4);
        for i:=0 to Length(audio.timeStamps.timeStamps)-1 do begin
          if i=Length(audio.timeStamps.timeStamps)-1 then begin
            actAudio.Write(audio.timeStamps.timeStamps[i].parameter, 4);
            actAudio.Write(audio.timeStamps.timeStamps[i].unkFloat, 4);
            actAudio.Write(audio.timeStamps.timeStamps[i].flags, 4);
            actAudio.Write(audio.timeStamps.timeStamps[i].time, 4);
          end else begin
            actAudio.Write(audio.timeStamps.timeStamps[i].djHash, 4);
            actAudio.Write(audio.timeStamps.timeStamps[i].parameter, 4);
            actAudio.Write(audio.timeStamps.timeStamps[i].flags, 4);
            actAudio.Write(audio.timeStamps.timeStamps[i].time, 4);
          end;
        end;
      end;
      SetLength(audio.blocks, audio.waveHeader.blocksCount);
      k:=0;
      for i:=0 to audio.waveHeader.blocksCount-1 do begin
        audio.blocks[i].offset:=k;
        actAudio.Write(audio.blocks[i].offset, 4);
        audio.blocks[i].frequency:=audio.blockHeader[0].channel.frequency;
        actAudio.Write(audio.blocks[i].frequency, 4);
        Inc(k, FullBSize div audio.waveHeader.channelsCount);
      end;
      wavOffset:=actAudio.Position;
      zero:=0;
      for i:=audio.waveHeader.dataOffset downto wavOffset+1 do
        actAudio.Write(zero, 1);
      for i:=0 to audio.waveHeader.channelsCount-1 do
        temp[i].Position:=0;
      m:=0;
      for i:=0 to audio.waveHeader.blocksCount-1 do begin
        if i=audio.waveHeader.blocksCount-1 then begin
          numb:=actAudio.Position;
          audio.blocks[i].headerOffset:=24;
          actAudio.Write(audio.blocks[i].headerOffset, 8);
          audio.blocks[i].offsetsOffset:=24+16*audio.waveHeader.channelsCount;
          actAudio.Write(audio.blocks[i].offsetsOffset, 8);
          actAudio.Write(audio.blocks[i].offsetsOffset, 8);
          SetLength(audio.blocks[i].blockChannel, audio.waveHeader.channelsCount);
          k:=0;
          for j:=0 to audio.waveHeader.channelsCount-1 do begin
            audio.blocks[i].blockChannel[j].offset:=k;
            actAudio.Write(audio.blocks[i].blockChannel[j].offset, 4);
            audio.blocks[i].blockChannel[j].size:=temp[j].Size*audio.waveHeader.channelsCount mod (FullBSize div audio.waveHeader.channelsCount) div 4096;
            actAudio.Write(audio.blocks[i].blockChannel[j].size, 4);
            WriteValue(actAudio, 0, 4);
            audio.blocks[i].blockChannel[j].samples:=temp[j].Size*audio.waveHeader.channelsCount mod (FullBSize div audio.waveHeader.channelsCount);
            actAudio.Write(audio.blocks[i].blockChannel[j].samples, 4);
            Inc(k, audio.blocks[i].blockChannel[j].size);
          end;
          for j:=0 to audio.waveHeader.channelsCount-1 do begin
            SetLength(audio.blocks[i].blockChannel[j].offsetsBytes, audio.blocks[i].blockChannel[j].size);
            k:=m;
            for l:=0 to audio.blocks[i].blockChannel[j].size-1 do begin
              audio.blocks[i].blockChannel[j].offsetsBytes[l].beginO:=k;
              actAudio.Write(audio.blocks[i].blockChannel[j].offsetsBytes[l].beginO, 4);
              Inc(k, 4095);
              audio.blocks[i].blockChannel[j].offsetsBytes[l].endO:=k;
              actAudio.Write(audio.blocks[i].blockChannel[j].offsetsBytes[l].endO, 4);
              Inc(k);
            end;
          end;
          m:=k;
          k:=Mod2048(actAudio.Position);
          for j:=0 to k-actAudio.Position-1 do
            actAudio.Write(zero, 1);
          for j:=0 to audio.waveHeader.channelsCount-1 do begin
            actAudio.CopyFrom(temp[j], temp[j].Size-temp[j].Position);
          end;
          k:=numb+audio.waveHeader.blockSize;
          for j:=0 to k-actAudio.Position-1 do
            actAudio.Write(zero, 1);
        end else begin
          audio.blocks[i].headerOffset:=24;
          actAudio.Write(audio.blocks[i].headerOffset, 8);
          audio.blocks[i].offsetsOffset:=24+16*audio.waveHeader.channelsCount;
          actAudio.Write(audio.blocks[i].offsetsOffset, 8);
          actAudio.Write(audio.blocks[i].offsetsOffset, 8);
          SetLength(audio.blocks[i].blockChannel, audio.waveHeader.channelsCount);
          k:=0;
          for j:=0 to audio.waveHeader.channelsCount-1 do begin
            audio.blocks[i].blockChannel[j].offset:=k;
            actAudio.Write(audio.blocks[i].blockChannel[j].offset, 4);
            audio.blocks[i].blockChannel[j].size:=FullBSize div audio.waveHeader.channelsCount div 4096;
            actAudio.Write(audio.blocks[i].blockChannel[j].size, 4);
            WriteValue(actAudio, 0, 4);
            audio.blocks[i].blockChannel[j].samples:=FullBSize div audio.waveHeader.channelsCount;
            actAudio.Write(audio.blocks[i].blockChannel[j].samples, 4);
            Inc(k, audio.blocks[i].blockChannel[j].size);
          end;
          for j:=0 to audio.waveHeader.channelsCount-1 do begin
            SetLength(audio.blocks[i].blockChannel[j].offsetsBytes, audio.blocks[i].blockChannel[j].size);
            k:=m;
            for l:=0 to audio.blocks[i].blockChannel[j].size-1 do begin
              audio.blocks[i].blockChannel[j].offsetsBytes[l].beginO:=k;
              actAudio.Write(audio.blocks[i].blockChannel[j].offsetsBytes[l].beginO, 4);
              Inc(k, 4095);
              audio.blocks[i].blockChannel[j].offsetsBytes[l].endO:=k;
              actAudio.Write(audio.blocks[i].blockChannel[j].offsetsBytes[l].endO, 4);
              Inc(k);
            end;
          end;
          m:=k;
          k:=Mod2048(actAudio.Position);
          for j:=0 to k-actAudio.Position-1 do
            actAudio.Write(zero, 1);
          for j:=0 to audio.waveHeader.channelsCount-1 do begin
            actAudio.CopyFrom(temp[j], audio.blocks[i].blockChannel[j].size*2048);
          end;
          for j:=0 to 4095 do
            actAudio.Write(zero, 1);
        end;
      end;
    end;
    actAudio.SaveToFile(ChangeFileExt(f, ''));
    TDirectory.Delete(GetSysTempPath+'RAGEAT', true);
  end else if ExtractFileExt(f)='' then begin    // TO OAF bank
    WriteLn('Extracting ', f, '...');
    audio:=TRAGEAudio.Create;
    actAudio:=TMemoryStream.Create;
    actAudio.LoadFromFile(f);
    audio.Load(actAudio, 0);
    json:=TJSONObject.Create;
    if audio.headerSize=28 then begin
      json.AddPair('isStream', TJSONBool.Create(false));
      if audio.swap then
        json.AddPair('platform', 'Console')
      else json.AddPair('platform', 'PC');
      json.AddPair('audioCount', TJSONNumber.Create(audio.header.audioCount));
      json.AddPair('animCount', TJSONNumber.Create(audio.header.animCount));
      jArr:=TJSONArray.Create;
      ForceDirectories(f+'_files');
      for i:=0 to audio.header.audioCount-1 do begin
        if audio.infoTables[i].elem.compression=Vorbis then
          audio.ExportAudio(actAudio, i, f+'_files\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.ogg')
        else if audio.infoTables[i].elem.compression=MP3 then
          audio.ExportAudio(actAudio, i, f+'_files\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.mp3')
        else if audio.infoTables[i].elem.compression=XMA then begin
          audio.ExportAudio(actAudio, i, tempPath+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.xma');
          ExecAndWait(ExtractFilePath(Application.ExeName)+'data\utils\towav.exe', '"'+tempPath+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.xma"', SW_HIDE);
          MoveFile(PWideChar(ExtractFilePath(Application.ExeName)+'data\utils\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.wav'), PWideChar(f+'_files\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.wav'));
        end else audio.ExportAudio(actAudio, i, f+'_files\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.wav');
        jArr.AddElement(TJSONObject.Create);
        jArrObj:=jArr.Items[pred(jArr.Count)] as TJSONObject;
        jArrObj.AddPair('name', hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash)));
        if audio.infoTables[i].elem.compression=Vorbis then
          jArrObj.AddPair('file', ExtractFileName(f)+'_files\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.ogg')
        else if audio.infoTables[i].elem.compression=MP3 then
          jArrObj.AddPair('file', ExtractFileName(f)+'_files\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.mp3')
        else jArrObj.AddPair('file', ExtractFileName(f)+'_files\'+hashes.ReadString('hashes', IntToStr(audio.infoTables[i].hash), '0x'+IntToHex(audio.infoTables[i].hash))+'.wav');
        case audio.infoTables[i].elem.compression of
          PCM: jArrObj.AddPair('compression', 'PCM');
          ADPCM: jArrObj.AddPair('compression', 'ADPCM');
          XMA: jArrObj.AddPair('compression', 'XMA');
          Vorbis: jArrObj.AddPair('compression', 'Vorbis');
          MP3: jArrObj.AddPair('compression', 'MP3');
        end;
        jArrObj.AddPair('headroom', TJSONNumber.Create(audio.infoTables[i].elem.headroom));
      end;
      json.AddPair('entries', jArr);
      if audio.header.animCount>0 then begin
        jArrAnim:=TJSONArray.Create;
        for i:=0 to audio.header.animCount-1 do begin
          animFile:=TMemoryStream.Create;
          actAudio.Position:=audio.header.infoOffset+16*audio.header.animCount+audio.animTables[i].offset;
          animFile.CopyFrom(actAudio, audio.animTables[i].size);
          animFile.SaveToFile(f+'_files\'+hashes.ReadString('hashes', IntToStr(audio.animTables[i].hash), '0x'+IntToHex(audio.animTables[i].hash))+'.anim');
          jArrAnim.AddElement(TJSONObject.Create);
          jArrObj:=jArrAnim.Items[pred(jArrAnim.Count)] as TJSONObject;
          jArrObj.AddPair('name', hashes.ReadString('hashes', IntToStr(audio.animTables[i].hash), '0x'+IntToHex(audio.animTables[i].hash)));
          jArrObj.AddPair('file', ExtractFileName(f)+'_files\'+hashes.ReadString('hashes', IntToStr(audio.animTables[i].hash), '0x'+IntToHex(audio.animTables[i].hash))+'.anim');
        end;
        json.AddPair('animations', jArrAnim);
      end;
      audio.Free;
      actAudio.Free;
    end else begin  // to oaf stream
      json.AddPair('isStream', TJSONBool.Create(true));
      if audio.swap then
        json.AddPair('platform', 'Console')
      else json.AddPair('platform', 'PC');
      json.AddPair('channelsCount', TJSONNumber.Create(audio.waveHeader.channelsCount));
      if audio.waveHeader.timeStCount>0 then
        json.AddPair('hasTimestamps', TJSONBool.Create(true))
      else json.AddPair('hasTimestamps', TJSONBool.Create(false));
      json.AddPair('file', ExtractFileName(f)+'.wav');
      if audio.blockHeader[0].channel.compression=MP3 then begin
        audio.ExportAudio(actAudio, 0, tempPath);
        SetLength(temp, audio.waveHeader.channelsCount);
        for i:=0 to audio.waveHeader.channelsCount-1 do begin
          Convert2Wav(tempPath+'temp_'+IntToStr(i)+'.mp3', tempPath+'temp_'+IntToStr(i)+'.wav', true);
          temp[i]:=TMemoryStream.Create;
          temp[i].LoadFromFile(tempPath+'temp_'+IntToStr(i)+'.wav');
        end;
        wave:=TMemoryStream.Create;
        wave.Position:=0;
        WriteArrayUInt(wave, [$46464952]);
        TrueSize:=(audio.blockHeader[0].channel.size*16*audio.waveHeader.channelsCount) div 2;
        DataSize:=TrueSize+36;
        wave.Write(DataSize, 4);
        WriteArrayUInt(wave, [$45564157, $20746D66, 16]);
        WriteValue(wave, 1, 2);
        wave.Write(audio.waveHeader.channelsCount, 2);
        wave.Write(audio.blockHeader[0].channel.frequency, 2);
        wave.Write(zero, 2);
        AvgBytesPerSec:=2*audio.waveHeader.channelsCount*audio.blockHeader[0].channel.frequency;
        wave.Write(AvgBytesPerSec, 4);
        WriteValue(wave, 2, 2);
        WriteValue(wave, 16, 2);
        WriteArrayUInt(wave, [$61746164]);
        wave.Write(TrueSize, 4);
        for i:=0 to temp[1].Size div 2-2 do
          for j:=0 to audio.waveHeader.channelsCount-1 do
            wave.CopyFrom(temp[j], 2);
        wave.SaveToFile(f+'.wav');
        wave.Free;
        for i:=0 to audio.waveHeader.channelsCount-1 do
          temp[i].Free;
      end else
        audio.ExportAudio(actAudio, 0, f+'.wav');
      jArr:=TJSONArray.Create;
      for i:=0 to audio.waveHeader.channelsCount-1 do begin
        jArr.AddElement(TJSONObject.Create);
        jArrObj:=jArr.Items[pred(jArr.Count)] as TJSONObject;
        jArrObj.AddPair('name', hashes.ReadString('hashes', IntToStr(audio.blockHeader[i].hash), '0x'+IntToHex(audio.blockHeader[i].hash)));
        case audio.blockHeader[i].channel.compression of
          PCM: jArrObj.AddPair('compression', 'PCM');
          ADPCM: jArrObj.AddPair('compression', 'ADPCM');
          XMA: jArrObj.AddPair('compression', 'XMA');
          Vorbis: jArrObj.AddPair('compression', 'Vorbis');
          MP3: jArrObj.AddPair('compression', 'MP3');
        end;
        jArrObj.AddPair('headroom', TJSONNumber.Create(audio.blockHeader[i].channel.headroom));
      end;
      json.AddPair('channels', jArr);
      if audio.waveHeader.timeStCount>0 then begin
        jArrAnim:=TJSONArray.Create;
        for i:=0 to Length(audio.timeStamps.timeStamps)-1 do begin
          jArrAnim.AddElement(TJSONObject.Create);
          jArrObj:=jArrAnim.Items[pred(jArrAnim.Count)] as TJSONObject;
          jArrObj.AddPair('eventTypeHash', TJSONNumber.Create(audio.timeStamps.timeStamps[i].djHash));
          jArrObj.AddPair('parameter', TJSONNumber.Create(audio.timeStamps.timeStamps[i].parameter));
          jArrObj.AddPair('flags', TJSONNumber.Create(audio.timeStamps.timeStamps[i].flags));
          jArrObj.AddPair('time', TJSONNumber.Create(audio.timeStamps.timeStamps[i].time));
        end;
        json.AddPair('timestamps', jArrAnim);
      end;
      audio.Free;
      actAudio.Free;
    end;
    jsonStr:=TStringList.Create;
    jsonStr.Text:=json.Format;
    jsonStr.SaveToFile(f+'.oaf');
    TDirectory.Delete(GetSysTempPath+'RAGEAT', true);
  end;
end;

begin
  WriteLn(' GTA IV Audio Editor v1.0');
  WriteLn('part of RAGE Audio Toolkit');
  WriteLn('--------------------------');
  WriteLn;
  if (HIWORD(BASS_GetVersion)<>BASSVERSION) then begin
    WriteLn('Bass.dll has incorrect version');
    Halt;
  end;
  if not BASS_Init(-1, 44100, 0, Application.Handle, nil) then begin
    WriteLn('Audio initialization error');
    Halt;
  end;
  ForceDirectories(GetSysTempPath+'RAGEAT\');
  tempPath:=GetSysTempPath+'RAGEAT\';
  hashes:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+'data\iv_eflc.ini');
  if ParamCount=0 then begin
    WriteLn('Commandline examples:');
    WriteLn(ExtractFileName(Application.ExeName), ' STARTING_TUNE');
    WriteLn(ExtractFileName(Application.ExeName), ' LOADING_TUNE.oaf');
    WriteLn(ExtractFileName(Application.ExeName), ' LOADING_TUNE.oaf STARTING_TUNE');
    WriteLn('or drag''n''drop files on exe file');
  end else
    for Params:=1 to ParamCount do begin
      f:=ParamStr(Params);
      DoFile(f);
    end;
  //DoFile('C:\Users\User\Desktop\Новая папка (2)\ps3\libertycity');
end.
