object fmRelatorios: TfmRelatorios
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rios Simples Sms'
  ClientHeight = 508
  ClientWidth = 777
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gbOpcaoFiltro: TGroupBox
    Left = 0
    Top = 0
    Width = 777
    Height = 169
    Align = alTop
    Caption = 'Op'#231#245'es de Filtro'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 38
      Height = 13
      Caption = 'Clientes'
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label3: TLabel
      Left = 160
      Top = 72
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object mkDataInicial: TMaskEdit
      Left = 16
      Top = 89
      Width = 119
      Height = 21
      EditMask = '!99/99/00;1;_'
      MaxLength = 8
      TabOrder = 0
      Text = '  /  /  '
    end
    object mkDataFinal: TMaskEdit
      Left = 160
      Top = 89
      Width = 119
      Height = 21
      EditMask = '!99/99/00;1;_'
      MaxLength = 8
      TabOrder = 1
      Text = '  /  /  '
    end
    object btBuscar: TBitBtn
      Left = 368
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Buscar'
      TabOrder = 2
      OnClick = btBuscarClick
    end
    object btExportarPdf: TBitBtn
      Left = 368
      Top = 119
      Width = 75
      Height = 25
      Caption = 'Exportar Pdf'
      TabOrder = 3
    end
    object cbListaClientes: TDBLookupComboBox
      Left = 16
      Top = 43
      Width = 337
      Height = 21
      KeyField = 'CNPJ'
      ListField = 'Nome'
      ListSource = dsRelClientes
      TabOrder = 4
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 424
    Width = 777
    Height = 65
    Align = alBottom
    Caption = 'Totais'
    TabOrder = 1
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 36
      Height = 13
      Caption = 'Envios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 80
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Valor Cada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 515
      Top = 22
      Width = 36
      Height = 13
      Caption = 'Envios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 592
      Top = 22
      Width = 60
      Height = 13
      Caption = 'Valor Cada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 680
      Top = 24
      Width = 61
      Height = 13
      Caption = 'Valor Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 162
      Top = 24
      Width = 61
      Height = 13
      Caption = 'Valor Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbValorCadaSms: TLabel
      Left = 80
      Top = 43
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbValorTotalSms: TLabel
      Left = 162
      Top = 43
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label13: TLabel
      Left = 360
      Top = 22
      Width = 111
      Height = 13
      Caption = 'Valor Cobrado Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbValorTotalCobrado: TLabel
      Left = 363
      Top = 40
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbEnvioEmail: TLabel
      Left = 515
      Top = 40
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbEnvioCadaEmail: TLabel
      Left = 592
      Top = 41
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbValorTotalEmail: TLabel
      Left = 684
      Top = 40
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lbEnviosSms: TLabel
      Left = 16
      Top = 43
      Width = 6
      Height = 13
      Caption = '0'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 489
    Width = 777
    Height = 19
    Panels = <>
  end
  object gbListaEnvios: TGroupBox
    Left = 0
    Top = 169
    Width = 777
    Height = 255
    Align = alClient
    Caption = 'Lista de Envios'
    TabOrder = 3
    object gbListaSms: TGroupBox
      Left = 2
      Top = 15
      Width = 367
      Height = 238
      Align = alLeft
      Caption = 'Lista Sms'
      TabOrder = 0
      object dgLIstaSms: TDBGrid
        Left = 2
        Top = 15
        Width = 363
        Height = 221
        Align = alClient
        DataSource = dsListaSms
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NumeroDia'
            Visible = True
          end>
      end
    end
    object gbListaEmails: TGroupBox
      Left = 400
      Top = 15
      Width = 375
      Height = 238
      Align = alRight
      Caption = 'Lista Emais'
      TabOrder = 1
      object dbListaEmail: TDBGrid
        Left = 2
        Top = 15
        Width = 371
        Height = 221
        Align = alClient
        DataSource = dsListaEmail
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NumeroDia'
            Visible = True
          end>
      end
    end
  end
  object dsListaSms: TDataSource
    DataSet = dmPrincipal.qrySms
    Left = 184
    Top = 328
  end
  object dsListaEmail: TDataSource
    DataSet = dmPrincipal.qryEmail
    Left = 456
    Top = 336
  end
  object dsRelClientes: TDataSource
    DataSet = dmPrincipal.qryRelClientes
    Left = 352
    Top = 40
  end
end
