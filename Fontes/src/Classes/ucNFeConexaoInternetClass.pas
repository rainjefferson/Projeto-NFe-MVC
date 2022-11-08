unit ucNFeConexaoInternetClass;

interface

uses
  uiNFeConexaoInternet, udNFe;

type
  TNFeConexaoInternet = class(TInterfacedObject,
    IConexaoInternet)
  private
    FOnConexaoInternetEvento: TeOnConexaoInternet;
  protected
    function GetOnConexaoInternetEvento: TeOnConexaoInternet; virtual;
    procedure SetOnConexaoInternetEvento(Value: TeOnConexaoInternet); virtual;
  public
    procedure CheckInternet;
    property OnConexaoInternetEvento: TeOnConexaoInternet read GetOnConexaoInternetEvento write SetOnConexaoInternetEvento;
  end;

  TNFeConexaoInternetFactory = class(TInterfacedObject,
    IConexaoInternetFactory)
  public
    function Construir: IConexaoInternet;
  end;

implementation

uses
  Winapi.WinInet;

{ TNFeConexaoInternet }

procedure TNFeConexaoInternet.CheckInternet;
var
  InternetConectada,
  InternetComProxy: Boolean;
  Flags : Cardinal;
begin
   InternetComProxy := False;
   InternetConectada := InternetGetConnectedState(@Flags, 0);
   if InternetConectada then
      InternetComProxy :=  (Flags and INTERNET_CONNECTION_PROXY <> 0);

  if Assigned(FOnConexaoInternetEvento) then
    FOnConexaoInternetEvento(InternetConectada, InternetComProxy);
end;

function TNFeConexaoInternet.GetOnConexaoInternetEvento: TeOnConexaoInternet;
begin
  result := FOnConexaoInternetEvento;
end;

procedure TNFeConexaoInternet.SetOnConexaoInternetEvento(Value: TeOnConexaoInternet);
begin
  FOnConexaoInternetEvento := Value;
end;

{ TNFeConexaoInternetFactory }

function TNFeConexaoInternetFactory.Construir: IConexaoInternet;
begin
  result := TNFeConexaoInternet.Create;
end;

end.
