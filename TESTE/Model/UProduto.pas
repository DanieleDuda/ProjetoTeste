unit UProduto;

interface

type
  TProduto = class
  private
    Fpreco_venda: real;
    Fdescricao: string;
    Fcodigo: integer;
  published
    public
      property codigo:integer read Fcodigo write Fcodigo;
      property descricao: string read Fdescricao write Fdescricao;
      property preco_venda: real read Fpreco_venda write Fpreco_venda;
    end;

implementation

end.
