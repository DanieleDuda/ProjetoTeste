unit UdmdProduto;

interface

uses
  SysUtils, Classes, FMTBcd, DB, DBClient, Provider, SqlExpr, UProduto;

type
  TdmdProduto = class(TDataModule)
    SqlProduto: TSQLQuery;
    dspProduto: TDataSetProvider;
    CdsProduto: TClientDataSet;
    CdsProdutocodigo_produto: TIntegerField;
    CdsProdutodescricao: TStringField;
    CdsProdutopreco_venda: TFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
    function RetornaProduto(vCodProd:integer):TProduto;
  end;

var
  dmdProduto: TdmdProduto;

implementation

{$R *.dfm}

{ TdmdProduto }

function TdmdProduto.RetornaProduto(vCodProd: integer): TProduto;
var obProduto:TProduto;
begin
  if (CdsProduto.Active) then
    CdsProduto.Close;

  CdsProduto.Params[0].AsInteger:=vCodProd;
  CdsProduto.Open;

  obProduto:=TProduto.Create;
  with obProduto do
  begin
    codigo:=CdsProdutocodigo_produto.AsInteger;
    descricao:=CdsProdutodescricao.AsString;
    preco_venda:=CdsProdutopreco_venda.AsFloat;
  end;

  result:=obProduto;
  CdsProduto.Close;
end;

end.
