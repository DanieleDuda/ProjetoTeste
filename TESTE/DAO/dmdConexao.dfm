object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 337
  Width = 457
  object SqlConexao: TSQLConnection
    ConnectionName = 'MYSQLCONNECTION'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbxmys.dll'
    LoginPrompt = False
    Params.Strings = (
      'drivername=MySQL'
      'connecttimeout=60'
      'Password=masterkey')
    VendorLib = 'libmysql.dll'
    Left = 56
    Top = 40
  end
end
