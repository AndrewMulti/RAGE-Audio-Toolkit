unit InstUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MetaFiles;

type
  TInstForm = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Save: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InstForm: TInstForm;
  Infos: array of TMetaInfo;

implementation

uses
  Main;

{$R *.dfm}

procedure TInstForm.Button1Click(Sender: TObject);
begin
  ListBox1.Items.Add(Main.MainForm.GameItems.Items[Main.MainForm.GameItems.ItemIndex]);
end;

end.
