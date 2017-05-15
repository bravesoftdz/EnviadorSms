object fVerificadator: TfVerificadator
  Left = 0
  Top = 0
  Caption = 'Verifica Envios'
  ClientHeight = 640
  ClientWidth = 1294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object gbEsperandoEnvios: TGroupBox
    Left = 0
    Top = 0
    Width = 1294
    Height = 193
    Align = alTop
    Caption = 'Esperando Envios'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 32
      Top = 88
      Width = 320
      Height = 120
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 2
      Top = 15
      Width = 1290
      Height = 176
      Align = alClient
      DataSource = dsEsperando
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJ'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'mensagem'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'celular'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NumeroEnvio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ComputadorEnvio'
          Width = 105
          Visible = True
        end>
    end
  end
  object gbEnviados: TGroupBox
    Left = 0
    Top = 193
    Width = 1294
    Height = 232
    Align = alTop
    Caption = 'Enviados'
    TabOrder = 1
    object DBGrid3: TDBGrid
      Left = 2
      Top = 15
      Width = 1290
      Height = 215
      Align = alClient
      DataSource = dsEnviados
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJ'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'mensagem'
          Width = 543
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'celular'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NumeroEnvio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ComputadorEnvio'
          Visible = True
        end>
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 425
    Width = 1294
    Height = 136
    Align = alTop
    Caption = 'N'#227'o Ennviados'
    TabOrder = 2
    object DBGrid4: TDBGrid
      Left = 2
      Top = 15
      Width = 1290
      Height = 119
      Align = alClient
      DataSource = dsNenviados
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJ'
          Width = 165
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'mensagem'
          Width = 545
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'celular'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NumeroEnvio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ComputadorEnvio'
          Visible = True
        end>
    end
  end
  object gbModens: TGroupBox
    Left = 0
    Top = 561
    Width = 1294
    Height = 79
    Align = alClient
    Caption = 'Modens'
    TabOrder = 3
    object DBGrid5: TDBGrid
      Left = 32
      Top = 88
      Width = 320
      Height = 120
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid6: TDBGrid
      Left = 2
      Top = 15
      Width = 1290
      Height = 62
      Align = alClient
      DataSource = dsModem
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object qryModem: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Conexao')
    Left = 32
    Top = 203
    object qryModemNumero: TStringField
      FieldName = 'Numero'
      FixedChar = True
      Size = 11
    end
    object qryModemdata: TDateField
      FieldName = 'data'
    end
    object qryModemhora: TTimeField
      FieldName = 'hora'
    end
    object qryModemenvios: TIntegerField
      FieldName = 'envios'
    end
    object qryModemLimite: TIntegerField
      FieldName = 'Limite'
    end
  end
  object qrySmsEsperando: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Enviados'
      'where enviado = 0 '
      'order by id desc')
    Left = 32
    Top = 243
    object qrySmsEsperandoid: TIntegerField
      DisplayWidth = 12
      FieldName = 'id'
    end
    object qrySmsEsperandoCNPJ: TStringField
      DisplayWidth = 31
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 40
    end
    object qrySmsEsperandomensagem: TStringField
      DisplayWidth = 71
      FieldName = 'mensagem'
      FixedChar = True
      Size = 180
    end
    object qrySmsEsperandocelular: TStringField
      DisplayWidth = 19
      FieldName = 'celular'
      FixedChar = True
      Size = 12
    end
    object qrySmsEsperandodata: TDateField
      DisplayWidth = 18
      FieldName = 'data'
    end
    object qrySmsEsperandohora: TTimeField
      DisplayWidth = 21
      FieldName = 'hora'
    end
    object qrySmsEsperandoNumeroEnvio: TStringField
      DisplayWidth = 13
      FieldName = 'NumeroEnvio'
      FixedChar = True
      Size = 11
    end
    object qrySmsEsperandoComputadorEnvio: TStringField
      DisplayWidth = 24
      FieldName = 'ComputadorEnvio'
      FixedChar = True
    end
    object qrySmsEsperandoEnviado: TIntegerField
      DisplayWidth = 12
      FieldName = 'Enviado'
    end
  end
  object dbPrincipal: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=cadmus182;Persist Security Info=True' +
      ';User ID=bibiacom_Geren;Data Source=Simples Sms 32;Initial Catal' +
      'og=bibiacom_Sms'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 32
    Top = 171
  end
  object Tverifica: TTimer
    OnTimer = TverificaTimer
    Left = 32
    Top = 139
  end
  object qrySmsEnviados: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Enviados'
      'where enviado = 1'
      'order by id desc')
    Left = 32
    Top = 283
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'id'
    end
    object StringField1: TStringField
      DisplayWidth = 27
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 40
    end
    object StringField2: TStringField
      DisplayWidth = 114
      FieldName = 'mensagem'
      FixedChar = True
      Size = 180
    end
    object StringField3: TStringField
      DisplayWidth = 15
      FieldName = 'celular'
      FixedChar = True
      Size = 12
    end
    object DateField1: TDateField
      DisplayWidth = 12
      FieldName = 'data'
    end
    object TimeField1: TTimeField
      DisplayWidth = 12
      FieldName = 'hora'
    end
    object StringField4: TStringField
      DisplayWidth = 13
      FieldName = 'NumeroEnvio'
      FixedChar = True
      Size = 11
    end
    object StringField5: TStringField
      DisplayWidth = 24
      FieldName = 'ComputadorEnvio'
      FixedChar = True
    end
    object IntegerField2: TIntegerField
      DisplayWidth = 12
      FieldName = 'Enviado'
    end
  end
  object qrySmsNEnviados: TADOQuery
    Connection = dbPrincipal
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Enviados'
      'where enviado = 3'
      'order by id desc')
    Left = 32
    Top = 323
    object qrySmsNEnviadosid: TIntegerField
      FieldName = 'id'
    end
    object qrySmsNEnviadosCNPJ: TStringField
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 40
    end
    object qrySmsNEnviadosmensagem: TStringField
      FieldName = 'mensagem'
      FixedChar = True
      Size = 180
    end
    object qrySmsNEnviadoscelular: TStringField
      FieldName = 'celular'
      FixedChar = True
      Size = 12
    end
    object qrySmsNEnviadosdata: TDateField
      FieldName = 'data'
    end
    object qrySmsNEnviadoshora: TTimeField
      FieldName = 'hora'
    end
    object qrySmsNEnviadosNumeroEnvio: TStringField
      FieldName = 'NumeroEnvio'
      FixedChar = True
      Size = 11
    end
    object qrySmsNEnviadosComputadorEnvio: TStringField
      FieldName = 'ComputadorEnvio'
      FixedChar = True
    end
    object qrySmsNEnviadosEnviado: TIntegerField
      FieldName = 'Enviado'
    end
  end
  object dsEsperando: TDataSource
    DataSet = qrySmsEsperando
    Left = 96
    Top = 256
  end
  object dsEnviados: TDataSource
    DataSet = qrySmsEnviados
    Left = 96
    Top = 296
  end
  object dsNenviados: TDataSource
    DataSet = qrySmsNEnviados
    Left = 96
    Top = 336
  end
  object dsModem: TDataSource
    DataSet = qryModem
    Left = 96
    Top = 376
  end
  object aeControlaErros: TApplicationEvents
    Left = 376
    Top = 136
  end
end
