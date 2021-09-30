unit UfrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, UFormularios;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    btnNovaVenda: TBitBtn;
    procedure btnNovaVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnNovaVendaClick(Sender: TObject);
begin
  TFormularios.AbrirVenda;
end;

end.
