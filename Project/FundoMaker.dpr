program FundoMaker;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in '..\Unit\Principal.pas' {fmrPrincipal},
  FmrImg in '..\Unit\FmrImg.pas' {fmrImage};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmrPrincipal, fmrPrincipal);
  Application.CreateForm(TfmrImage, fmrImage);
  Application.Run;
end.
