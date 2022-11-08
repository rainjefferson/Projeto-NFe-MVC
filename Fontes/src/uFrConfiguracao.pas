unit uFrConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TFrConfiguracao = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    btnConfirmar: TButton;
    Label25: TLabel;
    edtNumSerie: TEdit;
    lblDataValidadeCertificado: TLabel;
    btnProcurarCertificado: TSpeedButton;
    lblCnpj: TLabel;
    lblRazaoSoc: TLabel;
    procedure btnProcurarCertificadoClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarCertificado(const NumeroSerie, Cnpj, RazaoSocial: String; const DataVencimento: TDateTime);
    procedure AtualizarInformacoesCertificado;
    procedure LimparCampos;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  ucNFeHelper, udmPrincipal;

{$R *.dfm}

{ TFrConfiguracao }

function RemoveMascaraStr(const sStrTexto: String): String;
begin
   Result := Trim(sStrTexto);
   Result := StringReplace(Result, '.', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '-', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '/', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '(', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, ')', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '_', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, ',', '', [rfReplaceAll, rfIgnoreCase]);
end;

function MascaraCNPFCPF(const NrDoc: String): String;
var
  sNrDocAux: String;
begin
  sNrDocAux := RemoveMascaraStr(NrDoc);
  if (Length(NrDoc) = 14) then
    Result := Copy(sNrDocAux, 0, 2) + '.' +
      Copy(sNrDocAux, 3, 3) + '.' +
      Copy(sNrDocAux, 6, 3) + '/' +
      Copy(sNrDocAux, 9, 4) + '-' +
      Copy(sNrDocAux, 13, 2)
  else
    Result := Copy(sNrDocAux, 0, 3) + '.' +
      Copy(sNrDocAux, 4, 3) + '.' +
      Copy(sNrDocAux, 7, 3) + '-' +
      Copy(sNrDocAux, 10, 2);
end;

procedure TFrConfiguracao.AtualizarInformacoesCertificado;
begin
  LimparCampos;

  if Trim(dtmPrincipal.NumeroCertificado) = '' then
    Exit;

  edtNumSerie.Text := dtmPrincipal.NumeroCertificado;
  lblDataValidadeCertificado.Caption := 'Válido até: ' +
    FormatDateTime('dd/mm/yyyy', dtmPrincipal.DataVencimentoCertificado);
  lblCnpj.Caption := MascaraCNPFCPF(dtmPrincipal.CnpjCertificado);
  lblRazaoSoc.Caption := dtmPrincipal.RazaoSocialCertificado;
end;

procedure TFrConfiguracao.LimparCampos;
begin
  edtNumSerie.Text := '';
  lblDataValidadeCertificado.Caption := '';
  lblCnpj.Caption := '';
  lblRazaoSoc.Caption := '';
end;

procedure TFrConfiguracao.btnProcurarCertificadoClick(Sender: TObject);
begin
  TNFEHelper.Operacao.Configuracao.OnCarregarCertificadoEvento := CarregarCertificado;
  TNFEHelper.Operacao.Configuracao.CarregarCertificado;
end;

procedure TFrConfiguracao.CarregarCertificado(const NumeroSerie, Cnpj, RazaoSocial: String;
  const DataVencimento: TDateTime);
begin
  dtmPrincipal.NumeroCertificado := NumeroSerie;
  dtmPrincipal.DataVencimentoCertificado := DataVencimento;
  dtmPrincipal.CnpjCertificado := Cnpj;
  dtmPrincipal.RazaoSocialCertificado := RazaoSocial;

  AtualizarInformacoesCertificado;
end;

constructor TFrConfiguracao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AtualizarInformacoesCertificado;
end;

end.
