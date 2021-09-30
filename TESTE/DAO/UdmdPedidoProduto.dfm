object dmdPedidoProduto: TdmdPedidoProduto
  OldCreateOrder = False
  Height = 310
  Width = 523
  object SqlInserir: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'fk_num_pedido'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'fk_cod_produto'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'quantidade'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'valor_unitario'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'valor_total'
        ParamType = ptInput
      end>
    SQL.Strings = (
      
        'insert into tb_produto_pedido (fk_num_pedido, fk_cod_produto, qu' +
        'antidade, valor_unitario, valor_total) values'
      
        '( :fk_num_pedido, :fk_cod_produto, :quantidade, :valor_unitario,' +
        ' :valor_total)')
    SQLConnection = dmdConexao.SqlConexao
    Left = 48
    Top = 40
  end
  object SqlExcluir: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'num_pedido'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'delete from tb_produto_pedido where fk_num_pedido= :num_pedido')
    SQLConnection = dmdConexao.SqlConexao
    Left = 48
    Top = 96
  end
end
