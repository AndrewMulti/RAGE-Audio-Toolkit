unit MetaFiles;

interface

uses
  System.SysUtils, System.Classes, Winapi.Windows, Vcl.Dialogs, Utils;

type
  uint = cardinal;

  TMetaTypes = (tChannel = 12, tChannelsGroup = 13, tStream = 8, tSound = 6);

  TSpeechSound = record
    FileIndex: cardinal;
    DJspeakOffset: integer;
    hash: cardinal;
    unk: byte;
    Count: byte;
    DJspeakSub: array of byte;
  end;

  TSpeechFile = record
    offset: cardinal;
    hash: cardinal;
    count: word;
    SoundElemsInfo: array of TSpeechSound;
  end;

  TSpeech = class
    DJspeakSize: cardinal;
    DJspeak: array of byte;
    SoundElemCount: cardinal;
    FileElemCount: cardinal;
    FileElemsInfo: array of TSpeechFile;
    StringsCount: cardinal;
    StringsOffsets: array of cardinal;
    Strings: array of string;
  public
    procedure Load(f: TMemoryStream);
    procedure Rebuild();
    procedure Save(f: string);
  end;

  TMetaInfo = record
    strCount: byte;
    name: string;
    infoOffset: uint;
    infoSize: uint;
    data: TBytes;
    hashes: array of integer;
    hashes2: array of integer;
  end;

  TMetaFile = class
    version: uint;
    dataSize: uint;
    pathNamesSize: uint;
    pathNamesCount: uint;
    pathNamesOffsets: array of uint;
    pathNames: array of string;
    infoCount: uint;
    stringSize: uint;
    info: array of TMetaInfo;
    hashes1Count: uint;
    hashes1: array of uint;
    hashes2Count: uint;
    hashes2: array of uint;
  public
    procedure Load(f: TMemoryStream);
    procedure Rebuild();
    procedure Save(f: string);
  end;

implementation

procedure TSpeech.Rebuild;
var
  i, j, k, l, m: integer;
begin
  FileElemCount:=Length(FileElemsInfo);
  SoundElemCount:=0;
  DJspeakSize:=0;
  SetLength(DJspeak, 0);
  l:=0;
  for i:=0 to FileElemCount-1 do begin
    SoundElemCount:=SoundElemCount+FileElemsInfo[i].count;
    FileElemsInfo[i].offset:=l;
    l:=l+FileElemsInfo[i].count*14;
    for j:=0 to FileElemsInfo[i].count-1 do begin
      if FileElemsInfo[i].SoundElemsInfo[j].DJspeakOffset<>-1 then begin
        FileElemsInfo[i].SoundElemsInfo[j].DJspeakOffset:=DJspeakSize;
        if Length(FileElemsInfo[i].SoundElemsInfo[j].DJspeakSub)>0 then
          for k:=0 to Length(FileElemsInfo[i].SoundElemsInfo[j].DJspeakSub)-1 do begin
            SetLength(DJspeak, Length(DJspeak)+1);
            DJspeak[DJspeakSize]:=FileElemsInfo[i].SoundElemsInfo[j].DJspeakSub[k];
            Inc(DJspeakSize);
          end;
      end;
    end;
  end;
  StringsCount:=Length(Strings);
  SetLength(StringsOffsets, StringsCount);
  m:=0;
  for i:=0 to StringsCount-1 do begin
    StringsOffsets[i]:=m;
    m:=m+Length(Strings[i])+1;
  end;
end;

procedure TSpeech.Save(f: string);
var
  a: TMemoryStream;
  i, j: integer;
  z, c: byte;
begin
  z:=0;
  a:=TMemoryStream.Create;
  a.Write(DJspeakSize, 4);
  if DJspeakSize>0 then begin
    for i:=0 to DJspeakSize-1 do
      a.Write(DJspeak[i], 1);
  end;
  a.Write(SoundElemCount, 4);
  for i:=0 to FileElemCount-1 do begin
    for j:=0 to FileElemsInfo[i].count-1 do begin
      a.Write(FileElemsInfo[i].SoundElemsInfo[j].FileIndex, 4);
      a.Write(FileElemsInfo[i].SoundElemsInfo[j].DJspeakOffset, 4);
      a.Write(FileElemsInfo[i].SoundElemsInfo[j].hash, 4);
      a.Write(FileElemsInfo[i].SoundElemsInfo[j].unk, 1);
      a.Write(FileElemsInfo[i].SoundElemsInfo[j].Count, 1);
    end;
  end;
  a.Write(FileElemCount, 4);
  for i:=0 to FileElemCount-1 do begin
    a.Write(FileElemsInfo[i].offset, 4);
    a.Write(FileElemsInfo[i].hash, 4);
    a.Write(FileElemsInfo[i].count, 2);
  end;
  a.Write(StringsCount, 4);
  for i:=0 to StringsCount-1 do
    a.Write(StringsOffsets[i], 4);
  for i:=0 to StringsCount-1 do begin
    for j:=1 to Length(Strings[i]) do begin
      c:=Ord(Strings[i][j]);
      a.Write(c, 1);
    end;
    a.Write(z, 1);
  end;
  a.SaveToFile(f);
  a.Free;
end;

procedure TSpeech.Load(f: TMemoryStream);
var
  i, j, k, l: cardinal;
  c: byte;
begin
  f.Read(DJspeakSize, 4);
  if DJspeakSize>0 then begin
    SetLength(DJspeak, DJspeakSize);
    for i:=0 to DJspeakSize-1 do
      f.Read(DJspeak[i], 1);
  end;
  f.Read(SoundElemCount, 4);
  f.Position:=f.Position+SoundElemCount*14;
  f.Read(FileElemCount, 4);
  SetLength(FileElemsInfo, FileElemCount);
  for i:=0 to FileElemCount-1 do begin
    f.Position:=4+DJspeakSize+4+SoundElemCount*14+4+i*10;
    f.Read(FileElemsInfo[i].offset, 4);
    f.Read(FileElemsInfo[i].hash, 4);
    f.Read(FileElemsInfo[i].count, 2);
    SetLength(FileElemsInfo[i].SoundElemsInfo, FileElemsInfo[i].count);
    for j:=0 to FileElemsInfo[i].count-1 do begin
      f.Position:=4+DJspeakSize+4+FileElemsInfo[i].offset+j*14;
      f.Read(FileElemsInfo[i].SoundElemsInfo[j].FileIndex, 4);
      f.Read(FileElemsInfo[i].SoundElemsInfo[j].DJspeakOffset, 4);
      f.Read(FileElemsInfo[i].SoundElemsInfo[j].hash, 4);
      f.Read(FileElemsInfo[i].SoundElemsInfo[j].unk, 1);
      f.Read(FileElemsInfo[i].SoundElemsInfo[j].Count, 1);
      if FileElemsInfo[i].SoundElemsInfo[j].DJspeakOffset>-1 then begin
        l:=0;
        SetLength(FileElemsInfo[i].SoundElemsInfo[j].DJspeakSub, FileElemsInfo[i].SoundElemsInfo[j].Count);
        for k:=FileElemsInfo[i].SoundElemsInfo[j].DJspeakOffset to FileElemsInfo[i].SoundElemsInfo[j].DJspeakOffset+FileElemsInfo[i].SoundElemsInfo[j].Count-1 do begin
          FileElemsInfo[i].SoundElemsInfo[j].DJspeakSub[l]:=DJspeak[k];
          Inc(l);
        end;
      end;
    end;
  end;
  f.Position:=4+DJspeakSize+4+SoundElemCount*14+4+FileElemCount*10;
  f.Read(StringsCount, 4);
  SetLength(StringsOffsets, StringsCount);
  SetLength(Strings, StringsCount);
  for i:=0 to StringsCount-1 do
    f.Read(StringsOffsets[i], 4);
  for i:=0 to StringsCount-1 do begin
    Strings[i]:='';
    while true do begin
      f.Read(c, 1);
      if c<>0 then
        Strings[i]:=Strings[i]+Chr(c)
      else Break;
    end;
  end;
end;

procedure TMetaFile.Load(f: TMemoryStream);
var
  i, j, a, k, p: cardinal;
  c: byte;
begin
  f.Read(version, 4);
  f.Read(dataSize, 4);
  f.Position:=dataSize+8;
  f.Read(pathNamesSize, 4);
  f.Read(pathNamesCount, 4);
  if not (pathNamesCount=0) then begin
    SetLength(pathNamesOffsets, pathNamesCount);
    SetLength(pathNames, pathNamesCount);
    for i:=0 to pathNamesCount-1 do
      f.Read(pathNamesOffsets[i], 4);
    for i:=0 to pathNamesCount-1 do begin
      f.Position:=dataSize+16+4*pathNamesCount+pathNamesOffsets[i];
      pathNames[i]:='';
      repeat
        f.Read(c, 1);
        pathNames[i]:=pathNames[i]+Chr(c);
      until c=$00;
      SetLength(pathNames[i], Length(pathNames[i])-1);
    end;
  end;
  f.Position:=dataSize+12+pathNamesSize;
  f.Read(infoCount, 4);
  f.Read(stringSize, 4);
  SetLength(info, infoCount);
  if not (infoCount=0) then
    for i:=0 to infoCount-1 do begin
      f.Read(info[i].strCount, 1);
      info[i].name:='';
      for j:=1 to info[i].strCount do begin
        f.Read(c, 1);
        info[i].name:=info[i].name+Chr(c);
      end;
      f.Read(info[i].infoOffset, 4);
      f.Read(info[i].infoSize, 4);
    end;
  f.Read(hashes1Count, 4);
  if not (hashes1Count=0) then begin
    SetLength(hashes1, hashes1Count);
    for i:=0 to hashes1Count-1 do
      f.Read(hashes1[i], 4);
  end;
  f.Read(hashes2Count, 4);
  if not (hashes2Count=0) then begin
    SetLength(hashes2, hashes1Count);
    for i:=0 to hashes2Count-1 do
      f.Read(hashes2[i], 4);
  end;
  if not (infoCount=0) then
    for i:=0 to infoCount-1 do begin
      f.Position:=8+info[i].infoOffset;
      SetLength(info[i].data, info[i].infoSize);
      f.Read(info[i].data, info[i].infoSize);
    end;
  if not (hashes1Count=0) then begin
    a:=9;
    j:=0;
    k:=0;
    i:=0;
    while i<hashes1Count do begin
      if hashes1[i]>a then begin
        a:=a+info[j].infoSize+1;
        j:=j+1;
        k:=0;
      end else begin
        SetLength(info[j-1].hashes, Length(info[j-1].hashes)+1);
        info[j-1].hashes[k]:=hashes1[i]-(a-info[j-1].infoSize-1);
        k:=k+1;
        i:=i+1;
      end;
    end;
  end;
  if not (hashes2Count=0) then begin
    a:=9;
    j:=0;
    k:=0;
    i:=0;
    while i<hashes2Count do begin
      if hashes2[i]>a then begin
        a:=a+info[j].infoSize+1;
        j:=j+1;
        k:=0;
      end else begin
        SetLength(info[j-1].hashes2, Length(info[j-1].hashes2)+1);
        info[j-1].hashes2[k]:=hashes2[i]-(a-info[j-1].infoSize-1);
        k:=k+1;
        i:=i+1;
      end;
    end;
  end;
end;

procedure TMetaFile.Rebuild;
var
  i: integer;
begin
  pathNamesCount:=Length(pathNames);
  pathNamesSize:=4*pathNamesCount+4;
  SetLength(pathNamesOffsets, pathNamesCount);
  if not (pathNamesCount=0) then begin
    pathNamesOffsets[0]:=0;
    for i:=1 to pathNamesCount-1 do begin
      pathNamesOffsets[i]:=pathNamesOffsets[i-1]+Length(pathNames[i-1])+1;
      pathNamesSize:=pathNamesSize+Length(pathNames[i-1])+1;
    end;
    pathNamesSize:=pathNamesSize+Length(pathNames[pathNamesCount-1])+1;
  end;
  infoCount:=Length(info);
  dataSize:=0;
  stringSize:=0;
  for i:=0 to infoCount-1 do begin
    dataSize:=dataSize+Length(info[i].data)+1;
    info[i].infoOffset:=dataSize-Length(info[i].data);
    info[i].infoSize:=Length(info[i].data);
    info[i].strCount:=Length(info[i].name);
    SetValue(1, 4, stringSize, info[i].data);
    stringSize:=stringSize+info[i].strCount+1;
  end;

end;

procedure TMetaFile.Save(f: string);
var
  i, j: integer;
  a: TMemoryStream;
  z, c: byte;
begin
  a:=TMemoryStream.Create;
  z:=0;
  a.Write(version, 4);
  a.Write(dataSize, 4);
  for i:=0 to infoCount-1 do begin
    a.Write(z, 1);
    a.Write(info[i].data, Length(info[i].data));
  end;
  a.Write(pathNamesSize, 4);
  a.Write(pathNamesCount, 4);
  for i:=0 to pathNamesCount-1 do
    a.Write(pathNamesOffsets[i], 4);
  for i:=0 to pathNamesCount-1 do begin
    for j:=1 to Length(pathNames[i]) do begin
      c:=Ord(pathNames[i][j]);
      a.Write(c, 1);
    end;
    a.Write(z, 1);
  end;
  a.Write(infoCount, 4);
  a.Write(stringSize, 4);
  for i:=0 to infoCount-1 do begin
    a.Write(info[i].strCount, 1);
    for j:=1 to Length(info[i].name) do begin
      c:=Ord(info[i].name[j]);
      a.Write(c, 1);
    end;
    a.Write(info[i].infoOffset, 4);
    a.Write(info[i].infoSize, 4);
  end;
  a.Write(hashes1Count, 4);
  for i:=0 to hashes1Count-1 do begin
    a.Write(hashes1[i], 4);
  end;
  a.Write(hashes2Count, 4);
  for i:=0 to hashes2Count-1 do begin
    a.Write(hashes2[i], 4);
  end;
  a.SaveToFile(f);
  a.Free;
end;

end.
