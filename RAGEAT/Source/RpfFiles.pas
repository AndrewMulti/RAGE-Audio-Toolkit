unit RpfFiles;

interface

uses
  System.SysUtils, System.Classes, GTAArchives, Vcl.Dialogs, ZLibEx;

const
  ivKey: TGTAArchiveKey = ($1A, $B5, $6F, $ED, $7E, $C3, $FF, $01,
                           $22, $7B, $69, $15, $33, $97, $5D, $CE,
                           $47, $D7, $69, $65, $3F, $F7, $75, $42,
                           $6A, $96, $CD, $6D, $53, $07, $56, $5D);

  { TempStream.WriteByteArray([$2F, $00, $00, $00,
                             $00, $00, $00, $00,
                             $00, $00, $00, $00,
                             $00, $00, $00, $00]);}

type
  TRPFItem = record
    isFolder: boolean;
    Hash: cardinal;
    ParentHash: cardinal;
    Size: cardinal;
    Offset: cardinal;
    Count: cardinal;
    Flags: cardinal;
  end;

  TRPFFile = class
    filePath: string;
    rpfVersion: cardinal;
    tocSize: cardinal;
    cCount: cardinal;
    unk1: cardinal;
    encrypt: integer;
    Items: array of TRPFItem;
  public
    procedure Load(f: TFileStream);
    procedure LoadRPF3(f: TFileStream);
    procedure ReadItem(f: TFileStream);
  end;

implementation

procedure TRPFFile.ReadItem(f: TFileStream);
begin

end;

procedure TRPFFile.LoadRPF3(f: TFileStream);
var
  a: TMemoryStream;
  i: integer;
begin
  filePath:=f.FileName;
  f.Position:=2048;
  a:=TMemoryStream.Create;
  a.CopyFrom(f, tocSize);
  DecryptOrEncryptBlock(a, ivKey, 0, tocSize, false);
  SetLength(Items, cCount);
  a.Position:=0;
  for i:=0 to cCount-1 do begin
    if i=0 then begin
      a.Read(Items[i].Hash, 4);
      Items[i].isFolder:=true;
      a.Read(Items[i].Count, 4);
      a.Read(Items[i].Flags, 4);
      a.Read(Items[i].Flags, 4);
    end else if i=1 then begin
      a.Read(Items[i].Hash, 4);
      Items[i].isFolder:=true;
      a.Read(Items[i].ParentHash, 4);
      a.Read(Items[i].Flags, 4);
      a.Read(Items[i].Count, 4);
    end else begin
      a.Read(Items[i].Hash, 4);
      Items[i].isFolder:=false;
      a.Read(Items[i].Size, 4);
      a.Read(Items[i].Offset, 4);
      a.Read(Items[i].Size, 4);
    end;
  end;
  //a.Position:=0;
  //a.Clear;
  a.Free;
  //f.Position:=items[2].Offset;
  //a.CopyFrom(f, items[2].Size);
  //a.SaveToFile('d:\untitled3.bin');
end;

procedure TRPFFile.Load(f: TFileStream);
begin
  f.Read(rpfVersion, 4);
  f.Read(tocSize, 4);
  f.Read(cCount, 4);
  f.Read(unk1, 4);
  f.Read(encrypt, 4);
  if rpfVersion=860246098 then
    LoadRPF3(f);
end;

end.
