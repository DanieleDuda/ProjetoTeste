object dmdProduto: TdmdProduto
  OldCreateOrder = False
  Height = 203
  Width = 333
  object SqlProduto: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'cod_produto'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from tb_produto'
      'where codigo_produto = :cod_produto')
    SQLConnection = dmdConexao.SqlConexao
    Left = 40
    Top = 64
  end
  object dspProduto: TDataSetProvider
    DataSet = SqlProduto
    Left = 80
    Top = 64
  end
  object CdsProduto: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'cod_produto'
        ParamType = ptInput
      end>
    ProviderName = 'dspProduto'
    Left = 120
    Top = 64
    object CdsProdutocodigo_produto: TIntegerField
      FieldName = 'codigo_produto'
      Required = True
    end
    object CdsProdutodescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object CdsProdutopreco_venda: TFMTBCDField
      FieldName = 'preco_venda'
      Precision = 12
      Size = 2
    end
  end
end
