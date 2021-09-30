unit UClienteController;

interface

uses UCliente, UdmdCliente;

type
  TClienteController = class
    constructor Create;
    destructor Destroy; override;
    function RetornaCliente(vCodCliente:integer):TCliente;
  end;

implementation

uses
  Forms;

{ TClienteController }

constructor TClienteController.Create;
begin
  dmdCliente:=TdmdCliente.Create(application);
end;

destructor TClienteController.Destroy;
begin
  dmdCliente.Destroy;
  dmdCliente:=nil;
  inherited;
end;

function TClienteController.RetornaCliente(vCodCliente: integer): TCliente;
begin
  result:=dmdCliente.RetornaCliente(vCodCliente);
end;

end.
