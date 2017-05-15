
unit UEnviadorSms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ACBrBase, ACBrSMS,ACBrSMSClass, DB, ADODB, StdCtrls, Buttons, Grids,
  DBGrids, AppEvnts,Shellapi,WinInet, ZSqlUpdate, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection;

type
  TFEnviaSms = class(TForm)
    TVerificaNovoRegistro: TTimer;
    gbConfigurar: TGroupBox;
    cbCom: TComboBox;
    lbPorta: TLabel;
    lbNumero: TLabel;
    edNumeroCel: TEdit;
    lbMaxDia: TLabel;
    edMaxDia: TEdit;
    btAtivarDesativar: TBitBtn;
    lbEnviados: TLabel;
    lbAviso: TLabel;
    Sms: TACBrSMS;
    ds: TDataSource;
    dsModem: TDataSource;
    tAguardaConexao: TTimer;
    lbInternet: TLabel;
    tTempoFechar: TTimer;
    lbUltimoEnvio: TLabel;
    lbDataHoraUltimoEnvio: TLabel;
    lbIntervalo: TLabel;
    lbUltimoResete: TLabel;
    lbDataHoraUltimoResete: TLabel;
    lbUsuarioBanco: TLabel;
    lbVersao: TLabel;
    lbTituloEnviados: TLabel;
    lbTituloNEnviados: TLabel;
    lbNEnviados: TLabel;
    Sms2: TACBrSMS;
    tVerificaRecebimentoSms: TTimer;
    lbRemoto: TLabel;
    tRemoto: TTimer;
    ckVerificaRecebidos: TCheckBox;
    tReenvia: TTimer;
    lbReenvio: TLabel;
    lbParada: TLabel;
    ckReenviar: TCheckBox;
    ckDiferenciar: TCheckBox;
    mmLog: TMemo;
    dbModem: TZConnection;
    qryTotalEnviados: TZQuery;
    upTotalEnviados: TZUpdateSQL;
    qrySms: TZQuery;
    upSms: TZUpdateSQL;
    qrySmsRecebido: TZQuery;
    upSmsRecebidos: TZUpdateSQL;
    qryUpdate: TZQuery;
    qryRemoto: TZQuery;
    qryReenvia: TZQuery;
    qryTotalEnviadosid: TIntegerField;
    qryTotalEnviadosCNPJ: TStringField;
    qryTotalEnviadosmensagem: TStringField;
    qryTotalEnviadoscelular: TStringField;
    qryTotalEnviadosdata: TDateField;
    qryTotalEnviadoshora: TTimeField;
    qryTotalEnviadosNumeroEnvio: TStringField;
    qryTotalEnviadosComputadorEnvio: TStringField;
    qryTotalEnviadosEnviado: TIntegerField;
    qryTotalEnviadosTipo: TStringField;
    qryTotalEnviadosRemetente: TStringField;
    qryTotalEnviadosCodigoTextoEmail: TStringField;
    qrySmsid: TIntegerField;
    qrySmsCNPJ: TStringField;
    qrySmsmensagem: TStringField;
    qrySmscelular: TStringField;
    qrySmsdata: TDateField;
    qrySmshora: TTimeField;
    qrySmsNumeroEnvio: TStringField;
    qrySmsComputadorEnvio: TStringField;
    qrySmsEnviado: TIntegerField;
    qrySmsTipo: TStringField;
    qrySmsRemetente: TStringField;
    qrySmsCodigoTextoEmail: TStringField;
    qrySmsRecebidoNumero: TStringField;
    qrySmsRecebidoMensagem: TStringField;
    qrySmsRecebidoData: TStringField;
    qrySmsRecebidoid: TIntegerField;
    qrySmsRecebidoHORA: TStringField;
    qrySmsRecebidoDestinatario: TStringField;
    qrySmsRecebidoOriginal: TStringField;
    qryRemotoStatus: TStringField;
    aeControlaErros: TApplicationEvents;
    qryModem: TZQuery;
    upModem: TZUpdateSQL;
    qryModemNumero: TStringField;
    qryModemData: TDateField;
    qryModemHora: TTimeField;
    qryModemEnvios: TIntegerField;
    qryModemLimite: TIntegerField;
    qryModemUltima: TTimeField;
    qryModemUltimoEnvio: TStringField;
    qryModemIntervalo: TIntegerField;
    qryModemStatus: TStringField;
    dbTotalEnviados: TZConnection;
    dbSms: TZConnection;
    dbSmsRecebidos: TZConnection;
    dbUpdate: TZConnection;
    dbREmoto: TZConnection;
    dbReenvia: TZConnection;
    tPingServer: TTimer;
    TParada: TTimer;
    lbTempoParada: TLabel;
    Button1: TButton;
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
    procedure BitBtn1Click(Sender: TObject);
  //  procedure tVerificaRecebimentoSmsTimer(Sender: TObject);
    procedure tRemotoTimer(Sender: TObject);
    procedure lbRemotoClick(Sender: TObject);
    procedure tReenviaTimer(Sender: TObject);
    procedure ckReenviarClick(Sender: TObject);
    procedure tPingServerTimer(Sender: TObject);
    procedure TParadaTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEnviaSms: TFEnviaSms;

implementation

{$R *.dfm}


Function RemoveAcento(Texto: string): String;
const
  sLetraA = '������������������������������������������������';
  sLetraB = 'aeiouaeiouaeiouaeiouaoncAEIOUAEIOUAEIOUAEIOUAONC';
var
  i: Integer;
begin
  for i := 1 to Length(sLetraA)  do
    Texto := StringReplace(Texto, sLetraA[i], sLetraB[i], [rfReplaceAll, rfIgnoreCase]);
  Result := Texto;
End;


Function Segundos : Integer;
var Seg : String;
begin
  Seg := (FormatDateTime('SS',Time));
  if Seg[2] = '' then
    Result := StrToInt(Seg[1])
  else
    Result := StrToInt(Seg[2]);
end;

Procedure EvitarAbrirVariasInstancias;
var handle: Thandle;
begin
  handle := FindWindow('TFEnviaSms',nil);
  if Handle<>0 then
  begin
    if not ISWindowVisible(Handle) then
      showWindow (handle, sw_restore);
    setForegroundWindow(handle);
    application.Terminate;
   end;
 begin
   application.Initialize;
   application.Createform(TFEnviaSms, FEnviaSms);
   application.Run;
 end;
end;

Function TotalEnviados(Celular : String) : String;
begin
  FEnviaSms.dbTotalEnviados.Connect;
  FEnviaSms.dbTotalEnviados.Disconnect;
  FEnviaSms.qryTotalEnviados.Active := False;
  FEnviaSms.qryTotalEnviados.Active := True;
  FEnviaSms.qryTotalEnviados.Close;
  FEnviaSms.qryTotalEnviados.ParamByName('Data').Value :=FormatDateTime('yyyy-mm-dd',Date);
  FEnviaSms.qryTotalEnviados.ParamByName('Celular').Value :=Celular;
  FEnviaSms.qryTotalEnviados.Open;
  if FEnviaSms.qryTotalEnviados.RecordCount <> NULL then
    Result := IntToStr(FEnviaSms.qryTotalEnviados.RecordCount);
end;

function VerificaSeJaExisteIntervalo(Intervalo : Integer) : Integer;
Var Existe : Boolean;
begin
  Existe := False;
  with FEnviaSms do
  begin
    FEnviaSms.dbModem.Connect ;
    FEnviaSms.dbModem.Disconnect;
    while not qryModem.Eof do
    begin
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
  FEnviaSms.dbUpdate.Connect ;
  FEnviaSms.dbUpdate.Disconnect;
  Total :=TotalEnviados(FEnviaSms.edNumeroCel.Text);
  FEnviaSms.qryUpdate.SQL.Text:=
  'update Conexao ' +#13+
  ' set Envios=NumeroEnvios,Ultima=HoraAtual,Intervalo=DefineIntervalo,UltimoEnvio=DefineUltimoEnvio ' +#13+
  ' where Numero=Celular ';
  Randomize ;
  Intervalo := Random(10)+Segundos;
  if Intervalo = 0 then
    Intervalo := 1+Segundos;
  Intervalo := VerificaSeJaExisteIntervalo(Intervalo);
  FEnviaSms.qryUpdate.SQL.Text:=
  StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(FEnviaSms.qryUpdate.SQL.Text,'NumeroEnvios',Total,[rfIgnoreCase]),'Celular',''''+Trim(FEnviaSms.edNumeroCel.Text)+'''',[rfIgnoreCase]),'HoraAtual',''''+FormatDateTime('hh:mm:ss',Time)+'''',[rfIgnoreCase]),'DefineIntervalo',''''+IntToStr(Intervalo)+'''',[rfIgnoreCase]),'DefineUltimoEnvio',''''+FEnviaSms.lbDataHoraUltimoEnvio.Caption+'''',[rfIgnoreCase]);
  FEnviaSms.qryUpdate.ExecSQL;
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
  if FEnviaSms.ckVerificaRecebidos.Checked then
    VerificaRecebidos := 'Sim';
  Pausado := 'Nao';
  if FEnviaSms.lbRemoto.Visible then
    Pausado := 'Sim';
  if FEnviaSms.ckReenviar.Checked then
    Reenvia :='Sim'
  else
    Reenvia := 'N�o';
  if FEnviaSms.ckDiferenciar.Checked then
    Diferencia := 'Sim'
  else
    Diferencia := 'N�o';

  if (not FEnviaSms.Sms.Ativo) and (InternetGetConnectedState(@i,0)=True) then begin
    FEnviaSms.tTempoFechar.Enabled := False;
    Parametros := ('PEnviadorSms.exe ' + ' "'+FEnviaSms.cbCom.text+'" ' +' "'+FEnviaSms.edNumeroCel.Text+'" ' +' "'+FEnviaSms.edMaxDia.Text+'" '+' "'+IntToStr(FEnviaSms.Top)+'"' +' "'+IntToStr(FEnviaSms.Left)+'" '+' "'+(FEnviaSms.lbDataHoraUltimoEnvio.Caption)+'"' +' "'+ FormatDateTime('dd/mm/yy',date) +':'+FormatDateTime('hh:mm:ss',Time) +'" '+' "'+(Usuario)+'" ' +' "'+(VerificaRecebidos)+'" ' +' "'+(Pausado)+'" ' +' "'+(Reenvia)+'" ' +' "'+(Diferencia)+'" ');
    WinExec(PAnsiChar(Parametros),1);
    Application.Terminate;
  end;
end;

Function ConectaBancoDeDados(Usuario , Senha : String) : Boolean;
Var StringConexao : String;
begin
{  FEnviaSms.dbPrincipal.Connected;
  FEnviaSms.dbPrincipal.User := Usuario ;
  FEnviaSms.dbPrincipal.Password := Senha;   }
end;


procedure AtivarConexao;
begin
  //ConectaBancoDeDados(Trim(ParamStr(8)),'cadmus182');
  try
    FEnviaSms.dbModem.Disconnect;
    FEnviaSms.dbModem.Connect ;
  except on E: Exception do
    //ResetaPrograma;
  end;
  FEnviaSms.qryModem.Active := False;
  FEnviaSms.qryModem.Active := True;

  FEnviaSms.dbTotalEnviados.Disconnect;
  FEnviaSms.dbTotalEnviados.Connect;

  FEnviaSms.qryTotalEnviados.Active := False;
  FEnviaSms.qrySms.Active := False;

  FEnviaSms.qryTotalEnviados.Active := True;
  FEnviaSms.qrySms.Active := True;

  FEnviaSms.qryModem.Close;
  FEnviaSms.qryModem.SQL.Clear;
  FEnviaSms.qryModem.SQL.Add('Select * from Conexao ');
  FEnviaSms.qryModem.SQL.Add(' where NUMERO = '+''''+Trim(FEnviaSms.edNumeroCel.Text)+'''');
  FEnviaSms.qryModem.Open;
end;

procedure DesativarConexao;
begin
  FEnviaSms.dbModem.Disconnect;
  FEnviaSms.qryModem.Active := False;
  FEnviaSms.dbSms.Disconnect;
  FEnviaSms.qrySms.Active := False;
  FEnviaSms.dbTotalEnviados.Disconnect;
  FEnviaSms.qryTotalEnviados.Active := False;
end;

procedure LimpandoChip;
var Numero : Integer;
begin
  Numero := 0;
  while Numero <=49 do
  begin
    FEnviaSms.Sms2.EnviarComando('AT+CMGD='+IntToStr(Numero));
    Numero := Numero + 1;
  end;
end;

function VerificaSmsRecebido : Boolean;
begin
  FEnviaSms.Sms2.Device.Porta := FEnviaSms.cbCom.Text;
  FEnviaSms.Sms2.Device.Baud  := 115200;
  FEnviaSms.Sms2.Desativar;
  Try
    FEnviaSms.Sms2.Ativar;
    FEnviaSms.Sms2.ListarMensagens(fltNaoLidas,'SmsRecebidos.txt');
    LimpandoChip;
  except on E: Exception do
    //showmessage(e.Message);
  End;
  FEnviaSms.Sms2.Desativar;
end;

Function VerificaConexao : Boolean;
var i : DWord;
begin
  Result := True;
  if not InternetGetConnectedState(@i,0) then
  begin
    Result := False;
    FEnviaSms.TVerificaNovoRegistro.Enabled := False;
    DesativarConexao;
    FEnviaSms.tAguardaConexao.Enabled := True;
    FEnviaSms.lbInternet.Show;
  end else
  begin
    AtivarConexao;
    FEnviaSms.TVerificaNovoRegistro.Enabled := True;
    AtualizaEnvioModem;
  end;
end;


procedure RegistraModem;
begin
  FEnviaSms.dbModem.Disconnect;
  FEnviaSms.dbModem.Connect ;
  FEnviaSms.qryModem.Close;
  FEnviaSms.qryModem.SQL.Text := 'Select * from Conexao';
  FEnviaSms.qryModem.Open;
  FEnviaSms.qryModem.Active:= True;
  FEnviaSms.qryModem.Insert;
  FEnviaSms.qryModem['Numero']:= FEnviaSms.edNumeroCel.Text;
  FEnviaSms.qryModem['data'] := FormatDateTime('dd/mm/yyyy',Date);
  FEnviaSms.qryModem['hora'] := FormatDateTime('hh:mm:ss',Time);
  FEnviaSms.qryModem['envios']:= TotalEnviados(FEnviaSms.edNumeroCel.Text);
  FEnviaSms.qryModem['Limite']:= FEnviaSms.edMaxDia.Text;
  FEnviaSms.qryModem['Intervalo']:=2;
  FEnviaSms.qryModem['Status']:='Ativo';
  Try
    FEnviaSms.qryModem.Post;
    //FEnviaSms.qryModem.ApplyUpdates;
  except on E: Exception do
   SHOWMESSAGE('ERRO AO GRAVAR');
  End;
end;

procedure DesregistraModem;
begin
  FEnviaSms.dbModem.Disconnect;
  FEnviaSms.dbModem.Connect ;
  FEnviaSms.qryModem.Close;
  FEnviaSms.qryModem.SQL.Clear;
  FEnviaSms.qryModem.SQL.Add('Select * from Conexao ');
  FEnviaSms.qryModem.SQL.Add(' where NUMERO = '+''''+FEnviaSms.edNumeroCel.Text+'''');
  FEnviaSms.qryModem.Open;
  if FEnviaSms.qryModem.RecordCount > 0 then
    FEnviaSms.qryModem.Delete;
end;

Function TestaPorta : Boolean;
begin
  Result := True;
  FEnviaSms.Sms.Desativar;
  FEnviaSms.Sms.Device.Porta :=FEnviaSms.cbCom.Text;
  FEnviaSms.Sms.Device.Baud  := 115200;
  Try
    FEnviaSms.Sms.Ativar;
  except on E: Exception do
    Result := False;
  End;
  FEnviaSms.Sms.Desativar;
  //Result := True;
end;

Procedure ConectaSms;
begin
  FEnviaSms.Sms.Desativar;
  FEnviaSms.Sms.Device.Porta :=FEnviaSms.cbCom.Text;
  FEnviaSms.Sms.Device.Baud  := 115200;
  //FEnviaSms.Sms.IntervaloEntreMensagens:= FEnviaSms.qryModem['Intervalo'];
  Try
    FEnviaSms.Sms.Ativar;
  except on E: Exception do
    FEnviaSms.Sms.Desativar;
  End;
end;

procedure DesativarEnvio;
begin
  FEnviaSms.btAtivarDesativar.Caption := 'Ativar';
  FEnviaSms.btAtivarDesativar.Font.Color:= clBlue;
  FEnviaSms.Sms.Desativar;
  DesregistraModem;
  FEnviaSms.tTempoFechar.Enabled := False;
  FEnviaSms.tVerificaRecebimentoSms.Enabled := False;
  FEnviaSms.TVerificaNovoRegistro.Enabled := False;
  FEnviaSms.tReenvia.Enabled := False;
  FEnviaSms.tRemoto.Enabled := False;
end;

procedure AtivaEnvio;
begin
  if TestaPorta then
  begin
    FEnviaSms.tRemoto.Enabled := True;
    FEnviaSms.TVerificaNovoRegistro.Enabled:= True;
    FEnviaSms.tReenvia.Enabled := True;
    FEnviaSms.btAtivarDesativar.Caption := 'Desativar';
    FEnviaSms.btAtivarDesativar.Font.Color:= clred;
    FEnviaSms.lbEnviados.Caption := TotalEnviados(FEnviaSms.edNumeroCel.Text);
    DesregistraModem;
    RegistraModem;
    if FEnviaSms.ckVerificaRecebidos.Checked then
      FEnviaSms.tVerificaRecebimentoSms.Enabled := True;
    FEnviaSms.tTempoFechar.Enabled := True;
  end else
  begin
    FEnviaSms.btAtivarDesativar.Caption := 'Ativar';
    FEnviaSms.btAtivarDesativar.Font.Color:= clBlue;
    FEnviaSms.TVerificaNovoRegistro.Enabled:= False;
    FEnviaSms.tReenvia.Enabled := False;
     FEnviaSms.tVerificaRecebimentoSms.Enabled := False;
    FEnviaSms.tTempoFechar.Enabled := False;
  end;
end;

procedure TFEnviaSms.aeControlaErrosActionExecute(Action: TBasicAction;
  var Handled: Boolean);
var i : integer;
begin

end;

procedure VerificaErro;
begin
  {if FEnviaSms.btAtivarDesativar.Caption = 'Desativar' then
  begin
    if VerificaConexao then
      //ResetaPrograma
    else
      FEnviaSms.tAguardaConexao.Enabled := True;
  end;   }
end;

procedure TFEnviaSms.aeControlaErrosException(Sender: TObject; E: Exception);
begin
  mmLog.Lines.Add(E.Message);
End;

procedure TFEnviaSms.aeControlaErrosMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  {if FEnviaSms.btAtivarDesativar.Caption = 'Desativar' then
  begin
    if VerificaConexao = False then
      tAguardaConexao.Enabled := True;
  end;  }
end;

procedure TFEnviaSms.BitBtn1Click(Sender: TObject);
begin
  VerificaSmsRecebido;
end;

procedure TFEnviaSms.btAtivarDesativarClick(Sender: TObject);
begin
   if btAtivarDesativar.Caption = 'Ativar' then
     AtivaEnvio
   else
     DesativarEnvio;
end;

procedure TFEnviaSms.Button1Click(Sender: TObject);
begin
 FEnviaSms.Sms2.Device.Porta := FEnviaSms.cbCom.Text;
  FEnviaSms.Sms2.Device.Baud  := 115200;
  Try
    FEnviaSms.Sms2.Ativar;
    FEnviaSms.Sms2.ListarMensagens(fltNaoLidas,'SmsRecebidos.txt');
    LimpandoChip;
  except on E: Exception do
    //showmessage(e.Message);
  End;
  FEnviaSms.Sms2.Desativar;
end;

procedure TFEnviaSms.ckReenviarClick(Sender: TObject);
begin
  if ckReenviar.Checked  then
    tReenvia.Enabled := True
  else
    tReenvia.Enabled := False;
end;

procedure TFEnviaSms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   DesregistraModem;
end;

procedure TFEnviaSms.FormShow(Sender: TObject);
var handle: Thandle;
begin
  cbCom.Text       := ParamStr(1);
  edNumeroCel.Text := ParamStr(2);
  edMaxDia.Text    := ParamStr(3);
  lbDataHoraUltimoResete.Caption := ParamStr(7);;
  if ParamStr(4) <> '' then
    FEnviaSms.Top    := StrToInt(ParamStr(4));
  if ParamStr(5) <> '' then
    FEnviaSms.Left   := StrToInt(ParamStr(5));
  if Trim(ParamStr(9)) = 'Sim' then
    ckVerificaRecebidos.Checked := True;
  if Trim(ParamStr(10)) = 'Sim' then
    lbRemoto.Visible := True;
  if Trim(ParamStr(11)) = 'Sim' then
    ckReenviar.Checked := True;
  if Trim(ParamStr(12)) = 'Sim' then
    ckDiferenciar.Checked := True;
  if Trim(ParamStr(6)) = '' then
    FEnviaSms.lbDataHoraUltimoEnvio.Caption    := 'Sem Envios'
  Else
    FEnviaSms.lbDataHoraUltimoEnvio.Caption    := Trim(ParamStr(6));
  if (ParamStr(1) <> '') and  (ParamStr(2) <> '') and  (ParamStr(3) <> '') then
    btAtivarDesativar.Click;
  if Trim(ParamStr(8)) = '' then
    lbUsuarioBanco.Caption := 'bibiacom_Geren';
  if Trim(ParamStr(8)) = 'bibiacom_Geren' then
    lbUsuarioBanco.Caption := 'bibiacom_Envia';
  if Trim(ParamStr(8)) = 'bibiacom_Envia' then
    lbUsuarioBanco.Caption := 'bibiacom_Geren';
end;

procedure TFEnviaSms.lbRemotoClick(Sender: TObject);
begin
  lbRemoto.Visible := False;
end;

procedure TFEnviaSms.tAguardaConexaoTimer(Sender: TObject);
begin
  if VerificaConexao then
  begin
    AtivarConexao;
    TVerificaNovoRegisTro.Enabled := True;
    lbInternet.Hide;
    tAguardaConexao.Enabled := False;
  end;
end;


procedure TFEnviaSms.TParadaTimer(Sender: TObject);
begin
  lbTempoParada.Caption := IntToStr(StrToInt(lbTempoParada.Caption)-1);
end;

procedure PingServer;
var
  I : Integer ;
begin
  for I := 1 to FEnviaSms.ComponentCount -1 do
  begin
    if FEnviaSms.Components[i] is TZConnection then
      if TZConnection(FEnviaSms.Components[i]).Connected then
        TZConnection(FEnviaSms.Components[i]).PingServer;
  end;
end;


procedure TFEnviaSms.tPingServerTimer(Sender: TObject);
begin
  PingServer;
end;

procedure TFEnviaSms.tReenviaTimer(Sender: TObject);
begin
  dbReenvia.Disconnect;
  dbReenvia.Connect;
  if (FormatDateTime('hh:mm',Time) < '21:00') and (ckReenviar.Checked)  then
  begin
    try
      qryReenvia.ExecSQL;
      lbReenvio.Caption := 'Ultimo Reenvio : ' + FormatDateTime('hh:mm:ss',Time);
    Except
      lbReenvio.Caption := 'Falha no Reenvio Reenvio : ' + FormatDateTime('hh:mm:ss',Time);
    end;
  end; 
end;

procedure TFEnviaSms.tRemotoTimer(Sender: TObject);
  procedure VerificarRemoto;
  begin
    FEnviaSms.dbREmoto.Disconnect;
    FEnviaSms.dbREmoto.Connect;
    FEnviaSms.qryRemoto.Close;
    FEnviaSms.qryRemoto.SQL.Clear;
    FEnviaSms.qryRemoto.SQL.Add('Select * from Conexao ');
    FEnviaSms.qryRemoto.SQL.Add(' where NUMERO = '+''''+FEnviaSms.edNumeroCel.Text+'''');
    FEnviaSms.qryRemoto.Open;
  end;
begin
  if edNumeroCel.Text <> '' then
  begin
    VerificarRemoto;
    if (qryRemoto['Status'] = 'Desativado') and (btAtivarDesativar.Caption='Desativar') then
      lbRemoto.Visible := True;
    if (qryRemoto['Status'] = 'Ativo') and (btAtivarDesativar.Caption='Desativar') then
      lbRemoto.Visible := False;
  end;
end;

procedure TFEnviaSms.tTempoFecharTimer(Sender: TObject);
begin
  ResetaPrograma;
end;

procedure TFEnviaSms.TVerificaNovoRegistroTimer(Sender: TObject);
  Function VerificaNovoRegistro : Boolean;
  begin
    if 1=1 then //VerificaConexao
    begin
      Result := False;
      lbEnviados.Caption := TotalEnviados(Trim(edNumeroCel.Text));
      dbSms.Disconnect;
      dbSms.Connect;
      qrySms.Active := False;
      qrySms.Active := True;
      if qrySms.RecordCount > 0  then
        Result := True;
    end;
  end;

  procedure GravaEnviado;
  begin
    qrySms.Edit;
    qrySms['data'] := FormatDateTime('dd/mm/yyyy',Date);
    qrySms['hora'] := FormatDateTime('hh:mm:ss',Time);
    qrySms['NumeroEnvio'] := edNumeroCel.Text;
    qrySms['Enviado'] :=1;
    try
      qrySms.Post;
      qrySms.ApplyUpdates;
     except on E: Exception do

    end;
  end;

  procedure GravaNaoEnviado;
  begin
    qrySms.Edit;
    qrySms['data'] := FormatDateTime('dd/mm/yyyy',Date);
    qrySms['hora'] := FormatDateTime('hh:mm:ss',Time);
    qrySms['NumeroEnvio'] := edNumeroCel.Text;
    qrySms['Enviado'] :=3;
    Try
      qrySms.Post;
      qrySms.ApplyUpdates;
    except on E: Exception do

    End;
  end;

  procedure TravaSms;
  begin
    qrySms.Edit;
    qrySms['Enviado'] :=2;
    try
      qrySms.Post;
      qrySms.ApplyUpdates;
    except on E: Exception do

    end;
  end;

  Function VerificaLimiteEnvio : Boolean;
  begin
    Result := False;
    if lbEnviados.Caption = edMaxDia.Text then
    begin
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


  procedure EnviaSms(Celular,Mensagem : String);
  var IndiceMsgEnviada : String;
  begin
    IndiceMsgEnviada := '1';
    //if VerificaNovoRegistro then
    //begin
      TravaSms ;
      ConectaSms;
      if ckDiferenciar.Checked then
        Mensagem := Diferenciar(Mensagem);
      Try
        FEnviaSms.Sms.EnviarSMS(Celular,RemoveAcento(Mensagem),IndiceMsgEnviada);
        GravaEnviado;
        lbDataHoraUltimoEnvio.Caption := FormatDateTime('dd/mm/yy',date) +':'+FormatDateTime('hh:mm:ss',Time);
        AtualizaEnvioModem;
      except on E: Exception do
      begin
        mmLog.Lines.Add(E.Message);
        GravaNaoEnviado;
        lbNEnviados.Caption := IntToStr(StrToInt(lbNEnviados.Caption)+1);
        //FEnviaSms.Sms.Desativar;
        TVerificaNovoRegistro.Enabled := True;
      end;
      End;
    //end;
    FEnviaSms.Sms.Desativar;
  end;

  procedure BuscaModem;
  begin
    dbModem.Disconnect;
    dbModem.Connect;
    FEnviaSms.qryModem.Close;
    FEnviaSms.qryModem.SQL.Clear;
    FEnviaSms.qryModem.SQL.Add('Select * from Conexao ');
    FEnviaSms.qryModem.SQL.Add(' where NUMERO = '+''''+FEnviaSms.edNumeroCel.Text+'''');
    FEnviaSms.qryModem.Open;
  end;
  
Var Intervalo : Cardinal;
begin

  lbParada.Hide;
  TParada.Enabled := False;
  lbTempoParada.Caption := '180';
  lbTempoParada.Hide;

  Intervalo := Random(9000);
  if Intervalo = 0  then
     Intervalo := 1;
  //TVerificaNovoRegistro.Enabled := False;
  AtivarConexao;
  if FEnviaSms.ckVerificaRecebidos.Checked then
    FEnviaSms.tVerificaRecebimentoSms.Enabled := True
  else
    FEnviaSms.tVerificaRecebimentoSms.Enabled := False;
  if 1=1 then //(VerificaConexao) 
  begin
    if VerificaNovoRegistro then
      if VerificaLimiteEnvio = False then
        if(lbRemoto.Visible = False) then
          EnviaSms(qrySms['Celular'],qrySms['Mensagem']);
    BuscaModem;
    Randomize;
    TVerificaNovoRegistro.Interval := Intervalo  ;
    lbIntervalo.Caption := FloatToStr(TVerificaNovoRegistro.Interval);
    if (StrToInt(lbEnviados.Caption) MOD 40  = 0) and (Trim(lbEnviados.Caption)<>'0') then
    begin
      TVerificaNovoRegistro.Interval := 180000;
      lbParada.Show;
      TParada.Enabled := True;
      lbTempoParada.Show;
    end;
    DesativarConexao;
    //TVerificaNovoRegistro.Enabled := True;
  end;

end;

procedure GravandoSmsRecebidos;
  procedure GravaBancoDeDados(Mensagem,Celular : String);
  begin
    with FEnviaSms do
    begin
      dbSmsRecebidos.Connected := False;
      dbSmsRecebidos.Connected := True;
      qrySmsRecebido.Active := False;
      qrySmsRecebido.Active := true;

      if Trim(Celular) <> '' then
      begin
        qrySmsRecebido.Insert;
        qrySmsRecebidoNumero.Value := Copy(Celular,Pos('","',Celular)+6,Pos('",,"',Celular)-Pos('","',Celular)-6);
        qrySmsRecebidoMensagem.Value := Mensagem;
        qrySmsRecebidoData.Value := FormatDateTime('dd/mm/yyyy',Date);
        qrySmsRecebidoHora.Value := FormatDateTime('HH:MM:ss',Time);
        try
          qrySmsRecebido.Post;
          qrySmsRecebido.ApplyUpdates;
        except
        end;
      end;
    end;
  end;
var arq : TextFile;
Linha1,Linha2,PrimeiraLinha : String;
begin
  if FileExists('SmsRecebidos.txt') then
  begin
    AssignFile(Arq,'SmsRecebidos.txt');
    Reset(Arq);
    Readln(Arq,PrimeiraLinha);
    while not eof(Arq)  do
    begin
      Readln(Arq,Linha1);
      Readln(Arq,Linha2);
      if (Linha2 <> 'AT+CMGL="REC UNREAD"') and (Linha1 <> 'O') and (Linha2 <> 'O')
         and (Trim(Linha1) <> '') and (Trim(Linha2) <> '') then
        GravaBancoDeDados(Linha2,Linha1);
    end;
    CloseFile(Arq);
    DeleteFile('SmsRecebidos.txt');
  end;
end;

{procedure TFEnviaSms.tVerificaRecebimentoSmsTimer(Sender: TObject);

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
     if qrySmsRecebido.RecordCount > 0 then
     begin
       Total := qrySmsRecebido.RecordCount;
       Contador := 1;
       while Total >= Contador do
       begin
         qryVerificaDestinatario.Close;
         qryVerificaDestinatario.Parameters.ParamByName('Celular').Value :=
         Trim(qrySmsRecebidoNumero.Value) ;
         qryVerificaDestinatario.Open;
         if qryVerificaDestinatario.RecordCount > 0 then
         begin
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
  tVerificaRecebimentoSms.Enabled := False;
  //Application.ProcessMessages;
  if not FileExists('SmsRecebidos.txt') then
    VerificaSmsRecebido;
  if FileExists('SmsRecebidos.txt') then
    GravandoSmsRecebidos;
  tVerificaRecebimentoSms.Enabled := True;
end;
      }
end.
