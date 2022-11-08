unit uiNfeConexaoInternet;

interface

uses
  udNFe;

type
  IConexaoInternet = interface(IInterface)
    ['{E70BA03F-7154-4621-A0D4-B8FE4C858CEC}']
    function GetOnConexaoInternetEvento: TeOnConexaoInternet;
    procedure SetOnConexaoInternetEvento(Value: TeOnConexaoInternet);
    property OnConexaoInternetEvento: TeOnConexaoInternet read GetOnConexaoInternetEvento write SetOnConexaoInternetEvento;
    procedure CheckInternet;
  end;

  IConexaoInternetFactory = interface(IInterface)
    ['{6789D6FC-8DD6-47EB-A05E-B2E04D0C8489}']
    function Construir: IConexaoInternet;
  end;

implementation

end.
