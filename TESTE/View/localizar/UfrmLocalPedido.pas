unit UfrmLocalPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, UdmdPedido, DB,
  UPedido;

type
  TfrmLocalPedido = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    btnSair: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    btnBuscar: TBitBtn;
    edtPedido: TEdit;
    DBGrid1: TDBGrid;
    DsPesquisarPedido: TDataSource;
    procedure btnBuscarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure Pesquisar;
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
    function RetornaPedido: TPedido;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocalPedido: TfrmLocalPedido;

implementation

uses
  UPedidoController;

{$R *.dfm}

procedure TfrmLocalPedido.btnBuscarClick(Sender: TObject);
begin
  if (trim(edtPedido.Text)='') then
  begin
    Application.MessageBox('Digitar um pedido para consulta','Atenção',MB_OK+MB_ICONEXCLAMATION);
    edtpedido.SetFocus;
    Abort;
  end;

  Pesquisar;
end;

procedure TfrmLocalPedido.Pesquisar;
var objPedidoController: TPedidoController;
begin
  objPedidoController:=TPedidoController.Create;

  try
    objPedidoController.Pesquisar(strtoint(edtPedido.Text));
    DsPesquisarPedido.DataSet:=dmdPedido.CdsPesquisarPedido;
  finally
    FreeAndNil(objPedidoController);
  end;
end;

procedure TfrmLocalPedido.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLocalPedido.DBGrid1DblClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLocalPedido.edtPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then
    btnBuscar.SetFocus;
end;

procedure TfrmLocalPedido.FormDestroy(Sender: TObject);
begin
  if (dmdPedido.CdsPesquisarPedido.Active) then
    dmdPedido.CdsPesquisarPedido.Close;

end;

procedure TfrmLocalPedido.FormShow(Sender: TObject);
begin
  edtPedido.SetFocus;
end;

function TfrmLocalPedido.RetornaPedido: TPedido;
var obPedidoController:TPedidoController;
begin
  obPedidoController:=TPedidoController.Create;

  try
    result:= obPedidoController.RetornaPedido(DsPesquisarPedido.DataSet.FieldByName('id_pedido').AsInteger);
  finally
    FreeAndNil(obPedidoController);
  end;
end;

end.
