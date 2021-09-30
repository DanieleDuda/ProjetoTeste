unit UListaPedidoProduto;

interface

uses
  Classes, UConsultaItens;


Type
  TListaPedidoProduto = class
  private
    { private declarations }
    FListaPedidoProduto : TList;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor create;
    procedure Adicionar(pPedidoProduto: TConsultaItens);
  published
    { published declarations }
  end;
implementation

{ TListaPedidoProduto }

procedure TListaPedidoProduto.Adicionar(pPedidoProduto: TConsultaItens);
begin
  FListaPedidoProduto.Add(pPedidoProduto);
end;

constructor TListaPedidoProduto.create;
begin
  inherited Create;
  FListaPedidoProduto := TList.Create;
end;

end.
