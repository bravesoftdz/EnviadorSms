unit Sms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Shellapi, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
Procedure Inadimplentes ;
begin

end;

Procedure Promoção ;
begin

end;

Procedure AvisoEntrega;
begin

end;

Procedure AvisoChegadaEncomenda;
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://www.fsist.com.br/sms.aspx?tel='  + '4197415798' +  '&msg='+'Teste',nil,nil,SW_HIDE);

end;

procedure TForm1.FormCreate(Sender: TObject);
Procedure ConcectaFtp;
  begin
    idFtp.Disconnect();
    idFtp.Host := 'ftp.bibia.com.br';
    idFtp.Port := 21;
    idFtp.Username := 'envia@bibia.com.br';
    idFtp.Password := 'cadmus182';
    idFtp.Passive := false; { usa modo ativo }
    idFtp.RecvBufferSize := 8192;
    try
      { Espera até 10 segundos pela conexão }
      idFtp.Connect(true, 10000);
    except
      on E: Exception do
      //_Erro = E.Message;
    end;
  end;
begin

end;

end.
