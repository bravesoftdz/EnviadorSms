unit DmuVerificaAtividades;

interface

uses
  SysUtils, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, ExtCtrls, ZSqlUpdate;

type
  TdmVerificaAtividades = class(TDataModule)
    qryEmpresa: TZQuery;
    qrySmsEmail: TZQuery;
    upSmsEmail: TZUpdateSQL;
    qrySmsEmailid: TIntegerField;
    qrySmsEmailCNPJ: TStringField;
    qrySmsEmailmensagem: TStringField;
    qrySmsEmailcelular: TStringField;
    qrySmsEmaildata: TDateField;
    qrySmsEmailhora: TTimeField;
    qrySmsEmailNumeroEnvio: TStringField;
    qrySmsEmailComputadorEnvio: TStringField;
    qrySmsEmailEnviado: TIntegerField;
    qrySmsEmailTipo: TStringField;
    qrySmsEmailRemetente: TStringField;
    qrySmsEmailCodigoTextoEmail: TStringField;
    qryTextoEmail: TZQuery;
    upTextoEmail: TZUpdateSQL;
    qryTextoEmailCodigoTextoEmail: TStringField;
    qryTextoEmailTexto: TMemoField;
    qryTextoEmailCnpj: TStringField;
    TPingServer: TTimer;
    dbPrincipal: TZConnection;
    qryEmpresaNome: TStringField;
    qryEmpresaCnpj: TStringField;
    qryEmpresaUltimaDataAtivo: TDateField;
    qryEmpresaUltimaHoraAtivo: TStringField;
    qryEmpresaEmailAviso: TStringField;
    qryEmpresaCelularAviso: TStringField;
    qryEmpresaStatus: TStringField;
    procedure TPingServerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmVerificaAtividades: TdmVerificaAtividades;

implementation

{$R *.dfm}


procedure TdmVerificaAtividades.TPingServerTimer(Sender: TObject);
begin
  dbPrincipal.PingServer;
end;

end.
