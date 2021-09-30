object dmdCliente: TdmdCliente
  OldCreateOrder = False
  Height = 201
  Width = 294
  object SqlCliente: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'cod_cliente'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select *  from tb_cliente'
      'where codigo= :cod_cliente')
    SQLConnection = dmdConexao.SqlConexao
    Left = 40
    Top = 64
  end
  object DspCliente: TDataSetProvider
    DataSet = SqlCliente
    Left = 80
    Top = 64
  end
  object CdsCliente: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'cod_cliente'
        ParamType = ptInput
      end>
    ProviderName = 'DspCliente'
    Left = 120
    Top = 64
    object CdsClientenome: TStringField
      FieldName = 'nome'
      Size = 45
    end
    object CdsClientecodigo: TIntegerField
      FieldName = 'codigo'
      Required = True
    end
    object CdsClientecidade: TStringField
      FieldName = 'cidade'
      Size = 45
    end
    object CdsClienteuf: TStringField
      FieldName = 'uf'
      Size = 2
    end
  end
end
