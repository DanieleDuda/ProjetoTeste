program PTESTE;

uses
  Forms,
  UfrmPrincipal in 'View\UfrmPrincipal.pas' {frmPrincipal},
  UCliente in 'Model\UCliente.pas',
  UProduto in 'Model\UProduto.pas',
  UPedido in 'Model\UPedido.pas',
  UPedidoProduto in 'Model\UPedidoProduto.pas',
  UfrmVenda in 'View\UfrmVenda.pas' {frmVenda},
  UdmdConexao in 'DAO\UdmdConexao.pas' {dmdConexao: TDataModule},
  UdmdPedido in 'DAO\UdmdPedido.pas' {dmdPedido: TDataModule},
  UdmdPedidoProduto in 'DAO\UdmdPedidoProduto.pas' {dmdPedidoProduto: TDataModule},
  UPedidoController in 'Controller\UPedidoController.pas',
  UPedidoProdutoController in 'Controller\UPedidoProdutoController.pas',
  UdmdProduto in 'DAO\UdmdProduto.pas' {dmdProduto: TDataModule},
  UProdutoController in 'Controller\UProdutoController.pas',
  UdmdCliente in 'DAO\UdmdCliente.pas' {dmdCliente: TDataModule},
  UClienteController in 'Controller\UClienteController.pas',
  UFormularios in 'Model\UFormularios.pas',
  UfrmLocalPedido in 'View\localizar\UfrmLocalPedido.pas' {frmLocalPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmdConexao, dmdConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
