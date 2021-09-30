unit UdmdCliente;

interface

uses
  SysUtils, Classes, UCliente, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TdmdCliente = class(TDataModule)
    SqlCliente: TSQLQuery;
    DspCliente: TDataSetProvider;
    CdsCliente: TClientDataSet;
    CdsClientenome: TStringField;
    CdsClientecodigo: TIntegerField;
    CdsClientecidade: TStringField;
    CdsClienteuf: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function RetornaCliente(vCodPac:integer):TCliente;
  end;

var
  dmdCliente: TdmdCliente;

implementation

{$R *.dfm}

{ TdmdCliente }

function TdmdCliente.RetornaCliente(vCodPac: integer): TCliente;
var obCliente:TCliente;
begin
  if (CdsCliente.Active) then
    CdsCliente.Close;

  CdsCliente.Params[0].AsInteger:=vCodPac;
  CdsCliente.Open;

  obCliente:=TCliente.Create;
  with obCliente do
  begin
    codigo:=CdsClientecodigo.AsInteger;
    nome:=CdsClientenome.AsString;
    cidade:=CdsClientecidade.AsString;
    uf:=CdsClienteuf.AsString;
  end;

  result:=obCliente;
  CdsCliente.Close;
end;

end.
