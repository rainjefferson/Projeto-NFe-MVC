unit ucNFeOperacoesClass;

interface

uses
  Vcl.Controls, Vcl.Forms, System.Classes,
  uiNFeOperacoes, udNFe, uFrNotasEnviar, uFrNotasEnviadas, uFrNotasCanceladas, uFrConfiguracao, udmPrincipal;

type
  TNFeOperacoes = class(TInterfacedObject,
    INFeOperacoes)
  private
    FNotasEnviar: INFeOperacoesNotasEnviar;
    FNotasEnviadas: INFeOperacoesNotasEnviadas;
    FNotasCanceladas: INFeOperacoesNotasCanceladas;
    FConfiguracao: INFeOperacoesConfiguracao;

    function GetNotasEnviar: INFeOperacoesNotasEnviar;
    function GetNotasEnviadas: INFeOperacoesNotasEnviadas;
    function GetNotasCanceladas: INFeOperacoesNotasCanceladas;
    function GetConfiguracao: INFeOperacoesConfiguracao;
  public
    property NotasEnviar: INFeOperacoesNotasEnviar read GetNotasEnviar;
    property NotasEnviadas: INFeOperacoesNotasEnviadas read GetNotasEnviadas;
    property NotasCanceladas: INFeOperacoesNotasCanceladas read GetNotasCanceladas;
    property Configuracao: INFeOperacoesConfiguracao read GetConfiguracao;
  end;

  TNFeOperacoesFactory = class(TInterfacedObject,
    INFeOperacoesFactory)
    function Construir: INFeOperacoes;
  end;

  TNFeOperacoesNotasEnviar = class(TInterfacedObject,
    INFeOperacoesNotasEnviar)
  private
    FFrameNotasEnviar: TFrNotasEnviar;

    procedure EnviarSefaz(Sender: TObject);
  public
    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;

    constructor Create;
    destructor Destroy; override;
  end;

  TNFeOperacoesNotasEnviarFactory = class(TInterfacedObject,
    INFeOperacoesNotasEnviarFactory)
  public
    function Construir: INFeOperacoesNotasEnviar;
  end;

  TNFeOperacoesNotasEnviadas = class(TInterfacedObject,
    INFeOperacoesNotasEnviadas)
  private
    FFrameNotasEnviadas: TFrNotasEnviadas;
  public
    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;

    constructor Create;
    destructor Destroy; override;
  end;

  TNFeOperacoesNotasEnviadasFactory = class(TInterfacedObject,
    INFeOperacoesNotasEnviadasFactory)
  public
    function Construir: INFeOperacoesNotasEnviadas;
  end;

  TNFeOperacoesNotasCanceladas = class(TInterfacedObject,
    INFeOperacoesNotasCanceladas)
  private
    FFrameNotasCanceladas: TFrNotasCanceladas;
  public
    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;

    constructor Create;
    destructor Destroy; override;
  end;

  TNFeOperacoesNotasCanceladasFactory = class(TInterfacedObject,
    INFeOperacoesNotasCanceladasFactory)
  public
    function Construir: INFeOperacoesNotasCanceladas;
  end;

  TNFeOperacoesConfiguracao = class(TInterfacedObject,
    INFeOperacoesConfiguracao)
  private
    FFrameConfiguracao: TFrConfiguracao;
    FOnCarregarCertificadoEvento: TeOnCarregarCertificado;

    function GetOnCarregarCertificadoEvento: TeOnCarregarCertificado;
    procedure SetOnCarregarCertificadoEvento(Value: TeOnCarregarCertificado);
  public
    procedure Exibir(ControlContainer: TWinControl);
    procedure Ocultar;
    procedure CarregarCertificado;

    constructor Create;
    destructor Destroy; override;

    property OnCarregarCertificadoEvento: TeOnCarregarCertificado read GetOnCarregarCertificadoEvento write SetOnCarregarCertificadoEvento;
  end;

  TNFeOperacoesConfiguracaoFactory = class(TInterfacedObject,
    INFeOperacoesConfiguracaoFactory)
  public
    function Construir: INFeOperacoesConfiguracao;
  end;

implementation

uses
  ucSelecionarCertificadoClass, ucProcessosNFeClass;

{ TNFeOperacoes }

function TNFeOperacoes.GetNotasEnviar: INFeOperacoesNotasEnviar;
var
  Factory: TNFeOperacoesNotasEnviarFactory;
begin
  if not Assigned(FNotasEnviar) then
  begin
    Factory := TNFeOperacoesNotasEnviarFactory.Create;
    try
      FNotasEnviar := Factory.Construir;
    finally
      Factory.DisposeOf;
    end;
  end;

  result := FNotasEnviar;
end;

function TNFeOperacoes.GetNotasEnviadas: INFeOperacoesNotasEnviadas;
var
  Factory: TNFeOperacoesNotasEnviadasFactory;
begin
  if not Assigned(FNotasEnviadas) then
  begin
    Factory := TNFeOperacoesNotasEnviadasFactory.Create;
    try
      FNotasEnviadas := Factory.Construir;
    finally
      Factory.DisposeOf;
    end;
  end;

  result := FNotasEnviadas;
end;

function TNFeOperacoes.GetNotasCanceladas: INFeOperacoesNotasCanceladas;
var
  Factory: TNFeOperacoesNotasCanceladasFactory;
begin
  if not Assigned(FNotasCanceladas) then
  begin
    Factory := TNFeOperacoesNotasCanceladasFactory.Create;
    try
      FNotasCanceladas := Factory.Construir;
    finally
      Factory.DisposeOf;
    end;
  end;

  result := FNotasCanceladas;
end;

function TNFeOperacoes.GetConfiguracao: INFeOperacoesConfiguracao;
var
  Factory: TNFeOperacoesConfiguracaoFactory;
begin
  if not Assigned(FConfiguracao) then
  begin
    Factory := TNFeOperacoesConfiguracaoFactory.Create;
    try
      FConfiguracao := Factory.Construir;
    finally
      Factory.DisposeOf;
    end;
  end;

  result := FConfiguracao;
end;

{ TNFeOperacoesNotasEnviar }

constructor TNFeOperacoesNotasEnviar.Create;
begin
  FFrameNotasEnviar := TFrNotasEnviar.Create(Application);
end;

destructor TNFeOperacoesNotasEnviar.Destroy;
begin

  inherited;
end;

procedure TNFeOperacoesNotasEnviar.EnviarSefaz(Sender: TObject);
var
  ProcessosNFe: TProcessosNFe;
begin
  ProcessosNFe := TProcessosNFe.Create;
  try
    /// Seleciona os itens do pedido
    dtmPrincipal.cdsItensPedidos.Close;
    dtmPrincipal.cdsItensPedidos.ParamByName('NUMPED').AsInteger :=
      dtmPrincipal.cdsPedidos.FieldByName('NUMPED').AsInteger;
    dtmPrincipal.cdsItensPedidos.Open;

    ProcessosNFe.EnviarNotaSefaz(Sender, dtmPrincipal.cdsPedidos, dtmPrincipal.cdsItensPedidos);
  finally
    ProcessosNFe.DisposeOf;
  end;
end;

procedure TNFeOperacoesNotasEnviar.Exibir(ControlContainer: TWinControl);
begin
  FFrameNotasEnviar.dsoNotasEnviar.DataSet := dtmPrincipal.cdsPedidos;

  dtmPrincipal.cdsPedidos.Close;
  dtmPrincipal.cdsPedidos.Open;

  FFrameNotasEnviar.btnEnviarSefaz.OnClick := EnviarSefaz;

  FFrameNotasEnviar.Parent := ControlContainer;
  FFrameNotasEnviar.Align := TAlign.alClient;
  FFrameNotasEnviar.Visible := True;
end;

procedure TNFeOperacoesNotasEnviar.Ocultar;
begin
  FFrameNotasEnviar.Visible := False;
end;

{ TNFeOperacoesNotasEnviarFactory }

function TNFeOperacoesNotasEnviarFactory.Construir: INFeOperacoesNotasEnviar;
begin
  result := TNFeOperacoesNotasEnviar.Create;
end;

{ TNFeOperacoesFactory }

function TNFeOperacoesFactory.Construir: INFeOperacoes;
begin
  result := TNFeOperacoes.Create;
end;

{ TNFeOperacoesNotasEnviadas }

constructor TNFeOperacoesNotasEnviadas.Create;
begin
  FFrameNotasEnviadas := TFrNotasEnviadas.Create(Application);
end;

destructor TNFeOperacoesNotasEnviadas.Destroy;
begin

  inherited;
end;

procedure TNFeOperacoesNotasEnviadas.Exibir(ControlContainer: TWinControl);
begin
  FFrameNotasEnviadas.Parent := ControlContainer;
  FFrameNotasEnviadas.Align := TAlign.alClient;
  FFrameNotasEnviadas.Visible := True;
end;

procedure TNFeOperacoesNotasEnviadas.Ocultar;
begin
  FFrameNotasEnviadas.Visible := False;
end;

{ TNFeOperacoesNotasCanceladas }

constructor TNFeOperacoesNotasCanceladas.Create;
begin
  FFrameNotasCanceladas := TFrNotasCanceladas.Create(Application);
end;

destructor TNFeOperacoesNotasCanceladas.Destroy;
begin

  inherited;
end;

procedure TNFeOperacoesNotasCanceladas.Exibir(ControlContainer: TWinControl);
begin
  FFrameNotasCanceladas.Parent := ControlContainer;
  FFrameNotasCanceladas.Align := TAlign.alClient;
  FFrameNotasCanceladas.Visible := True;
end;

procedure TNFeOperacoesNotasCanceladas.Ocultar;
begin
  FFrameNotasCanceladas.Visible := False;
end;

{ TNFeOperacoesNotasEnviadasFactory }

function TNFeOperacoesNotasEnviadasFactory.Construir: INFeOperacoesNotasEnviadas;
begin
  result := TNFeOperacoesNotasEnviadas.Create;
end;

{ TNFeOperacoesNotasCanceladasFactory }

function TNFeOperacoesNotasCanceladasFactory.Construir: INFeOperacoesNotasCanceladas;
begin
  result := TNFeOperacoesNotasCanceladas.Create;
end;

{ TNFeOperacoesConfiguracao }

constructor TNFeOperacoesConfiguracao.Create;
begin
  FFrameConfiguracao := TFrConfiguracao.Create(Application);
end;

destructor TNFeOperacoesConfiguracao.Destroy;
begin

  inherited;
end;

function TNFeOperacoesConfiguracao.GetOnCarregarCertificadoEvento: TeOnCarregarCertificado;
begin
  result := FOnCarregarCertificadoEvento;
end;

procedure TNFeOperacoesConfiguracao.SetOnCarregarCertificadoEvento(Value: TeOnCarregarCertificado);
begin
  FOnCarregarCertificadoEvento := Value;
end;

procedure TNFeOperacoesConfiguracao.Exibir(ControlContainer: TWinControl);
begin
  FFrameConfiguracao.Parent := ControlContainer;
  FFrameConfiguracao.Align := TAlign.alClient;
  FFrameConfiguracao.Visible := True;
end;

procedure TNFeOperacoesConfiguracao.Ocultar;
begin
  FFrameConfiguracao.Visible := False;
end;

procedure TNFeOperacoesConfiguracao.CarregarCertificado;
var
  Certificado: TCertificado;
begin
  Certificado := TCertificado.Create;
  try
    Certificado.OnSelecionarCertificado := OnCarregarCertificadoEvento;
    Certificado.Selecionar;
  finally
    Certificado.DisposeOf;
  end;
end;

{ TNFeOperacoesConfiguracaoFactory }

function TNFeOperacoesConfiguracaoFactory.Construir: INFeOperacoesConfiguracao;
begin
  result := TNFeOperacoesConfiguracao.Create;
end;

end.
