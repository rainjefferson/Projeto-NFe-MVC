unit ucDadosConexaoUtil;

interface

uses
  FireDAC.Phys.MSSQLDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.ODBCBase, FireDAC.Stan.Param,
  Generics.Collections,
  ucDadosConexaoBase;

type
  TDB = class
  public
    procedure ConectarBaseDados(Base: TDataConnect; Connection: TFDConnection);
  end;

implementation

{ TDB }

procedure TDB.ConectarBaseDados(Base: TDataConnect; Connection: TFDConnection);
begin
  if Assigned(Base) and Assigned(Connection) then
  begin
    Connection.Close;
    Connection.Params.Clear;
    Connection.Params.Add('User_Name=' + Base.Usuario);
    Connection.Params.Add('Database=' + Base.Base);
    Connection.Params.Add('Password=' + Base.Senha);
    Connection.Params.Add('Server=' + Base.Server);
    Connection.Params.Add('DriverID=FB');
    Connection.Open;
  end;
end;

end.
