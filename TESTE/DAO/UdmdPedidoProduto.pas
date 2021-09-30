unit UdmdPedidoProduto;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, UPedidoProduto;

type
  TdmdPedidoProduto = class(TDataModule)
    SqlInserir: TSQLQuery;
    SqlExcluir: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function Inserir(objPedidoProduto:TPedidoProduto; out sErro:string):boolean;
    function Excluir(vidPedido:integer; out sErro:string):boolean;
  end;

var
  dmdPedidoProduto: TdmdPedidoProduto;

implementation

uses UdmdConexao;

{$R *.dfm}

{ TdmdPedidoProduto }

function TdmdPedidoProduto.Excluir(vidPedido: integer;
  out sErro: string): boolean;
begin
  SqlExcluir.Params[0].AsInteger:= vidPedido;

  try
    SqlExcluir.ExecSQL();
    Result:=true;
  except
    on e:exception do
    begin
      sErro:='Erro ao excluir Itens do Pedido'+sLineBreak+e.Message;
      Result:=false;
    end;
  end;
end;

function TdmdPedidoProduto.Inserir(objPedidoProduto: TPedidoProduto;
  out sErro: string): boolean;
begin
  SqlInserir.Params[0].AsInteger:= objPedidoProduto.fk_num_pedido;
  SqlInserir.Params[1].AsInteger:= objPedidoProduto.fk_cod_produto;
  SqlInserir.Params[2].AsInteger:=objPedidoProduto.quantidade;
  SqlInserir.Params[3].AsFloat:=objPedidoProduto.valor_unitario;
  SqlInserir.Params[4].AsFloat:=objPedidoProduto.valor_total;

  try
    SqlInserir.ExecSQL();
    result:=true;
  except
    on e:exception do
    begin
      sErro:='Erro ao inserir Itens do Pedido'+sLineBreak+e.Message;
      Result:=false;
    end;
  end;
end;

end.
