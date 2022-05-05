unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, MetaFiles,
  Vcl.StdCtrls, Vcl.Grids, IniFiles, Utils, FileCtrl, Masks, StrUtils,
  Vcl.ExtCtrls, ShellAPI, LoadForm, About, InstUnit, Vcl.Mask, JvExMask, JvSpin,
  JvExExtCtrls, JvSplitter, SynEditHighlighter, SynEditCodeFolding,
  SynHighlighterXML, SynEdit, SynMemo, uSynEditPopupEdit, System.ImageList,
  Vcl.ImgList, JvImageList, JvExComCtrls, JvComCtrls,
  IOUtils, Vcl.Imaging.pngimage, JvProgressBar, StreamCreate;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    GameItems: TListBox;
    About1: TMenuItem;
    GameName: TEdit;
    GameNameEnter: TLabel;
    GameHex: TStringGrid;
    GameHexLabel: TLabel;
    GameSaveInfo: TButton;
    GameTypeGrid: TStringGrid;
    StatusBar: TStatusBar;
    Save2: TMenuItem;
    Setgamedirectory1: TMenuItem;
    GameResetInfo: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GamePathNames: TListBox;
    Makebackups1: TMenuItem;
    MetaPopup: TPopupMenu;
    Duplicate2: TMenuItem;
    Delete2: TMenuItem;
    Movetobottom1: TMenuItem;
    Movetotop1: TMenuItem;
    Moveup1: TMenuItem;
    Movedown1: TMenuItem;
    Movetobottom2: TMenuItem;
    FilesPopup: TPopupMenu;
    Insert1: TMenuItem;
    Delete3: TMenuItem;
    Edit3: TEdit;
    Label1: TLabel;
    Rename1: TMenuItem;
    FileSelect: TComboBox;
    Duplicateto1: TMenuItem;
    N2: TMenuItem;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    SpeechSelect: TComboBox;
    AudioBankNameEdit: TEdit;
    Label3: TLabel;
    EntryList: TListBox;
    Label4: TLabel;
    Label5: TLabel;
    JvSpinEdit1: TJvSpinEdit;
    Label6: TLabel;
    SpeechGrid: TStringGrid;
    SpeechSave: TButton;
    SpeechDefault: TButton;
    SpeechLeftPanel: TPanel;
    SpeechCTop: TPanel;
    SpeechRightPanel: TPanel;
    JvSplitter2: TJvSplitter;
    GameLeftPanel: TPanel;
    GameRightPanel: TPanel;
    JvSplitter3: TJvSplitter;
    SpeechFiles: TComboBox;
    TabSheet6: TTabSheet;
    SynXMLSyn1: TSynXMLSyn;
    XMLSelect: TComboBox;
    SynEdit1: TSynEdit;
    JvImageList1: TJvImageList;
    Splitter1: TSplitter;
    SpeechPopup: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    N4: TMenuItem;
    Create1: TMenuItem;
    Audiostream1: TMenuItem;
    FBPopup: TPopupMenu;
    Create2: TMenuItem;
    Audiofile1: TMenuItem;
    Soundbank1: TMenuItem;
    Extract1: TMenuItem;
    Delete4: TMenuItem;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    BankPopup: TPopupMenu;
    Add2: TMenuItem;
    Replace1: TMenuItem;
    N5: TMenuItem;
    Delete5: TMenuItem;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Timer1: TTimer;
    SpeechCBottom: TPanel;
    JvSplitter4: TJvSplitter;
    Label9: TLabel;
    SpeechFL: TListBox;
    SpeechFLPopup: TPopupMenu;
    Add3: TMenuItem;
    Delete6: TMenuItem;
    Extract2: TMenuItem;
    N3: TMenuItem;
    hisfiletooP1: TMenuItem;
    OpenDialog2: TOpenDialog;
    oPtofile1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure GameItemsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GameHexDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure GameHexSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GameHexMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GameTypeGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure GameHexSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure GameHexKeyPress(Sender: TObject; var Key: Char);
    procedure GameSaveInfoClick(Sender: TObject);
    procedure GameResetInfoClick(Sender: TObject);
    procedure Setgamedirectory1Click(Sender: TObject);
    procedure LoadMetaClick(Sender: TObject);
    procedure Save2Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Delete3Click(Sender: TObject);
    procedure Insert1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Rename1Click(Sender: TObject);
    procedure Duplicate2Click(Sender: TObject);
    procedure DuplicateToNew(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure FileSelectSelect(Sender: TObject);
    procedure Moveup1Click(Sender: TObject);
    procedure Movedown1Click(Sender: TObject);
    procedure Movetotop1Click(Sender: TObject);
    procedure Movetobottom2Click(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure Createinstallpackage1Click(Sender: TObject);
    procedure SpeechSelectSelect(Sender: TObject);
    procedure EntryListClick(Sender: TObject);
    procedure SpeechDefaultClick(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure SpeechSaveClick(Sender: TObject);
    procedure XMLSelectSelect(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure Add3Click(Sender: TObject);
    procedure Delete6Click(Sender: TObject);
    procedure SpeechGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SpeechFilesChange(Sender: TObject);
    procedure SpeechFilesExit(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure hisfiletooP1Click(Sender: TObject);
    procedure oPtofile1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function GetCardinal(ACol, ARow: integer): cardinal; overload;
    function GetCardinal(a: TBytes; p: integer): cardinal; overload;
    function GetValue(c, r, n: integer): string;
    function GetLength(): integer;
    procedure HashesRebuild(n: integer);
  end;

const
  VERSION = '0.3';

var
  MainForm: TMainForm;
  LForm: TLForm;
  gtaPath: string;
  sounds, game: TMetaFile;
  hashes, iniSettings: TMemIniFile;
  isLoaded: boolean = false;
  hashCells, strCells: array of TPoint;
  DrawTick: integer = 0;
  ColorDraw, CurIndex: integer;
  meta: array of TMetaFile;
  speech: array of TSpeech;
  Ins: boolean = false;
  scVal: integer;
  itemsSeld: array of integer;
  sc: TAStreamCreate;

implementation

{$R *.dfm}
{$SetPEFlags 1}

function TMainForm.GetCardinal(a: TBytes; p: integer): cardinal;
var
  i: integer;
  s: string;
begin
  s:='';
  for i:=p to p+3 do
    s:=IntToHex(a[i], 2)+s;
  s:='$'+s;
  Result:=Cardinal(StrToInt(s));
end;

function TMainForm.GetCardinal(ACol: Integer; ARow: Integer): cardinal;
var
  s: string;
  i, x, y: integer;
begin
  s:='';
  x:=ACol;
  y:=ARow;
  for i:=0 to 3 do begin
    s:=GameHex.Cells[x, y]+s;
    x:=x+1;
    if x mod 16 = 0 then begin
      y:=y+1;
      x:=0;
    end;
  end;
  s:='$'+s;
  Result:=Cardinal(StrToInt(s));
end;

procedure TMainForm.About1Click(Sender: TObject);
var
  abForm: TAboutForm;
begin
  abForm:=TAboutForm.Create(nil);
  abForm.ShowModal;
end;

procedure TMainForm.Add1Click(Sender: TObject);
var
  s: string;
begin
  s:=InputBox('', 'Enter new name', '');
  if not (s='') and not (CheckString(s)) then begin
    SetLength(speech[SpeechSelect.ItemIndex].FileElemsInfo, Length(speech[SpeechSelect.ItemIndex].FileElemsInfo)+1);
    speech[SpeechSelect.ItemIndex].FileElemsInfo[Length(speech[SpeechSelect.ItemIndex].FileElemsInfo)-1].hash:=GetHash(UpperCase(s));
    EntryList.Items.Add(UpperCase(s));
    EntryList.ItemIndex:=EntryList.Items.Count-1;
    EntryListClick(Self);
  end;
end;

procedure TMainForm.Add3Click(Sender: TObject);
var
  s: string;
begin
  s:=InputBox('', 'Enter new name', '');
  if not (s='') and not (CheckString(s)) then begin
    SpeechFL.Items.Add(UpperCase(s));
    SetLength(speech[SpeechSelect.ItemIndex].Strings, Length(speech[SpeechSelect.ItemIndex].Strings)+1);
    speech[SpeechSelect.ItemIndex].Strings[Length(speech[SpeechSelect.ItemIndex].Strings)-1]:=UpperCase(s);
    SpeechFiles.Items:=SpeechFL.Items;
  end;
end;

procedure TMainForm.Createinstallpackage1Click(Sender: TObject);
begin
  InstForm.Show;
end;

procedure TMainForm.Delete1Click(Sender: TObject);
var
  i: integer;
begin
  if EntryList.ItemIndex>=0 then begin
    for i:=EntryList.ItemIndex+1 to EntryList.Items.Count-1 do begin
      speech[SpeechSelect.ItemIndex].FileElemsInfo[i-1]:=speech[SpeechSelect.ItemIndex].FileElemsInfo[i];
      EntryList.Items[i-1]:=EntryList.Items[i];
    end;
    SetLength(speech[SpeechSelect.ItemIndex].FileElemsInfo, Length(speech[SpeechSelect.ItemIndex].FileElemsInfo)-1);
    EntryList.Items.Delete(EntryList.Items.Count-1);
  end;
end;

procedure TMainForm.Delete2Click(Sender: TObject);
var
  i, j, k: integer;
begin
  if GameItems.ItemIndex>=0 then begin
    for i:=GameItems.ItemIndex+1 to GameItems.Items.Count-1 do begin
      meta[FileSelect.ItemIndex].info[i-1]:=meta[FileSelect.ItemIndex].info[i];
      GameItems.Items[i-1]:=GameItems.Items[i];
    end;
    SetLength(meta[FileSelect.ItemIndex].info, Length(meta[FileSelect.ItemIndex].info)-1);
    GameItems.Items.Delete(GameItems.Items.Count-1);
    Dec(meta[FileSelect.ItemIndex].infoCount);
  end;
end;

procedure TMainForm.Delete3Click(Sender: TObject);
var
  i: integer;
begin
  if GamePathNames.ItemIndex>=0 then begin
    for i:=GamePathNames.ItemIndex+1 to GamePathNames.Items.Count-1 do begin
      meta[FileSelect.ItemIndex].pathNames[i-1]:=meta[FileSelect.ItemIndex].pathNames[i];
      GamePathNames.Items[i-1]:=GamePathNames.Items[i];
    end;
    SetLength(meta[FileSelect.ItemIndex].pathNames, Length(meta[FileSelect.ItemIndex].pathNames)-1);
    GamePathNames.Items.Delete(GamePathNames.Items.Count-1);
    Dec(meta[FileSelect.ItemIndex].pathNamesCount);
    //sc.FileList.Items:=GamePathNames.Items;
  end;
end;

procedure TMainForm.Delete6Click(Sender: TObject);
var
  i, j: integer;
  can: boolean;
begin
  if SpeechFL.ItemIndex>=0 then begin
    can:=true;
    for i:=0 to Length(speech[SpeechSelect.ItemIndex].FileElemsInfo)-1 do begin
      if Length(speech[SpeechSelect.ItemIndex].FileElemsInfo[i].SoundElemsInfo)>0 then
        if speech[SpeechSelect.ItemIndex].FileElemsInfo[i].SoundElemsInfo[0].FileIndex=SpeechFL.ItemIndex then begin
          MessageBox(handle, PChar('Unable to delete. Some entry uses this file'), PChar('Warning'), MB_OK+MB_ICONWARNING);
          can:=false;
          Break;
        end;
    end;
    if can then begin
      SpeechFL.Items.Delete(SpeechFL.ItemIndex);
      for i:=0 to Length(speech[SpeechSelect.ItemIndex].FileElemsInfo)-1 do begin
        for j:=0 to Length(speech[SpeechSelect.ItemIndex].FileElemsInfo[i].SoundElemsInfo)-1 do begin
          if speech[SpeechSelect.ItemIndex].FileElemsInfo[i].SoundElemsInfo[j].FileIndex>SpeechFL.ItemIndex then
            Dec(speech[SpeechSelect.ItemIndex].FileElemsInfo[i].SoundElemsInfo[j].FileIndex);
        end;
      end;
      SpeechFiles.Items:=SpeechFL.Items;
    end;
  end;
end;

procedure TMainForm.DuplicateToNew(Sender: TObject);
var
  i: integer;
  Item: TMenuItem;
begin
  if GameItems.ItemIndex>=0 then begin
    Item:=Sender as TMenuItem;
    SetLength(meta[Item.Tag].info, Length(meta[Item.Tag].info)+1);
    meta[Item.Tag].info[Length(meta[Item.Tag].info)-1]:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex];
    Inc(meta[Item.Tag].infoCount);
  end;
end;

procedure TMainForm.Duplicate2Click(Sender: TObject);
var
  i, j, k: integer;
begin
  if GameItems.ItemIndex>=0 then begin
    SetLength(itemsSeld, GameItems.SelCount);
    k:=0;
    for j:=0 to GameItems.Items.Count-1 do begin
      if GameItems.Selected[j] then begin
        itemsSeld[k]:=j;
        Inc(k);
      end;
    end;
    for j:=Length(itemsSeld)-1 downto 0 do begin
      SetLength(meta[FileSelect.ItemIndex].info, Length(meta[FileSelect.ItemIndex].info)+1);
      GameItems.Items.Add(' ');
      for i:=Length(meta[FileSelect.ItemIndex].info)-2 downto itemsSeld[j] do begin
        meta[FileSelect.ItemIndex].info[i+1]:=meta[FileSelect.ItemIndex].info[i];
        GameItems.Items[i+1]:=GameItems.Items[i];
      end;
      meta[FileSelect.ItemIndex].info[itemsSeld[j]+1].name:=meta[FileSelect.ItemIndex].info[itemsSeld[j]].name+'_COPY';
      GameItems.Items[itemsSeld[j]+1]:=GameItems.Items[itemsSeld[j]]+'_COPY';
      Inc(meta[FileSelect.ItemIndex].infoCount);
    end;
  end;
end;

procedure TMainForm.Edit3Change(Sender: TObject);
begin
  GameItems.ItemIndex:=GameItems.Perform(LB_FINDSTRING, $FFFFFFFF, PWideChar(Edit3.Text));
end;

procedure TMainForm.EntryListClick(Sender: TObject);
var
  i, j: integer;
begin
  if EntryList.ItemIndex<>-1 then begin
    for i:=1 to 100 do begin
      SpeechGrid.Cells[0, i]:='';
      SpeechGrid.Cells[1, i]:='';
      SpeechGrid.Cells[2, i]:='';
      SpeechGrid.Cells[3, i]:='';
    end;
    AudioBankNameEdit.Text:=EntryList.Items[EntryList.ItemIndex];
    JvSpinEdit1.Value:=speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].count;
    if speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].count=0 then
      SpeechGrid.RowCount:=speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].count+2
    else
      SpeechGrid.RowCount:=speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].count+1;
    for i:=0 to speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].count-1 do begin
      SpeechGrid.Cells[0, i+1]:=hashes.ReadString('hashes', IntToStr(speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].hash), 'hash:'+IntToStr(speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].hash));
      SpeechGrid.Cells[2, i+1]:=IntToStr(speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].Count);
      SpeechGrid.Cells[1, i+1]:=SpeechFL.Items[speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].FileIndex];
      if not (speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].DJspeakOffset=-1) then begin
        SpeechGrid.Cells[3, i+1]:='';
        for j:=0 to speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].Count-1 do begin
          SpeechGrid.Cells[3, i+1]:=SpeechGrid.Cells[3, i+1]+IntToStr(speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].DJspeakSub[j]);
          if j<>speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].Count-1 then
            SpeechGrid.Cells[3, i+1]:=SpeechGrid.Cells[3, i+1]+', ';
        end;
      end else SpeechGrid.Cells[3, i+1]:='-1';
    end;
    JvSpinEdit1.Enabled:=true;
  end;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.SpeechDefaultClick(Sender: TObject);
begin
  EntryListClick(Self);
end;

procedure TMainForm.SpeechFilesChange(Sender: TObject);
begin
  SpeechGrid.Cells[SpeechGrid.Col, SpeechGrid.Row]:=SpeechFiles.Items[SpeechFiles.ItemIndex];
  SpeechFiles.Visible:=false;
  SpeechGrid.SetFocus;
end;

procedure TMainForm.SpeechFilesExit(Sender: TObject);
begin
  SpeechGrid.Cells[SpeechGrid.Col, SpeechGrid.Row]:=SpeechFiles.Items[SpeechFiles.ItemIndex];
  SpeechFiles.Visible:=false;
  SpeechGrid.SetFocus;
end;

procedure TMainForm.SpeechGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  R: TRect;
begin
  if ACol=1 then begin
    SpeechFiles.ItemIndex:=SpeechFiles.Items.IndexOf(SpeechGrid.Cells[ACol, ARow]);
    R:=SpeechGrid.CellRect(ACol, ARow);
    R.Left:=R.Left+SpeechGrid.Left;
    R.Right:=R.Right+SpeechGrid.Left;
    R.Top:=R.Top+SpeechGrid.Top;
    R.Bottom:=R.Bottom+SpeechGrid.Top;
    SpeechFiles.Left:=R.Left+1;
    SpeechFiles.Top:=R.Top+1;
    SpeechFiles.Width:=(R.Right+1)-R.Left;
    SpeechFiles.Height:=(R.Bottom+1)-R.Top;
    SpeechFiles.Visible:=true;
    SpeechFiles.SetFocus;
  end;
  CanSelect:=true;
end;

procedure TMainForm.SpeechSaveClick(Sender: TObject);
var
  i, j: integer;
  s: string;
  sl: TStringList;
  can: boolean;
begin
  EntryList.Items[EntryList.ItemIndex]:=UpperCase(AudioBankNameEdit.Text);
  speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].hash:=GetHash(UpperCase(AudioBankNameEdit.Text));
  speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].count:=Round(JvSpinEdit1.Value);
  SetLength(speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo, Round(JvSpinEdit1.Value));
  SpeechFilesExit(Self);
  can:=true;
  for i:=0 to Round(JvSpinEdit1.Value)-1 do begin
    if (SpeechGrid.Cells[0, i+1]='') or (SpeechGrid.Cells[1, i+1]='') or (SpeechGrid.Cells[2, i+1]='') then begin
      can:=false;
      MessageBox(handle, PChar('Unable to save. Grid has empty values'), PChar('Warning'), MB_OK+MB_ICONWARNING);
      Break;
    end;
  end;
  if can then
    for i:=0 to Round(JvSpinEdit1.Value)-1 do begin
      speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].FileIndex:=SpeechFiles.Items.IndexOf(SpeechGrid.Cells[1, i+1]);
      if SpeechGrid.Cells[0, i+1].StartsWith('hash:') then
        speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].hash:=StrToUInt(Copy(SpeechGrid.Cells[0, i+1], 6, 10))
      else begin
        speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].hash:=GetHash(SpeechGrid.Cells[0, i+1]);
        hashes.WriteString('hashes', IntToStr(GetHash(SpeechGrid.Cells[0, i+1])), SpeechGrid.Cells[0, i+1]);
      end;
      speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].unk:=0;
      speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].Count:=StrToInt(SpeechGrid.Cells[2, i+1]);
      if not (SpeechGrid.Cells[3, i+1]='-1') then begin
        s:=StringReplace(SpeechGrid.Cells[3, i+1], Chr(160), '', [rfReplaceAll, rfIgnoreCase]);
        sl:=TStringList.Create;
        sl.Delimiter:=',';
        sl.StrictDelimiter:=true;
        sl.DelimitedText:=s;
        SetLength(speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].DJspeakSub, sl.Count);
        for j:=0 to sl.Count-1 do
          speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].DJspeakSub[j]:=StrToInt(sl[j]);
        sl.Free;
      end else begin
        speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].DJspeakOffset:=-1;
        SetLength(speech[SpeechSelect.ItemIndex].FileElemsInfo[EntryList.ItemIndex].SoundElemsInfo[i].DJspeakSub, 0);
      end;
    end;
end;

procedure TMainForm.SpeechSelectSelect(Sender: TObject);
var
  i: integer;
begin
  for i:=1 to 100 do begin
    SpeechGrid.Cells[0, i]:='';
    SpeechGrid.Cells[1, i]:='';
    SpeechGrid.Cells[2, i]:='';
    SpeechGrid.Cells[3, i]:='';
  end;
  SpeechFiles.Text:='';
  AudioBankNameEdit.Text:='';
  JvSpinEdit1.Value:=0;
  JvSpinEdit1.Enabled:=false;
  SpeechFiles.Items.Clear;
  SpeechFL.Items.Clear;
  for i:=0 to speech[SpeechSelect.ItemIndex].StringsCount-1 do
    SpeechFL.Items.Add(speech[SpeechSelect.ItemIndex].Strings[i]);
  SpeechFiles.Items:=SpeechFL.Items;
  EntryList.Items.Clear;
  for i:=0 to speech[SpeechSelect.ItemIndex].FileElemCount-1 do
    EntryList.Items.Add(hashes.ReadString('hashes', IntToStr(speech[SpeechSelect.ItemIndex].FileElemsInfo[i].hash), 'hash:'+IntToStr(speech[SpeechSelect.ItemIndex].FileElemsInfo[i].hash)));
end;

procedure TMainForm.XMLSelectSelect(Sender: TObject);
begin
  SynEdit1.Lines.LoadFromFile(gtaPath+'\'+XMLSelect.Items[XMLSelect.ItemIndex]);
end;

procedure TMainForm.FileSelectSelect(Sender: TObject);
var
  i, j: integer;
  DupFile: TMenuItem;
begin
  GameItems.Clear;
  GamePathNames.Clear;
  Edit3.Clear;
  isLoaded:=false;
  for i:=1 to 8 do
    GameTypeGrid.Cells[1, i]:='';
  GameName.Text:='';
  for i:=1 to GameHex.RowCount-1 do
    for j:=0 to GameHex.ColCount-1 do
      GameHex.Cells[j, i]:='';
  for i:=0 to meta[FileSelect.ItemIndex].infoCount-1 do
    GameItems.Items.Add(meta[FileSelect.ItemIndex].info[i].name);
  if meta[FileSelect.ItemIndex].pathNamesCount>0 then begin
    TabSheet2.TabVisible:=true;
    for i:=0 to meta[FileSelect.ItemIndex].pathNamesCount-1 do
      GamePathNames.Items.Add(meta[FileSelect.ItemIndex].pathNames[i]);
  end else begin
    PageControl1.ActivePage:=TabSheet1;
    TabSheet2.TabVisible:=false;
  end;
  Duplicateto1.Visible:=false;
  Duplicateto1.Clear;
  //sc.FileList.Items:=GamePathNames.Items;
  {if (FileSelect.Items[FileSelect.ItemIndex].EndsWith('15')) and (meta[FileSelect.ItemIndex].pathNamesCount>0) then begin
    Create1.Visible:=true;
    N4.Visible:=true;
  end else begin
    Create1.Visible:=false;
    N4.Visible:=false;
  end; }
  for i:=0 to FileSelect.Items.Count-1 do
    if (meta[FileSelect.ItemIndex].version=meta[i].version) and not (FileSelect.ItemIndex=i) then begin
      DupFile:=TMenuItem.Create(Duplicateto1);
      DupFile.Caption:=FileSelect.Items[i];
      DupFile.OnClick:=DuplicateToNew;
      DupFile.Tag:=i;
      Duplicateto1.Add(DupFile);
    end;
  if Duplicateto1.Count>0 then
    Duplicateto1.Visible:=true;
  StatusBar.Panels[0].Text:=ExtractFileName(FileSelect.Text)+' - '+IntToStr(Length(meta[FileSelect.ItemIndex].info));
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  hashes.UpdateFile;
  hashes.Free;
  iniSettings.WriteBool('Settings', 'MakeBackups', Makebackups1.Checked);
  iniSettings.WriteInteger('Settings', 'Width', MainForm.Width);
  iniSettings.WriteInteger('Settings', 'Height', MainForm.Height);
  iniSettings.WriteInteger('Settings', 'Top', MainForm.Top);
  iniSettings.WriteInteger('Settings', 'Left', MainForm.Left);
  if MainForm.WindowState=wsMaximized then
    iniSettings.WriteBool('Settings', 'Maximized', true)
  else iniSettings.WriteBool('Settings', 'Maximized', false);
  iniSettings.UpdateFile;
  iniSettings.Free;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: byte;
  s: string;
  a: TMemoryStream;
  j: integer;
  actFile: boolean;
  ss: TStrings;
  sl: TStringList;
begin
  LForm:=TLForm.Create(nil);
  Application.ProcessMessages;
  LForm.Visible:=true;
  Application.ProcessMessages;
  SpeechGrid.DefaultRowHeight:=SpeechFiles.Height;
  SpeechFiles.Visible:=false;
  sc:=TAStreamCreate.Create(nil);
  sc.ChannelsGrid.Cells[0, 0]:='Channel Meta Name';
  sc.ChannelsGrid.Cells[1, 0]:='Channel Name in File';
  FormatSettings.DecimalSeparator:='.';
  FormatSettings.LongTimeFormat:='hh:mm:ss';
  {if (HIWORD(BASS_GetVersion) <> BASSVERSION) then begin
    MessageBox(Handle, 'Bass.dll has incorrect version', 'Error', MB_OK + MB_ICONERROR);
    Halt;
  end;
  if not BASS_Init(-1, 44100, 0, Handle, nil) then begin
    MessageBox(Handle, 'Audio initialization error', 'Error', MB_OK + MB_ICONERROR);
    Halt;
  end;}
  for i:=0 to 15 do
    GameHex.Cells[i, 0]:=IntToHex(i, 1);
  hashes:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+'data\iv_eflc.ini');
  Sleep(1000);
  SpeechGrid.Cells[0, 0]:='Sound Name';
  SpeechGrid.Cells[1, 0]:='File Path';
  SpeechGrid.Cells[2, 0]:='Sounds Variation';
  SpeechGrid.Cells[3, 0]:='Sounds Durations (for DJ''s speech)';
  GameTypeGrid.Cells[0, 0]:='Type';
  GameTypeGrid.Cells[1, 0]:='Value';
  GameTypeGrid.Cells[0, 1]:='Signed Byte';
  GameTypeGrid.Cells[0, 2]:='Unsigned Byte';
  GameTypeGrid.Cells[0, 3]:='Signed Short';
  GameTypeGrid.Cells[0, 4]:='Unsigned Short';
  GameTypeGrid.Cells[0, 5]:='Signed Int';
  GameTypeGrid.Cells[0, 6]:='Unsigned Int';
  GameTypeGrid.Cells[0, 7]:='Float';
  GameTypeGrid.Cells[0, 8]:='Hash';
  //GameTypeGrid.Cells[0, 9]:='String';
  GameTypeGrid.ColWidths[0]:=82;
  GameTypeGrid.ColWidths[1]:=176;
  iniSettings:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+'settings.ini');
  gtaPath:=iniSettings.ReadString('Settings', 'Path', '');
  if gtaPath='' then
    if SelectDirectory('Select folder with GTA IV or EFLC', '', gtaPath) then begin
      if FileExists(gtaPath+'\GTAIV.exe') or FileExists(gtaPath+'\EFLC.exe') then
        iniSettings.WriteString('Settings', 'Path', gtaPath)
      else begin
        MessageBox(Handle, 'GTAIV.exe or EFLC.exe is not found', 'Error', MB_OK + MB_ICONWARNING);
        Halt;
      end;
    end else begin
      MessageBox(Handle, 'Game needed for working with this tool!', 'Error', MB_OK + MB_ICONWARNING);
      Halt;
    end;
  Makebackups1.Checked:=iniSettings.ReadBool('Settings', 'MakeBackups', true);
  FindFiles(gtaPath+'\', '*.dat1?', FileSelect.Items, true);
  FindFiles(gtaPath+'\', '*speech.dat', SpeechSelect.Items, true);
  FindFiles(gtaPath+'\pc\audio\config\', '*.xml', XMLSelect.Items);
  actFile:=false;
  for i:=0 to FileSelect.Items.Count-1 do begin
    s:=FileSelect.Items[i];
    Delete(s, 1, Length(gtaPath)+1);
    FileSelect.Items[i]:=s;
    if not (actFile) then
      if (ContainsStr(s, 'SOUNDS')) or (ContainsStr(s, 'sounds')) then begin
        actFile:=true;
        FileSelect.ItemIndex:=i;
      end;
  end;
  for i:=0 to SpeechSelect.Items.Count-1 do begin
    s:=SpeechSelect.Items[i];
    Delete(s, 1, Length(gtaPath)+1);
    SpeechSelect.Items[i]:=s;
  end;
  for i:=0 to XMLSelect.Items.Count-1 do begin
    s:=XMLSelect.Items[i];
    Delete(s, 1, Length(gtaPath)+1);
    XMLSelect.Items[i]:=s;
  end;
  if not (actFile) then
    FileSelect.ItemIndex:=0;
  SetLength(meta, FileSelect.Items.Count);
  for i:=0 to FileSelect.Items.Count-1 do begin
    LForm.LoadText.Caption:='Loading file ('+IntToStr(i+1)+'/'+IntToStr(FileSelect.Items.Count)+') '+FileSelect.Items[i];
    a:=TMemoryStream.Create;
    a.LoadFromFile(gtaPath+'\'+FileSelect.Items[i]);
    meta[i]:=TMetaFile.Create;
    meta[i].Load(a);
    for j:=0 to meta[i].infoCount-1 do begin
      Application.ProcessMessages;
      hashes.WriteString('hashes', IntToStr(GetHash(meta[i].info[j].name)), meta[i].info[j].name);
    end;
    for j:=0 to meta[i].pathNamesCount-1 do begin
      Application.ProcessMessages;
      if ContainsText(meta[i].pathNames[j], '\') then begin
        hashes.WriteString('hashes', IntToStr(GetHash(meta[i].pathNames[j])), meta[i].pathNames[j]);
        hashes.WriteString('hashes', IntToStr(GetHash(StringReplace(meta[i].pathNames[j], '\', '/', [rfReplaceAll]))), StringReplace(meta[i].pathNames[j], '\', '/', [rfReplaceAll]));
      end else if ContainsText(meta[i].pathNames[j], '/') then begin
        hashes.WriteString('hashes', IntToStr(GetHash(meta[i].pathNames[j])), meta[i].pathNames[j]);
        hashes.WriteString('hashes', IntToStr(GetHash(StringReplace(meta[i].pathNames[j], '/', '\', [rfReplaceAll]))), StringReplace(meta[i].pathNames[j], '/', '\', [rfReplaceAll]));
      end else
        hashes.WriteString('hashes', IntToStr(GetHash(meta[i].pathNames[j])), meta[i].pathNames[j]);
    end;
    a.Clear;
  end;
  SetLength(speech, SpeechSelect.Items.Count);
  SpeechSelect.ItemIndex:=0;
  for i:=0 to SpeechSelect.Items.Count-1 do begin
    LForm.LoadText.Caption:='Loading file ('+IntToStr(i+1)+'/'+IntToStr(SpeechSelect.Items.Count)+') '+SpeechSelect.Items[i];
    a:=TMemoryStream.Create;
    a.LoadFromFile(gtaPath+'\'+SpeechSelect.Items[i]);
    speech[i]:=TSpeech.Create;
    speech[i].Load(a);
    for j:=0 to speech[i].StringsCount-1 do begin
      Application.ProcessMessages;
      if ContainsText(speech[i].Strings[j], '\') then begin
        hashes.WriteString('hashes', IntToStr(GetHash(speech[i].Strings[j])), speech[i].Strings[j]);
        hashes.WriteString('hashes', IntToStr(GetHash(StringReplace(speech[i].Strings[j], '\', '/', [rfReplaceAll]))), StringReplace(speech[i].Strings[j], '\', '/', [rfReplaceAll]));
      end else if ContainsText(speech[i].Strings[j], '/') then begin
        hashes.WriteString('hashes', IntToStr(GetHash(speech[i].Strings[j])), speech[i].Strings[j]);
        hashes.WriteString('hashes', IntToStr(GetHash(StringReplace(speech[i].Strings[j], '/', '\', [rfReplaceAll]))), StringReplace(speech[i].Strings[j], '/', '\', [rfReplaceAll]));
      end else
        hashes.WriteString('hashes', IntToStr(GetHash(speech[i].Strings[j])), speech[i].Strings[j]);
      hashes.WriteString('hashes', IntToStr(GetHash(ExtractFileName(speech[i].Strings[j]))), ExtractFileName(speech[i].Strings[j]));
    end;
    a.Clear;
  end;
  LForm.LoadText.Caption:='Loading application...';
  XMLSelect.ItemIndex:=0;
  hashes.UpdateFile;
  MainForm.Width:=iniSettings.ReadInteger('Settings', 'Width', 757);
  MainForm.Height:=iniSettings.ReadInteger('Settings', 'Height', 643);
  if (iniSettings.ReadInteger('Settings', 'Top', -1)=-1) or (iniSettings.ReadInteger('Settings', 'Left', -1)=-1) then
    MainForm.Position:=poDesktopCenter
  else begin
    MainForm.Top:=iniSettings.ReadInteger('Settings', 'Top', -1);
    MainForm.Left:=iniSettings.ReadInteger('Settings', 'Left', -1);
  end;
  if iniSettings.ReadBool('Settings', 'Maximize', false) then
    MainForm.WindowState:=wsMaximized
  else MainForm.WindowState:=wsNormal;
  Application.ProcessMessages;
  FileSelect.OnSelect(Self);
  Application.ProcessMessages;
  SpeechSelect.OnSelect(Self);
  Application.ProcessMessages;
  XMLSelect.OnSelect(Self);
  a.Free;
  //sl:=TStringList.Create;
  //ss:=TStringList.Create;
  Application.ProcessMessages;
  {FindFiles(gtaPath, '*.rpf', ss);
  for i:=0 to ss.Count-1 do begin
    s:=ss[i];
    Delete(s, 1, Length(gtaPath)+1);
    sl.Add(s);
  end;
  Application.ProcessMessages;
  FillTreeViewWithFiles(JvTreeView1, sl);
  JvTreeView1.Perform(WM_VSCROLL, MakeWParam(SB_TOP, 0), 0); }
  //SpeechGrid
  LForm.Visible:=false;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  GameTypeGrid.ColWidths[1]:=GameTypeGrid.Width-GameTypeGrid.ColWidths[0]-GameTypeGrid.Left;
  StatusBar.Panels[0].Width:=StatusBar.Width div 2;
  StatusBar.Panels[1].Width:=StatusBar.Width div 2;
end;

procedure TMainForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  {if Msg.CharCode = VK_INSERT then begin
    Ins:=not Ins;
    if Ins then
      StatusBar.Panels[1].Text:='INS      '
    else
      StatusBar.Panels[1].Text:='OVW      ';
    Handled:=true;
  end;}
end;

function isStrCell(x, y: integer): boolean;
var
  i: integer;
begin
  Result:=false;
  for i:=0 to Length(strCells)-1 do
    if (strCells[i].X=x) and (strCells[i].Y=y) then begin
      Result:=true;
      Break;
    end;
end;

function isCell(x, y: integer): boolean;
var
  i: integer;
begin
  Result:=false;
  for i:=0 to Length(hashCells)-1 do
    if (hashCells[i].X=x) and (hashCells[i].Y=y) then begin
      Result:=true;
      Break;
    end;
end;

function CellIndex(x, y: integer): integer;
var
  i: integer;
begin
  for i:=0 to Length(hashCells)-1 do
    if (hashCells[i].X=x) and (hashCells[i].Y=y) then begin
      Result:=i;
      Break;
    end;
end;

procedure TMainForm.GameHexDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if ((ACol>0) and (ACol<5) and (ARow=1) and (isLoaded)) then begin
    GameHex.Canvas.Brush.Color:=RGB(170, 170, 170);
    Rect.Left:=Rect.Left-5;
    GameHex.Canvas.FillRect(Rect);
    GameHex.Canvas.TextOut(Rect.Left+Canvas.TextWidth(GameHex.Cells[ACol, ARow]) div 2, Rect.Top+2, GameHex.Cells[Acol, Arow]);
  end;
  if (isLoaded) and (isCell(ACol, ARow)) then begin
    GameHex.Canvas.Brush.Color:=RGB(255, 180, 244);
    Rect.Left:=Rect.Left-5;
    GameHex.Canvas.FillRect(Rect);
    GameHex.Canvas.TextOut(Rect.Left+Canvas.TextWidth(GameHex.Cells[ACol, ARow]) div 2, Rect.Top+2, GameHex.Cells[Acol, Arow]);
  end;
  if (isLoaded) and (isStrCell(ACol, ARow)) then begin
    GameHex.Canvas.Brush.Color:=RGB(255, 255, 160);
    Rect.Left:=Rect.Left-5;
    GameHex.Canvas.FillRect(Rect);
    GameHex.Canvas.TextOut(Rect.Left+Canvas.TextWidth(GameHex.Cells[ACol, ARow]) div 2, Rect.Top+2, GameHex.Cells[Acol, Arow]);
  end;
end;

procedure TMainForm.GameHexKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'f'] then
    Key:=UpCase(Key)
  else if not (Key in ['0'..'9', 'A'..'F']) then
    Key:=#0;
end;

procedure TMainForm.GameHexMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  r, c, i: integer;
  h: cardinal;
  sv, str: string;
begin
  if isLoaded then begin
    GameHex.MouseToCell(X, Y, c, r);
    if isStrCell(c, r) or isCell(c, r) then begin
      if isStrCell(c, r) then begin
        sv:=GetValue(c, r, StrToInt(GetValue(c, r, 1))+1);
        i:=StrToInt(GetValue(c, r, 1))*2;
        str:='';
        while i>1 do begin
          str:=str+AnsiChar(Byte(StrToInt('$'+Copy(sv, i, 2))));
          i:=i-2;
        end;
        GameHex.Hint:=str;
        Application.ActivateHint(GameHex.ClientToScreen(Point(X, Y)));
      end;
      if isCell(c, r) then begin
        h:=GetCardinal(hashCells[CellIndex(c, r) div 4 * 4].X, hashCells[CellIndex(c, r) div 4 * 4].y);
        GameHex.Hint:=hashes.ReadString('hashes', IntToStr(h), '');
        Application.ActivateHint(GameHex.ClientToScreen(Point(X, Y)));
      end;
    end else
      Application.CancelHint;
  end;
end;

function TMainForm.GetLength(): integer;
var
  x, y: integer;
begin
  x:=0;
  y:=1;
  Result:=0;
  while not (GameHex.Cells[x, y]='') do begin
    Result:=Result+1;
    x:=x+1;
    if x=16 then begin
      x:=0;
      y:=y+1;
    end;
  end;
end;

function TMainForm.GetValue(c, r, n: integer): string;
var
  i, x, y, index: integer;
begin
  index:=16*(r-1)+c;
  if index+n-1>=GetLength() then
    Result:='null'
  else begin
    Result:='';
    x:=c;
    y:=r;
    for i:=index to index+n-1 do begin
      Result:=GameHex.Cells[x, y]+Result;
      x:=x+1;
      if x=16 then begin
        x:=0;
        y:=y+1;
      end;
    end;
    Result:='$'+Result;
  end;
end;

procedure TMainForm.GameHexSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  i, x, y: integer;
  sl: byte;
  s, str, sv: string;
begin
  if ((ACol>0) and (ACol<5) and (ARow=1) and (isLoaded)) then
    GameHex.Options:=GameHex.Options-[goEditing]
  else GameHex.Options:=GameHex.Options+[goEditing];
  x:=ACol;
  y:=ARow;
  if (isLoaded) and (GameHex.Cells[x, y]='') then
    if x=0 then begin
      x:=15;
      y:=y-1;
    end else
      if GameHex.Cells[x-1, y]='' then
        GameHex.Options:=GameHex.Options-[goEditing]
      else GameHex.Options:=GameHex.Options+[goEditing];
  if isLoaded then begin
    if not (GameHex.Cells[ACol, ARow]='') then begin
      GameTypeGrid.Cells[1, 1]:=IntToStr(ShortInt(StrToInt(GetValue(ACol, ARow, 1))));
      GameTypeGrid.Cells[1, 2]:=IntToStr(Byte(StrToInt(GetValue(ACol, ARow, 1))));
      if not (GetValue(ACol, ARow, 2)='null') then begin
        sl:=Byte(StrToInt(GetValue(ACol, ARow, 1)));
        str:='';
        GameTypeGrid.Cells[1, 9]:='';
        if (sl<25) and (sl>1) then begin
          sv:=GetValue(ACol, ARow, sl+1);
          if not (sv='null') then begin
            i:=sl*2;
            while i>1 do begin
              if AnsiChar(Byte(StrToInt('$'+Copy(sv, i, 2)))) in ['a'..'z', 'A'..'Z', '/', '\', '_', '0'..'9'] then begin
                str:=str+AnsiChar(Byte(StrToInt('$'+Copy(sv, i, 2))));
                i:=i-2;
              end else begin
                str:='';
                Break;
              end;
            end;
            //GameTypeGrid.Cells[1, 9]:=str;
          end;
        end;
        GameTypeGrid.Cells[1, 3]:=IntToStr(SmallInt(StrToInt(GetValue(ACol, ARow, 2))));
        GameTypeGrid.Cells[1, 4]:=IntToStr(Word(StrToInt(GetValue(ACol, ARow, 2))));
        if not (GetValue(ACol, ARow, 4)='null') then begin
          GameTypeGrid.Cells[1, 5]:=IntToStr(Integer(StrToInt(GetValue(ACol, ARow, 4))));
          GameTypeGrid.Cells[1, 6]:=IntToStr(Cardinal(StrToInt(GetValue(ACol, ARow, 4))));
          try
            GameTypeGrid.Cells[1, 7]:=FloatToStr(HexToSingle(GetValue(ACol, ARow, 4)));
          except
            on Exception: EInvalidOp do
              GameTypeGrid.Cells[1, 7]:='';
          end;
          GameTypeGrid.Cells[1, 8]:=hashes.ReadString('hashes', IntToStr(Cardinal(StrToInt(GetValue(ACol, ARow, 4)))), '');
        end else begin
          GameTypeGrid.Cells[1, 5]:='';
          GameTypeGrid.Cells[1, 6]:='';
          GameTypeGrid.Cells[1, 7]:='';
        end;
      end else begin
        GameTypeGrid.Cells[1, 3]:='';
        GameTypeGrid.Cells[1, 4]:='';
      end;
    end else
      for i:=1 to 9 do
        GameTypeGrid.Cells[1, i]:='';
  end;
end;

procedure TMainForm.GameHexSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  x, y: integer;
begin
  if Length(Value)>=2 then
    if ACol=15 then
      SetGridFocus(GameHex, ARow+1, 0)
    else
      SetGridFocus(GameHex, ARow, ACol+1);
end;

procedure TMainForm.GameItemsClick(Sender: TObject);
var
  i, j, k, x, y, l: integer;
  str: string;
  a: tmemorystream;
  gr: TGridRect;
begin
  if GameItems.ItemIndex>=0 then begin
    GameName.Text:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].name;
    for i:=1 to GameHex.RowCount-1 do
      for j:=0 to GameHex.ColCount-1 do
        GameHex.Cells[j, i]:='';
    for i:=1 to 8 do
      GameTypeGrid.Cells[1, i]:='';
    GameHex.RowCount:=Length(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data) div 16 + 2;
    gr.Left:=-1;
    gr.Right:=-1;
    gr.Top:=-1;
    gr.Bottom:=-1;
    GameHex.Selection:=gr;
    x:=0;
    y:=0;
    for i:=0 to Length(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data)-1 do begin
      if i mod 16 = 0 then begin
        x:=0;
        y:=y+1;
      end;
      GameHex.Cells[x, y]:=IntToHex(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data[i], 2);
      x:=x+1;
    end;
    isLoaded:=true;
    j:=0;
    SetLength(hashCells, 0);
    SetLength(strCells, 0);
    for i:=0 to Length(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data)-4 do begin
      if not (hashes.ReadString('hashes', IntToStr(GetCardinal(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data, i)), 'nil')='nil') then begin
        SetLength(hashCells, Length(hashCells)+4);
        for k:=0 to 3 do begin
          hashCells[j+k].y:=(i+k) div 16 + 1;
          hashCells[j+k].x:=(i+k) mod 16;
        end;
        j:=j+4;
      end;
      str:='';
      if (meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data[i]<25) and (meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data[i]>3) then begin
        for l:=1 to meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data[i] do
          if AnsiChar(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data[i+l]) in ['a'..'z', 'A'..'Z', '/', '\', '_', '0'..'9'] then
            str:=str+AnsiChar(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data[i+l])
          else begin
            str:='';
            Break;
          end;
        if not (str='') then begin
          SetLength(strCells, Length(strCells)+1);
          strCells[Length(strCells)-1].y:=i div 16 + 1;
          strCells[Length(strCells)-1].x:=i mod 16;
        end;
      end;
    end;
    DrawTick:=0;
    GameHex.Repaint;
  end;
end;

procedure TMainForm.GameResetInfoClick(Sender: TObject);
begin
  if isLoaded then
    GameItemsClick(Self);
end;

procedure TMainForm.GameSaveInfoClick(Sender: TObject);
var
  x, y, i, j: integer;
  a, c: cardinal;
  s: string;
begin
  if isLoaded then begin
    meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].name:=UpperCase(GameName.Text);
    GameItems.Items[GameItems.ItemIndex]:=UpperCase(GameName.Text);
    hashes.WriteString('hashes', IntToStr(GetHash(UpperCase(GameName.Text))), UpperCase(GameName.Text));
    SetLength(meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data, GetLength());
    x:=0;
    y:=1;
    for i:=0 to GetLength()-1 do begin
      meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].data[i]:=StrToInt('$'+GameHex.Cells[x, y]);
      x:=x+1;
      if x=16 then begin
        x:=0;
        y:=y+1;
      end;
    end;
  end;
end;

procedure TMainForm.GameTypeGridSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  s: string;
  i, x, y: integer;
begin
  if (isLoaded) and not (Value='') then begin
    if ARow=1 then
      try
        if (StrToInt(Value)>=ShortInt.MinValue) and (StrToInt(Value)<=ShortInt.MaxValue) then begin
          GameHex.Cells[GameHex.Col, GameHex.Row]:=IntToHex(StrToInt(Value), 2);
          StatusBar.Panels[0].Text:='';
        end else StatusBar.Panels[0].Text:='Value out of range '''+Value+'''';
      except
        on Exception: EConvertError do
          StatusBar.Panels[0].Text:='Invalid value '''+Value+'''';
      end
    else if ARow=2 then
      try
        if (StrToInt(Value)>=Byte.MinValue) and (StrToInt(Value)<=Byte.MaxValue) then begin
          GameHex.Cells[GameHex.Col, GameHex.Row]:=IntToHex(StrToInt(Value), 2);
          StatusBar.Panels[0].Text:='';
        end else StatusBar.Panels[0].Text:='Value out of range '''+Value+'''';
      except
        on Exception: EConvertError do
          StatusBar.Panels[0].Text:='Invalid value '''+Value+'''';
      end
    else if ARow=3 then
      try
        if (StrToInt(Value)>=SmallInt.MinValue) and (StrToInt(Value)<=SmallInt.MaxValue) then begin
          s:=IntToHex(SmallInt(StrToInt(Value)), 4);
          x:=GameHex.Col;
          y:=GameHex.Row;
          for i:=1 to 2 do begin
            GameHex.Cells[x, y]:=Copy(s, Length(s)-2*i+1, 2);
            x:=x+1;
            if x=16 then begin
              x:=0;
              y:=y+1;
            end;
          end;
          StatusBar.Panels[0].Text:='';
        end else StatusBar.Panels[0].Text:='Value out of range '''+Value+'''';
      except
        on Exception: EConvertError do
          StatusBar.Panels[0].Text:='Invalid value '''+Value+'''';
      end
    else if ARow=4 then
      try
        if (StrToInt(Value)>=Word.MinValue) and (StrToInt(Value)<=Word.MaxValue) then begin
          s:=IntToHex(Word(StrToInt(Value)), 4);
          x:=GameHex.Col;
          y:=GameHex.Row;
          for i:=1 to 2 do begin
            GameHex.Cells[x, y]:=Copy(s, Length(s)-2*i+1, 2);
            x:=x+1;
            if x=16 then begin
              x:=0;
              y:=y+1;
            end;
          end;
          StatusBar.Panels[0].Text:='';
        end else StatusBar.Panels[0].Text:='Value out of range '''+Value+'''';
      except
        on Exception: EConvertError do
          StatusBar.Panels[0].Text:='Invalid value '''+Value+'''';
      end
    else if ARow=5 then
      try
        if (StrToInt(Value)>=Integer.MinValue) and (StrToInt(Value)<=Integer.MaxValue) then begin
          s:=IntToHex(Integer(StrToInt(Value)), 8);
          x:=GameHex.Col;
          y:=GameHex.Row;
          for i:=1 to 4 do begin
            GameHex.Cells[x, y]:=Copy(s, Length(s)-2*i+1, 2);
            x:=x+1;
            if x=16 then begin
              x:=0;
              y:=y+1;
            end;
          end;
          StatusBar.Panels[0].Text:='';
        end else StatusBar.Panels[0].Text:='Value out of range '''+Value+'''';
      except
        on Exception: EConvertError do
          StatusBar.Panels[0].Text:='Invalid value '''+Value+'''';
      end
    else if ARow=6 then
      try
        if (Cardinal(StrToInt64(Value))>=Cardinal.MinValue) and (Cardinal(StrToInt64(Value))<=Cardinal.MaxValue) then begin
          s:=IntToHex(Cardinal(StrToInt64(Value)), 8);
          x:=GameHex.Col;
          y:=GameHex.Row;
          for i:=1 to 4 do begin
            GameHex.Cells[x, y]:=Copy(s, Length(s)-2*i+1, 2);
            x:=x+1;
            if x=16 then begin
              x:=0;
              y:=y+1;
            end;
          end;
          StatusBar.Panels[0].Text:='';
        end else StatusBar.Panels[0].Text:='Value out of range '''+Value+'''';
      except
        on Exception: EConvertError do
          StatusBar.Panels[0].Text:='Invalid value '''+Value+'''';
      end
    else if ARow=7 then
      try
        if (StrToFloat(Value)>=Single.MinValue) and (StrToFloat(Value)<=Single.MaxValue) then begin
          s:=SingleToHex(StrToFloat(Value));
          x:=GameHex.Col;
          y:=GameHex.Row;
          for i:=1 to 4 do begin
            GameHex.Cells[x, y]:=Copy(s, Length(s)-2*i+1, 2);
            x:=x+1;
            if x=16 then begin
              x:=0;
              y:=y+1;
            end;
          end;
          StatusBar.Panels[0].Text:='';
        end else StatusBar.Panels[0].Text:='Value out of range '''+Value+'''';
      except
        on Exception: EConvertError do
          StatusBar.Panels[0].Text:='Invalid value '''+Value+'''';
      end
    else if ARow=8 then begin
      s:=IntToHex(GetHash(Value), 8);
      x:=GameHex.Col;
      y:=GameHex.Row;
      for i:=1 to 4 do begin
        GameHex.Cells[x, y]:=Copy(s, Length(s)-2*i+1, 2);
        x:=x+1;
        if x=16 then begin
          x:=0;
          y:=y+1;
        end;
      end;
      StatusBar.Panels[0].Text:='';
    end;
  end;
end;

procedure TMainForm.LoadMetaClick(Sender: TObject);
var
  i: integer;
begin
  GameItems.Clear;
  GamePathNames.Clear;
  for i:=0 to meta[FileSelect.ItemIndex].infoCount-1 do
    GameItems.Items.Add(meta[FileSelect.ItemIndex].info[i].name);
  if meta[FileSelect.ItemIndex].pathNamesCount>0 then begin
    TabSheet2.TabVisible:=true;
    for i:=0 to meta[FileSelect.ItemIndex].pathNamesCount-1 do
      GamePathNames.Items.Add(meta[FileSelect.ItemIndex].pathNames[i]);
  end else begin
    PageControl1.ActivePage:=TabSheet1;
    TabSheet2.TabVisible:=false;
  end;
end;

procedure TMainForm.Movedown1Click(Sender: TObject);
var
  a: TMetaInfo;
begin
  if (GameItems.ItemIndex>=0) and (GameItems.ItemIndex<GameItems.Items.Count-1) then begin
    a:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex];
    meta[FileSelect.ItemIndex].info[GameItems.ItemIndex]:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex+1];
    meta[FileSelect.ItemIndex].info[GameItems.ItemIndex+1]:=a;
    GameItems.Items[GameItems.ItemIndex]:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].name;
    GameItems.Items[GameItems.ItemIndex+1]:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex+1].name;
    GameItems.ItemIndex:=GameItems.ItemIndex+1;
  end;
end;

procedure TMainForm.Movetobottom2Click(Sender: TObject);
var
  a: TMetaInfo;
  i: integer;
begin
  if (GameItems.ItemIndex>=0) and (GameItems.ItemIndex<GameItems.Items.Count-1) then begin
    a:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex];
    for i:=GameItems.ItemIndex+1 to GameItems.Items.Count-1 do begin
      meta[FileSelect.ItemIndex].info[i-1]:=meta[FileSelect.ItemIndex].info[i];
      GameItems.Items[i-1]:=GameItems.Items[i];
    end;
    meta[FileSelect.ItemIndex].info[GameItems.Items.Count-1]:=a;
    GameItems.Items[GameItems.Items.Count-1]:=a.name;
  end;
end;

procedure TMainForm.Movetotop1Click(Sender: TObject);
var
  a: TMetaInfo;
  i: integer;
begin
  if GameItems.ItemIndex>0 then begin
    a:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex];
    for i:=GameItems.ItemIndex-1 downto 0 do begin
      meta[FileSelect.ItemIndex].info[i+1]:=meta[FileSelect.ItemIndex].info[i];
      GameItems.Items[i+1]:=GameItems.Items[i];
    end;
    meta[FileSelect.ItemIndex].info[0]:=a;
    GameItems.Items[0]:=a.name;
  end;
end;

procedure TMainForm.Moveup1Click(Sender: TObject);
var
  a: TMetaInfo;
begin
  if GameItems.ItemIndex>0 then begin
    a:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex];
    meta[FileSelect.ItemIndex].info[GameItems.ItemIndex]:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex-1];
    meta[FileSelect.ItemIndex].info[GameItems.ItemIndex-1]:=a;
    GameItems.Items[GameItems.ItemIndex]:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex].name;
    GameItems.Items[GameItems.ItemIndex-1]:=meta[FileSelect.ItemIndex].info[GameItems.ItemIndex-1].name;
    GameItems.ItemIndex:=GameItems.ItemIndex-1;
  end;
end;

procedure TMainForm.PageControl2Change(Sender: TObject);
begin
  if PageControl2.ActivePage=TabSheet3 then
    StatusBar.Panels[0].Text:=ExtractFileName(FileSelect.Text)+' - '+IntToStr(Length(meta[FileSelect.ItemIndex].info))+' entries'
  else if PageControl2.ActivePage=TabSheet4 then
    StatusBar.Panels[0].Text:=ExtractFileName(SpeechSelect.Text)+' - '+IntToStr(Length(speech[SpeechSelect.ItemIndex].FileElemsInfo))+' entries'
  else if PageControl2.ActivePage=TabSheet6 then
    StatusBar.Panels[0].Text:='';
end;

{procedure TMainForm.PlayButtonClick(Sender: TObject);
begin
  if (isPaused) and (isPlaying) then begin
    PlayButton.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'data\resources\pause.png');
    isPaused:=false;
    BASS_ChannelPlay(Sound, false);
    Timer1.Enabled:=true;
  end else if isPlaying then begin
    PlayButton.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'data\resources\play.png');
    isPaused:=true;
    BASS_ChannelPause(Sound);
    Timer1.Enabled:=false;
    StatusBar.Panels[1].Text:='Paused - '+FormatDateTime('hh:nn:ss', BASS_ChannelBytes2Seconds(Sound, BASS_ChannelGetPosition(Sound, BASS_POS_BYTE))/SecsPerDay);
  end else if isFileLoaded then begin
    PlayButton.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'data\resources\pause.png');
    if PageControl3.ActivePage=AudioBank then
      AudBSGDblClick(nil)
    else if PageControl3.ActivePage=AudioFile then begin
      BASS_ChannelStop(Sound);
      BASS_StreamFree(Sound);
      audio.ExportAudio(actAudio, 0, 'd:\multi.wav');
      Sound:=BASS_StreamCreateFile(false, PChar('d:\multi.wav'), 0, 0, 0 {$IFDEF UNICODE} //or BASS_UNICODE {$ENDIF});
 {     PlayerPB.Max:=Trunc(BASS_ChannelGetLength(Sound, 0)/Divider);
      BASS_ChannelPlay(Sound, false);
      PlayButton.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'data\resources\pause.png');
      Timer1.Enabled:=true;
      isPlaying:=true;
    end;
    Timer1.Enabled:=true;
  end;
end;}

{procedure TMainForm.ForwardButtonClick(Sender: TObject);
begin
  if not (isPlaying) and not (AudBSG.Row=AudBSG.RowCount-1) then
    AudBSG.Row:=AudBSG.Row+1
  else if (isPlaying) and not (AudBSG.Row=AudBSG.RowCount-1) then begin
    AudBSG.Row:=AudBSG.Row+1;
    PlayButton.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'data\resources\pause.png');
    AudBSGDblClick(nil);
    Timer1.Enabled:=true;
  end;
end;}

{procedure TMainForm.BackwardButtonClick(Sender: TObject);
begin
  if not (isPlaying) and not (AudBSG.Row=1) then
    AudBSG.Row:=AudBSG.Row-1
  else if (isPlaying) and not (AudBSG.Row=1) then begin
    AudBSG.Row:=AudBSG.Row-1;
    PlayButton.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'data\resources\pause.png');
    AudBSGDblClick(nil);
    Timer1.Enabled:=true;
  end;
end;}

{procedure TMainForm.PlayerPBMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  newPosition: integer;
begin
  if (ssLeft in Shift) and (isPlaying or isPaused) then begin
    isScrolling:=true;
    newPosition:=Round(X*PlayerPB.Max/PlayerPB.ClientWidth);
    PlayerPB.Position:=newPosition;
    BASS_ChannelSetPosition(Sound, PlayerPB.Position*Divider, 0);
  end else isScrolling:=false;
end; }

procedure TMainForm.HashesRebuild(n: integer);
var
  i, j: integer;
  a: cardinal;
  s: string;
begin
  SetLength(meta[n].hashes1, 0);
  SetLength(meta[n].hashes2, 0);
  a:=9;
  for i:=0 to meta[n].infoCount-1 do begin
    if Length(meta[n].info[i].hashes)>0 then
      for j:=0 to Length(meta[n].info[i].hashes)-1 do begin
        SetLength(meta[n].hashes1, Length(meta[n].hashes1)+1);
        meta[n].hashes1[Length(meta[n].hashes1)-1]:=a+meta[n].info[i].hashes[j];
      end;
    if Length(meta[n].info[i].hashes2)>0 then
      for j:=0 to Length(meta[n].info[i].hashes2)-1 do begin
        SetLength(meta[n].hashes2, Length(meta[n].hashes2)+1);
        meta[n].hashes2[Length(meta[n].hashes2)-1]:=a+meta[n].info[i].hashes2[j];
      end;
    a:=a+Length(meta[n].info[i].data)+1;
  end;
  meta[n].hashes1Count:=Length(meta[n].hashes1);
  meta[n].hashes2Count:=Length(meta[n].hashes2);
end;

procedure TMainForm.hisfiletooP1Click(Sender: TObject);
var
  f, temp: TMemoryStream;
  m: TMetaFile;
  t: TextFile;
  i, j: integer;
begin
  if OpenDialog2.Execute then begin
    TDirectory.CreateDirectory(ChangeFileExt(OpenDialog2.FileName, ''));
    f:=TMemoryStream.Create;
    f.LoadFromFile(OpenDialog2.FileName);
    m:=TMetaFile.Create;
    m.Load(f);
    AssignFile(t, ChangeFileExt(OpenDialog2.FileName, '.odat'));
    ReWrite(t);
    WriteLn(t, m.version);
    WriteLn(t, m.pathNamesCount);
    for i:=0 to m.pathNamesCount-1 do
      WriteLn(t, m.pathNames[i]);
    WriteLn(t, m.infoCount);
    for i:=0 to m.infoCount-1 do begin
      temp:=TMemoryStream.Create;
      temp.Position:=0;
      temp.Write(m.info[i].data, m.info[i].infoSize);
      temp.SaveToFile(ChangeFileExt(OpenDialog2.FileName, '')+'\'+m.info[i].name+'.bin');
      temp.Free;
      WriteLn(t, m.info[i].name);
      {if Length(m.info[i].hashes)>0 then
        for j:=0 to Length(m.info[i].hashes)-1 do
          Write(t, m.info[i].hashes[j], ' ');
      WriteLn;
      if Length(m.info[i].hashes2)>0 then
        for j:=0 to Length(m.info[i].hashes2)-1 do
          Write(t, m.info[i].hashes2[j], ' ');
      WriteLn;}
    end;
    WriteLn(t, m.hashes1Count);
    for i:=0 to m.hashes1Count-1 do
      WriteLn(t, m.hashes1[i]);
    WriteLn(t, m.hashes2Count);
    for i:=0 to m.hashes2Count-1 do
      WriteLn(t, m.hashes2[i]);
    CloseFile(t);
    m.Free;
    f.Free;
  end;
end;

procedure TMainForm.oPtofile1Click(Sender: TObject);
var
  m: TMetaFile;
  temp: TMemoryStream;
  t: TextFile;
  i, j: integer;
begin
  if OpenDialog2.Execute then begin
    AssignFile(t, OpenDialog2.FileName);
    Reset(t);
    m:=TMetaFile.Create;
    ReadLn(t, m.version);
    ReadLn(t, m.pathNamesCount);
    SetLength(m.pathNames, m.pathNamesCount);
    for i:=0 to m.pathNamesCount-1 do
      ReadLn(t, m.pathNames[i]);
    ReadLn(t, m.infoCount);
    SetLength(m.info, m.infoCount);
    for i:=0 to m.infoCount-1 do begin
      ReadLn(t, m.info[i].name);
      temp:=TMemoryStream.Create;
      temp.LoadFromFile(ChangeFileExt(OpenDialog2.FileName, '')+'\'+m.info[i].name+'.bin');
      temp.Position:=0;
      SetLength(m.info[i].data, temp.Size);
      temp.Read(m.info[i].data, temp.Size);
      temp.Free;
    end;
    ReadLn(t, m.hashes1Count);
    SetLength(m.hashes1, m.hashes1Count);
    for i:=0 to m.hashes1Count-1 do
      ReadLn(t, m.hashes1[i]);
    ReadLn(t, m.hashes2Count);
    SetLength(m.hashes2, m.hashes2Count);
    for i:=0 to m.hashes2Count-1 do
      ReadLn(t, m.hashes2[i]);
    m.Rebuild;
    m.Save(ChangeFileExt(OpenDialog2.FileName, '.dat'+IntToStr(m.version)));
    CloseFile(t);
    m.Free;
  end;
end;

procedure TMainForm.Insert1Click(Sender: TObject);
var
  s: string;
begin
  s:=InputBox('', 'Enter the path', '');
  if not (s='') and not (CheckString(s)) then begin
    SetLength(meta[FileSelect.ItemIndex].pathNames, Length(meta[FileSelect.ItemIndex].pathNames)+1);
    s:=UpperCase(StringReplace(s, '/', '\', [rfReplaceAll]));
    meta[FileSelect.ItemIndex].pathNames[Length(meta[FileSelect.ItemIndex].pathNames)-1]:=s;
    GamePathNames.Items.Add(s);
    Inc(meta[FileSelect.ItemIndex].pathNamesCount);
    hashes.WriteString('hashes', IntToStr(GetHash(s)), s);
    sc.FileList.Items:=GamePathNames.Items;
  end;
end;

procedure TMainForm.JvSpinEdit1Change(Sender: TObject);
begin
  if JvSpinEdit1.Value=0 then begin
    SpeechGrid.RowCount:=2;
    SpeechGrid.FixedRows:=1;
  end else begin
    SpeechGrid.RowCount:=Round(JvSpinEdit1.Value)+1;
    SpeechGrid.FixedRows:=1;
  end;
end;

procedure TMainForm.Rename1Click(Sender: TObject);
var
  s: string;
begin
  if GamePathNames.ItemIndex>=0 then begin
    s:=InputBox('', 'Enter the path', meta[FileSelect.ItemIndex].pathNames[Length(meta[FileSelect.ItemIndex].pathNames)-1]);
    if not (s='') and not (CheckString(s)) then begin
      s:=UpperCase(StringReplace(s, '/', '\', [rfReplaceAll]));
      meta[FileSelect.ItemIndex].pathNames[GamePathNames.ItemIndex]:=s;
      GamePathNames.Items[GamePathNames.ItemIndex]:=s;
      hashes.WriteString('hashes', IntToStr(GetHash(s)), s);
      sc.FileList.Items:=GamePathNames.Items;
    end;
  end;
end;

procedure TMainForm.Save1Click(Sender: TObject);
var
  time: TDateTime;
  s: string;
  i: integer;
begin
  for i:=0 to FileSelect.Items.Count-1 do begin
    HashesRebuild(i);
    if Makebackups1.Checked then begin
      time:=Now;
      DateTimeToString(s, '_ddmmyyyy_hhmmss', time);
      CopyFile(PWideChar(gtaPath+'\'+FileSelect.Items[i]), PWideChar(gtaPath+'\'+FileSelect.Items[i]+s), false);
      meta[i].Rebuild;
      meta[i].Save(gtaPath+'\'+FileSelect.Items[i]);
    end else begin
      meta[i].Rebuild;
      meta[i].Save(gtaPath+'\'+FileSelect.Items[i]);
    end;
  end;
end;

procedure TMainForm.Save2Click(Sender: TObject);
var
  time: TDateTime;
  s: string;
begin
  if PageControl2.ActivePage=TabSheet3 then begin
    HashesRebuild(FileSelect.ItemIndex);
    if Makebackups1.Checked then begin
      time:=Now;
      DateTimeToString(s, '_ddmmyyyy_hhmmss', time);
      CopyFile(PWideChar(gtaPath+'\'+FileSelect.Items[FileSelect.ItemIndex]), PWideChar(gtaPath+'\'+FileSelect.Items[FileSelect.ItemIndex]+s), false);
      meta[FileSelect.ItemIndex].Rebuild;
      meta[FileSelect.ItemIndex].Save(gtaPath+'\'+FileSelect.Items[FileSelect.ItemIndex]);
    end else begin
      meta[FileSelect.ItemIndex].Rebuild;
      meta[FileSelect.ItemIndex].Save(gtaPath+'\'+FileSelect.Items[FileSelect.ItemIndex]);
    end;
  end else if PageControl2.ActivePage=TabSheet6 then
    SynEdit1.Lines.SaveToFile(gtaPath+'\'+XMLSelect.Items[XMLSelect.ItemIndex])
  else if PageControl2.ActivePage=TabSheet4 then begin
    if Makebackups1.Checked then begin
      time:=Now;
      DateTimeToString(s, '_ddmmyyyy_hhmmss', time);
      CopyFile(PWideChar(gtaPath+'\'+SpeechSelect.Items[SpeechSelect.ItemIndex]), PWideChar(gtaPath+'\'+SpeechSelect.Items[SpeechSelect.ItemIndex]+s), false);
      speech[SpeechSelect.ItemIndex].Rebuild;
      speech[SpeechSelect.ItemIndex].Save(gtaPath+'\'+SpeechSelect.Items[SpeechSelect.ItemIndex]);
    end else begin
      speech[SpeechSelect.ItemIndex].Rebuild;
      speech[SpeechSelect.ItemIndex].Save(gtaPath+'\'+SpeechSelect.Items[SpeechSelect.ItemIndex]);
    end;
  end;
end;

procedure TMainForm.Setgamedirectory1Click(Sender: TObject);
begin
  if SelectDirectory('Select folder with GTA IV or EFLC', '', gtaPath) then begin
    if FileExists(gtaPath+'\GTAIV.exe') or FileExists(gtaPath+'\EFLC.exe') then begin
      iniSettings.WriteString('Settings', 'Path', gtaPath);
      iniSettings.UpdateFile;
      ShellExecute(Handle, nil, PChar(Application.ExeName), nil, nil, SW_SHOWNORMAL);
      Application.Terminate;
    end else
      MessageBox(Handle, 'GTAIV.exe or EFLC.exe is not found', 'Error', MB_OK + MB_ICONWARNING);
  end;
end;

end.
