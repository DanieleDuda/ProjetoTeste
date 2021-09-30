unit UProdutoController;

interface

uses UProduto, UdmdProduto;

  type
    TProdutoController = class
      constructor Create;
      destructor Destroy; override;
      function RetornaProduto(vCodProd:integer):TProduto;
    end;

implementation

uses
  Forms;

{ TProdutoController }

constructor TProdutoController.Create;
begin
  dmdProduto:=TdmdProduto.Create(application);
end;

destructor TProdutoController.Destroy;
begin
  dmdProduto.Destroy;
  inherited;
end;

function TProdutoController.RetornaProduto(vCodProd: integer): TProduto;
begin
  result:=dmdProduto.RetornaProduto(vCodProd);
end;

end.
