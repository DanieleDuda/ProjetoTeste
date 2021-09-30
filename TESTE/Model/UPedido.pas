unit UPedido;

interface

type
  TPedido = class
  private
    Fvalor_total: real;
    Fdata_emissao: TDate;
    Fid_pedido: integer;
    Ffk_cod_cliente: integer;
  published
    public
      property id_pedido: integer read Fid_pedido write Fid_pedido;
      property data_emissao: TDate read Fdata_emissao write Fdata_emissao;
      property fk_cod_cliente: integer read Ffk_cod_cliente write Ffk_cod_cliente;
      property valor_total: real read Fvalor_total write Fvalor_total;
  end;

implementation

end.
