unit UdmuPrincipal;

interface

uses
  SysUtils, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, ZSqlUpdate;

type
  TdmPrincipal = class(TDataModule)
    dbPrincipal: TZConnection;
    qrySms: TZQuery;
    qryEmail: TZQuery;
    qrySmsData: TDateField;
    qrySmsNumeroDia: TLargeintField;
    qryEmailData: TDateField;
    qryEmailNumeroDia: TLargeintField;
    qryRelClientes: TZQuery;
    qryRelClientesNome: TStringField;
    qryRelClientesCNPJ: TStringField;
    qryRelClientesid: TIntegerField;
    qryRelClientesSENHA: TStringField;
    qryRelClientesCelularAviso: TStringField;
    qryRelClientesEmailAviso: TStringField;
    qryRelClientesUltimaHoraAtivo: TStringField;
    qryRelClientesUltimaDataAtivo: TDateField;
    qryRelClientesDiaVencimento: TIntegerField;
    qryRelClientesPrazoPagamento: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{$R *.dfm}

end.
