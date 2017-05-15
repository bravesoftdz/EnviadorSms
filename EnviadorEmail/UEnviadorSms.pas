unit UEnviadorSms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ACBrBase, ACBrSMS,ACBrSMSClass, DB, ADODB, StdCtrls, Buttons, Grids,
  DBGrids, AppEvnts,Shellapi,WinInet, ACBrMail, ZSqlUpdate, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection, IBEvents;

type
  TFEnviaEmail = class(TForm)
    TVerificaNovoRegistro: TTimer;
    gbConfigurar: TGroupBox;
    btAtivarDesativar: TBitBtn;
    lbEnviados: TLabel;
    ds: TDataSource;
    dsModem: TDataSource;
    lbUltimoEnvio: TLabel;
    lbDataHoraUltimoEnvio: TLabel;
    lbUltimoResete: TLabel;
    lbDataHoraUltimoResete: TLabel;
    lbUsuarioBanco: TLabel;
    lbVersao: TLabel;
    lbTituloEnviados: TLabel;
    lbTituloNEnviados: TLabel;
    lbNEnviados: TLabel;
    lbRemoto: TLabel;
    tRemoto: TTimer;
    mmErro: TMemo;
    Email: TACBrMail;
    dbPrincipal: TZConnection;
    qryTotalEnviados: TZQuery;
    upTotalEnviados: TZUpdateSQL;
    qryEmail: TZQuery;
    upSms: TZUpdateSQL;
    upSmsRecebidos: TZUpdateSQL;
    qryUpdate: TZQuery;
    qryRemoto: TZQuery;
    qryReenvia: TZQuery;
    qryModem: TZQuery;
    upModem: TZUpdateSQL;
    qryEmpresa: TZQuery;
    qryTextoEmail: TZQuery;
    TPingServer: TTimer;
    dbErro: TZConnection;
    qryErro: TZQuery;
    upErro: TZUpdateSQL;
    cbUsuario: TEdit;
    qryListaNegra: TZQuery;
    ckPrioriadade: TCheckBox;
    edPrioridade: TEdit;
    ckNaoEnviar: TCheckBox;
    qryEmpresaNome: TWideStringField;
    qryModemNumero: TWideStringField;
    qryModemData: TDateField;
    qryModemHora: TTimeField;
    qryModemEnvios: TIntegerField;
    qryModemLimite: TIntegerField;
    qryModemUltima: TTimeField;
    qryModemUltimoEnvio: TWideStringField;
    qryModemIntervalo: TIntegerField;
    qryModemStatus: TWideStringField;
    qryModemErro: TWideStringField;
    qryModemPrioridade: TWideStringField;
    qryTotalEnviadosid: TIntegerField;
    qryTotalEnviadosCNPJ: TWideStringField;
    qryTotalEnviadosmensagem: TWideStringField;
    qryTotalEnviadoscelular: TWideStringField;
    qryTotalEnviadosdata: TDateField;
    qryTotalEnviadoshora: TTimeField;
    qryTotalEnviadosNumeroEnvio: TWideStringField;
    qryTotalEnviadosComputadorEnvio: TWideStringField;
    qryTotalEnviadosEnviado: TIntegerField;
    qryTotalEnviadosTipo: TWideStringField;
    qryTotalEnviadosRemetente: TWideStringField;
    qryTotalEnviadosCodigoTextoEmail: TWideStringField;
    qryTotalEnviadosValidado: TWideStringField;
    qryEmailid: TIntegerField;
    qryEmailCNPJ: TWideStringField;
    qryEmailmensagem: TWideStringField;
    qryEmailcelular: TWideStringField;
    qryEmaildata: TDateField;
    qryEmailhora: TTimeField;
    qryEmailNumeroEnvio: TWideStringField;
    qryEmailComputadorEnvio: TWideStringField;
    qryEmailEnviado: TIntegerField;
    qryEmailTipo: TWideStringField;
    qryEmailRemetente: TWideStringField;
    qryEmailCodigoTextoEmail: TWideStringField;
    qryEmailValidado: TWideStringField;
    qryRemotoStatus: TWideStringField;
    qryRemotoPrioridade: TWideStringField;
    qryListaNegraDescricao: TWideStringField;
    qryErroErro: TWideStringField;
    qryTextoEmailTexto: TWideMemoField;
    rgEnviador: TRadioGroup;
    procedure TVerificaNovoRegistroTimer(Sender: TObject);
    procedure btAtivarDesativarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aeControlaErrosActionExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure aeControlaErrosMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure tTempoFecharTimer(Sender: TObject);
    procedure aeControlaErrosException(Sender: TObject; E: Exception);
    procedure tRemotoTimer(Sender: TObject);
    procedure lbRemotoClick(Sender: TObject);
   // procedure tReenviaTimer(Sender: TObject);
//    procedure ckReenviarClick(Sender: TObject);
    procedure TPingServerTimer(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure BitBtn1Click(Sender: TObject);
    procedure ckPrioriadadeClick(Sender: TObject);
    procedure ckNaoEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEnviaEmail: TFEnviaEmail;

implementation


{$R *.dfm}

function ListaNegra(DescricaoEmail : String) : Boolean;
begin
  Result := False;
  with FEnviaEmail do
  begin
    qryListaNegra.Active := true;
    qryListaNegra.Close;
    qryListaNegra.ParamByName('Descricao').Value :=
    AnsiLowerCase(DescricaoEmail);
    qryListaNegra.Open;
    if qryListaNegra.RecordCount > 0 then
      Result := True;
  end;
end;


function ValidarEMail(aStr: string): Boolean; 
var Email,Mostra : String;
begin
 aStr := Trim(UpperCase(aStr));
 Email := Trim(UpperCase(aStr));
 Result := False;
 if Pos('@', aStr) > 1 then
 begin
   Delete(aStr, 1, pos('@',aStr));
   Mostra := LowerCase(copy(Email,1,Pos('@', Email)-1));
   if ListaNegra(Mostra) = False then
     Result := (Length(aStr) > 0) and (Pos('.', aStr) > 2);
 end
 else 
   Result := False;
end;

Function Segundos : Integer;
var Seg : String;
begin
  Seg := (FormatDateTime('SS',Time));
  if Seg[2] = '' then
    Result := StrToInt(Seg[1])
  else
    Result := StrToInt(Seg[2]);
end;


Function TotalEnviados(Celular : String) : String;
begin
  FEnviaEmail.qryTotalEnviados.Active := False;
  FEnviaEmail.qryTotalEnviados.Active := True;
  FEnviaEmail.qryTotalEnviados.Close;
  FEnviaEmail.qryTotalEnviados.ParamByName('Data').Value :=FormatDateTime('yyyy-mm-dd',Date);
  FEnviaEmail.qryTotalEnviados.ParamByName('Celular').Value :=Celular;
  FEnviaEmail.qryTotalEnviados.Open;
  if FEnviaEmail.qryTotalEnviados.RecordCount <> NULL then
    Result := IntToStr(FEnviaEmail.qryTotalEnviados.RecordCount);
  FEnviaEmail.qryTotalEnviados.Active := False;
end;

function VerificaSeJaExisteIntervalo(Intervalo : Integer) : Integer;
Var Existe : Boolean;
begin
  Existe := False;
  with FEnviaEmail do begin
    while not qryModem.Eof do begin
      if qryModemIntervalo.Value = Intervalo then
        Existe := True;
      qryModem.Next;
    end;
    if existe = True then
      Result := Intervalo + 2
    else
      Result := Intervalo;
  end;
end;

procedure AtualizaEnvioModem;
Var Total , Celular : String;
Intervalo : Integer;
begin
  Total :=TotalEnviados(FEnviaEmail.cbUsuario.Text);
  FEnviaEmail.qryUpdate.SQL.Text:=
  'update Conexao ' +#13+
  ' set Envios=NumeroEnvios,Ultima=HoraAtual,Intervalo=DefineIntervalo,UltimoEnvio=DefineUltimoEnvio ' +#13+
  ' where Numero=Celular ';
  if Intervalo = 0 then
    Intervalo := 1+Segundos;
  Intervalo := VerificaSeJaExisteIntervalo(Intervalo);
  FEnviaEmail.qryUpdate.SQL.Text:=
  StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(FEnviaEmail.qryUpdate.SQL.Text,'NumeroEnvios',Total,[rfIgnoreCase]),'Celular',''''+Trim(FEnviaEmail.cbUsuario.Text)+'''',[rfIgnoreCase]),'HoraAtual',''''+FormatDateTime('hh:mm:ss',Time)+'''',[rfIgnoreCase]),'DefineIntervalo',''''+IntToStr(Intervalo)+'''',[rfIgnoreCase]),'DefineUltimoEnvio',''''+FEnviaEmail.lbDataHoraUltimoEnvio.Caption+'''',[rfIgnoreCase]);
  FEnviaEmail.qryUpdate.ExecSQL;
end;

Procedure ResetaPrograma;
var Parametros,Usuario,VerificaRecebidos,Pausado,Reenvia,Diferencia : String;
var i : DWord;
begin
 { if Trim(ParamStr(8)) = '' then
    Usuario := 'bibiacom_Email';
  if Trim(ParamStr(8)) = 'bibiacom_Email' then
    Usuario := 'bibiacom_Email2';
  if Trim(ParamStr(8)) = 'bibiacom_Email2' then
    Usuario := 'bibiacom_Email3';
  if Trim(ParamStr(8)) = 'bibiacom_Email3' then
    Usuario := 'bibiacom_Email';
  if FEnviaEmail.lbRemoto.Visible then
    Pausado := 'Sim'
  else
    Pausado := 'N�o';
  if (InternetGetConnectedState(@i,0)=True) then begin
    FEnviaEmail.tTempoFechar.Enabled := False;
    Parametros := ('PEnviadorEmail.exe ' +
                   ' "'+FEnviaEmail.cbUsuario.text+'" ' +
                   ' ' +
                   ' "'+FEnviaEmail.edMaxDia.Text+'" '+
                   ' "'+IntToStr(FEnviaEmail.Top)+'"' +
                   ' "'+IntToStr(FEnviaEmail.Left)+
                   '" '+' "'+(FEnviaEmail.lbDataHoraUltimoEnvio.Caption)+
                   '"' +' "'+ FormatDateTime('dd/mm/yy',date) +':'+
                   FormatDateTime('hh:mm:ss',Time) +'" '+
                   ' "'+(Usuario)+'" ' +
                   ' "'+(Pausado)+'" '+
                   ' "'+IntToStr(FEnviaEmail.rgOpcaoEnvio.itemindex)+'" ') ;

    WinExec(PAnsiChar(Parametros),1);
    Application.Terminate;
  end; }
end;

Function ConectaBancoDeDados(Usuario , Senha : String) : Boolean;
Var StringConexao : String;
begin
  FEnviaEmail.dbPrincipal.Connected := False;
 // StringConexao := 'Provider=MSDASQL.1;' + 'Password='+Senha+';Persist Security Info=True;User ID='+Usuario+';'
 // +'Data Source=Simples Sms 32;Initial Catalog=bibiacom_Sms' ;
  //FEnviaEmail.dbPrincipal.ConnectionString:=StringConexao;
end;


procedure AtivarConexao;
begin
  ConectaBancoDeDados(Trim(ParamStr(8)),'cadmus182');
  FEnviaEmail.dbPrincipal.Connected := False;
  try
    FEnviaEmail.dbPrincipal.Connected := True;
  except on E: Exception do
    FEnviaEmail.TVerificaNovoRegistro.Enabled := True;
  end;
  try
    FEnviaEmail.qryModem.Active := True;
  except on E: Exception do
    FEnviaEmail.TVerificaNovoRegistro.Enabled := True;
  end;
  try
    FEnviaEmail.qryTotalEnviados.Active := True;
  except on E: Exception do
    FEnviaEmail.TVerificaNovoRegistro.Enabled := True;
  end;
  try
    FEnviaEmail.qryEmail.Active := True;
  except on E: Exception do
    FEnviaEmail.TVerificaNovoRegistro.Enabled := True;
  end;
  FEnviaEmail.qryModem.Close;
  FEnviaEmail.qryModem.SQL.Clear;
  FEnviaEmail.qryModem.SQL.Add('Select * from Conexao ');
  FEnviaEmail.qryModem.SQL.Add(' where NUMERO = '+''''+Trim(FEnviaEmail.cbUsuario.Text)+'''');
  try
    FEnviaEmail.qryModem.Open;
  except on E: Exception do
    FEnviaEmail.TVerificaNovoRegistro.Enabled := True;
  end;

end;

procedure DesativarConexao;
begin
  FEnviaEmail.dbPrincipal.Connected := False;
  FEnviaEmail.qryModem.Active := False;
  FEnviaEmail.qryEmail.Active := False;
  FEnviaEmail.qryTotalEnviados.Active := False;
end;

Function VerificaConexao : Boolean;
var i : DWord;
begin
{  Result := True;
  if not InternetGetConnectedState(@i,0) then begin
    Result := False;
    FEnviaEmail.TVerificaNovoRegistro.Enabled := False;
    DesativarConexao;
    FEnviaEmail.tAguardaConexao.Enabled := True;
    FEnviaEmail.lbInternet.Show;
  end else begin
    AtivarConexao;
    FEnviaEmail.TVerificaNovoRegistro.Enabled := True;
    AtualizaEnvioModem;
  end;    }
end;


procedure RegistraModem;
begin
  FEnviaEmail.qryModem.Close;
  FEnviaEmail.qryModem.SQL.Text := 'Select * from Conexao';
  FEnviaEmail.qryModem.Open;
  FEnviaEmail.qryModem.Insert;
  FEnviaEmail.qryModem['Numero']:= FEnviaEmail.cbUsuario.Text;
  FEnviaEmail.qryModem['data'] := FormatDateTime('dd/mm/yyyy',Date);
  FEnviaEmail.qryModem['hora'] := FormatDateTime('hh:mm:ss',Time);
  FEnviaEmail.qryModem['envios']:= TotalEnviados(FEnviaEmail.cbUsuario.Text);
  //FEnviaEmail.qryModem['Limite']:= FEnviaEmail.edMaxDia.Text;
  FEnviaEmail.qryModem['Intervalo']:=2;
  FEnviaEmail.qryModem['Status']:='Ativo';
  FEnviaEmail.qryModem['Erro']:='';
  Try
    FEnviaEmail.qryModem.Post;
  except on E: Exception do
   SHOWMESSAGE('ERRO AO GRAVAR');
  End;
end;

procedure DesregistraModem;
begin
  FEnviaEmail.qryModem.Close;
  FEnviaEmail.qryModem.SQL.Clear;
  FEnviaEmail.qryModem.SQL.Add('Select * from Conexao ');
  FEnviaEmail.qryModem.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUsuario.Text+'''');
  FEnviaEmail.qryModem.Open;
  if FEnviaEmail.qryModem.RecordCount > 0 then
    FEnviaEmail.qryModem.Delete;
end;

Function TestaPorta : Boolean;
begin

end;

procedure DesativarEnvio;
begin
  FEnviaEmail.btAtivarDesativar.Caption := 'Ativar';
  FEnviaEmail.btAtivarDesativar.Font.Color:= clBlue;
  DesregistraModem;
  FEnviaEmail.TVerificaNovoRegistro.Enabled := False;
end;

procedure AtivaEnvio;
begin
  FEnviaEmail.TVerificaNovoRegistro.Enabled:= True;
  FEnviaEmail.btAtivarDesativar.Caption := 'Desativar';
  FEnviaEmail.btAtivarDesativar.Font.Color:= clred;
  FEnviaEmail.lbEnviados.Caption := TotalEnviados(FEnviaEmail.cbUsuario.Text);
  DesregistraModem;
  RegistraModem;
end;

procedure TFEnviaEmail.aeControlaErrosActionExecute(Action: TBasicAction;
  var Handled: Boolean);
var i : integer;
begin

end;

procedure VerificaErro;
begin
  if FEnviaEmail.btAtivarDesativar.Caption = 'Desativar' then begin
    if VerificaConexao then
      ResetaPrograma
    else
      //FEnviaEmail.tAguardaConexao.Enabled := True;
  end;
end;

procedure TFEnviaEmail.aeControlaErrosException(Sender: TObject; E: Exception);
begin
  //VerificaErro;
  ShowMessage(e.Message);
end;

procedure TFEnviaEmail.aeControlaErrosMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if FEnviaEmail.btAtivarDesativar.Caption = 'Desativar' then begin
    if VerificaConexao = False then
      //tAguardaConexao.Enabled := True;
  end;
end;

procedure TFEnviaEmail.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);

  procedure BuscaModemModemComErro;
  begin
    FEnviaEmail.qryErro.Active := False;
    FEnviaEmail.qryErro.Active := True;
    FEnviaEmail.qryErro.Close;
    FEnviaEmail.qryErro.SQL.Clear;
    FEnviaEmail.qryErro.SQL.Add('Select Erro from Conexao ');
    FEnviaEmail.qryErro.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUsuario.Text+'''');
    FEnviaEmail.qryErro.Open;
  end;

  procedure GravaErro(Erro : String);
  begin
    BuscaModemModemComErro;
    FEnviaEmail.qryErro.Edit;
    FEnviaEmail.qryErro['Erro']:= Erro;
    FEnviaEmail.qryErro.Post;
  end;

begin
  //ShowMessage(e.Message);
  GravaErro(E.Message);
  mmErro.Lines.Add(E.Message);
  //ResetaPrograma;
end;

procedure TFEnviaEmail.BitBtn1Click(Sender: TObject);
 procedure BuscaModemModemComErro;
  begin
    FEnviaEmail.qryErro.Active := False;
    FEnviaEmail.qryErro.Active := True;
    FEnviaEmail.qryErro.Close;
    FEnviaEmail.qryErro.SQL.Clear;
    FEnviaEmail.qryErro.SQL.Add('Select Erro from Conexao ');
    FEnviaEmail.qryErro.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUsuario.Text+'''');
    FEnviaEmail.qryErro.Open;

  end;

  procedure GravaErro(Erro : String);
  begin
    BuscaModemModemComErro;
    FEnviaEmail.qryErro.Edit;
    FEnviaEmail.qryErro['Erro']:= Erro;
    FEnviaEmail.qryErro.Post;
  end;

begin
  GravaErro('tesete');
end;

procedure TFEnviaEmail.btAtivarDesativarClick(Sender: TObject);
begin
   if btAtivarDesativar.Caption = 'Ativar' then
     AtivaEnvio
   else
     DesativarEnvio;
end;

procedure TFEnviaEmail.ckNaoEnviarClick(Sender: TObject);

  Function Enviar : String;
  begin
    Result :=
    'Select '                   +#13+
    '  *    '                   +#13+
    'from         '             +#13+
    '  Enviados   '             +#13+
    'where        '             +#13+
    '  enviado =0 '             +#13+
    '  and Tipo=''E'' '         +#13+
    '  and celular is not null '+#13+
    '  and Validado = ''Sim''  '+#13+
    'Limit                    ' +#13+
    '  1 ';
  end;

  Function NaoEnviar : String;
  begin
  Result :=
    'Select '                   +#13+
    '  *    '                   +#13+
    'from         '             +#13+
    '  Enviados   '             +#13+
    'where        '             +#13+
    '  enviado =0 '             +#13+
    '  and Tipo=''E'' '         +#13+
    'Limit                    ' +#13+
    '  1 ';

  end;

begin
  if ckNaoEnviar.Checked then
    qryEmail.SQL.Text := NaoEnviar
  else
    qryEmail.SQL.Text := NaoEnviar;
end;

procedure TFEnviaEmail.ckPrioriadadeClick(Sender: TObject);
begin
  if ckPrioriadade.Checked then
  begin
    edPrioridade.Visible := True ;
    edPrioridade.Text := qryRemoto['Prioridade'];
    if edPrioridade.Text <> '' then
      qryEmail.SQL[8] := 'and cnpj in ('+ edPrioridade.Text +')';
  end else
  begin
    edPrioridade.Visible := False;
    edPrioridade.Text := '';
    qryEmail.SQL[8] := '';
  end;
end;

procedure TFEnviaEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   DesregistraModem;
end;

procedure TFEnviaEmail.FormShow(Sender: TObject);
var handle: Thandle;
begin
{  cbUusario.Text       := ParamStr(1);
  //cbSenha.Text := ParamStr(2);
  edMaxDia.Text    := ParamStr(3);
  lbDataHoraUltimoResete.Caption := ParamStr(7);;
  if ParamStr(4) <> '' then
    FEnviaEmail.Top    := StrToInt(ParamStr(4));
  if ParamStr(5) <> '' then
    FEnviaEmail.Left   := StrToInt(ParamStr(5));
  if Trim(ParamStr(10)) = 'Sim' then
    lbRemoto.Visible := True;
  if Trim(ParamStr(6)) = '' then
    FEnviaEmail.lbDataHoraUltimoEnvio.Caption    := 'Sem Envios'
  Else
    FEnviaEmail.lbDataHoraUltimoEnvio.Caption    := Trim(ParamStr(6));
  if (ParamStr(1) <> '') and  (ParamStr(2) <> '') and  (ParamStr(3) <> '') then
    btAtivarDesativar.Click;
  if Trim(ParamStr(8)) = '' then
    lbUsuarioBanco.Caption := 'bibiacom_Geren';
  if Trim(ParamStr(8)) = 'bibiacom_Geren' then
    lbUsuarioBanco.Caption := 'bibiacom_Envia';
  if Trim(ParamStr(8)) = 'bibiacom_Envia' then
    lbUsuarioBanco.Caption := 'bibiacom_Geren';
  if Trim(ParamStr(9)) = 'Sim' then
    lbRemoto.Visible := True;
  if (Trim(ParamStr(10))) <> '' then
    FEnviaEmail.rgOpcaoEnvio.ItemIndex :=  StrToInt(Trim(ParamStr(10)));   }
end;

procedure TFEnviaEmail.lbRemotoClick(Sender: TObject);
begin
  lbRemoto.Visible := False;
end;

procedure TFEnviaEmail.TPingServerTimer(Sender: TObject);
begin
  dbPrincipal.PingServer;
end;


procedure TFEnviaEmail.tRemotoTimer(Sender: TObject);
  procedure VerificarRemoto;
  begin
    FEnviaEmail.qryRemoto.Close;
    FEnviaEmail.qryRemoto.SQL.Clear;
    FEnviaEmail.qryRemoto.SQL.Add('Select * from Conexao ');
    FEnviaEmail.qryRemoto.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUsuario.Text+'''');
    FEnviaEmail.qryRemoto.Open;
  end;
begin
  if cbUsuario.Text <> '' then begin
    VerificarRemoto;
    if (qryRemoto['Status'] = 'Desativado') and (btAtivarDesativar.Caption='Desativar') then
    begin
      lbRemoto.Visible := True;
      ckPrioriadade.Checked := False;
    end;
    if (qryRemoto['Status'] = 'Ativo') and (btAtivarDesativar.Caption='Desativar') then
    begin
      ckPrioriadade.Checked := False;
      lbRemoto.Visible := False;
    end;
    if (qryRemoto['Status'] = 'Prioridade') and (btAtivarDesativar.Caption='Desativar') then
    begin
      ckPrioriadade.Checked := True;
      lbRemoto.Visible := False;
    end;
  end;
end;

procedure TFEnviaEmail.tTempoFecharTimer(Sender: TObject);
begin
  ResetaPrograma;
end;

procedure TFEnviaEmail.TVerificaNovoRegistroTimer(Sender: TObject);

  Function VerificaNovoRegistro : Boolean;
  begin
    Result := False;
    AtualizaEnvioModem;
    lbEnviados.Caption := TotalEnviados(Trim(cbUsuario.Text));
    try
      dbPrincipal.Connected := False;
      dbPrincipal.Connected := True;
      qryEmail.Active := False;
    except
      TVerificaNovoRegistro.Enabled := True;
    end;
    try
      qryEmail.Active := True;
      qryEmail.Close;
      qryEmail.Open;
    except on E: Exception do
      TVerificaNovoRegistro.Enabled := True;
    end;
    if qryEmail.RecordCount > 0  then
      Result := True;
  end;

  procedure GravaEnviado;
  begin
    qryEmail.Edit;
    qryEmail['data'] := FormatDateTime('dd/mm/yyyy',Date);
    qryEmail['hora'] := FormatDateTime('hh:mm:ss',Time);
    qryEmail['NumeroEnvio'] := cbUsuario.Text;
    qryEmail['Enviado'] :=1;
    try
      qryEmail.Post;
    except on E: Exception do
      TVerificaNovoRegistro.Enabled := True;
    end;
    dbPrincipal.Connected := False;
    dbPrincipal.Connected := True;
    qryEmail.Active := False;
    qryEmail.Active := True;
  end;

  procedure GravaNaoEnviado;
  begin
    qryEmail.Edit;
    qryEmail['data'] := FormatDateTime('dd/mm/yyyy',Date);
    qryEmail['hora'] := FormatDateTime('hh:mm:ss',Time);
    qryEmail['NumeroEnvio'] := cbUsuario.Text;
    qryEmail['Enviado'] :=3;
    Try
      qryEmail.Post;
    except on E: Exception do
      TVerificaNovoRegistro.Enabled := True;
    End;
    dbPrincipal.Connected := False;
    dbPrincipal.Connected := True;
    qryEmail.Active := False;
    qryEmail.Active := True;
    lbNEnviados.Caption := IntToStr(StrToInt(lbNEnviados.Caption)+1);
  end;

  procedure TravaSms;
  begin
    qryEmail.Edit;
    qryEmail['Enviado'] :=2;
    qryEmail['data'] := FormatDateTime('dd/mm/yyyy',Date);
    try
      qryEmail.Post;
    except on E: Exception do
      TVerificaNovoRegistro.Enabled := True;
    end;
  end;

  Function BuscaTextoEmail(Codigo,Cnpj : String) : String;
  begin
    qryTextoEmail.Close;
    qryTextoEmail.ParamByName('Codigo').Value := Codigo ;
    qryTextoEmail.ParamByName('Cnpj').Value := Cnpj;
    qryTextoEmail.Open;
    qryTextoEmail.Last;
    if qryTextoEmail.RecordCount > 0 then
    begin
      Result :=  (qryTextoEmail['Texto']);
    end;
  end;

  Procedure EnviaEmail(Empresa,EmailEnvio,EmailDestino,Titulo,TextoEmail,Cnpj : String);
  Var Mensagem,Anexos,cc : TStringList;
  Stream : TStringStream;
  begin
    with FEnviaEmail do
    begin
      if (ValidarEmail(EmailDestino)) and (qryEmail['Validado'] = 'Sim') then
      Begin
        Mensagem := TStringList.Create;
        if rgEnviador.ItemIndex = 0 then
        begin
          Email.Host := 'email-smtp.us-west-2.amazonaws.com';
          Email.Port := '465';
          Email.Username :=  'AKIAJVLO2YAUFJVB2UHQ';
          Email.Password :=  'Ao69w253pZBzZaUy780w5T1kZMGr8gmU8ycPhjzpphbW';
          Email.SetSSL := True;
          Email.SetTLS := True;
        end
        else if rgEnviador.ItemIndex = 1 then
        begin
          Email.Host := 'smtp.sparkpostmail.com';
          Email.Port := '587';
          Email.Username :=  'SMTP_Injection';
          Email.Password :=  '1a1477f18918566ad643d4d30e18d9652f781bfe';
          Email.SMTP.StartTLS;
          Email.SMTP.Login;
        end;
        Email.FromName := Empresa;
        Email.From     :=EmailEnvio;
        Email.AddAddress(Trim(LowerCase(EmailDestino)));
        Email.Subject := (Titulo);
        Email.Body.Add(StringReplace(StringReplace(BuscaTextoEmail(TextoEmail,Cnpj),'[Email______________________________]',Trim(LowerCase(EmailDestino)),[rfReplaceAll]),'[DataAtual__]',FormatDateTime('yyyy-mm-dd',Date),[rfReplaceAll]));
        Email.IsHTML := True;
        Email.Send(True);
        Email.Clear;
        GravaEnviado;
        lbDataHoraUltimoEnvio.Caption := FormatDateTime('dd/mm/yy',date) +':'+FormatDateTime('hh:mm:ss',Time);
        AtualizaEnvioModem;
      end else
      begin
        GravaNaoEnviado;
      end;
    end;
  end;

  procedure BuscaModem;
  begin
    FEnviaEmail.qryModem.Close;
    FEnviaEmail.qryModem.SQL.Clear;
    FEnviaEmail.qryModem.SQL.Add('Select * from Conexao ');
    FEnviaEmail.qryModem.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUsuario.Text+'''');
    FEnviaEmail.qryModem.Open;
  end;

  function BuscaNomeEmpresa : String;
  begin
    qryEmpresa.Close;
    qryEmpresa.ParamByName('Cnpj').Value := qryEmail['CNPJ'];
    qryEmpresa.Open;
    Result := qryEmpresa['Nome'];
  end;

Var Intervalo : string;
begin
  TVerificaNovoRegistro.Enabled := False;
  try
    AtivarConexao;
  except
    TVerificaNovoRegistro.Enabled := True;
  end;
  if VerificaNovoRegistro then
  begin
    if (lbRemoto.Visible = False) then
      try
        EnviaEmail(BuscaNomeEmpresa,qryEmail['Remetente'],qryEmail['celular'],qryEmail['mensagem'],qryEmail['CodigoTextoEmail'],qryEmail['CNPJ']);
        BuscaModem;
      except
        TVerificaNovoRegistro.Enabled := True;
    end;
  end;
  try
    DesativarConexao;
  except
    TVerificaNovoRegistro.Enabled := True;
  end;
  TVerificaNovoRegistro.Enabled := True;
end;



end.
