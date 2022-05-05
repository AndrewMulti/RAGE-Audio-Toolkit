unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, JvExControls, JvLabel, Vcl.Imaging.jpeg, Vcl.ComCtrls,
  Vcl.OleCtrls, SHDocVw;

type
  TAboutForm = class(TForm)
    Image1: TImage;
    JvLabel1: TJvLabel;
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  RichEdit1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'data\about.rtf');
end;

end.
