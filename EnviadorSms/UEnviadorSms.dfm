object FEnviaSms: TFEnviaSms
  Left = 0
  Top = 0
  Caption = 'Enviador Sms'
  ClientHeight = 497
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbVersao: TLabel
    Left = 8
    Top = 88
    Width = 6
    Height = 13
    Caption = '7'
  end
  object gbConfigurar: TGroupBox
    Left = 0
    Top = 0
    Width = 891
    Height = 149
    Align = alTop
    Caption = 'Configurar'
    TabOrder = 0
    object lbPorta: TLabel
      Left = 13
      Top = 16
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object lbNumero: TLabel
      Left = 168
      Top = 16
      Width = 37
      Height = 13
      Caption = 'Numero'
    end
    object lbMaxDia: TLabel
      Left = 293
      Top = 14
      Width = 38
      Height = 13
      Caption = 'Max Dia'
    end
    object lbEnviados: TLabel
      Left = 623
      Top = 34
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbAviso: TLabel
      Left = 694
      Top = 53
      Width = 176
      Height = 33
      Caption = 'Limite Atingido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbInternet: TLabel
      Left = 714
      Top = 14
      Width = 156
      Height = 33
      Caption = 'Sem Internet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbUltimoEnvio: TLabel
      Left = 13
      Top = 62
      Width = 65
      Height = 13
      Caption = 'Ultimo Envio :'
    end
    object lbDataHoraUltimoEnvio: TLabel
      Left = 82
      Top = 62
      Width = 54
      Height = 13
      Caption = 'Sem Envios'
    end
    object lbIntervalo: TLabel
      Left = 178
      Top = 59
      Width = 44
      Height = 13
      Caption = 'Intervalo'
    end
    object lbUltimoResete: TLabel
      Left = 307
      Top = 61
      Width = 66
      Height = 13
      Caption = 'Ultimo Resete'
    end
    object lbDataHoraUltimoResete: TLabel
      Left = 384
      Top = 62
      Width = 3
      Height = 13
    end
    object lbUsuarioBanco: TLabel
      Left = 495
      Top = 64
      Width = 3
      Height = 13
    end
    object lbTituloEnviados: TLabel
      Left = 607
      Top = 15
      Width = 43
      Height = 13
      Caption = 'Enviados'
    end
    object lbTituloNEnviados: TLabel
      Left = 596
      Top = 59
      Width = 65
      Height = 13
      Caption = 'N'#227'o Enviados'
    end
    object lbNEnviados: TLabel
      Left = 621
      Top = 78
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbRemoto: TLabel
      Left = 388
      Top = 14
      Width = 213
      Height = 13
      Caption = 'Desativado Pelo Remoto clique para reativar'
      Visible = False
      OnClick = lbRemotoClick
    end
    object lbReenvio: TLabel
      Left = 272
      Top = 96
      Width = 39
      Height = 13
      Caption = 'Reenvio'
    end
    object lbParada: TLabel
      Left = 416
      Top = 96
      Width = 58
      Height = 19
      Caption = 'Parada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbTempoParada: TLabel
      Left = 480
      Top = 96
      Width = 30
      Height = 19
      Caption = '180'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object cbCom: TComboBox
      Left = 11
      Top = 32
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'cbCom'
    end
    object edNumeroCel: TEdit
      Left = 166
      Top = 31
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'edNumeroCel'
    end
    object edMaxDia: TEdit
      Left = 293
      Top = 31
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'edMaxDia'
    end
    object btAtivarDesativar: TBitBtn
      Left = 440
      Top = 29
      Width = 105
      Height = 25
      Caption = 'Ativar'
      TabOrder = 3
      OnClick = btAtivarDesativarClick
    end
    object ckVerificaRecebidos: TCheckBox
      Left = 32
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Verifica Recebidos'
      TabOrder = 4
    end
    object ckReenviar: TCheckBox
      Left = 32
      Top = 108
      Width = 97
      Height = 17
      Caption = 'Reenviar'
      TabOrder = 5
      OnClick = ckReenviarClick
    end
    object ckDiferenciar: TCheckBox
      Left = 32
      Top = 129
      Width = 97
      Height = 17
      Caption = 'Diferenciar'
      TabOrder = 6
      OnClick = ckReenviarClick
    end
    object Button1: TButton
      Left = 584
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 7
      OnClick = Button1Click
    end
  end
  object mmLog: TMemo
    Left = 0
    Top = 155
    Width = 891
    Height = 89
    TabOrder = 1
  end
  object TVerificaNovoRegistro: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = TVerificaNovoRegistroTimer
    Left = 32
    Top = 153
  end
  object Sms: TACBrSMS
    Ativo = False
    Modelo = modDaruma
    ATTimeOut = 900000
    ATResult = False
    IntervaloEntreMensagens = 0
    RecebeConfirmacao = False
    QuebraMensagens = False
    Left = 121
    Top = 180
  end
  object ds: TDataSource
    Left = 256
    Top = 184
  end
  object dsModem: TDataSource
    Left = 256
    Top = 216
  end
  object tAguardaConexao: TTimer
    Enabled = False
    OnTimer = tAguardaConexaoTimer
    Left = 72
    Top = 152
  end
  object tTempoFechar: TTimer
    Tag = 1
    Enabled = False
    Interval = 100000
    OnTimer = tTempoFecharTimer
    Left = 112
    Top = 153
  end
  object Sms2: TACBrSMS
    Ativo = False
    Modelo = modZTE
    ATTimeOut = 10000
    ATResult = False
    IntervaloEntreMensagens = 0
    RecebeConfirmacao = False
    QuebraMensagens = False
    Left = 160
    Top = 179
  end
  object tVerificaRecebimentoSms: TTimer
    Enabled = False
    Interval = 4000
    Left = 152
    Top = 153
  end
  object tRemoto: TTimer
    Enabled = False
    Interval = 9000
    OnTimer = tRemotoTimer
    Left = 189
    Top = 152
  end
  object tReenvia: TTimer
    Enabled = False
    Interval = 1800000
    OnTimer = tReenviaTimer
    Left = 221
    Top = 152
  end
  object dbModem: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_EnviaS'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\EnviadorSms\libmySQL.dll'
    Left = 72
    Top = 256
  end
  object qryTotalEnviados: TZQuery
    Connection = dbTotalEnviados
    UpdateObject = upTotalEnviados
    SQL.Strings = (
      'Select * from Enviados'
      'where data=:Data and NumeroEnvio=:Celular'
      'and Enviado=1'
      'and Tipo='#39'S'#39
      '')
    Params = <
      item
        DataType = ftString
        Name = 'Data'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'Celular'
        ParamType = ptUnknown
      end>
    Left = 120
    Top = 298
    ParamData = <
      item
        DataType = ftString
        Name = 'Data'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'Celular'
        ParamType = ptUnknown
      end>
    object qryTotalEnviadosid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qryTotalEnviadosCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 160
    end
    object qryTotalEnviadosmensagem: TStringField
      FieldName = 'mensagem'
      Size = 720
    end
    object qryTotalEnviadoscelular: TStringField
      FieldName = 'celular'
      Size = 320
    end
    object qryTotalEnviadosdata: TDateField
      FieldName = 'data'
    end
    object qryTotalEnviadoshora: TTimeField
      FieldName = 'hora'
    end
    object qryTotalEnviadosNumeroEnvio: TStringField
      FieldName = 'NumeroEnvio'
      Size = 320
    end
    object qryTotalEnviadosComputadorEnvio: TStringField
      FieldName = 'ComputadorEnvio'
      Size = 80
    end
    object qryTotalEnviadosEnviado: TIntegerField
      FieldName = 'Enviado'
    end
    object qryTotalEnviadosTipo: TStringField
      FieldName = 'Tipo'
      Size = 4
    end
    object qryTotalEnviadosRemetente: TStringField
      FieldName = 'Remetente'
      Size = 320
    end
    object qryTotalEnviadosCodigoTextoEmail: TStringField
      FieldName = 'CodigoTextoEmail'
      Required = True
      Size = 120
    end
  end
  object upTotalEnviados: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM Enviados'
      'WHERE'
      '  Enviados.id = :OLD_id')
    InsertSQL.Strings = (
      'INSERT INTO Enviados'
      
        '  (id, CNPJ, mensagem, celular, data, hora, NumeroEnvio, Computa' +
        'dorEnvio, '
      '   Enviado, Tipo, Remetente, CodigoTextoEmail)'
      'VALUES'
      
        '  (:id, :CNPJ, :mensagem, :celular, :data, :hora, :NumeroEnvio, ' +
        ':ComputadorEnvio, '
      '   :Enviado, :Tipo, :Remetente, :CodigoTextoEmail)')
    ModifySQL.Strings = (
      'UPDATE Enviados SET'
      '  id = :id,'
      '  CNPJ = :CNPJ,'
      '  mensagem = :mensagem,'
      '  celular = :celular,'
      '  data = :data,'
      '  hora = :hora,'
      '  NumeroEnvio = :NumeroEnvio,'
      '  ComputadorEnvio = :ComputadorEnvio,'
      '  Enviado = :Enviado,'
      '  Tipo = :Tipo,'
      '  Remetente = :Remetente,'
      '  CodigoTextoEmail = :CodigoTextoEmail'
      'WHERE'
      '  Enviados.id = :OLD_id')
    UseSequenceFieldForRefreshSQL = False
    Left = 160
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CNPJ'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mensagem'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'celular'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'hora'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NumeroEnvio'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ComputadorEnvio'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Enviado'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Tipo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Remetente'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodigoTextoEmail'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_id'
        ParamType = ptUnknown
      end>
  end
  object qrySms: TZQuery
    Connection = dbSms
    UpdateObject = upSms
    SQL.Strings = (
      'Select * from Enviados'
      'where enviado = 0 '
      'and Tipo='#39'S'#39
      'order by celular,Rand() desc')
    Params = <>
    Left = 120
    Top = 330
    object qrySmsid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qrySmsCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 160
    end
    object qrySmsmensagem: TStringField
      FieldName = 'mensagem'
      Size = 720
    end
    object qrySmscelular: TStringField
      FieldName = 'celular'
      Size = 320
    end
    object qrySmsdata: TDateField
      FieldName = 'data'
    end
    object qrySmshora: TTimeField
      FieldName = 'hora'
    end
    object qrySmsNumeroEnvio: TStringField
      FieldName = 'NumeroEnvio'
      Size = 320
    end
    object qrySmsComputadorEnvio: TStringField
      FieldName = 'ComputadorEnvio'
      Size = 80
    end
    object qrySmsEnviado: TIntegerField
      FieldName = 'Enviado'
    end
    object qrySmsTipo: TStringField
      FieldName = 'Tipo'
      Size = 4
    end
    object qrySmsRemetente: TStringField
      FieldName = 'Remetente'
      Size = 320
    end
    object qrySmsCodigoTextoEmail: TStringField
      FieldName = 'CodigoTextoEmail'
      Required = True
      Size = 120
    end
  end
  object upSms: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM Enviados'
      'WHERE'
      '  Enviados.id = :OLD_id')
    InsertSQL.Strings = (
      'INSERT INTO Enviados'
      
        '  (id, CNPJ, mensagem, celular, data, hora, NumeroEnvio, Computa' +
        'dorEnvio, '
      '   Enviado, Tipo, Remetente, CodigoTextoEmail)'
      'VALUES'
      
        '  (:id, :CNPJ, :mensagem, :celular, :data, :hora, :NumeroEnvio, ' +
        ':ComputadorEnvio, '
      '   :Enviado, :Tipo, :Remetente, :CodigoTextoEmail)')
    ModifySQL.Strings = (
      'UPDATE Enviados SET'
      '  id = :id,'
      '  CNPJ = :CNPJ,'
      '  mensagem = :mensagem,'
      '  celular = :celular,'
      '  data = :data,'
      '  hora = :hora,'
      '  NumeroEnvio = :NumeroEnvio,'
      '  ComputadorEnvio = :ComputadorEnvio,'
      '  Enviado = :Enviado,'
      '  Tipo = :Tipo,'
      '  Remetente = :Remetente,'
      '  CodigoTextoEmail = :CodigoTextoEmail'
      'WHERE'
      '  Enviados.id = :OLD_id')
    UseSequenceFieldForRefreshSQL = False
    Left = 160
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CNPJ'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'mensagem'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'celular'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'hora'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NumeroEnvio'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ComputadorEnvio'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Enviado'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Tipo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Remetente'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodigoTextoEmail'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_id'
        ParamType = ptUnknown
      end>
  end
  object qrySmsRecebido: TZQuery
    Connection = dbSmsRecebidos
    UpdateObject = upSmsRecebidos
    SQL.Strings = (
      'Select * from Recebidas'
      ''
      ''
      ''
      ''
      '')
    Params = <>
    Left = 120
    Top = 362
    object qrySmsRecebidoNumero: TStringField
      FieldName = 'Numero'
      Size = 48
    end
    object qrySmsRecebidoMensagem: TStringField
      FieldName = 'Mensagem'
      Size = 640
    end
    object qrySmsRecebidoData: TStringField
      FieldName = 'Data'
      Size = 48
    end
    object qrySmsRecebidoid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qrySmsRecebidoHORA: TStringField
      FieldName = 'HORA'
      Size = 32
    end
    object qrySmsRecebidoDestinatario: TStringField
      FieldName = 'Destinatario'
      Size = 120
    end
    object qrySmsRecebidoOriginal: TStringField
      FieldName = 'Original'
      Size = 720
    end
  end
  object upSmsRecebidos: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM Recebidas'
      'WHERE'
      '  Recebidas.id = :OLD_id')
    InsertSQL.Strings = (
      'INSERT INTO Recebidas'
      '  (Numero, Mensagem, Data, id, HORA, Destinatario, Original)'
      'VALUES'
      
        '  (:Numero, :Mensagem, :Data, :id, :HORA, :Destinatario, :Origin' +
        'al)')
    ModifySQL.Strings = (
      'UPDATE Recebidas SET'
      '  Numero = :Numero,'
      '  Mensagem = :Mensagem,'
      '  Data = :Data,'
      '  id = :id,'
      '  HORA = :HORA,'
      '  Destinatario = :Destinatario,'
      '  Original = :Original'
      'WHERE'
      '  Recebidas.id = :OLD_id')
    UseSequenceFieldForRefreshSQL = False
    Left = 160
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Numero'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Mensagem'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'HORA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Destinatario'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Original'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_id'
        ParamType = ptUnknown
      end>
  end
  object qryUpdate: TZQuery
    Connection = dbUpdate
    SQL.Strings = (
      'update Conexao'
      'set Envios=NumeroEnvios'
      'where Numero=Celular')
    Params = <>
    Left = 120
    Top = 394
  end
  object qryRemoto: TZQuery
    Connection = dbREmoto
    SQL.Strings = (
      'Select Status from Conexao')
    Params = <>
    Left = 120
    Top = 426
    object qryRemotoStatus: TStringField
      FieldName = 'Status'
      Size = 40
    end
  end
  object qryReenvia: TZQuery
    Connection = dbReenvia
    CachedUpdates = True
    SQL.Strings = (
      
        'update  `Enviados` set Enviado=0 WHERE data = current_date and E' +
        'nviado = 3 and Tipo='#39'S'#39'  order by celular,rand()')
    Params = <>
    Left = 120
    Top = 458
  end
  object aeControlaErros: TApplicationEvents
    OnActionExecute = aeControlaErrosActionExecute
    OnException = aeControlaErrosException
    Left = 376
    Top = 160
  end
  object qryModem: TZQuery
    Connection = dbModem
    UpdateObject = upModem
    SQL.Strings = (
      'select * from Conexao'
      ''
      ''
      '')
    Params = <>
    Left = 120
    Top = 256
    object qryModemNumero: TStringField
      FieldName = 'Numero'
      Size = 200
    end
    object qryModemData: TDateField
      FieldName = 'Data'
    end
    object qryModemHora: TTimeField
      FieldName = 'Hora'
    end
    object qryModemEnvios: TIntegerField
      FieldName = 'Envios'
    end
    object qryModemLimite: TIntegerField
      FieldName = 'Limite'
    end
    object qryModemUltima: TTimeField
      FieldName = 'Ultima'
    end
    object qryModemUltimoEnvio: TStringField
      FieldName = 'UltimoEnvio'
      Size = 72
    end
    object qryModemIntervalo: TIntegerField
      FieldName = 'Intervalo'
    end
    object qryModemStatus: TStringField
      FieldName = 'Status'
      Size = 40
    end
  end
  object upModem: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM Conexao'
      'WHERE'
      
        '  ((Conexao.Numero IS NULL AND :OLD_Numero IS NULL) OR (Conexao.' +
        'Numero = :OLD_Numero)) AND'
      
        '  ((Conexao.Data IS NULL AND :OLD_Data IS NULL) OR (Conexao.Data' +
        ' = :OLD_Data)) AND'
      
        '  ((Conexao.Hora IS NULL AND :OLD_Hora IS NULL) OR (Conexao.Hora' +
        ' = :OLD_Hora))')
    InsertSQL.Strings = (
      'INSERT INTO Conexao'
      
        '  (Numero, Data, Hora, Envios, Limite, Ultima, UltimoEnvio, Inte' +
        'rvalo, '
      '   Status)'
      'VALUES'
      
        '  (:Numero, :Data, :Hora, :Envios, :Limite, :Ultima, :UltimoEnvi' +
        'o, :Intervalo, '
      '   :Status)')
    ModifySQL.Strings = (
      'UPDATE Conexao SET'
      '  Numero = :Numero,'
      '  Data = :Data,'
      '  Hora = :Hora,'
      '  Envios = :Envios,'
      '  Limite = :Limite,'
      '  Ultima = :Ultima,'
      '  UltimoEnvio = :UltimoEnvio,'
      '  Intervalo = :Intervalo,'
      '  Status = :Status'
      'WHERE'
      
        '  ((Conexao.Numero IS NULL AND :OLD_Numero IS NULL) OR (Conexao.' +
        'Numero = :OLD_Numero)) AND'
      
        '  ((Conexao.Data IS NULL AND :OLD_Data IS NULL) OR (Conexao.Data' +
        ' = :OLD_Data)) AND'
      
        '  ((Conexao.Hora IS NULL AND :OLD_Hora IS NULL) OR (Conexao.Hora' +
        ' = :OLD_Hora))')
    UseSequenceFieldForRefreshSQL = False
    Left = 160
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Numero'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Hora'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Envios'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Limite'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Ultima'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'UltimoEnvio'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Intervalo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Status'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_Numero'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_Data'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_Hora'
        ParamType = ptUnknown
      end>
  end
  object dbTotalEnviados: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_EnviaS'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\EnviadorSms\libmySQL.dll'
    Left = 72
    Top = 296
  end
  object dbSms: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_EnviaS'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\EnviadorSms\libmySQL.dll'
    Left = 72
    Top = 328
  end
  object dbSmsRecebidos: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_EnviaS'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\EnviadorSms\libmySQL.dll'
    Left = 72
    Top = 360
  end
  object dbUpdate: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_EnviaS'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\EnviadorSms\libmySQL.dll'
    Left = 72
    Top = 399
  end
  object dbREmoto: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_EnviaS'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\EnviadorSms\libmySQL.dll'
    Left = 72
    Top = 431
  end
  object dbReenvia: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_EnviaS'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\EnviadorSms\libmySQL.dll'
    Left = 72
    Top = 463
  end
  object tPingServer: TTimer
    Interval = 9000
    OnTimer = tPingServerTimer
    Left = 253
    Top = 152
  end
  object TParada: TTimer
    Enabled = False
    OnTimer = TParadaTimer
    Left = 293
    Top = 152
  end
end
