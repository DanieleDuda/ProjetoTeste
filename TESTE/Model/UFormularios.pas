unit UFormularios;

interface

uses Forms;

type
  TFormularios = class
    public
      class procedure AbrirVenda;
  end;
implementation

uses
  UfrmVenda;

{ TFormularios }

class procedure TFormularios.AbrirVenda;
begin
  frmVenda:=TfrmVenda.Create(Application);
  try
    frmVenda.ShowModal;
  finally
    frmVenda.Free;
  end;
end;

end.
