program NFe;

uses
  Vcl.Forms,
  ucNFeHelper in 'src\Classes\ucNFeHelper.pas',
  uFrmPrincipal in 'src\uFrmPrincipal.pas' {FrmPrincipalNFe},
  ucNFeConexaoInternetClass in 'src\Classes\ucNFeConexaoInternetClass.pas',
  uiNfeConexaoInternet in 'src\Interfaces\uiNfeConexaoInternet.pas',
  udNFe in 'src\Definições\udNFe.pas',
  uFrNotasEnviar in 'src\uFrNotasEnviar.pas' {FrNotasEnviar: TFrame},
  uiNFeOperacoes in 'src\Interfaces\uiNFeOperacoes.pas',
  ucNFeOperacoesClass in 'src\Classes\ucNFeOperacoesClass.pas',
  uFrNotasEnviadas in 'src\uFrNotasEnviadas.pas' {FrNotasEnviadas},
  uFrNotasCanceladas in 'src\uFrNotasCanceladas.pas' {FrNotasCanceladas: TFrame},
  uFrConfiguracao in 'src\uFrConfiguracao.pas' {FrConfiguracao: TFrame},
  udmPrincipal in 'src\udmPrincipal.pas' {dtmPrincipal: TDataModule},
  ucSelecionarCertificadoClass in 'src\Classes\ucSelecionarCertificadoClass.pas',
  ucDadosConexaoBase in 'src\Classes\ucDadosConexaoBase.pas',
  udConsts_Geral in 'src\Definições\udConsts_Geral.pas',
  ucDadosConexaoUtil in 'src\Classes\ucDadosConexaoUtil.pas',
  ucProcessosNFeClass in 'src\Classes\ucProcessosNFeClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipalNFe, FrmPrincipalNFe);
  Application.CreateForm(TdtmPrincipal, dtmPrincipal);
  Application.Run;
end.
