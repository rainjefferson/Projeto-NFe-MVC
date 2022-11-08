unit ucNFePlano;

interface

uses
  uiNfeConexaoInternet, ucNFeConexaoInternetFactory;

type
  TConexaoInternetPlano = (ConexaoInternet);

  TConexaoInternetPlanoHelper = record helper for TConexaoInternetPlano
    function Criar: IConexaoInternet;
  end;

implementation

{ TConexaoInternetPlanoHelper }

function TConexaoInternetPlanoHelper.Criar: IConexaoInternet;
begin
  case Self of
    ConexaoInternet: result := TNFeConexaoInternetFactory.Criar.ConexaoInternet;
  end;
end;
end.
