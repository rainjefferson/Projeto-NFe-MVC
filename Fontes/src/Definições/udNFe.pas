unit udNFe;

interface

type
  TeOnConexaoInternet = procedure(const Internet, Proxy: boolean) of object;

  TeOnCarregarCertificado = procedure(const NumeroSerie, Cnpj, RazaoSoc: String; const DataVenc: TDateTime) of object;

implementation

end.
