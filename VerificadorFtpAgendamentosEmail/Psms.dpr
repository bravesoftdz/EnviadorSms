program Psms;

uses
  Forms,
  USms in 'USms.pas' {FVerificador};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFVerificador, FVerificador);
  Application.Run;
end.
