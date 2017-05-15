unit UEnviadorSms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ACBrBase, ACBrSMS,ACBrSMSClass, DB, ADODB, StdCtrls, Buttons, Grids,
  DBGrids, AppEvnts,Shellapi,WinInet, ACBrMail;

type
  TFEnviaEmail = class(TForm)
    TVerificaNovoRegistro: TTimer;
    dbPrincipal: TADOConnection;
    qryEmail: TADOQuery;
    qryEmailid: TIntegerField;
    qryEmailCNPJ: TStringField;
    qryEmailmensagem: TStringField;
    qryEmaildata: TDateField;
    qryEmailhora: TTimeField;
    qryEmailComputadorEnvio: TStringField;
    qryEmailEnviado: TIntegerField;
    gbConfigurar: TGroupBox;
    cbUusario: TComboBox;
    lbUsuario: TLabel;
    lbSenha: TLabel;
    lbMaxDia: TLabel;
    edMaxDia: TEdit;
    btAtivarDesativar: TBitBtn;
    qryTotalEnviados: TADOQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    DateField1: TDateField;
    TimeField1: TTimeField;
    StringField5: TStringField;
    IntegerField2: TIntegerField;
    lbEnviados: TLabel;
    lbAviso: TLabel;
    ds: TDataSource;
    dsModem: TDataSource;
    qryUpdate: TADOQuery;
    tAguardaConexao: TTimer;
    lbInternet: TLabel;
    tTempoFechar: TTimer;
    lbUltimoEnvio: TLabel;
    lbDataHoraUltimoEnvio: TLabel;
    lbIntervalo: TLabel;
    lbUltimoResete: TLabel;
    lbDataHoraUltimoResete: TLabel;
    lbUsuarioBanco: TLabel;
    Label1: TLabel;
    lbTituloEnviados: TLabel;
    lbTituloNEnviados: TLabel;
    lbNEnviados: TLabel;
    tVerificaRecebimentoSms: TTimer;
    lbRemoto: TLabel;
    qryRemoto: TADOQuery;
    qryRemotoStatus: TStringField;
    tRemoto: TTimer;
    ckVerificaRecebidos: TCheckBox;
    qryModem: TADOQuery;
    qryModemData: TDateField;
    qryModemHora: TTimeField;
    qryModemEnvios: TIntegerField;
    qryModemLimite: TIntegerField;
    qryModemUltima: TTimeField;
    qryModemUltimoEnvio: TStringField;
    qryModemStatus: TStringField;
    qryModemIntervalo: TIntegerField;
    tReenvia: TTimer;
    lbReenvio: TLabel;
    lbParada: TLabel;
    ckReenviar: TCheckBox;
    ckDiferenciar: TCheckBox;
    Memo1: TMemo;
    Email: TACBrMail;
    qryEmpresa: TADOQuery;
    qryEmpresaNome: TStringField;
    qryEmailTipo: TStringField;
    rgOpcaoEnvio: TRadioGroup;
    cbSenha: TComboBox;
    qryEmailcelular: TStringField;
    qryEmailNumeroEnvio: TStringField;
    qryEmailRemetente: TStringField;
    qryTotalEnviadoscelular: TStringField;
    qryTotalEnviadosNumeroEnvio: TStringField;
    qryTotalEnviadosTipo: TStringField;
    qryTotalEnviadosRemetente: TStringField;
    qryTotalEnviadosCodigoTextoEmail: TStringField;
    qryModemNumero: TStringField;
    qryTextoEmail: TADOQuery;
    qryTextoEmailTexto: TMemoField;
    qryEmailCodigoTextoEmail: TStringField;
    procedure TVerificaNovoRegistroTimer(Sender: TObject);
    procedure btAtivarDesativarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aeControlaErrosActionExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure tAguardaConexaoTimer(Sender: TObject);
    procedure aeControlaErrosMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure tTempoFecharTimer(Sender: TObject);
    procedure aeControlaErrosException(Sender: TObject; E: Exception);
    procedure tRemotoTimer(Sender: TObject);
    procedure lbRemotoClick(Sender: TObject);
    procedure tReenviaTimer(Sender: TObject);
    procedure ckReenviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEnviaEmail: TFEnviaEmail;

implementation


{$R *.dfm}


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
   if (Mostra <> 'naotem') and (Mostra <> 'n�otem') and
   (Mostra <> 'nao') and (Mostra<> 'naopossui')
   and (Mostra<> 'naopossuiemail') and (Mostra <> 'naotememail')
   and (Mostra <> 'n�otememail') and (Mostra <> 'n�opossui')
   and (Mostra <> 'naot') then
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
  FEnviaEmail.qryTotalEnviados.Parameters.ParamByName('Data').Value :=FormatDateTime('yyyy-mm-dd',Date);
  FEnviaEmail.qryTotalEnviados.Parameters.ParamByName('Celular').Value :=Celular;
  FEnviaEmail.qryTotalEnviados.Open;
  if FEnviaEmail.qryTotalEnviados.RecordCount <> NULL then
    Result := IntToStr(FEnviaEmail.qryTotalEnviados.RecordCount);
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
  Total :=TotalEnviados(FEnviaEmail.cbUusario.Text);
  FEnviaEmail.qryUpdate.SQL.Text:=
  'update Conexao ' +#13+
  ' set Envios=NumeroEnvios,Ultima=HoraAtual,Intervalo=DefineIntervalo,UltimoEnvio=DefineUltimoEnvio ' +#13+
  ' where Numero=Celular ';
  if Intervalo = 0 then
    Intervalo := 1+Segundos;
  Intervalo := VerificaSeJaExisteIntervalo(Intervalo);
  FEnviaEmail.qryUpdate.SQL.Text:=
  StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(FEnviaEmail.qryUpdate.SQL.Text,'NumeroEnvios',Total,[rfIgnoreCase]),'Celular',''''+Trim(FEnviaEmail.cbUusario.Text)+'''',[rfIgnoreCase]),'HoraAtual',''''+FormatDateTime('hh:mm:ss',Time)+'''',[rfIgnoreCase]),'DefineIntervalo',''''+IntToStr(Intervalo)+'''',[rfIgnoreCase]),'DefineUltimoEnvio',''''+FEnviaEmail.lbDataHoraUltimoEnvio.Caption+'''',[rfIgnoreCase]);
  FEnviaEmail.qryUpdate.ExecSQL;
end;

Procedure ResetaPrograma;
var Parametros,Usuario,VerificaRecebidos,Pausado,Reenvia,Diferencia : String;
var i : DWord;
begin
  if Trim(ParamStr(8)) = '' then
    Usuario := 'bibiacom_Geren';
  if Trim(ParamStr(8)) = 'bibiacom_Geren' then
    Usuario := 'bibiacom_Envia';
  if Trim(ParamStr(8)) = 'bibiacom_Envia' then
    Usuario := 'bibiacom_Geren';
  VerificaRecebidos := 'Nao';
  if FEnviaEmail.ckVerificaRecebidos.Checked then
    VerificaRecebidos := 'Sim';
  Pausado := 'Nao';
  if FEnviaEmail.lbRemoto.Visible then
    Pausado := 'Sim';
  if FEnviaEmail.ckReenviar.Checked then
    Reenvia :='Sim'
  else
    Reenvia := 'N�o';
  if FEnviaEmail.ckDiferenciar.Checked then
    Diferencia := 'Sim'
  else
    Diferencia := 'N�o';

  if (InternetGetConnectedState(@i,0)=True) then begin
    FEnviaEmail.tTempoFechar.Enabled := False;
    Parametros := ('PEnviadorSms.exe ' + ' "'+FEnviaEmail.cbUusario.text+'" ' +' "'+FEnviaEmail.cbSenha.Text+'" ' +' "'+FEnviaEmail.edMaxDia.Text+'" '+' "'+IntToStr(FEnviaEmail.Top)+'"' +' "'+IntToStr(FEnviaEmail.Left)+'" '+' "'+(FEnviaEmail.lbDataHoraUltimoEnvio.Caption)+'"' +' "'+ FormatDateTime('dd/mm/yy',date) +':'+FormatDateTime('hh:mm:ss',Time) +'" '+' "'+(Usuario)+'" ' +' "'+(VerificaRecebidos)+'" ' +' "'+(Pausado)+'" ' +' "'+(Reenvia)+'" ' +' "'+(Diferencia)+'" ');
    WinExec(PAnsiChar(Parametros),1);
    Application.Terminate;
  end;
end;

Function ConectaBancoDeDados(Usuario , Senha : String) : Boolean;
Var StringConexao : String;
begin
  FEnviaEmail.dbPrincipal.Connected := False;
  StringConexao := 'Provider=MSDASQL.1;' + 'Password='+Senha+';Persist Security Info=True;User ID='+Usuario+';'
  +'Data Source=Simples Sms 32;Initial Catalog=bibiacom_Sms' ;
  FEnviaEmail.dbPrincipal.ConnectionString:=StringConexao;
end;


procedure AtivarConexao;
begin
  ConectaBancoDeDados(Trim(ParamStr(8)),'cadmus182');
  try
    FEnviaEmail.dbPrincipal.Connected := True;
  except on E: Exception do
    ResetaPrograma;
  end;
  FEnviaEmail.qryModem.Active := True;
  FEnviaEmail.qryTotalEnviados.Active := True;
  FEnviaEmail.qryEmail.Active := True;
  FEnviaEmail.qryModem.Close;
  FEnviaEmail.qryModem.SQL.Clear;
  FEnviaEmail.qryModem.SQL.Add('Select * from Conexao ');
  FEnviaEmail.qryModem.SQL.Add(' where NUMERO = '+''''+Trim(FEnviaEmail.cbUusario.Text)+'''');
  FEnviaEmail.qryModem.Open;
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
  Result := True;
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
  end;
end;


procedure RegistraModem;
begin
  FEnviaEmail.qryModem.Close;
  FEnviaEmail.qryModem.SQL.Text := 'Select * from Conexao';
  FEnviaEmail.qryModem.Open;
  FEnviaEmail.qryModem.Insert;
  FEnviaEmail.qryModem['Numero']:= FEnviaEmail.cbUusario.Text;
  FEnviaEmail.qryModem['data'] := FormatDateTime('dd/mm/yyyy',Date);
  FEnviaEmail.qryModem['hora'] := FormatDateTime('hh:mm:ss',Time);
  FEnviaEmail.qryModem['envios']:= TotalEnviados(FEnviaEmail.cbUusario.Text);
  FEnviaEmail.qryModem['Limite']:= FEnviaEmail.edMaxDia.Text;
  FEnviaEmail.qryModem['Intervalo']:=2;
  FEnviaEmail.qryModem['Status']:='Ativo';
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
  FEnviaEmail.qryModem.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUusario.Text+'''');
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
  //FEnviaEmail.Sms.Desativar;
  DesregistraModem;
  FEnviaEmail.tTempoFechar.Enabled := False;
  FEnviaEmail.tVerificaRecebimentoSms.Enabled := False;
  FEnviaEmail.TVerificaNovoRegistro.Enabled := False;
  FEnviaEmail.tReenvia.Enabled := False;
end;

procedure AtivaEnvio;
begin
  //if TestaPorta then  begin
    FEnviaEmail.TVerificaNovoRegistro.Enabled:= True;
    FEnviaEmail.tReenvia.Enabled := True;
    FEnviaEmail.btAtivarDesativar.Caption := 'Desativar';
    FEnviaEmail.btAtivarDesativar.Font.Color:= clred;
    FEnviaEmail.lbEnviados.Caption := TotalEnviados(FEnviaEmail.cbUusario.Text);    
    DesregistraModem;
    RegistraModem;
 //   if FEnviaEmail.ckVerificaRecebidos.Checked then
  //    FEnviaEmail.tVerificaRecebimentoSms.Enabled := True;
    FEnviaEmail.tTempoFechar.Enabled := True;
 // end else begin
    {FEnviaEmail.btAtivarDesativar.Caption := 'Ativar';
    FEnviaEmail.btAtivarDesativar.Font.Color:= clBlue;
    FEnviaEmail.TVerificaNovoRegistro.Enabled:= False;
    FEnviaEmail.tReenvia.Enabled := False; }
   //  FEnviaEmail.tVerificaRecebimentoSms.Enabled := False;
    FEnviaEmail.tTempoFechar.Enabled := False;
  //end;  }
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
      FEnviaEmail.tAguardaConexao.Enabled := True;
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
      tAguardaConexao.Enabled := True;
  end;
end;

procedure TFEnviaEmail.btAtivarDesativarClick(Sender: TObject);
begin
   if btAtivarDesativar.Caption = 'Ativar' then
     AtivaEnvio
   else
     DesativarEnvio;
end;

procedure TFEnviaEmail.ckReenviarClick(Sender: TObject);
begin
  if ckReenviar.Checked  then
    tReenvia.Enabled := True
  else
    tReenvia.Enabled := False;
end;

procedure TFEnviaEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   DesregistraModem;
end;

procedure TFEnviaEmail.FormShow(Sender: TObject);
var handle: Thandle;
begin
//  cbUusario.Text       := ParamStr(1);
  //edSenha.Text := ParamStr(2);
  //edMaxDia.Text    := ParamStr(3);
  lbDataHoraUltimoResete.Caption := ParamStr(7);;
  if ParamStr(4) <> '' then
    FEnviaEmail.Top    := StrToInt(ParamStr(4));
  if ParamStr(5) <> '' then
    FEnviaEmail.Left   := StrToInt(ParamStr(5));
  if Trim(ParamStr(9)) = 'Sim' then
    ckVerificaRecebidos.Checked := True;
  if Trim(ParamStr(10)) = 'Sim' then
    lbRemoto.Visible := True;
  if Trim(ParamStr(11)) = 'Sim' then
    ckReenviar.Checked := True;
  if Trim(ParamStr(12)) = 'Sim' then
    ckDiferenciar.Checked := True;
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
end;

procedure TFEnviaEmail.lbRemotoClick(Sender: TObject);
begin
  lbRemoto.Visible := False;
end;

procedure TFEnviaEmail.tAguardaConexaoTimer(Sender: TObject);
begin
  if VerificaConexao then begin
    AtivarConexao;
    TVerificaNovoRegisTro.Enabled := True;
    lbInternet.Hide;
    tAguardaConexao.Enabled := False;
  end;
end;

procedure TFEnviaEmail.tReenviaTimer(Sender: TObject);
begin
  if (FormatDateTime('hh:mm',Time) < '21:00') and (ckReenviar.Checked)  then begin
    try
      //qryReenvia.ExecSQL;
      lbReenvio.Caption := 'Ultimo Reenvio : ' + FormatDateTime('hh:mm:ss',Time);
    Except
      lbReenvio.Caption := 'Falha no Reenvio Reenvio : ' + FormatDateTime('hh:mm:ss',Time);
    end;
  end;
end;

procedure TFEnviaEmail.tRemotoTimer(Sender: TObject);
  procedure VerificarRemoto;
  begin
    FEnviaEmail.qryRemoto.Close;
    FEnviaEmail.qryRemoto.SQL.Clear;
    FEnviaEmail.qryRemoto.SQL.Add('Select * from Conexao ');
    FEnviaEmail.qryRemoto.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUusario.Text+'''');
    FEnviaEmail.qryRemoto.Open;
  end;
begin
  if cbUusario.Text <> '' then begin
    VerificarRemoto;
    if (qryRemoto['Status'] = 'Desativado') and (btAtivarDesativar.Caption='Desativar') then
      lbRemoto.Visible := True;
    if (qryRemoto['Status'] = 'Ativo') and (btAtivarDesativar.Caption='Desativar') then
      lbRemoto.Visible := False;
  end;
end;

procedure TFEnviaEmail.tTempoFecharTimer(Sender: TObject);
begin
  ResetaPrograma;
end;

procedure TFEnviaEmail.TVerificaNovoRegistroTimer(Sender: TObject);
  Function VerificaNovoRegistro : Boolean;
  begin
    if VerificaConexao then begin
      Result := False;
      lbEnviados.Caption := TotalEnviados(Trim(cbUusario.Text));
      dbPrincipal.Connected := False;
      dbPrincipal.Connected := True;
      qryEmail.Active := False;
      qryEmail.Active := True;
      if qryEmail.RecordCount > 0  then
        Result := True;
    end;
  end;

  procedure GravaEnviado;
  begin
    qryEmail.Edit;
    qryEmail['data'] := FormatDateTime('dd/mm/yyyy',Date);
    qryEmail['hora'] := FormatDateTime('hh:mm:ss',Time);
    qryEmail['NumeroEnvio'] := cbUusario.Text;
    qryEmail['Enviado'] :=1;
    try
      qryEmail.Post;
     except on E: Exception do

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
    qryEmail['NumeroEnvio'] := cbUusario.Text;
    qryEmail['Enviado'] :=3;
    Try
      qryEmail.Post;
    except on E: Exception do

    End;
    dbPrincipal.Connected := False;
    dbPrincipal.Connected := True;
    qryEmail.Active := False;
    qryEmail.Active := True;
  end;

  procedure TravaSms;
  begin
    qryEmail.Edit;
    qryEmail['Enviado'] :=2;
    try
      qryEmail.Post;
    except on E: Exception do

    end;
  end;

  Function VerificaLimiteEnvio : Boolean;
  begin
    Result := False;
    if lbEnviados.Caption = edMaxDia.Text then begin
      lbAviso.Show ;
      Result := True;
    end else
      lbAviso.Hide;
  end;

  function Diferenciar(Msg : String) : String ;

  function Variavel : String;
  begin
    Randomize;
    case Random(6) of
      0: Variavel := ',' ;
      1: Variavel := '.' ;
      2: Variavel := '..';
      3: Variavel := '#';
      4: Variavel := '';
      5: Variavel := '!';
    end;
  end;

  begin
    Result := Msg+Variavel;
    Result := Copy(Result,1,160);
    Result := Trim(Result);
  end;

  Function BuscaTextoEmail(Codigo,Cnpj : String) : String;
  begin
    qryTextoEmail.Close;
    qryTextoEmail.Parameters.ParamByName('Codigo').Value := Codigo ;
    qryTextoEmail.Parameters.ParamByName('Cnpj').Value := Cnpj;
    qryTextoEmail.Open;
    qryTextoEmail.Last;
    if qryTextoEmail.RecordCount > 0 then begin
      if cbUusario.Text = 'simplessms@gmail.com' then
        Result := (qryTextoEmail['Texto'])
      else
        Result := AnsiToUtf8(qryTextoEmail['Texto']);
    end;
  end;

  Procedure EnviaEmail(Empresa,EmailEnvio,EmailDestino,Titulo,TextoEmail,Cnpj : String);
  Var Mensagem,Anexos,cc : TStringList;
  Stream : TStringStream;
  begin
    with FEnviaEmail do begin
      Mensagem := TStringList.Create;
      case rgOpcaoEnvio.ItemIndex of
        0 : begin
          Email.Host := 'smtp.mandrillapp.com';
          Email.Port := '587';
          Email.SetTLS := True;
          Email.Username :=  'simplessms@gmail.com';
          //Email.DefaultCharset:='iso-8859-1';
        end;
        1 : begin
          Email.Host := 'email-smtp.us-west-2.amazonaws.com';
          //Email.Host := 'smtp.gmail.com';
          Email.Port := '465';
          Email.SetSSL := True;
          Email.SetTLS := True;
          Email.Username :=  'AKIAJVLO2YAUFJVB2UHQ';
          //Email.DefaultCharset := iso-8859-1;
        end;
      end;

      Email.Password := cbSenha.Text;
      Email.FromName := Empresa;
      Email.From     :=EmailEnvio;
      Email.AddAddress(Trim(LowerCase(EmailDestino)));
      Email.Subject := AnsiToUtf8(Titulo);

      Mensagem.Add(StringReplace(StringReplace(BuscaTextoEmail(TextoEmail,Cnpj),'[Email______________________________]',Trim(LowerCase(EmailDestino)),[rfReplaceAll]),'[DataAtual__]',FormatDateTime('yyyy-mm-dd',Date),[rfReplaceAll]));

      Email.Body := Mensagem;
      Email.IsHTML := True;
    end;
    //if VerificaNovoRegistro then begin
      TravaSms ;
      if ValidarEMail(EmailDestino) then  Begin


        Email.Send(True);
        //showmessage('Email Enviado');
        GravaEnviado;
        lbDataHoraUltimoEnvio.Caption := FormatDateTime('dd/mm/yy',date) +':'+FormatDateTime('hh:mm:ss',Time);
        AtualizaEnvioModem;
      end else begin
        //showmessage('Email nao Enviado');
        GravaNaoEnviado;
        //AtualizaEnvioModem;
      end;
    //end;
  end;

  procedure BuscaModem;
  begin
    FEnviaEmail.qryModem.Close;
    FEnviaEmail.qryModem.SQL.Clear;
    FEnviaEmail.qryModem.SQL.Add('Select * from Conexao ');
    FEnviaEmail.qryModem.SQL.Add(' where NUMERO = '+''''+FEnviaEmail.cbUusario.Text+'''');
    FEnviaEmail.qryModem.Open;
  end;

  function BuscaNomeEmpresa : String;
  begin
    qryEmpresa.Close;
    qryEmpresa.Parameters.ParamByName('Cnpj').Value := qryEmail['CNPJ'];
    qryEmpresa.Open;
    Result := qryEmpresa['Nome'];
  end;

Var Intervalo : string;
begin
  lbParada.Hide;
  TVerificaNovoRegistro.Enabled := False;
  AtivarConexao;
  if FEnviaEmail.ckVerificaRecebidos.Checked then
    FEnviaEmail.tVerificaRecebimentoSms.Enabled := True
  else
    FEnviaEmail.tVerificaRecebimentoSms.Enabled := False;
  if (VerificaConexao)  then begin
    if VerificaNovoRegistro then
      if VerificaLimiteEnvio = False then
        if (VerificaConexao) and (lbRemoto.Visible = False) then
          EnviaEmail(BuscaNomeEmpresa,qryEmail['Remetente'],qryEmail['celular'],qryEmail['mensagem'],qryEmail['CodigoTextoEmail'],qryEmail['CNPJ']);
    BuscaModem;
    case rgOpcaoEnvio.ItemIndex of
      0: begin
        if (StrToInt(lbEnviados.Caption) MOD 25  = 0) and (Trim(lbEnviados.Caption)<>'0') then begin
          TVerificaNovoRegistro.Interval := 360000;
          lbParada.Show;
        end else
          TVerificaNovoRegistro.Interval := 500;
      end;
      1 : begin
        TVerificaNovoRegistro.Interval := 500;
      end;
    end;
      lbIntervalo.Caption :=  IntToStr(TVerificaNovoRegistro.Interval) ;
    DesativarConexao;
    TVerificaNovoRegistro.Enabled := True;
  end;
end;


end.
