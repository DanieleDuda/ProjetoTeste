unit UfrmVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB, DBClient,
  UPedidoProduto, UPedido, UCliente, UClienteController, UProduto,
  UProdutoController, UfrmLocalPedido, UdmdPedido;

type
  TOperacao =(opNovo, opLocalizar, opSalvar, opCancelar);
  TfrmVenda = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    btnLocalizar: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    edtCodCliente: TEdit;
    Label2: TLabel;
    edtCodProduto: TEdit;
    edtDescProduto: TEdit;
    edtNomeCliente: TEdit;
    edtQuantidade: TEdit;
    Label3: TLabel;
    edtValor: TEdit;
    Label4: TLabel;
    btnAdd: TBitBtn;
    btnRemove: TBitBtn;
    DBGrid1: TDBGrid;
    lblTotal: TLabel;
    Label5: TLabel;
    btnGravarPedido: TBitBtn;
    DsItens: TDataSource;
    CdsItens: TClientDataSet;
    CdsItensid: TIntegerField;
    CdsItenscodigo_produto: TIntegerField;
    CdsItensdescricao_produto: TStringField;
    CdsItensquantidade: TIntegerField;
    CdsItensvalor_unitario: TFloatField;
    CdsItensvalor_total: TFloatField;
    CdsItensvalor_final: TAggregateField;
    CdsItenstipo_alteracao: TStringField;
    btnCancelar: TBitBtn;
    labelPedido: TLabel;
    lblPedido: TLabel;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FOperacao: TOperacao;
  public
    { Public declarations }
    procedure LimpaVarProduto;
    procedure LimpaTela;
    procedure HabilitaControle(vOperacao:TOperacao);
    procedure GravarPedido;
    procedure Novo;
    procedure ConsultaCliente;
    procedure ConsultaProduto;
    procedure RemoverItem;
    procedure CarregaProduto;
    procedure CancelarPedido;
    procedure GravaPedidoPrincipal(out sErro:string; out numPedido:integer);
    procedure GravaItensPedido(num_pedido:integer; out sErro:string);
    procedure ConsultarPedido;
    procedure CarregarItens(numPedido:integer);
  end;

var
  frmVenda: TfrmVenda;

implementation

uses
  UPedidoProdutoController, UPedidoController, SqlExpr, UdmdConexao,
  UdmdPedidoProduto;

{$R *.dfm}

procedure TfrmVenda.btnAddClick(Sender: TObject);
var f:double;
begin
  if (trim(edtCodProduto.Text)='') then
  begin
    Application.MessageBox('Selecionar um produto para inserir','Atenção',MB_OK+MB_ICONEXCLAMATION);
    edtCodProduto.SetFocus;
    Abort;
  end;

  if (trim(edtQuantidade.Text)='') then
  begin
    Application.MessageBox('Adicionar a quantidade','Atenção',MB_OK+MB_ICONEXCLAMATION);
    edtQuantidade.SetFocus;
    Abort;
  end;
  if (trim(edtQuantidade.Text)='0') then
  begin
    Application.MessageBox('A quantidade deve ser maior que 0','Atenção',MB_OK+MB_ICONEXCLAMATION);
    edtQuantidade.SetFocus;
    Abort;
  end;

  if (trim(edtValor.Text)='') then
  begin
    Application.MessageBox('Inserir o valor do produto','Atenção',MB_OK+MB_ICONEXCLAMATION);
    edtValor.SetFocus;
    Abort;
  end;
  if (TryStrToFloat(edtValor.Text,f)=false) then
  begin
    Application.MessageBox('Inserir o valor válido para o produto','Atenção',MB_OK+MB_ICONEXCLAMATION);
    edtValor.SetFocus;
    Abort;
  end;

  try
    CdsItens.Append;
    CdsItensid.AsInteger:= CdsItensid.AsInteger+1;
    CdsItenscodigo_produto.AsString:=edtCodProduto.Text;
    CdsItensdescricao_produto.AsString:=edtDescProduto.Text;
    CdsItensquantidade.AsString:=edtQuantidade.Text;
    CdsItensvalor_unitario.AsString:=edtValor.Text;
    CdsItensvalor_total.AsFloat:=CdsItensquantidade.AsFloat*CdsItensvalor_unitario.AsFloat;
    CdsItens.Post;
  finally
    lblTotal.Caption:=formatfloat('#,###,##0.00',strtofloat(CdsItensvalor_final.AsString));
    LimpaVarProduto;
    edtCodProduto.SetFocus;
  end;
end;

procedure TfrmVenda.btnCancelarClick(Sender: TObject);
begin
  FOperacao:=opCancelar;
  HabilitaControle(FOperacao);
end;

procedure TfrmVenda.btnGravarPedidoClick(Sender: TObject);
begin
  if (trim(edtCodCliente.Text)='') then
  begin
    Application.MessageBox('Selecionar um cliente para salvar a venda','Atenção',MB_OK+MB_ICONEXCLAMATION);
    edtCodCliente.SetFocus;
    Abort;
  end;

  FOperacao:=opSalvar;
  HabilitaControle(FOperacao);
end;

procedure TfrmVenda.btnLocalizarClick(Sender: TObject);
begin
  FOperacao:= opLocalizar;
  HabilitaControle(FOperacao);
end;

procedure TfrmVenda.btnRemoveClick(Sender: TObject);
begin
  RemoverItem;
end;

procedure TfrmVenda.CancelarPedido;
var objPedidoProdutoController:TPedidoProdutoController;
    objPedidoController: TPedidoController;
    sErro:string;
begin
  if (Application.MessageBox('Deseja Cancelar Pedido?','Atenção',MB_YESNO+MB_ICONQUESTION)=IDYES) then
  begin
    try
      if (objPedidoProdutoController.Excluir(strtoint(lblPedido.Caption),sErro)=false) then
        raise Exception.Create(sErro)
      else
      begin
        try
          if (objPedidoController.Excluir(StrToInt(lblPedido.Caption),sErro)=false) then
            raise Exception.Create(sErro);
        finally
        end;
      end;
    finally
    end;
  end;
end;

procedure TfrmVenda.CarregaProduto;
begin
  edtCodProduto.Text:=CdsItenscodigo_produto.AsString;
  edtDescProduto.Text:=CdsItensdescricao_produto.AsString;
  edtQuantidade.Text:=CdsItensquantidade.AsString;
  edtValor.Text:=CdsItensvalor_unitario.AsString;

  CdsItens.Delete;
  edtQuantidade.SetFocus;

  edtCodProduto.Enabled:=false;
  edtDescProduto.Enabled:=false;
end;

procedure TfrmVenda.CarregarItens(numPedido: integer);
var sql: TSQLQuery;
begin
  CdsItens.Close;
  CdsItens.Open;
  CdsItens.EmptyDataSet;

  sql:=TSQLQuery.Create(nil);

  try
    sql.Close;
    sql.SQL.Clear;
    sql.SQL.Add('select ');
    sql.SQL.Add('  tpp.id_produto_pedido, tpp.fk_num_pedido, tpp.fk_cod_produto, ');
    sql.SQL.Add('  (select tpr.descricao from tb_produto tpr where tpr.codigo_produto = tpp.fk_cod_produto) as descricao_prod, ');
    sql.SQL.Add('  tpp.quantidade, ');
    sql.SQL.Add('  tpp.valor_unitario, tpp.valor_total ');
    sql.SQL.Add(' from tb_produto_pedido tpp');
    sql.SQL.Add(' where tpp.fk_num_pedido='+IntToStr(numPedido));
    sql.SQLConnection:=dmdConexao.SqlConexao;
    sql.Open;

    sql.First;
    while not sql.Eof do
    begin
      CdsItens.Append;
      CdsItensid.AsInteger:= sql.FieldByName('id_produto_pedido').AsInteger;
      CdsItenscodigo_produto.AsInteger:=sql.FieldByName('fk_cod_produto').AsInteger;
      CdsItensdescricao_produto.AsString:=sql.FieldByName('descricao_prod').AsString;
      CdsItensquantidade.AsInteger:=sql.FieldByName('quantidade').AsInteger;
      CdsItensvalor_unitario.AsFloat:=sql.FieldByName('valor_unitario').AsFloat;
      CdsItensvalor_total.AsFloat:=sql.FieldByName('valor_total').AsFloat;
      CdsItens.Post;

      sql.Next;
    end;
  finally
    FreeAndNil(sql);
  end;
end;

procedure TfrmVenda.ConsultaCliente;
var obCliente:TCliente;
    obClienteController: TClienteController;
begin
  obClienteController:=TClienteController.Create;
  obCliente:=TCliente.Create;

  try
    obCliente:=obClienteController.RetornaCliente(strtoint(edtCodCliente.Text));
    edtNomeCliente.Text:=  obCliente.nome;
  finally
    FreeAndNil(obCliente);
    FreeAndNil(obClienteController);
  end;
end;

procedure TfrmVenda.ConsultaProduto;
var obProduto: TProduto;
    obProdutoController: TProdutoController;
begin
  if (trim(edtCodProduto.Text)<>'') then
  begin
    obProdutoController:=TProdutoController.Create;
    obProduto:=TProduto.Create;

    try
      obProduto:=obProdutoController.RetornaProduto(strtoint(edtCodProduto.Text));
      edtDescProduto.Text:=obProduto.descricao;
      edtValor.Text:=floattostr(obProduto.preco_venda);
    finally
      FreeAndNil(obProduto);
      FreeAndNil(obProdutoController);
    end;
  end

end;

procedure TfrmVenda.ConsultarPedido;
var obPedido:TPedido;
begin
  frmLocalPedido:=TfrmLocalPedido.Create(Application);
  frmLocalPedido.ShowModal;

  with frmLocalPedido do
  begin
    obPedido:=TPedido.Create;

    try
      obPedido:=frmLocalPedido.RetornaPedido;

      if (obPedido.id_pedido<>0) then
      begin
        labelPedido.Visible:=true;
        lblPedido.Caption:= inttostr(obPedido.id_pedido);
        edtCodCliente.Text:=inttostr(obPedido.fk_cod_cliente);
        edtCodClienteExit(Self);
        lblTotal.Caption:=FormatFloat('#,##.00',obPedido.valor_total);
        CarregarItens(obPedido.id_pedido);
      end else
      begin
        btnCancelar.Visible:=false;
        lblPedido.Caption:='';
        labelPedido.Visible:=false;
      end;
    finally
      FreeAndNil(obPedido);
    end;
  end;

  FreeAndNil(frmLocalPedido);
end;

procedure TfrmVenda.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then //deletar
    RemoverItem;
end;

procedure TfrmVenda.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then
    CarregaProduto;
end;

procedure TfrmVenda.edtCodClienteExit(Sender: TObject);
begin
  if (trim(edtCodCliente.Text)='') then
    btnLocalizar.Visible:=true
  else
  begin
    btnLocalizar.Visible:=false;

    ConsultaCliente;
  end;
end;

procedure TfrmVenda.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then
    edtCodProduto.SetFocus;
end;

procedure TfrmVenda.edtCodProdutoExit(Sender: TObject);
begin
  ConsultaProduto;
end;

procedure TfrmVenda.edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then
    edtQuantidade.SetFocus;
end;

procedure TfrmVenda.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then
    edtValor.SetFocus;
end;

procedure TfrmVenda.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', '.', ',', #13, #08, #83, #27]) then
    Abort;

  if (key=#13) then
    btnAdd.SetFocus;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
begin
  dmdPedido:=TdmdPedido.Create(Application);

  dmdPedidoProduto:=TdmdPedidoProduto.Create(Application);
end;

procedure TfrmVenda.FormDestroy(Sender: TObject);
begin
  dmdPedido.Destroy;
  dmdPedido:=nil;

  dmdPedidoProduto.Destroy;
  dmdPedidoProduto:=nil;
end;

procedure TfrmVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#9) then
    DBGrid1.SetFocus;
end;

procedure TfrmVenda.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=39) or (key=40) then
    DBGrid1.SetFocus;

  if (key=9) then
    edtCodProduto.SetFocus;
end;

procedure TfrmVenda.FormShow(Sender: TObject);
begin
  FOperacao:=opNovo;
  HabilitaControle(FOperacao);
end;

procedure TfrmVenda.GravaItensPedido(num_pedido:integer; out sErro:string);
var obPedidoProduto: TPedidoProduto;
    obPedidoProdutoController: TPedidoProdutoController;
begin
  CdsItens.First;
  while not CdsItens.Eof do
  begin
    obPedidoProduto:=TPedidoProduto.Create;
    obPedidoProdutoController:=TPedidoProdutoController.Create;

    try
      obPedidoProduto.fk_num_pedido:=num_pedido;
      obPedidoProduto.fk_cod_produto:=CdsItenscodigo_produto.AsInteger;
      obPedidoProduto.quantidade:=CdsItensquantidade.AsInteger;
      obPedidoProduto.valor_unitario:=CdsItensvalor_unitario.AsFloat;
      obPedidoProduto.valor_total:=CdsItensvalor_total.AsFloat;

      if (obPedidoProdutoController.Inserir(obPedidoProduto,sErro)=false) then
        raise Exception.Create(sErro);
    finally
      FreeAndNil(obPedidoProduto);
      FreeAndNil(obPedidoProdutoController);
    end;

    CdsItens.Next;
  end;
end;
procedure TfrmVenda.GravaPedidoPrincipal(out sErro: string; out numPedido:integer);
var obPedido:TPedido;
    obPedidoController: TPedidoController;
begin
  obPedido:=TPedido.Create;
  obPedidoController:=TPedidoController.Create;

  try
    obPedido.data_emissao:=Date;
    obPedido.fk_cod_cliente:=strtoint(edtCodCliente.Text);
    obPedido.valor_total:=StrToFloat(lblTotal.Caption);

    if (obPedidoController.Inserir(obPedido,sErro, numPedido)=false) then
      raise Exception.Create(sErro);
  finally
    FreeAndNil(obPedido);
    FreeAndNil(obPedidoController);
  end;
end;

procedure TfrmVenda.GravarPedido;
var num_pedido:integer;
    sErro:string;
begin
  //grava primeiro na tabela pedido
  GravaPedidoPrincipal(sErro, num_pedido);

  //depois grava os produtos do pedido
  if (num_pedido<>0) then
  begin
    //GravaItens
    try
      GravaItensPedido(num_pedido, sErro);
    except
      raise Exception.Create(sErro);
    end;
  end else
    Application.MessageBox('Erro ao Gravar Pedido','Erro',MB_OK+MB_ICONERROR);

end;

procedure TfrmVenda.HabilitaControle(vOperacao: TOperacao);
begin
  btnCancelar.Enabled:=false;
  btnCancelar.Visible:=false;

  case vOperacao of
    opNovo:
      begin
        LimpaTela;
        edtCodCliente.SetFocus;
      end;
    opLocalizar:
      begin
        btnCancelar.Enabled:=true;
        btnCancelar.Visible:=true;
        ConsultarPedido;
      end;
    opSalvar:
      begin
        GravarPedido;
        FOperacao:=opNovo;
        LimpaTela;
        edtCodCliente.SetFocus;
      end;
    opCancelar:
      begin
        CancelarPedido;
        FOperacao:=opNovo;
        LimpaTela;
        edtCodCliente.SetFocus;
      end;
  end;
end;

procedure TfrmVenda.LimpaTela;
begin
  LimpaVarProduto;
  edtCodCliente.Clear;
  edtNomeCliente.Clear;

  lblTotal.Caption:='0,00';

  labelPedido.Visible:=false;
  lblPedido.Caption:='';

  CdsItens.Close;
  CdsItens.Open;
  CdsItens.EmptyDataSet;

  btnLocalizar.Visible:=true;
end;

procedure TfrmVenda.LimpaVarProduto;
begin
  edtCodProduto.Clear;
  edtDescProduto.Clear;
  edtQuantidade.Clear;
  edtValor.Clear;

  edtCodProduto.Enabled:=true;
end;

procedure TfrmVenda.Novo;
begin
  FOperacao:=opNovo;
  HabilitaControle(FOperacao);
end;

procedure TfrmVenda.RemoverItem;
begin
  if (FOperacao=opNovo) then
  begin
    if (Application.MessageBox('Deseja remover item?','Atenção',MB_YESNO+MB_ICONQUESTION)=IDYES) then
    begin
      CdsItens.Delete;
      lblTotal.Caption:=formatfloat('#,###,##0.00',strtofloat(CdsItensvalor_final.AsString));
    end;
  end;
end;

end.
