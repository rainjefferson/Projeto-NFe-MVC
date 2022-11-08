unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, dxGDIPlusClasses;

type
  TFrmPrincipalNFe = class(TForm)
    MainMenu1: TMainMenu;
    pnlBotoesEsqueda: TPanel;
    pnlProcessos: TPanel;
    Panel3: TPanel;
    btnNotasEnviadas: TSpeedButton;
    btnNotasEnviar: TSpeedButton;
    lblConexaoInternet: TLabel;
    lblProxy: TLabel;
    imgConexaoInternet: TImage;
    btnNotasCanceladas: TSpeedButton;
    imgBolaVermelha: TImage;
    imgBolaVerde: TImage;
    Bevel1: TBevel;
    btnConfig: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNotasEnviarClick(Sender: TObject);
    procedure btnNotasEnviadasClick(Sender: TObject);
    procedure btnNotasCanceladasClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
  private
    { Private declarations }
    procedure VerificarConexaoInternet(const TemConexaoInternet, TemProxy: Boolean);
  public
    { Public declarations }
  end;

var
  FrmPrincipalNFe: TFrmPrincipalNFe;

implementation

uses
  ucNFeHelper;

{$R *.dfm}


{ TFrmPrincipalNFe }

procedure TFrmPrincipalNFe.btnConfigClick(Sender: TObject);
begin
  TNFEHelper.Operacao.NotasEnviar.Ocultar;
  TNFEHelper.Operacao.NotasEnviadas.Ocultar;
  TNFEHelper.Operacao.NotasCanceladas.Ocultar;
  TNFEHelper.Operacao.Configuracao.Exibir(pnlProcessos);
end;

procedure TFrmPrincipalNFe.btnNotasCanceladasClick(Sender: TObject);
begin
  TNFEHelper.Operacao.NotasEnviar.Ocultar;
  TNFEHelper.Operacao.NotasEnviadas.Ocultar;
  TNFEHelper.Operacao.Configuracao.Ocultar;
  TNFEHelper.Operacao.NotasCanceladas.Exibir(pnlProcessos);
end;

procedure TFrmPrincipalNFe.btnNotasEnviadasClick(Sender: TObject);
begin
  TNFEHelper.Operacao.NotasEnviar.Ocultar;
  TNFEHelper.Operacao.NotasCanceladas.Ocultar;
  TNFEHelper.Operacao.Configuracao.Ocultar;
  TNFEHelper.Operacao.NotasEnviadas.Exibir(pnlProcessos);
end;

procedure TFrmPrincipalNFe.btnNotasEnviarClick(Sender: TObject);
begin
  TNFEHelper.Operacao.NotasCanceladas.Ocultar;
  TNFEHelper.Operacao.NotasEnviadas.Ocultar;
  TNFEHelper.Operacao.Configuracao.Ocultar;
  TNFEHelper.Operacao.NotasEnviar.Exibir(pnlProcessos);
end;

procedure TFrmPrincipalNFe.FormCreate(Sender: TObject);
begin
  TNFEHelper.Internet.OnConexaoInternetEvento := VerificarConexaoInternet;
end;

procedure TFrmPrincipalNFe.FormShow(Sender: TObject);
begin
  TNFEHelper.Internet.CheckInternet;
  btnNotasEnviarClick(btnNotasEnviar);
end;

procedure TFrmPrincipalNFe.VerificarConexaoInternet(const TemConexaoInternet, TemProxy: Boolean);
begin
  lblConexaoInternet.Font.Color := clMaroon;
  lblConexaoInternet.Caption := 'Conexão Internet: Não';
  imgConexaoInternet.Picture.Assign(imgBolaVermelha.Picture);
  if TemConexaoInternet then
  begin
    imgConexaoInternet.Picture.Assign(imgBolaVerde.Picture);
    lblConexaoInternet.Font.Color := clGreen;
    lblConexaoInternet.Caption := 'Conexão Internet: Sim';
    lblProxy.Visible := TemProxy;
  end;
end;

end.
