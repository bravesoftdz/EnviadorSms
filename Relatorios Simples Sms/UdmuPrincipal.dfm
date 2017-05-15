object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 306
  Width = 392
  object dbPrincipal: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    Connected = True
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_Consult'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'libmySQL.dll'
    Left = 32
    Top = 16
  end
  object qrySms: TZQuery
    Connection = dbPrincipal
    SQL.Strings = (
      'SELECT '
      '  Data,Count(*) as NumeroDia '
      'FROM '
      '  Enviados'
      'where '
      '  Tipo='#39'S'#39' and'
      '  CNPJ=:Empresa and'
      '  data between :DataInicial and :DataFinal'
      '  and Enviado=1'
      'Group by Data')
    Params = <
      item
        DataType = ftUnknown
        Name = 'Empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataFinal'
        ParamType = ptUnknown
      end>
    Left = 32
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataFinal'
        ParamType = ptUnknown
      end>
    object qrySmsData: TDateField
      FieldName = 'Data'
    end
    object qrySmsNumeroDia: TLargeintField
      FieldName = 'NumeroDia'
      ReadOnly = True
    end
  end
  object qryEmail: TZQuery
    Connection = dbPrincipal
    SQL.Strings = (
      'SELECT '
      '  Data,Count(*) as NumeroDia '
      'FROM '
      '  Enviados'
      'where '
      '  Tipo='#39'E'#39' and'
      '  CNPJ=:Empresa and'
      '  data between :DataInicial and :DataFinal'
      '  and Enviado=1'
      'Group by Data')
    Params = <
      item
        DataType = ftUnknown
        Name = 'Empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataFinal'
        ParamType = ptUnknown
      end>
    Left = 32
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DataFinal'
        ParamType = ptUnknown
      end>
    object qryEmailData: TDateField
      FieldName = 'Data'
    end
    object qryEmailNumeroDia: TLargeintField
      FieldName = 'NumeroDia'
      ReadOnly = True
    end
  end
  object qryRelClientes: TZQuery
    Connection = dbPrincipal
    Active = True
    SQL.Strings = (
      'Select '
      '  *'
      'From'
      '  Clientes'
      ''
      ''
      '')
    Params = <>
    Left = 32
    Top = 176
    object qryRelClientesNome: TStringField
      FieldName = 'Nome'
      Required = True
      Size = 400
    end
    object qryRelClientesCNPJ: TStringField
      FieldName = 'CNPJ'
      Required = True
      Size = 80
    end
    object qryRelClientesid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qryRelClientesSENHA: TStringField
      FieldName = 'SENHA'
      Required = True
      Size = 16
    end
    object qryRelClientesCelularAviso: TStringField
      FieldName = 'CelularAviso'
      Size = 80
    end
    object qryRelClientesEmailAviso: TStringField
      FieldName = 'EmailAviso'
      Size = 480
    end
    object qryRelClientesUltimaHoraAtivo: TStringField
      FieldName = 'UltimaHoraAtivo'
      Size = 40
    end
    object qryRelClientesUltimaDataAtivo: TDateField
      FieldName = 'UltimaDataAtivo'
    end
    object qryRelClientesDiaVencimento: TIntegerField
      FieldName = 'DiaVencimento'
    end
    object qryRelClientesPrazoPagamento: TIntegerField
      FieldName = 'PrazoPagamento'
    end
  end
end
