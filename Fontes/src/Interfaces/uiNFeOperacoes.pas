unit uiNFeOperacoes;

interface

uses
  Vcl.Controls, udNFe;

type
  INFeOperacoesNotasEnviar = interface;
  INFeOperacoesNotasEnviadas = interface;
  INFeOperacoesNotasCanceladas = interface;
  INFeOperacoesConfiguracao = interface;

  INFeOperacoes = interface(IInterface)
    ['{54DDA445-E5A4-44DE-AB21-C92B0E71674A}']
    function GetNotasEnviar: INFeOperacoesNotasEnviar;
    function GetNotasEnviadas: INFeOperacoesNotasEnviadas;
    function GetNotasCanceladas: INFeOperacoesNotasCanceladas;
    function GetConfiguracao: INFeOperacoesConfiguracao;

    property NotasEnviar: INFeOperacoesNotasEnviar read GetNotasEnviar;
    property NotasEnviadas: INFeOperacoesNotasEnviadas read GetNotasEnviadas;
    property NotasCanceladas: INFeOperacoesNotasCanceladas read GetNotasCanceladas;
    property Configuracao: INFeOperacoesConfiguracao read GetConfiguracao;
  end;

  INFeOperacoesFactory = interface(IInterface)
    ['{AD88C018-DD7E-4312-AF8B-9A84314F5814}']
    function Construir: INFeOperacoes;
  end;

  INFeOperacoesNotasEnviar = interface(IInterface)
    ['{194C7526-5604-4C77-B398-0DC7D70A89D7}']
    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;
  end;

  INFeOperacoesNotasEnviarFactory = interface(IInterface)
    ['{05EE5298-DF75-4220-9354-C292EBAA591A}']
    function Construir: INFeOperacoesNotasEnviar;
  end;

  INFeOperacoesNotasEnviadas = interface(IInterface)
    ['{8AC83085-F686-4B59-AACE-D28880F45372}']
    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;
  end;

  INFeOperacoesNotasEnviadasFactory = interface(IInterface)
    ['{648EDF44-053C-492E-BBB7-6DEDD5278426}']
    function Construir: INFeOperacoesNotasEnviadas;
  end;

  INFeOperacoesNotasCanceladas = interface(IInterface)
    ['{8AC83085-F686-4B59-AACE-D28880F45372}']
    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;
  end;

  INFeOperacoesNotasCanceladasFactory = interface(IInterface)
    ['{648EDF44-053C-492E-BBB7-6DEDD5278426}']
    function Construir: INFeOperacoesNotasCanceladas;
  end;

  INFeOperacoesConfiguracao = interface(IInterface)
    ['{5159FF1C-F9CA-4D8B-BC63-F7F623BFA1B6}']

    function GetOnCarregarCertificadoEvento: TeOnCarregarCertificado;
    procedure SetOnCarregarCertificadoEvento(Value: TeOnCarregarCertificado);

    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;
    procedure CarregarCertificado;

    property OnCarregarCertificadoEvento: TeOnCarregarCertificado read GetOnCarregarCertificadoEvento write SetOnCarregarCertificadoEvento;
  end;

  INFeOperacoesConfiguracaoFactory = interface(IInterface)
    ['{486B6D82-2AFA-4B5F-B72E-4FFA3B4D602E}']
    function Construir: INFeOperacoesConfiguracao;
  end;

implementation

end.
