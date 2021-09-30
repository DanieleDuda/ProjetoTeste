unit UdmdConexao;

interface

uses
  SysUtils, Classes, WideStrings, DBXMySql, DB, SqlExpr;

type
  TdmdConexao = class(TDataModule)
    SqlConexao: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmdConexao: TdmdConexao;

implementation

uses
  Dialogs, Forms;

{$R *.dfm}

procedure TdmdConexao.DataModuleCreate(Sender: TObject);
begin
  SqlConexao.Connected := false;
  SqlConexao.Params.Values['Database']:='';

  try
   with SqlConexao do
   begin
      Connected := false;
      Params.Values['Database'] := 'db_pedido';
      params.Values['HostName'] := 'localhost';
      params.Values['Password']:='masterkey';
      params.Values['User_Name']:='root';
      try
        Connected :=true;
      except
        Params.Values['Password']:='masterkey';
        params.Values['User_Name']:='root';
        params.Values['HostName'] := 'localhost';
        Params.Values['Database']:='db_pedido';
        connected:=true;
      end;
   end;
  except
    on E: Exception do begin
      showmessage('Falha ao conectar ao servidor'#13+E.Message);
      ShowMessage('Por favor, acesse o sistema novamente');
      application.terminate;
      abort;
    end;
  end;
end;

procedure TdmdConexao.DataModuleDestroy(Sender: TObject);
begin
  SqlConexao.CloseDataSets;
  SqlConexao.Connected:=false;
end;

end.
