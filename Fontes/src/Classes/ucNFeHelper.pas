unit ucNFeHelper;

interface

uses
  ucNFeConexaoInternetClass, uiNfeConexaoInternet, uiNFeOperacoes, ucNFeOperacoesClass;

type
  TNFEHelper = class(TObject)
  private
    class var FInternet: IConexaoInternet;
    class var FOperacao: INFeOperacoes;
  protected
    class function GetInternet: IConexaoInternet; static;
    class function GetOperacao: INFeOperacoes; static;
  public
    class property Internet: IConexaoInternet read GetInternet;
    class property Operacao: INFeOperacoes read GetOperacao;
  end;

implementation

{ TNFEHelper }

class function TNFEHelper.GetInternet: IConexaoInternet;
var
  Factory: TNFeConexaoInternetFactory;
begin
  if not Assigned(FInternet) then
  begin
    Factory := TNFeConexaoInternetFactory.Create;
    try
      FInternet := Factory.Construir;
    finally
      Factory.DisposeOf;
    end;
  end;

  result := FInternet;
end;

class function TNFEHelper.GetOperacao: INFeOperacoes;
var
  Factory: TNFeOperacoesFactory;
begin
  if not Assigned(FOperacao) then
  begin
    Factory := TNFeOperacoesFactory.Create;
    try
      FOperacao := Factory.Construir;
    finally
      Factory.DisposeOf;
    end;
  end;

  result := FOperacao;
end;

end.
