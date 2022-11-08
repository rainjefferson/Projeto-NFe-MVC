unit ucNFeConexaoInternetFactory;

interface

uses
  uiNfeConexaoInternet, ucNFeConexaoInternetClass;

type
  TNFeConexaoInternetFactory = class(TInterfacedObject, IConexaoInternetFactory)
  public
    class function Criar: IConexaoInternetFactory;
    function ConexaoInternet: IConexaoInternet;
  end;

implementation

{ TNFeConexaoInternetFactory }

function TNFeConexaoInternetFactory.ConexaoInternet: IConexaoInternet;
begin
  result := TNFeConexaoInternet.Create;
end;

class function TNFeConexaoInternetFactory.Criar: IConexaoInternetFactory;
begin
  result := Self.Create;
end;

end.
