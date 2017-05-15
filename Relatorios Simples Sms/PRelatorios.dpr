program PRelatorios;

uses
  Forms,
  URelatorios in 'URelatorios.pas' {fmRelatorios},
  UdmuPrincipal in 'UdmuPrincipal.pas' {dmPrincipal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmRelatorios, fmRelatorios);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.Run;
end.
