unit StreamCreate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin,
  Vcl.Grids, Utils;

type
  TAStreamCreate = class(TForm)
    OKButton: TButton;
    MainName: TEdit;
    CheckRadio: TCheckBox;
    MaskEdit1: TMaskEdit;
    JvSpinEdit1: TJvSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    FileList: TComboBox;
    ChannelsGrid: TStringGrid;
    Button1: TButton;
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    isCanceled: boolean;
  end;

var
  AStreamCreate: TAStreamCreate;

implementation

{$R *.dfm}

procedure TAStreamCreate.Button1Click(Sender: TObject);
begin
  isCanceled:=true;
  Self.Close;
end;

procedure TAStreamCreate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  isCanceled:=true;
  Self.Close;
end;

procedure TAStreamCreate.JvSpinEdit1Change(Sender: TObject);
begin
  if JvSpinEdit1.Value=0 then
    ChannelsGrid.RowCount:=2
  else
    ChannelsGrid.RowCount:=Round(JvSpinEdit1.Value)+1;
end;

procedure TAStreamCreate.OKButtonClick(Sender: TObject);
begin
  if not (MainName.Text='') and not (CheckString(MainName.Text)) then begin
    isCanceled:=false;
    Self.Close;
  end else
    MessageBox(handle, PChar('The stream name is entered incorrectly'), PChar('Warning'), MB_OK+MB_ICONWARNING);
end;

end.
