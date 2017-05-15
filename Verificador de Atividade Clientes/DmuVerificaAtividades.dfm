object dmVerificaAtividades: TdmVerificaAtividades
  OldCreateOrder = False
  Height = 277
  Width = 394
  object qryEmpresa: TZQuery
    Connection = dbPrincipal
    Active = True
    SQL.Strings = (
      
        'Select Nome,Cnpj,UltimaDataAtivo,UltimaHoraAtivo,EmailAviso,Celu' +
        'larAviso,Status from Clientes'
      ''
      ''
      ''
      '')
    Params = <>
    Left = 48
    Top = 64
    object qryEmpresaNome: TStringField
      FieldName = 'Nome'
      Required = True
      Size = 400
    end
    object qryEmpresaCnpj: TStringField
      FieldName = 'Cnpj'
      Required = True
      Size = 80
    end
    object qryEmpresaUltimaDataAtivo: TDateField
      FieldName = 'UltimaDataAtivo'
    end
    object qryEmpresaUltimaHoraAtivo: TStringField
      FieldName = 'UltimaHoraAtivo'
      Size = 40
    end
    object qryEmpresaEmailAviso: TStringField
      FieldName = 'EmailAviso'
      Size = 480
    end
    object qryEmpresaCelularAviso: TStringField
      FieldName = 'CelularAviso'
      Size = 80
    end
    object qryEmpresaStatus: TStringField
      FieldName = 'Status'
      Size = 40
    end
  end
  object qrySmsEmail: TZQuery
    Connection = dbPrincipal
    UpdateObject = upSmsEmail
    SQL.Strings = (
      'select * from Enviados where 1=2'
      '')
    Params = <>
    Left = 48
    Top = 112
    object qrySmsEmailid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qrySmsEmailCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 160
    end
    object qrySmsEmailmensagem: TStringField
      FieldName = 'mensagem'
      Size = 720
    end
    object qrySmsEmailcelular: TStringField
      FieldName = 'celular'
      Size = 320
    end
    object qrySmsEmaildata: TDateField
      FieldName = 'data'
    end
    object qrySmsEmailhora: TTimeField
      FieldName = 'hora'
    end
    object qrySmsEmailNumeroEnvio: TStringField
      FieldName = 'NumeroEnvio'
      Size = 320
    end
    object qrySmsEmailComputadorEnvio: TStringField
      FieldName = 'ComputadorEnvio'
      Size = 80
    end
    object qrySmsEmailEnviado: TIntegerField
      FieldName = 'Enviado'
    end
    object qrySmsEmailTipo: TStringField
      FieldName = 'Tipo'
      Size = 4
    end
    object qrySmsEmailRemetente: TStringField
      FieldName = 'Remetente'
      Size = 320
    end
    object qrySmsEmailCodigoTextoEmail: TStringField
      FieldName = 'CodigoTextoEmail'
      Required = True
      Size = 120
    end
  end
  object upSmsEmail: TZUpdateSQL
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
    Left = 136
    Top = 112
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
  object qryTextoEmail: TZQuery
    Connection = dbPrincipal
    UpdateObject = upTextoEmail
    SQL.Strings = (
      'select * from TextoEmai where 1=2')
    Params = <>
    Left = 48
    Top = 160
    object qryTextoEmailCodigoTextoEmail: TStringField
      FieldName = 'CodigoTextoEmail'
      Size = 120
    end
    object qryTextoEmailTexto: TMemoField
      FieldName = 'Texto'
      Required = True
      BlobType = ftMemo
    end
    object qryTextoEmailCnpj: TStringField
      FieldName = 'Cnpj'
      Required = True
      Size = 120
    end
  end
  object upTextoEmail: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM TextoEmail'
      'WHERE'
      
        '  ((TextoEmail.CodigoTextoEmail IS NULL AND :OLD_CodigoTextoEmai' +
        'l IS NULL) OR (TextoEmail.CodigoTextoEmail = :OLD_CodigoTextoEma' +
        'il)) AND'
      '  TextoEmail.Cnpj = :OLD_Cnpj')
    InsertSQL.Strings = (
      'INSERT INTO TextoEmail'
      '  (CodigoTextoEmail, Texto, Cnpj)'
      'VALUES'
      '  (:CodigoTextoEmail, :Texto, :Cnpj)')
    ModifySQL.Strings = (
      'UPDATE TextoEmail SET'
      '  CodigoTextoEmail = :CodigoTextoEmail,'
      '  Texto = :Texto,'
      '  Cnpj = :Cnpj'
      'WHERE'
      
        '  ((TextoEmail.CodigoTextoEmail IS NULL AND :OLD_CodigoTextoEmai' +
        'l IS NULL) OR (TextoEmail.CodigoTextoEmail = :OLD_CodigoTextoEma' +
        'il)) AND'
      '  TextoEmail.Cnpj = :OLD_Cnpj')
    UseSequenceFieldForRefreshSQL = False
    Left = 136
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CodigoTextoEmail'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Texto'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CNPJ'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_CodigoTextoEmail'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_Cnpj'
        ParamType = ptUnknown
      end>
  end
  object TPingServer: TTimer
    Interval = 6000
    OnTimer = TPingServerTimer
    Left = 200
    Top = 112
  end
  object dbPrincipal: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    Connected = True
    HostName = 'www.bibia.com.br'
    Port = 3306
    Database = 'bibiacom_Sms'
    User = 'bibiacom_Email'
    Password = 'cadmus182'
    Protocol = 'mysql-5'
    LibraryLocation = 'C:\Projeto Sms\Verificador de Atividade Clientes\libmySQL.dll'
    Left = 48
    Top = 16
  end
end
