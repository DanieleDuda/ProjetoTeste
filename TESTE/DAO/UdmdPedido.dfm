object dmdPedido: TdmdPedido
  OldCreateOrder = False
  Height = 390
  Width = 579
  object SqlInserir: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'id_pedido'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'data_emissao'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fk_cod_cliente'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'valor_total_pedido'
        ParamType = ptInput
      end>
    SQL.Strings = (
      
        'insert into tb_pedido (id_pedido, data_emissao, fk_cod_cliente, ' +
        'valor_total_pedido) values ('
      ':id_pedido, :data_emissao, :fk_cod_cliente, :valor_total_pedido)')
    SQLConnection = dmdConexao.SqlConexao
    Left = 48
    Top = 40
  end
  object SqlExcluir: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'id_pedido'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'delete from tb_pedido where id_pedido = :id_pedido')
    SQLConnection = dmdConexao.SqlConexao
    Left = 48
    Top = 104
  end
  object SqlPesquisarPedido: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'num_pedido'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select'
      '  tp.id_pedido,'
      '  tp.data_emissao,'
      '  tp.valor_total_pedido,'
      '  tp.fk_cod_cliente,'
      
        '  (select tc.nome from tb_cliente tc where tc.codigo=tp.fk_cod_c' +
        'liente) as nome_cliente'
      'from tb_pedido tp'
      'where tp.id_pedido=:num_pedido')
    SQLConnection = dmdConexao.SqlConexao
    Left = 272
    Top = 176
  end
  object DspPesquisarPedido: TDataSetProvider
    DataSet = SqlPesquisarPedido
    Left = 304
    Top = 176
  end
  object CdsPesquisarPedido: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'num_pedido'
        ParamType = ptInput
      end>
    ProviderName = 'DspPesquisarPedido'
    Left = 344
    Top = 176
    object CdsPesquisarPedidoid_pedido: TIntegerField
      FieldName = 'id_pedido'
      Required = True
    end
    object CdsPesquisarPedidodata_emissao: TDateField
      FieldName = 'data_emissao'
    end
    object CdsPesquisarPedidovalor_total_pedido: TFMTBCDField
      FieldName = 'valor_total_pedido'
      Precision = 12
      Size = 2
    end
    object CdsPesquisarPedidofk_cod_cliente: TIntegerField
      FieldName = 'fk_cod_cliente'
    end
    object CdsPesquisarPedidonome_cliente: TStringField
      FieldName = 'nome_cliente'
      Size = 45
    end
  end
end
