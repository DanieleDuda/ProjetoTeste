unit UPedidoProdutoController;

interface

uses UdmdPedidoProduto, UPedidoProduto;

type
  TPedidoProdutoController = class
    public
      constructor Create;
      destructor Destroy; override;
      function Inserir(obPedidoProduto: TPedidoProduto; var sErro:string):boolean;
      function Excluir(idNumPedido:Integer; var sErro:string):Boolean;
  end;

implementation

uses
  Forms;

{ TPedidoProduto }


{ TPedidoProdutoController }

constructor TPedidoProdutoController.Create;
begin
end;

destructor TPedidoProdutoController.Destroy;
begin

  inherited;
end;

function TPedidoProdutoController.Excluir(idNumPedido: integer;
  var sErro: string): Boolean;
begin
  result:=dmdPedidoProduto.Excluir(idNumPedido,sErro);
end;

function TPedidoProdutoController.Inserir(obPedidoProduto: TPedidoProduto;
  var sErro: string): boolean;
begin
  result:=dmdPedidoProduto.Inserir(obPedidoProduto, sErro);
end;

end.
