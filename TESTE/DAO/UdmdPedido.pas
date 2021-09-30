unit UdmdPedido;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, UPedido, DBClient, Provider;

type
  TdmdPedido = class(TDataModule)
    SqlInserir: TSQLQuery;
    SqlExcluir: TSQLQuery;
    SqlPesquisarPedido: TSQLQuery;
    DspPesquisarPedido: TDataSetProvider;
    CdsPesquisarPedido: TClientDataSet;
    CdsPesquisarPedidoid_pedido: TIntegerField;
    CdsPesquisarPedidodata_emissao: TDateField;
    CdsPesquisarPedidovalor_total_pedido: TFMTBCDField;
    CdsPesquisarPedidofk_cod_cliente: TIntegerField;
    CdsPesquisarPedidonome_cliente: TStringField;
  private
    { Private declarations }
    function SelecionarNumPedido:integer;
  public
    { Public declarations }
    function Inserir(objPedido:TPedido; out sErro:string; out num_pedido:integer):boolean;
    function Excluir(vidPedido:integer; out sErro:string):boolean;
    procedure PesquisarPedido(vNumPedido:integer);
    function RetornaPedido(numPedido:integer):TPedido;
  end;

var
  dmdPedido: TdmdPedido;

implementation

uses UdmdConexao;

{$R *.dfm}

{ TdmdPedido }

function TdmdPedido.Excluir(vidPedido: integer; out sErro: string): boolean;
begin
  SqlExcluir.Params[0].AsInteger:= vidPedido;

  try
    SqlExcluir.ExecSQL();
    Result:=true;
  except
    on e:exception do
    begin
      sErro:='Erro ao excluir Pedido'+sLineBreak+e.Message;
      Result:=false;
    end;
  end;
end;

function TdmdPedido.Inserir(objPedido: TPedido; out sErro: string; out num_pedido:integer): boolean;
var vnum_pedido:integer;
begin
  vnum_pedido:= SelecionarNumPedido;
  SqlInserir.Params[0].AsInteger:= vnum_pedido;
  SqlInserir.Params[1].AsDate:= objPedido.data_emissao;
  SqlInserir.Params[2].AsInteger:=objPedido.fk_cod_cliente;
  SqlInserir.Params[3].AsFloat:=objPedido.valor_total;

  try
    SqlInserir.ExecSQL();
    num_pedido:= vnum_pedido;
    result:=true;
  except
    on e:exception do
    begin
      sErro:='Erro ao inserir Pedido'+sLineBreak+e.Message;
      num_pedido:=0;
      Result:=false;
    end;
  end;
end;

procedure TdmdPedido.PesquisarPedido(vNumPedido: integer);
begin
  CdsPesquisarPedido.Close;
  CdsPesquisarPedido.Params[0].AsInteger:=vNumPedido;
  CdsPesquisarPedido.Open;

  CdsPesquisarPedido.First;
end;

function TdmdPedido.RetornaPedido(numPedido:integer): TPedido;
var sql: TSQLQuery;
    obPedido:TPedido;
begin
  sql:=TSQLQuery.Create(nil);
  obPedido:=TPedido.Create;

  try
    sql.Close;
    sql.SQL.Clear;
    sql.SQL.Add('select tp.id_pedido, tp.data_emissao, tp.valor_total_pedido, tp.fk_cod_cliente, ');
    sql.SQL.Add('  (select tc.nome from tb_cliente tc where tc.codigo=tp.fk_cod_cliente) as nome_cliente ');
    sql.SQL.Add(' from tb_pedido tp ');
    sql.SQL.Add(' where tp.id_pedido='+IntToStr(numPedido));
    sql.SQLConnection:=dmdConexao.SqlConexao;
    sql.Open;

    with obPedido do
    begin
      id_pedido:=sql.FieldByName('id_pedido').AsInteger;
      data_emissao:=sql.FieldByName('data_emissao').AsDateTime;
      fk_cod_cliente:=sql.FieldByName('fk_cod_cliente').AsInteger;
      valor_total:=sql.FieldByName('valor_total_pedido').AsFloat;
    end;
    result:= obPedido;
  finally
    FreeAndNil(sql);
  end;

end;

function TdmdPedido.SelecionarNumPedido: integer;
var sql:TSQLQuery;
begin
  sql:=TSQLQuery.Create(nil);
  try
    sql.Close;
    sql.SQL.Clear;
    sql.SQL.Add('select coalesce(max(id_pedido),0) as id from tb_pedido');
    sql.SQLConnection:=dmdConexao.SqlConexao;
    sql.Open;
    result:=sql.FieldByName('id').AsInteger+1;
  finally
    FreeAndNil(sql);
  end;
end;


end.
