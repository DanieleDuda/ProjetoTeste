unit UPedidoController;

interface

uses UPedido, UdmdPedido;

type
  TPedidoController = class
    public
      constructor Create;
      destructor Destroy; override;
      function Inserir(obPedido: TPedido; var sErro:string; var num_pedido:integer):boolean;
      function Excluir(idNumPedido:SmallInt; var sErro:string):Boolean;
      procedure Pesquisar(vNumPedido:integer);
      function RetornaPedido(numPedido:integer):TPedido;
    end;

implementation

uses
  Forms;

{ TPedidoController }

constructor TPedidoController.Create;
begin
end;

destructor TPedidoController.Destroy;
begin

  inherited;
end;

function TPedidoController.Excluir(idNumPedido: SmallInt;
  var sErro: string): Boolean;
begin
  Result:=dmdPedido.Excluir(idNumPedido,sErro);
end;

function TPedidoController.Inserir(obPedido: TPedido;
  var sErro: string; var num_pedido:integer): boolean;
begin
  result:=dmdPedido.Inserir(obPedido,sErro, num_pedido);
end;

procedure TPedidoController.Pesquisar(vNumPedido: integer);
begin
  dmdPedido.PesquisarPedido(vNumPedido);
end;

function TPedidoController.RetornaPedido(numPedido: integer): TPedido;
begin
  result:=dmdPedido.RetornaPedido(numPedido);
end;

end.
