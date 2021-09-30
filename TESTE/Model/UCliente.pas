unit UCliente;

interface

type
  TCliente = class
    private
    Fuf: string;
    Fcodigo: integer;
    Fnome: string;
    Fcidade: string;
     { private declarations }
    public
     { public declarations }
     property codigo: integer read Fcodigo write Fcodigo;
     property nome: string read Fnome write Fnome;
     property cidade: string read Fcidade write Fcidade;
     property uf: string read Fuf write Fuf;
    end;

implementation

end.
