unit USms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdFTP, StdCtrls, Buttons,Shellapi,
  ExtCtrls, ACBrBase, ACBrSMS,math,ACBrSMSDaruma, ACBrSMSClass,DateUtils,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,WinInet, OoMisc,
  AdFax, IdIntercept, IdLogBase, IdLogEvent, AppEvnts, WideStrings, SqlExpr, DB,
  ADODB, Grids, DBGrids;

type
  TFVerificador = class(TForm)
    IdFTP1: TIdFTP;
    mmClientes: TMemo;
    gbConexao: TGroupBox;
    lbCNPJ1: TLabel;
    tAguardaConexao: TTimer;
    dbPrincipal: TADOConnection;
    qrySms: TADOQuery;
    qrySmsCNPJ: TStringField;
    qrySmsmensagem: TStringField;
    qrySmsdata: TDateField;
    qrySmshora: TTimeField;
    pnAguardandoConexao: TPanel;
    qrySmsNumeroEnvio: TStringField;
    qrySmsComputadorEnvio: TStringField;
    qrySmsEnviado: TIntegerField;
    btAtivar: TBitBtn;
    qryClientes: TADOQuery;
    qryClientesid: TIntegerField;
    qryClientesNome: TStringField;
    qryClientesCnpj: TStringField;
    lbContaFechamento: TLabel;
    tContaFechamento: TTimer;
    Tverificando: TTimer;
    qryVerificaDestinatario: TADOQuery;
    qrySmsRecebido: TADOQuery;
    qryVerificaDestinatarioCnpj: TStringField;
    qrySmsRecebidoNumero: TStringField;
    IdFTP2: TIdFTP;
    qrySmsRecebidoMensagem: TStringField;
    qrySmsRecebidoData: TStringField;
    qrySmsRecebidoHora: TStringField;
    qrySmsRecebidoDestinatario: TStringField;
    qryGravaSmsRecebido: TADOQuery;
    qryGravaSmsRecebidoDestinatario: TStringField;
    qryGravaSmsRecebidoNumero: TStringField;
    qryGravaSmsRecebidoMensagem: TStringField;
    qryGravaSmsRecebidoData: TStringField;
    qryGravaSmsRecebidoHora: TStringField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Memo1: TMemo;
    qryVerificaDestinatarioMensagem: TStringField;
    qryGravaSmsRecebidoOriginal: TStringField;
    qrySmsid: TAutoIncField;
    qrySmsRecebidoId: TAutoIncField;
    qrySmsTipo: TStringField;
    qrySmsRemetente: TStringField;
    qrySmscelular: TStringField;
    qryTextoEmail: TADOQuery;
    qryTextoEmailTexto: TMemoField;
    qryTextoEmailCnpj: TStringField;
    mmTextoEmail: TMemo;
    qryTextoEmailCodigoTextoEmail: TStringField;
    qrySmsCodigoTextoEmail: TStringField;
    aeControlaErros: TApplicationEvents;
    procedure btAtivarClick(Sender: TObject);
    procedure tAguardaConexaoTimer(Sender: TObject);
    procedure aeControlaErrosException(Sender: TObject; E: Exception);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tContaFechamentoTimer(Sender: TObject);
    procedure TverificandoTimer(Sender: TObject);
    procedure aeControlaErrosMessage(var Msg: tagMSG; var Handled: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FVerificador: TFVerificador;
  ExisteArquivoFtp : Boolean;
implementation

{$R *.dfm}

Function RemoveAcento(Texto: string): String;
  const
    sLetraA = 'áéíóúàèìòùâêîôûäëïöüãõñçÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÄËÏÖÜÃÕÑÇ';
    sLetraB = 'aeiouaeiouaeiouaeiouaoncAEIOUAEIOUAEIOUAEIOUAONC';
  var
    i: Integer;
  begin
    for i := 1 to Length(sLetraA)  do
      Texto := StringReplace(Texto, sLetraA[i], sLetraB[i], [rfReplaceAll, rfIgnoreCase]);
    Result := Texto;
  End;

Procedure BuscaArquivoFtp(Arquivo,Empresa : String);
begin
  if not DirectoryExists(Empresa) then
    CreateDir(Empresa);
  FVerificador.IdFTP1.Get(Arquivo,Empresa+'\'+Arquivo, true, false);
end;

Procedure ConectaFtpRecebidos(Pasta : String);
begin
  FVerificador.idFtp2.Host := 'ftp.bibia.com.br';
  FVerificador.idFtp2.Port := 21;
  FVerificador.idFtp2.Username := Trim(Pasta)+'@bibia.com.br';
  FVerificador.idFtp2.Password := 'cadmus182';
  FVerificador.idFtp2.Passive := True; { usa modo ativo }
  try
    { Espera até 10 segundos pela conexão }
    FVerificador.idFtp2.Connect;
  except on E: Exception do
    //Showmessage(E.Message);
  end;
  //FVerificador.lbCNPJ1.Caption := Pasta;
end;

Procedure EnviaAcrescentaArquivo(Arquivo,Destinatario : String);

  Function VerificaExisteArquivoFtp(Arquivo : String):Boolean ;
  begin
    Result:= False;
    if (FVerificador.IdFTP2.Size(Arquivo) > 0)  then  begin
      Result := True;
    end;
  end;

  Procedure BuscaArquivoFtp(Arquivo : String);
  begin
    if not DirectoryExists('Acrescenta') then
      CreateDir('Acrescenta');
    FVerificador.IdFTP2.Get(Arquivo,'Acrescenta\'+Arquivo, true, false);
  end;

  Procedure AcrescentaDados(Arquivo : String);
  Var ArqFtp,ArqLocal : TextFile;
  Linha : String;
  begin
    AssignFile(ArqLocal,Arquivo);
    Reset(ArqLocal);
    AssignFile(ArqFtp,'Acrescenta\'+Arquivo);
    Append(ArqFtp);
    while not eof(ArqLocal) do begin
      Readln(ArqLocal,Linha);
      Writeln(ArqFtp,Linha);
    end;
    CloseFile(ArqLocal);
    CloseFile(ArqFtp);
  end;

  Procedure DesconectaFtp2;
  begin
  Try
    FVerificador.idFtp2.Disconnect();
  except
  End;
  end;

begin
  ConectaFtpRecebidos(Destinatario);
  if VerificaExisteArquivoFtp(Arquivo) = True then begin
    BuscaArquivoFtp(Arquivo);
    AcrescentaDados(Arquivo);
    if VerificaExisteArquivoFtp(Arquivo) = True then begin
      Try
        FVerificador.IdFTP2.Put('Acrescenta\'+Arquivo,Arquivo,True)
      except on E: Exception do
      end;
      DesconectaFtp2;
      DeleteFile('Acrescenta\'+Arquivo);
    end else begin
      Try
        FVerificador.IdFTP2.Put(Arquivo,Arquivo,True);
      except on E: Exception do
      end;
      DesconectaFtp2;
      DeleteFile(Arquivo);
    end;
    DesconectaFtp2;
    DeleteFile('Acrescenta\'+Arquivo);
  end else begin
    Try
      FVerificador.IdFTP2.Put('Recebidos.txt','Recebidos.txt',False);
    except on E: Exception do
    end;
    DesconectaFtp2;
    DeleteFile(Arquivo);
  end;
end;


Procedure DesconectaBanco;
begin
  FVerificador.dbPrincipal.Connected:= False;
  FVerificador.qrySms.Active := False;
  FVerificador.qryClientes.Active := False;
end;

procedure ConectaBanco;
begin
  FVerificador.qryClientes.Active := True;
  Fverificador.dbPrincipal.Connected:= True;
  FVerificador.qrySms.Active := True;
end;

Procedure VerificaConexao;
var i : DWord;
begin
  if not InternetGetConnectedState(@i,0) then begin
    FVerificador.pnAguardandoConexao.Show;
    FVerificador.tAguardaConexao.Enabled := True;
    FVerificador.Tverificando.Enabled := False;
  end;
end;

function GetFileSize(const FileName: string): Int64;
var
  Handle: THandle;
  FindData: TWin32FindData;
begin
  Handle := FindFirstFile(PChar(FileName), FindData);
  if Handle <> INVALID_HANDLE_VALUE then begin
    Windows.FindClose(Handle);
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      Int64Rec(Result).Lo := FindData.nFileSizeLow;
      Int64Rec(Result).Hi := FindData.nFileSizeHigh;
      Exit;
    end;
  end;
  Result := -1;
end;

function VerificaPausa(Numero : Integer):Boolean;
var conta : Real;
begin
  Result := False;
  conta := (Numero/20);
  if (Numero/20)  = 1  then begin
    Sleep(30000);
  end;
  if (Numero/600) = 1 then
    Sleep(60000);
end;

Procedure AtivarEnvio;
begin
  FVerificador.btAtivar.Caption := 'Desativar';
  FVerificador.btAtivar.Font.Color := clRed;
  FVerificador.Tverificando.Enabled := True;
end;

Procedure DesativarEnvio;
Begin
  FVerificador.btAtivar.Caption := 'Ativar' ;
  FVerificador.btAtivar.Font.Color := clGreen;
  FVerificador.Tverificando.Enabled := False;
End;



procedure TFVerificador.aeControlaErrosException(Sender: TObject; E: Exception);
begin
  Application.Terminate;
  //showmessage(E.Message);
end;

procedure TFVerificador.aeControlaErrosMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  //application.Terminate;
end;

procedure TFVerificador.btAtivarClick(Sender: TObject);
begin
  if btAtivar.Caption = 'Ativar'  then
    AtivarEnvio
  else if btAtivar.Caption = 'Desativar' then
    DesativarEnvio;
end;

procedure TFVerificador.tContaFechamentoTimer(Sender: TObject);

   procedure GerarArquivoDestinatarioSmsRecebido(Destinatario,Numero,Msg,Data,Hora,MensagemOriginal : String);
   var Arq : TextFile;
   begin
     AssignFile(Arq,'Recebidos.txt');
     Rewrite(Arq);
     Writeln(Arq,'Numero: '+Numero+' Msg '+Msg +' - '+ Data + ' - ' + Hora +' - Mensagem Original - ' +MensagemOriginal );
     CloseFile(Arq);
     ConectaFtpRecebidos(Destinatario);
     Try
       IdFTP2.Put('Recebidos.txt','Recebidos.txt',True);
     finally
       DeleteFile('Recebidos.txt');
       idftp2.Disconnect();
     End;
     memo1.Lines.Add('Numero: '+Numero+' Msg '+Msg +' - '+ Data + ' - ' + Hora);
   end;

   procedure GravaDestinatarioSmsRecebido(Destinatario,Mensagem : String ; id : Integer);
   begin
     qryGravaSmsRecebido.Close;
     qryGravaSmsRecebido.Parameters.ParamByName('id').Value :=Id;
     qryGravaSmsRecebido.Open;
     qryGravaSmsRecebido.Edit;
     qryGravaSmsRecebidoDestinatario.Value := Destinatario;
     qryGravaSmsRecebidoOriginal.Value :=  Mensagem;
     qryGravaSmsRecebido.Post;
   end;

   procedure VerificaDestinatarioSmsRecebido;
   Var Total,Contador : Integer;
   begin
     dbPrincipal.Connected := False;
     dbPrincipal.Connected := True;
     qrySmsRecebido.Active := True;
     qryVerificaDestinatario.Active := True;
     if qrySmsRecebido.RecordCount > 0 then begin
       Total := qrySmsRecebido.RecordCount;
       Contador := 1;
       while Total >= Contador do begin
         qryVerificaDestinatario.Close;
         qryVerificaDestinatario.Parameters.ParamByName('Celular').Value :=
         Trim(qrySmsRecebidoNumero.Value) ;
         qryVerificaDestinatario.Open;
         if qryVerificaDestinatario.RecordCount > 0 then begin
           GerarArquivoDestinatarioSmsRecebido(qryVerificaDestinatarioCnpj.Value,
           qrySmsRecebidoNumero.Value,
           qrySmsRecebidoMensagem.Value,
           qrySmsRecebidoData.Value,
           qrySmsRecebidoHora.Value,
           qryVerificaDestinatarioMensagem.Value);
           GravaDestinatarioSmsRecebido(qryVerificaDestinatarioCnpj.Value,
           qryVerificaDestinatarioMensagem.Value,
           qrySmsRecebidoId.value);
         end;
         qrySmsRecebido.Next;
         Contador := Contador + 1;
       end;
     end;
     application.Terminate;
   end;

begin
  if Trim(lbContaFechamento.Caption) <> '0'  then
    lbContaFechamento.Caption :=  IntToStr(StrToInt(lbContaFechamento.Caption)  - 1);
  if (Trim(lbContaFechamento.Caption) = '0') and not ( qrySms.State in [dsInsert] ) then begin
    tContaFechamento.Enabled := False;
    VerificaDestinatarioSmsRecebido;
    tContaFechamento.Enabled := True;

  end;
end;

procedure TFVerificador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //DesconectaFtp1;
end;

procedure TFVerificador.tAguardaConexaoTimer(Sender: TObject);
var i : Dword;
begin
  if InternetGetConnectedState(@i,0) then begin
    //tVerifica.Enabled := True;
    pnAguardandoConexao.Visible := False;
    tAguardaConexao.Enabled := False;
  end else begin
    pnAguardandoConexao.Show;
  end;
end;

procedure TFVerificador.TverificandoTimer(Sender: TObject);
  Procedure ConectaFtp(Pasta : String);
  begin
    VerificaConexao;
    FVerificador.idFtp1.Host := 'ftp.bibia.com.br';
    FVerificador.idFtp1.Port := 21;
    FVerificador.idFtp1.Username := Trim(Pasta)+'@bibia.com.br';
    FVerificador.idFtp1.Password := 'cadmus182';
    FVerificador.idFtp1.Passive := True; { usa modo ativo }
    try
      { Espera até 10 segundos pela conexão }
      FVerificador.idFtp1.Connect;
    except on E: Exception do
    //Showmessage(E.Message);
    end;
  //FVerificador.lbCNPJ1.Caption := Pasta;
  end;



  Procedure DesconectaFtp1;
  begin
  Try
    FVerificador.idFtp1.Disconnect();
  except
  End;
  end;

  procedure BuscaClientes ;
  begin
    ConectaBanco;
    qryClientes.Close;
    qryClientes.Open;
    mmClientes.Clear;
    qryClientes.First;
    while not qryClientes.Eof do begin
      mmClientes.Lines.Add(qryClientes['Cnpj']);
      qryClientes.Next;
    end;
    DesconectaBanco;
  end;

  Function VerificaOTexto(CodigoTextoEmail,Cnpj,Texto : string) : Boolean;
  begin
    Result := False;
    qryTextoEmail.Close;
    qryTextoEmail.SQL.Add('where CodigoTextoEmail='+''''+CodigoTextoEmail+''''+' and '+'Cnpj='+''''+Cnpj+'''');
    qryTextoEmail.Open;
    if qryTextoEmail.RecordCount > 0 then
      if Trim(qryTextoEmail['Texto']) = Trim(Texto) then
        Result := True;
    qryTextoEmail.Close;
    qryTextoEmail.SQL.Text:='Select * from TextoEmail';
    qryTextoEmail.Open;
  end;

  procedure GravaTextoEmail(CodigoTextoEmail,Cnpj,Texto : string);
  begin
    if VerificaOTexto(CodigoTextoEmail,Cnpj,Texto) = False then begin

      qryTextoEmail.Insert;
      qryTextoEmail['CodigoTextoEmail'] := CodigoTextoEmail;
      qryTextoEmail['Cnpj'] := Cnpj;
      qryTextoEmailTexto.LoadFromFile(Cnpj+'\'+CodigoTextoEmail+'.txt');;
      qryTextoEmail.Post;
    end;
  end;

  procedure ApagandoTextoEmail(CodigoTextoEmail,Cnpj,Texto : string);
  begin
    if VerificaOTexto(CodigoTextoEmail,Cnpj,Texto) then
      qryTextoEmail.Delete;
    qryTextoEmail.Close;
    qryTextoEmail.SQL.Text:='Select * from TextoEmail';
    qryTextoEmail.Open;
  end;

  procedure GravaSmsBancoDeDados(Empresa,Celular,Mensagem,Remetente,CodigoTextoEmail,Tipo : String);
  Var Total : Integer;
  begin
    if Tipo = 'E' then begin
      DesconectaFtp1;
      ConectaFtp(Empresa);
      BuscaArquivoFtp(CodigoTextoEmail+'.txt',Empresa);
      mmTextoEmail.Lines.LoadFromFile(Empresa+'\'+CodigoTextoEmail+'.txt');
      //ApagandoTextoEmail(CodigoTextoEmail,Empresa,mmTextoEmail.Lines.Text);
      GravaTextoEmail(CodigoTextoEmail,Empresa,mmTextoEmail.Lines.Text);
      DesconectaFtp1;
    end;
    DesconectaBanco;
    ConectaBanco;
    qrySms.Active := False;
    qrySms.Active := True;
    qrySms.Insert;
    qrySms['CNPJ']:= Empresa;
    qrySms['celular']:=Celular;
    qrySms['mensagem']:= Mensagem;
    qrySms['Enviado']:=0;
    qrySms['Remetente' ] := Remetente ;
    qrySms['CodigoTextoEmail'] :=  CodigoTextoEmail;
    qrySms['Tipo'] := Tipo ;
    Try
      qrySms.Post;
    Finally

    End;
  End;

  Procedure VerificaBuscaLeGravaSms(Arquivo : String);
  Var Mensagem,Celular,Comando : String;
  IndiceMsgEnviada ,Empresa , Remetente,Destinatario,CodigoTextoEmail: STRING;
  Num,ContaMensagens  : Integer;
  Arq : TextFile;
  begin
    ContaMensagens := 0;
    VerificaConexao;
    Empresa := FVerificador.lbCNPJ1.Caption;
    if (FVerificador.IdFTP1.Size(Arquivo) > 0)  then  begin
     if not DirectoryExists(Empresa +'Temporaria') then
        CreateDir(Empresa +'Temporaria');
      VerificaConexao;
      FVerificador.IdFTP1.Get(Arquivo,Empresa+'Temporaria\'+ Arquivo, true, false);
      VerificaConexao;
      FVerificador.IdFTP1.Delete(Arquivo);
      AssignFile(arq,Empresa+'Temporaria\'+Arquivo);
      Reset(Arq);
      while not eof(Arq) do begin
      if (Arquivo = 'EnviaEmailOrcamentoVenda.txt') or (Arquivo = 'EnviaEmailAgendamento.txt') then begin
          Readln(arq, Remetente);
          Readln(arq, Destinatario );
          Readln(arq, Mensagem );
          Readln(arq, CodigoTextoEmail );
          Celular := Destinatario;
          Mensagem:=Mensagem;
          GravaSmsBancoDeDados(Empresa,Celular,Mensagem,Remetente,CodigoTextoEmail,'E');
        end else begin
          Readln(arq, Mensagem );
          Readln(arq, Celular );
          Mensagem:=RemoveAcento(Mensagem);
          if Celular <> '32999872221' then
            GravaSmsBancoDeDados(Empresa,Celular,Mensagem,'','','S');
        end;
      end;
      CloseFile(Arq);
    end;
  end;

  procedure IniciaVerificacao;
  var Contador : Integer;
  begin
    VerificaConexao;
    Contador := 0 ;
    BuscaClientes;
    while FVerificador.mmClientes.Lines.Count-1 >= Contador do begin
      Tverificando.Enabled := False;
      VerificaConexao;
      FVerificador.lbCNPJ1.Caption := FVerificador.mmClientes.Lines[Contador];
      ConectaFtp(FVerificador.mmClientes.Lines[Contador]);
      //VerificaBuscaLeGravaSms('EnviaPromocao.txt');
      //VerificaBuscaLeGravaSms('EnviaInadimplentes.txt');
      //VerificaBuscaLeGravaSms('EnviaAniversarios.txt');
      //VerificaBuscaLeGravaSms('EnviaEntrega.txt');
      VerificaBuscaLeGravaSms('EnviaEmailAgendamento.txt');
      //VerificaBuscaLeGravaSms('EnviaEmailOrcamentoVenda.txt');
      Contador := Contador + 1;
      DesconectaFtp1;
      Application.ProcessMessages;
      Tverificando.Enabled := True;
    end;
    if Trim(lbContaFechamento.Caption) = '0' then
      Application.Terminate;
  end;
begin
  IniciaVerificacao;
end;


end.
