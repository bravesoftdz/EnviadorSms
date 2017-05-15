program PEnviadorEmail;

uses
  Forms,
  UEnviadorSms in 'UEnviadorSms.pas' {FEnviaEmail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFEnviaEmail, FEnviaEmail);
  Application.Run;
end.
