unit LoadForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TLForm = class(TForm)
    Image1: TImage;
    LoadText: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LForm: TLForm;

implementation

{$R *.dfm}

end.
