program IVAudioMng;

uses
  Vcl.Forms,
  Main in 'Source\Main.pas' {MainForm},
  MetaFiles in 'Source\MetaFiles.pas',
  Utils in 'Source\Utils.pas',
  LoadForm in 'Source\LoadForm.pas' {LForm},
  About in 'Source\About.pas' {AboutForm},
  InstUnit in 'Source\InstUnit.pas' {InstForm},
  uSynEditPopupEdit in 'Source\uSynEditPopupEdit.pas',
  RpfFiles in 'Source\RpfFiles.pas',
  RageAudio in 'Source\RageAudio.pas',
  IMAADPCM in 'Source\IMAADPCM.pas',
  StreamCreate in 'Source\StreamCreate.pas' {AStreamCreate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'RAGE Audio Toolkit';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLForm, LForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TInstForm, InstForm);
  Application.CreateForm(TAStreamCreate, AStreamCreate);
  Application.Run;
end.
