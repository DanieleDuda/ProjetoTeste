unit UPedidoProduto;

interface

type
  TPedidoProduto = class
  private
    Fvalor_unitario: real;
    Ffk_num_pedido: integer;
    Fvalor_total: real;
    Ffk_cod_produto: integer;
    Fquantidade: integer;
    Fid_prod_pedido: integer;
  published
    public
      property id_prod_pedido:integer read Fid_prod_pedido write Fid_prod_pedido;
      property fk_num_pedido:integer read Ffk_num_pedido write Ffk_num_pedido;
      property fk_cod_produto: integer read Ffk_cod_produto write Ffk_cod_produto;
      property quantidade: integer read Fquantidade write Fquantidade;
      property valor_unitario: real read Fvalor_unitario write Fvalor_unitario;
      property valor_total: real read Fvalor_total write Fvalor_total;
  end;

implementation

end.
