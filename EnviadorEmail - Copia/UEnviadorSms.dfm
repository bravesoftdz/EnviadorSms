object FEnviaEmail: TFEnviaEmail
  Left = 0
  Top = 0
  Caption = 'Enviador Email'
  ClientHeight = 335
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
  object Label1: TLabel
    Left = 8
    Top = 88
    Width = 6
    Height = 13
    Caption = '2'
  end
  object gbConfigurar: TGroupBox
    Left = 0
    Top = 0
    Width = 891
    Height = 149
    Align = alTop
    Caption = 'Configurar'
    TabOrder = 0
    object lbUsuario: TLabel
      Left = 13
      Top = 16
      Width = 36
      Height = 13
      Caption = 'Usuario'
    end
    object lbSenha: TLabel
      Left = 168
      Top = 16
      Width = 30
      Height = 13
      Caption = 'Senha'
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
      Left = 544
      Top = 109
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
    object cbUusario: TComboBox
      Left = 11
      Top = 32
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'simplessms@gmail.com'
      Items.Strings = (
        'AKIAJVLO2YAUFJVB2UHQ'
        'simplessms@gmail.com')
    end
    object edMaxDia: TEdit
      Left = 293
      Top = 31
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '10'
    end
    object btAtivarDesativar: TBitBtn
      Left = 440
      Top = 29
      Width = 105
      Height = 25
      Caption = 'Ativar'
      TabOrder = 2
      OnClick = btAtivarDesativarClick
    end
    object ckVerificaRecebidos: TCheckBox
      Left = 32
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Verifica Recebidos'
      TabOrder = 3
    end
    object ckReenviar: TCheckBox
      Left = 32
      Top = 108
      Width = 97
      Height = 17
      Caption = 'Reenviar'
      TabOrder = 4
      OnClick = ckReenviarClick
    end
    object ckDiferenciar: TCheckBox
      Left = 32
      Top = 129
      Width = 97
      Height = 17
      Caption = 'Diferenciar'
      TabOrder = 5
      OnClick = ckReenviarClick
    end
    object rgOpcaoEnvio: TRadioGroup
      Left = 148
      Top = 100
      Width = 208
      Height = 46
      Caption = 'Op'#231#227'o Envio'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Mandril'
        'SeS Amazon')
      TabOrder = 6
    end
    object cbSenha: TComboBox
      Left = 162
      Top = 31
      Width = 127
      Height = 21
      ItemHeight = 13
      TabOrder = 7
      Text = 'simplessms@gmail.com'
      Items.Strings = (
        'Ao69w253pZBzZaUy780w5T1kZMGr8gmU8ycPhjzpphbW'
        'NJL6tmYUpExprGr75W_ZNA')
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 152
    Width = 891
    Height = 89
    TabOrder = 1
  end
  object TVerificaNovoRegistro: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TVerificaNovoRegistroTimer
    Left = 32
    Top = 153
  end
  object dbPrincipal: TADOConnection
    CommandTimeout = 0
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=cadmus182;Persist Security Info=True' +
      ';User ID=bibiacom_Envia;Data Source=Simples Sms 32;Initial Catal' +
      'og=bibiacom_Sms'
    ConnectionTimeout = 0
    LoginPrompt = False
    Left = 32
    Top = 188
  end
  object qryEmail: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'Select * from Enviados'
      'where enviado = 0 '
      'and Tipo='#39'E'#39
      'order by celular,Rand() desc')
    Left = 32
    Top = 300
    object qryEmailid: TIntegerField
      FieldName = 'id'
    end
    object qryEmailCNPJ: TStringField
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 40
    end
    object qryEmailmensagem: TStringField
      FieldName = 'mensagem'
      FixedChar = True
      Size = 180
    end
    object qryEmaildata: TDateField
      FieldName = 'data'
    end
    object qryEmailhora: TTimeField
      FieldName = 'hora'
    end
    object qryEmailComputadorEnvio: TStringField
      FieldName = 'ComputadorEnvio'
      FixedChar = True
    end
    object qryEmailEnviado: TIntegerField
      FieldName = 'Enviado'
    end
    object qryEmailTipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
    object qryEmailcelular: TStringField
      FieldName = 'celular'
      FixedChar = True
      Size = 80
    end
    object qryEmailNumeroEnvio: TStringField
      FieldName = 'NumeroEnvio'
      FixedChar = True
      Size = 80
    end
    object qryEmailRemetente: TStringField
      FieldName = 'Remetente'
      Size = 80
    end
    object qryEmailCodigoTextoEmail: TStringField
      FieldName = 'CodigoTextoEmail'
      Size = 30
    end
  end
  object qryTotalEnviados: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'Data'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Celular'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'Select * from Enviados'
      'where data=:Data and NumeroEnvio=:Celular'
      'and Enviado=1'
      'and Tipo = '#39'E'#39)
    Left = 32
    Top = 260
    object IntegerField1: TIntegerField
      FieldName = 'id'
    end
    object StringField1: TStringField
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 40
    end
    object StringField2: TStringField
      FieldName = 'mensagem'
      FixedChar = True
      Size = 180
    end
    object DateField1: TDateField
      FieldName = 'data'
    end
    object TimeField1: TTimeField
      FieldName = 'hora'
    end
    object StringField5: TStringField
      FieldName = 'ComputadorEnvio'
      FixedChar = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'Enviado'
    end
    object qryTotalEnviadoscelular: TStringField
      FieldName = 'celular'
      FixedChar = True
      Size = 80
    end
    object qryTotalEnviadosNumeroEnvio: TStringField
      FieldName = 'NumeroEnvio'
      FixedChar = True
      Size = 80
    end
    object qryTotalEnviadosTipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
    object qryTotalEnviadosRemetente: TStringField
      FieldName = 'Remetente'
      Size = 80
    end
    object qryTotalEnviadosCodigoTextoEmail: TStringField
      FieldName = 'CodigoTextoEmail'
      Size = 10
    end
  end
  object ds: TDataSource
    DataSet = qryEmail
    Left = 256
    Top = 184
  end
  object dsModem: TDataSource
    DataSet = qryModem
    Left = 256
    Top = 216
  end
  object qryUpdate: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'update Conexao'
      'set Envios=NumeroEnvios'
      'where Numero=Celular')
    Left = 80
    Top = 292
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
    Interval = 10000000
    OnTimer = tTempoFecharTimer
    Left = 112
    Top = 153
  end
  object tVerificaRecebimentoSms: TTimer
    Enabled = False
    Interval = 4000
    Left = 152
    Top = 153
  end
  object qryRemoto: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'Select Status from Conexao'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 64
    Top = 228
    object qryRemotoStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
  end
  object tRemoto: TTimer
    Interval = 9000
    OnTimer = tRemotoTimer
    Left = 189
    Top = 152
  end
  object qryModem: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Conexao')
    Left = 32
    Top = 224
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
      Size = 10
    end
    object qryModemStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
    object qryModemIntervalo: TIntegerField
      FieldName = 'Intervalo'
    end
    object qryModemNumero: TStringField
      FieldName = 'Numero'
      Size = 50
    end
  end
  object tReenvia: TTimer
    Enabled = False
    Interval = 1800000
    OnTimer = tReenviaTimer
    Left = 221
    Top = 152
  end
  object Email: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    ReadingConfirmation = True
    IsHTML = True
    Attempts = 3
    Left = 416
    Top = 256
  end
  object qryEmpresa: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'Cnpj'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    SQL.Strings = (
      'Select Nome from Clientes'
      'where CNPJ =:Cnpj')
    Left = 32
    Top = 340
    object qryEmpresaNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
  end
  object qryTextoEmail: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'Cnpj'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = -1
        Value = ''
      end>
    SQL.Strings = (
      'Select Texto from TextoEmail'
      'where Cnpj=:Cnpj and CodigoTextoEmail=:Codigo')
    Left = 80
    Top = 340
    object qryTextoEmailTexto: TMemoField
      FieldName = 'Texto'
      BlobType = ftMemo
    end
  end
end
