program PVisualizadorEnvios;

uses
  Forms,
  UVisualizadorEnvios in 'UVisualizadorEnvios.pas' {fVerificadator};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfVerificadator, fVerificadator);
  Application.Run;
end.
