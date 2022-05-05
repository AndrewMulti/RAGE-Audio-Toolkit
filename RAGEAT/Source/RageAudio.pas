unit RageAudio;

interface

uses
  System.SysUtils, IMAADPCM, System.Classes, Vcl.Dialogs, Utils, Vcl.Forms;

type
  TRAGEAudioCompression = (XMA = 0, PCM = 1, MP3 = 256, Vorbis = 512, ADPCM = 1024);

  TRAGEBankElementEx = record
    offset: int64;
    numSamples: cardinal;
    wFA: int64;
    numStates: integer;
    states: array of TADPCMState;
  end;

  TRAGEBankElement = record
    offset: int64;
    hash: cardinal;
    size: cardinal;
    size2: cardinal;
    unk: integer;
    freq: word;
    headroom: smallint;
    compression: TRAGEAudioCompression;
  end;

  TRAGEAnimTable = record
    offset: int64;
    hash: cardinal;
    size: cardinal;
    f0: cardinal;
    size2: cardinal;
    //anim struct
  end;

  TRAGEInfoTable = record
    offset: int64;
    hash: cardinal;
    size: cardinal;
    elem: TRAGEBankElement;
    elem2: TRAGEBankElementEx;
  end;

  TRAGEHeader = record
    infoOffset: int64;
    audioCount: cardinal;
    animCount: cardinal;
    dataOffset: cardinal;
  end;

  TRAGEWAVEChannel = record
    _unk1: int64;
    hash: cardinal;
    size: cardinal;
    length: cardinal;
    iUnknown: integer;
    frequency: word;
    headroom: smallint;
    compression: TRAGEAudioCompression;
    offsetStates: int64;
    samples: cardinal;
    _unk2: uint64;
    statesCount: cardinal;
    states: array of TADPCMState;
  end;

  TRAGEWAVETimeStamp = record
    djHash: cardinal;
    parameter: cardinal;
    flags: cardinal;
    time: cardinal;
    unkFloat: single;
  end;

  TRAGEWAVETimeStamps = record
    offset: int64;
    hash: cardinal;
    size: cardinal;
    hash2: cardinal;
    size2: cardinal;
    timeStamps: array of TRAGEWAVETimeStamp;
  end;

  TRAGEWAVEBlockHeader = record
    offset: int64;
    hash: cardinal;
    size: cardinal;
    channel: TRAGEWAVEChannel;
  end;

  TRAGEWAVEHeader = record
    blocksCount: cardinal;
    blockSize: cardinal;
    unk: cardinal;
    chInfoOffset: int64;
    blInfoOffset: int64;
    channelsCount: cardinal;
    timeStCount: cardinal;
    dataOffset: cardinal;
  end;

  TRAGEWAVEBlockChannelOffsets = record
    beginO: cardinal;
    endO: cardinal;
  end;

  TRAGEWAVEBlockChannel = record
    offset: cardinal;
    size: cardinal;
    samples: cardinal;
    size2: cardinal;
    samples2: cardinal;
    offsetsBytes: array of TRAGEWAVEBlockChannelOffsets;
  end;

  TRAGEWAVEBlock = record
    offset: cardinal;
    frequency: cardinal;
    headerOffset: uint64;
    offsetsOffset: uint64;
    blockChannel: array of TRAGEWAVEBlockChannel;
  end;

  TRAGEAudio = class
    headerSize: uint64;
    header: TRAGEHeader;
    infoTables: array of TRAGEInfoTable;
    animTables: array of TRAGEAnimTable;
    waveHeader: TRAGEWAVEHeader;
    blockHeader: array of TRAGEWAVEBlockHeader;
    timeStamps: TRAGEWAVETimeStamps;
    blocks: array of TRAGEWAVEBlock;
    swap: boolean;
  public
    procedure Load(f: TMemoryStream; startHeader: cardinal);
    procedure ExportAudio(actAudio: TMemoryStream; ind: integer; s: string);
  end;

implementation

procedure TRAGEAudio.ExportAudio(actAudio: TMemoryStream; ind: integer; s: string);
var
  f: TMemoryStream;
  DataSize, TrueSize, AvgBytesPerSec, blkHS, i, j, k, freq: cardinal;
  one, BlockAlign, BitsPSample, zero: word;
  Odata: byte;
  NData: smallint;
  oldStates: array of TADPCMState;
  temp, tempPCM: array of TMemoryStream;
begin
  if headerSize=28 then begin
    f:=TMemoryStream.Create;
    if infoTables[ind].elem.compression=PCM then begin
      zero:=$00;
      one:=1;
      BlockAlign:=2;
      BitsPSample:=16;
      f.Position:=0;
      WriteArrayUInt(f, [$46464952]);
      TrueSize:=infoTables[ind].elem.size*4;
      DataSize:=TrueSize+36;
      f.Write(DataSize, 4);
      WriteArrayUInt(f, [$45564157, $20746D66, 16]);
      f.Write(one, 2);
      f.Write(one, 2);
      f.Write(infoTables[ind].elem.freq, 2);
      f.Write(zero, 2);
      f.Write(infoTables[ind].elem.freq, 2);
      f.Write(zero, 2);
      f.Write(BlockAlign, 2);
      f.Write(BitsPSample, 2);
      WriteArrayUInt(f, [$61746164]);
      f.Write(TrueSize, 4);
      actAudio.Position:=header.dataOffset+infoTables[ind].elem.offset;
      f.CopyFrom(actAudio, infoTables[ind].elem.size);
    end else if infoTables[ind].elem.compression=ADPCM then begin
      zero:=$0000;
      one:=1;
      BlockAlign:=2;
      BitsPSample:=16;
      f.Position:=0;
      WriteArrayUInt(f, [$46464952]);
      TrueSize:=infoTables[ind].elem.size*4;
      DataSize:=TrueSize+36;
      f.Write(DataSize, 4);
      WriteArrayUInt(f, [$45564157, $20746D66, 16]);
      f.Write(one, 2);
      f.Write(one, 2);
      f.Write(infoTables[ind].elem.freq, 2);
      f.Write(zero, 2);
      f.Write(zero, 2);
      f.Write(infoTables[ind].elem.freq, 2);
      f.Write(BlockAlign, 2);
      f.Write(BitsPSample, 2);
      WriteArrayUInt(f, [$61746164]);
      f.Write(TrueSize, 4);
      actAudio.Position:=header.dataOffset+infoTables[ind].elem.offset;
      SetLength(oldStates, infoTables[ind].elem2.numStates);
      for i:=0 to infoTables[ind].elem2.numStates-1 do begin
        oldStates[i]:=TADPCMState.Create;
        oldStates[i].valprev:=infoTables[ind].elem2.states[i].valprev;
        oldStates[i].index:=infoTables[ind].elem2.states[i].index;
      end;
      for i:=0 to infoTables[ind].elem2.numStates-1 do begin
        for j:=0 to 2047 do begin
          actAudio.Read(Odata, 1);
          Ndata:=DecodeADPCM((Odata and $F), infoTables[ind].elem2.states[i]);
          f.Write(Ndata, 2);
          Ndata:=DecodeADPCM(((Odata shr 4) and $F), infoTables[ind].elem2.states[i]);
          f.Write(Ndata, 2);
        end;
      end;
      for i:=0 to infoTables[ind].elem2.numStates-1 do begin
        infoTables[ind].elem2.states[i].valprev:=oldStates[i].valprev;
        infoTables[ind].elem2.states[i].index:=oldStates[i].index;
      end;
      for i:=0 to infoTables[ind].elem2.numStates-1 do oldStates[i].Free;
    end else if infoTables[ind].elem.compression=XMA then begin
      f.Position:=0;
      WriteValue(f, 1179011410, 4);
      WriteValue(f, 2082848, 4);
      WriteValue(f, 1163280727, 4);
      WriteValue(f, 544501094, 4);
      WriteValue(f, 32, 4);
      WriteValue(f, 1048933, 4);
      WriteValue(f, 4310, 4);
      WriteValue(f, 33554433, 4);
      WriteValue(f, 9614, 4);
      freq:=infoTables[ind].elem.freq;
      WriteValue(f, freq, 4);
      WriteValue(f, 0, 4);
      WriteValue(f, 0, 4);
      WriteValue(f, 65792, 4);
      WriteValue(f, 1635017060, 4);
      WriteValue(f, 2078720, 4);
      actAudio.Position:=header.dataOffset+infoTables[ind].elem.offset;
      f.CopyFrom(actAudio, infoTables[ind].elem.size);
    end else begin
      f.Position:=0;
      actAudio.Position:=header.dataOffset+infoTables[ind].elem.offset;
      f.CopyFrom(actAudio, infoTables[ind].elem.size);
    end;
    f.SaveToFile(s);
    f.Free;
  end else begin
    f:=TMemoryStream.Create;
    f.Position:=0;
    zero:=$0000;
    one:=1;
    BlockAlign:=2;
    BitsPSample:=16;
    if blockHeader[0].channel.compression=XMA then begin
      f.Position:=0;
      WriteValue(f, 1179011410, 4);
      WriteValue(f, 2082848, 4);
      WriteValue(f, 1163280727, 4);
      WriteValue(f, 544501094, 4);
      WriteValue(f, 32, 4);
      WriteValue(f, 1048933, 4);
      WriteValue(f, 4310, 4);
      WriteValue(f, 33554433, 4);
      WriteValue(f, 9614, 4);
      freq:=blockHeader[0].channel.frequency;
      WriteValue(f, freq, 4);
      WriteValue(f, 0, 4);
      WriteValue(f, 0, 4);
      WriteValue(f, 65792, 4);
      WriteValue(f, 1635017060, 4);
      WriteValue(f, 2078720, 4);
    end else if not (blockHeader[0].channel.compression=MP3) then begin
      WriteArrayUInt(f, [$46464952]);
      if blockHeader[0].channel.compression=ADPCM then
        TrueSize:=blockHeader[0].channel.size*4*waveHeader.channelsCount
      else TrueSize:=(blockHeader[0].channel.size*4*waveHeader.channelsCount) div 2;
      DataSize:=TrueSize+36;
      f.Write(DataSize, 4);
      WriteArrayUInt(f, [$45564157, $20746D66, 16]);
      one:=1;
      f.Write(one, 2);
      f.Write(waveHeader.channelsCount, 2);
      f.Write(blockHeader[0].channel.frequency, 2);
      f.Write(zero, 2);
      AvgBytesPerSec:=2*waveHeader.channelsCount*blockHeader[0].channel.frequency;
      f.Write(AvgBytesPerSec, 4);
      f.Write(BlockAlign, 2);
      f.Write(BitsPSample, 2);
      WriteArrayUInt(f, [$61746164]);
      f.Write(TrueSize, 4);
    end;
    SetLength(temp, waveHeader.channelsCount);
    SetLength(tempPCM, waveHeader.channelsCount);
    for i:=0 to waveHeader.channelsCount-1 do begin
      temp[i]:=TMemoryStream.Create;
      temp[i].Position:=0;
      tempPCM[i]:=TMemoryStream.Create;
      tempPCM[i].Position:=0;
    end;
    for i:=0 to waveHeader.blocksCount-2 do begin
      for j:=0 to waveHeader.channelsCount-1 do begin
        if waveHeader.channelsCount>3 then begin
          if blockHeader[j].channel.compression=ADPCM then begin
            actAudio.Position:=waveHeader.dataOffset+waveHeader.blockSize*i+4096+blocks[i].blockChannel[j].offset*2048;
            temp[j].CopyFrom(actAudio, blocks[i].blockChannel[j].size*2048);
          end else if blockHeader[j].channel.compression=PCM then begin
            actAudio.Position:=waveHeader.dataOffset+waveHeader.blockSize*i+4096+blocks[i].blockChannel[j].offset*1024;
            temp[j].CopyFrom(actAudio, blocks[i].blockChannel[j].size*1024);
          end
        end else begin
          if blockHeader[j].channel.compression=ADPCM then begin
            actAudio.Position:=waveHeader.dataOffset+waveHeader.blockSize*i+2048+blocks[i].blockChannel[j].offset*2048;
            temp[j].CopyFrom(actAudio, blocks[i].blockChannel[j].size*2048);
          end else if blockHeader[j].channel.compression=PCM then begin
            if waveHeader.channelsCount=2 then
              Dec(blocks[i].blockChannel[0].size);
            actAudio.Position:=waveHeader.dataOffset+waveHeader.blockSize*i+2048+blocks[i].blockChannel[j].offset*2048;
            temp[j].CopyFrom(actAudio, blocks[i].blockChannel[j].samples2);
          end else if blockHeader[j].channel.compression=MP3 then begin
            actAudio.Position:=waveHeader.dataOffset+waveHeader.blockSize*i+2048+blocks[i].blockChannel[j].offset*2048;
            temp[j].CopyFrom(actAudio, blocks[i].blockChannel[j].size*2048);
          end else if blockHeader[j].channel.compression=XMA then begin
            if j=0 then begin
              actAudio.Position:=waveHeader.dataOffset+waveHeader.blockSize*i+2048+blocks[i].blockChannel[j].offset div 2;
              temp[0].CopyFrom(actAudio, blocks[i].blockChannel[j].size*2048);
            end;
          end;
        end;
      end;
    end;
    for i:=0 to waveHeader.channelsCount-1 do
      temp[i].Position:=0;
    if blockHeader[0].channel.compression=ADPCM then begin
      for i:=0 to waveHeader.channelsCount-1 do begin
        SetLength(oldStates, blockHeader[i].channel.statesCount);
        for j:=0 to blockHeader[i].channel.statesCount-1 do begin
          oldStates[j]:=TADPCMState.Create;
          oldStates[j].valprev:=blockHeader[i].channel.states[j].valprev;
          oldStates[j].index:=blockHeader[i].channel.states[j].index;
        end;
        for j:=0 to blockHeader[i].channel.statesCount-1 do begin
          for k:=0 to 2047 do begin
            temp[i].Read(Odata, 1);
            Ndata:=DecodeADPCM((Odata and $F), blockHeader[i].channel.states[j]);
            tempPCM[i].Write(Ndata, 2);
            Ndata:=DecodeADPCM(((Odata shr 4) and $F), blockHeader[i].channel.states[j]);
            tempPCM[i].Write(Ndata, 2);
          end;
        end;
        for j:=0 to blockHeader[i].channel.statesCount-1 do begin
          blockHeader[i].channel.states[j].valprev:=oldStates[j].valprev;
          blockHeader[i].channel.states[j].index:=oldStates[j].index;
        end;
        for j:=0 to blockHeader[i].channel.statesCount-1 do oldStates[j].Free;
      end;
      for i:=0 to waveHeader.channelsCount-1 do
        tempPCM[i].Position:=0;
      for i:=0 to tempPCM[0].Size div 2-1 do
        for j:=0 to waveHeader.channelsCount-1 do
          f.CopyFrom(tempPCM[j], 2);
    end else if blockHeader[0].channel.compression=PCM then begin
      for i:=0 to temp[0].Size div 2-2 do
        for j:=0 to waveHeader.channelsCount-1 do
          f.CopyFrom(temp[j], 2);
    end else if blockHeader[0].channel.compression=MP3 then begin
      for i:=0 to waveHeader.channelsCount-1 do
        temp[i].SaveToFile(s+'temp_'+IntToStr(i)+'.mp3');
    end else if blockHeader[0].channel.compression=XMA then begin
      temp[0].Position:=0;
      f.CopyFrom(temp[0], temp[0].Size);
    end;
    if not (blockHeader[0].channel.compression=MP3) then
      f.SaveToFile(s);
    f.Free;
  end;
end;

procedure TRAGEAudio.Load(f: TMemoryStream; startHeader: cardinal);
var
  i, j, k: integer;
  comp, sw: cardinal;
begin
  f.Position:=0;
  f.Read(sw, 4);
  if sw=0 then
    swap:=true
  else swap:=false;
  f.Position:=0;
  headerSize:=ReadValueU64(f, swap);
  if headerSize=28 then begin
    header.infoOffset:=ReadValueU64(f, swap);
    header.audioCount:=ReadValueU32(f, swap);
    header.animCount:=ReadValueU32(f, swap);
    header.dataOffset:=ReadValueU32(f, swap);
    SetLength(infoTables, header.audioCount);
    for i:=0 to header.audioCount-1 do begin
      f.Position:=28+i*16+startHeader;
      infoTables[i].offset:=ReadValueU64(f, swap);
      infoTables[i].hash:=ReadValueU32(f, swap);
      infoTables[i].size:=ReadValueU32(f, swap);
      f.Position:=28+16*header.audioCount+infoTables[i].offset+startHeader;
      infoTables[i].elem.offset:=ReadValueU64(f, swap);
      infoTables[i].elem.hash:=ReadValueU32(f, swap);
      infoTables[i].elem.size:=ReadValueU32(f, swap);
      infoTables[i].elem.size2:=ReadValueU32(f, swap);
      infoTables[i].elem.unk:=ReadValueS32(f, swap);
      infoTables[i].elem.freq:=ReadValueU16(f, swap);
      infoTables[i].elem.headroom:=ReadValueS16(f, swap);
      comp:=ReadValueU32(f, swap);
      case comp of
        0: infoTables[i].elem.compression:=XMA;
        1: infoTables[i].elem.compression:=PCM;
        256: infoTables[i].elem.compression:=MP3;
        512: infoTables[i].elem.compression:=Vorbis;
        1024: infoTables[i].elem.compression:=ADPCM;
      end;
      if infoTables[i].elem.compression=ADPCM then begin
        infoTables[i].elem2.offset:=ReadValueU64(f, swap);
        infoTables[i].elem2.numSamples:=ReadValueU32(f, swap);
        infoTables[i].elem2.wFA:=ReadValueU64(f, swap);
        infoTables[i].elem2.numStates:=ReadValueU32(f, swap);
        SetLength(infoTables[i].elem2.states, infoTables[i].elem2.numStates);
        for j:=0 to infoTables[i].elem2.numStates-1 do begin
          infoTables[i].elem2.states[j]:=TADPCMState.Create;
          infoTables[i].elem2.states[j].valprev:=ReadValueS16(f, swap);
          f.Read(infoTables[i].elem2.states[j].index, 1);
        end;
      end;
    end;
    if header.animCount>0 then
      SetLength(animTables, header.animCount);
      for i:=0 to header.animCount-1 do begin
        f.Position:=header.infoOffset+16*i+startHeader;
        animTables[i].offset:=ReadValueU64(f, swap);
        animTables[i].hash:=ReadValueU32(f, swap);
        animTables[i].size:=ReadValueU32(f, swap);
        f.Position:=header.infoOffset+16*header.animCount+animTables[i].offset+startHeader;
        animTables[i].f0:=ReadValueU32(f, swap);
        animTables[i].size2:=ReadValueU32(f, swap);
        //anim file
      end;
  end else begin
    waveHeader.blocksCount:=ReadValueU32(f, swap);
    waveHeader.blockSize:=ReadValueU32(f, swap);
    waveHeader.unk:=ReadValueU32(f, swap);
    waveHeader.chInfoOffset:=ReadValueU64(f, swap);
    waveHeader.blInfoOffset:=ReadValueU64(f, swap);
    waveHeader.channelsCount:=ReadValueU32(f, swap);
    waveHeader.timeStCount:=ReadValueU32(f, swap);
    waveHeader.dataOffset:=ReadValueU32(f, swap);
    SetLength(blockHeader, waveHeader.channelsCount);
    for i:=0 to waveHeader.channelsCount-1 do begin
      f.Position:=48+i*16+startHeader;
      blockHeader[i].offset:=ReadValueU64(f, swap);
      blockHeader[i].hash:=ReadValueU32(f, swap);
      blockHeader[i].size:=ReadValueU32(f, swap);
      f.Position:=48+16*waveHeader.channelsCount+blockHeader[i].offset+startHeader;
      blockHeader[i].channel._unk1:=ReadValueU64(f, swap);
      blockHeader[i].channel.hash:=ReadValueU32(f, swap);
      blockHeader[i].channel.size:=ReadValueU32(f, swap);
      blockHeader[i].channel.length:=ReadValueU32(f, swap);
      blockHeader[i].channel.iUnknown:=ReadValueS32(f, swap);
      blockHeader[i].channel.frequency:=ReadValueU16(f, swap);
      blockHeader[i].channel.headroom:=ReadValueS16(f, swap);
      comp:=ReadValueU32(f, swap);
      case comp of
        0: blockHeader[i].channel.compression:=XMA;
        1: blockHeader[i].channel.compression:=PCM;
        256: blockHeader[i].channel.compression:=MP3;
        512: blockHeader[i].channel.compression:=Vorbis;
        1024: blockHeader[i].channel.compression:=ADPCM;
      end;
      if blockHeader[i].channel.compression=ADPCM then begin
        blockHeader[i].channel.offsetStates:=ReadValueU64(f, swap);
        blockHeader[i].channel.samples:=ReadValueU32(f, swap);
        blockHeader[i].channel._unk2:=ReadValueU64(f, swap);
        blockHeader[i].channel.statesCount:=ReadValueU32(f, swap);
        SetLength(blockHeader[i].channel.states, blockHeader[i].channel.statesCount);
        for j:=0 to blockHeader[i].channel.statesCount-1 do begin
          blockHeader[i].channel.states[j]:=TADPCMState.Create;
          blockHeader[i].channel.states[j].valprev:=ReadValueS16(f, swap);
          f.Read(blockHeader[i].channel.states[j].index, 1);
        end;
      end;
    end;
    f.Position:=waveHeader.blInfoOffset+startHeader;
    if waveHeader.timeStCount>0 then begin
      timeStamps.offset:=ReadValueU64(f, swap);
      timeStamps.hash:=ReadValueU32(f, swap);
      timeStamps.size:=ReadValueU32(f, swap);
      timeStamps.hash2:=ReadValueU32(f, swap);
      timeStamps.size2:=ReadValueU32(f, swap);
      SetLength(timeStamps.timeStamps, timeStamps.size2 div 16);
      for i:=0 to timeStamps.size2 div 16-1 do begin
        timeStamps.timeStamps[i].djHash:=ReadValueU32(f, swap);
        timeStamps.timeStamps[i].parameter:=ReadValueU32(f, swap);
        timeStamps.timeStamps[i].flags:=ReadValueU32(f, swap);
        timeStamps.timeStamps[i].time:=ReadValueU32(f, swap);
      end;
    end;
    SetLength(blocks, waveHeader.blocksCount);
    for i:=0 to waveHeader.blocksCount-1 do begin
      blocks[i].offset:=ReadValueU32(f, swap);
      blocks[i].frequency:=ReadValueU32(f, swap);
    end;
    for i:=0 to waveHeader.blocksCount-1 do begin
      f.Position:=waveHeader.dataOffset+i*waveHeader.blockSize+startHeader;
      blocks[i].headerOffset:=ReadValueU64(f, swap);
      blocks[i].offsetsOffset:=ReadValueU64(f, swap);
      blocks[i].offsetsOffset:=ReadValueU64(f, swap);
      SetLength(blocks[i].blockChannel, waveHeader.channelsCount);
      if blockHeader[0].channel.compression=MP3 then begin
        for j:=0 to waveHeader.channelsCount-1 do begin
          blocks[i].blockChannel[j].offset:=ReadValueU32(f, swap);
          blocks[i].blockChannel[j].size:=ReadValueU32(f, swap);
          f.Position:=f.Position+4;
          blocks[i].blockChannel[j].samples:=ReadValueU32(f, swap);
          blocks[i].blockChannel[j].size2:=ReadValueU32(f, swap);
          blocks[i].blockChannel[j].samples2:=ReadValueU32(f, swap);
        end;
      end else begin
        for j:=0 to waveHeader.channelsCount-1 do begin
          blocks[i].blockChannel[j].offset:=ReadValueU32(f, swap);
          blocks[i].blockChannel[j].size:=ReadValueU32(f, swap);
          f.Position:=f.Position+4;
          blocks[i].blockChannel[j].samples:=ReadValueU32(f, swap);
        end;
      end;
      for j:=0 to waveHeader.channelsCount-1 do begin
        SetLength(blocks[i].blockChannel[j].offsetsBytes, blocks[i].blockChannel[j].size+1);
        for k:=0 to blocks[i].blockChannel[j].size-1 do begin
          blocks[i].blockChannel[j].offsetsBytes[k].beginO:=ReadValueU32(f, swap);
          blocks[i].blockChannel[j].offsetsBytes[k].endO:=ReadValueU32(f, swap);
        end;
      end;
    end;
  end;
end;

end.
