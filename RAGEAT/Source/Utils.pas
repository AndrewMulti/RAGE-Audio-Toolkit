unit Utils;

interface

uses
  System.SysUtils, System.Classes, System.Masks, Vcl.Grids, Vcl.ComCtrls,
  RpfFiles, Vcl.Dialogs, IniFiles;

  function GetHash(strKey: string): cardinal;
  function SingleToHex(d: single): string;
  function HexToSingle(hex: string): single;
  procedure SetGridFocus(SGrid: TStringGrid; r, c: integer);
  procedure FindFiles(StartFolder, Mask: string; List: TStrings; ScanSubFolders: Boolean = True);
  function CheckString(s: string): boolean;
  procedure SetValue(index, n, val: cardinal; a: TBytes);
  function StringsToStringList(s: TStrings): TStringList;
  procedure WriteArrayUInt(f: TMemoryStream; a: array of cardinal);
  function Mod2048(c: cardinal): cardinal;
  procedure WriteValue(f: TMemoryStream; a: cardinal; b: byte);
  function ReadValueU16(f: TMemoryStream; swap: boolean): word;
  function ReadValueS16(f: TMemoryStream; swap: boolean): smallint;
  function ReadValueU32(f: TMemoryStream; swap: boolean): cardinal;
  function ReadValueS32(f: TMemoryStream; swap: boolean): integer;
  function ReadValueU64(f: TMemoryStream; swap: boolean): uint64;
  function SetZero(n: cardinal): cardinal;

implementation

function SetZero(n: cardinal): cardinal;
begin
  if n<0 then
    Result:=0
  else Result:=n;
end;

function FlipU64(Value: uint64): uint64;
type
  Bytes = packed array[0..7] of byte;
begin
  Bytes(Result)[0]:=Bytes(Value)[7];
  Bytes(Result)[1]:=Bytes(Value)[6];
  Bytes(Result)[2]:=Bytes(Value)[5];
  Bytes(Result)[3]:=Bytes(Value)[4];
  Bytes(Result)[4]:=Bytes(Value)[3];
  Bytes(Result)[5]:=Bytes(Value)[2];
  Bytes(Result)[6]:=Bytes(Value)[1];
  Bytes(Result)[7]:=Bytes(Value)[0];
end;

function FlipU32(Value: cardinal): cardinal;
type
  Bytes = packed array[0..3] of byte;
begin
  Bytes(Result)[0]:=Bytes(Value)[3];
  Bytes(Result)[1]:=Bytes(Value)[2];
  Bytes(Result)[2]:=Bytes(Value)[1];
  Bytes(Result)[3]:=Bytes(Value)[0];
end;

function FlipS32(Value: integer): integer;
type
  Bytes = packed array[0..3] of byte;
begin
  Bytes(Result)[0]:=Bytes(Value)[3];
  Bytes(Result)[1]:=Bytes(Value)[2];
  Bytes(Result)[2]:=Bytes(Value)[1];
  Bytes(Result)[3]:=Bytes(Value)[0];
end;

function FlipU16(Value: word): word;
type
  Bytes = packed array[0..1] of byte;
begin
  Bytes(Result)[0]:=Bytes(Value)[1];
  Bytes(Result)[1]:=Bytes(Value)[0];
end;

function FlipS16(Value: smallint): smallint;
type
  Bytes = packed array[0..1] of byte;
begin
  Bytes(Result)[0]:=Bytes(Value)[1];
  Bytes(Result)[1]:=Bytes(Value)[0];
end;

function ReadValueU16(f: TMemoryStream; swap: boolean): word;
begin
  f.Read(Result, 2);
  if swap then
    Result:=FlipU16(Result);
end;

function ReadValueS16(f: TMemoryStream; swap: boolean): smallint;
begin
  f.Read(Result, 2);
  if swap then
    Result:=FlipS16(Result);
end;

function ReadValueU32(f: TMemoryStream; swap: boolean): cardinal;
begin
  f.Read(Result, 4);
  if swap then
    Result:=FlipU32(Result);
end;

function ReadValueS32(f: TMemoryStream; swap: boolean): integer;
begin
  f.Read(Result, 4);
  if swap then
    Result:=FlipS32(Result);
end;

function ReadValueU64(f: TMemoryStream; swap: boolean): uint64;
begin
  f.Read(Result, 8);
  if swap then
    Result:=FlipU64(Result);
end;

function Mod2048(c: cardinal): cardinal;
begin
  Result:=c;
  while not (Result mod 2048 = 0) do
    Result:=Result+1;
end;

procedure SetValue(index, n, val: cardinal; a: TBytes);
var
  i: integer;
  s: string;
begin
  s:=IntToHex(val, n*2);
  for i:=index+n-1 downto index do
    a[i]:=StrToInt('$'+Copy(s, Length(s)-2*i+1, 2));
end;

function GetHash(strKey: string): cardinal;
var
  TempHash: cardinal;
  i, key_len: integer;
begin
  strKey:=LowerCase(strKey);
  key_len:=Length(strKey);
  TempHash:=0;
  for i:=1 to key_len do
  begin
    Inc(TempHash, Ord(strKey[i]));
    Inc(TempHash, (TempHash shl 10));
    TempHash:=TempHash xor (TempHash shr 6);
  end;
  Inc(TempHash, (TempHash shl 3));
  TempHash:=TempHash xor (TempHash shr 11);
  Inc(TempHash, (TempHash shl 15));
  Result:=TempHash;
end;

function SingleToHex(d: single): string;
var
  i: integer;
begin
  i:=PInteger(@d)^;
  Result:=Format('%.8X', [i]);
end;

function HexToSingle(hex: string): single;
var
  i: integer;
begin
  i:=StrToInt(hex);
  Result:=PSingle(@i)^;
end;

procedure SetGridFocus(SGrid: TStringGrid; r, c: integer);
var
  SRect: TGridRect;
begin
  with SGrid do begin
    SetFocus;
    Row:=r;
    Col:=c;
    SRect.Top:=r;
    SRect.Left:=c;
    SRect.Bottom:=r;
    SRect.Right:=c;
    Selection:=SRect;
  end;
end;

procedure FindFiles(StartFolder, Mask: string; List: TStrings;
  ScanSubFolders: Boolean = True);
var
  SearchRec: TSearchRec;
  FindResult: Integer;
begin
  List.BeginUpdate;
  try
    StartFolder:=IncludeTrailingBackslash(StartFolder);
    FindResult:=FindFirst(StartFolder + '*.*', faAnyFile, SearchRec);
    try
      while FindResult = 0 do
        with SearchRec do begin
          if (Attr and faDirectory) <> 0 then
          begin
            if ScanSubFolders and (Name <> '.') and (Name <> '..') then
              FindFiles(StartFolder + Name, Mask, List, ScanSubFolders);
          end else begin
            if MatchesMask(Name, Mask) then
              List.Add(StartFolder + Name);
          end;
          FindResult := FindNext(SearchRec);
        end;
    finally
      FindClose(SearchRec);
    end;
  finally
    List.EndUpdate;
  end;
end;

function CheckString(s: string): boolean;
var
  Len, I: integer;
begin
  Len:=Length(s);
  I:=1;
  while (I<=Len) and (s[I] in ['0'..'9', 'a'..'z', 'A'..'Z', '/', '\', '_']) do
    Inc(I);
  Result:=I<=Len;
end;

function StringsToStringList(s: TStrings): TStringList;
var
  i: integer;
begin
  Result:=TStringList.Create;
  for i:=0 to s.Count-1 do
    Result.Add(s[i]);
end;

procedure WriteArrayUInt(f: TMemoryStream; a: array of cardinal);
var
  i: integer;
begin
  for i:=0 to Length(a)-1 do
    f.Write(a[i], 4);
end;

procedure WriteValue(f: TMemoryStream; a: cardinal; b: byte);
begin
  f.Write(a, b);
end;

end.
