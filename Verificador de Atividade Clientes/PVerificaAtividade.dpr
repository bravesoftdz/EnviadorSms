program PVerificaAtividade;

uses
  Forms,
  UVerificaAtividade in 'UVerificaAtividade.pas' {FMVerificaAtividades},
  DmuVerificaAtividades in 'DmuVerificaAtividades.pas' {dmVerificaAtividades: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMVerificaAtividades, FMVerificaAtividades);
  Application.CreateForm(TdmVerificaAtividades, dmVerificaAtividades);
  Application.Run;
end.
