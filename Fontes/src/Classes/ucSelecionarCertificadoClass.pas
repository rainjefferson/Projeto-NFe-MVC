unit ucSelecionarCertificadoClass;

interface

uses
  System.SysUtils, Vcl.Forms, Winapi.Windows, ACBrNFe, ACBrDFeSSL, udNFe;

type
  TCertificado = class(TObject)
  private
    FAcbrNFE: TACBrNFe;
    FOnSelecionarCertificado: TeOnCarregarCertificado;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Selecionar;

    property OnSelecionarCertificado: TeOnCarregarCertificado read FOnSelecionarCertificado write FOnSelecionarCertificado;
  end;

implementation

{ TCertificado }

constructor TCertificado.Create;
begin
  FAcbrNFE := TACBrNFe.Create(nil);
end;

destructor TCertificado.Destroy;
begin
  FAcbrNFE.DisposeOf;
  inherited;
end;

procedure TCertificado.Selecionar;
var
  NumeroCertificado,
  Cnpj,
  RazaoSocial: String;
  DataVencimento: TDateTime;
begin
  try
    Cnpj := '';
    RazaoSocial := '';
    DataVencimento := 0;

    FAcbrNFE.Configuracoes.Geral.SSLLib := libCapicom;
    NumeroCertificado := FAcbrNFE.SSL.SelecionarCertificado;
    if FAcbrNFE.SSL.CertificadoLido then
    begin
      Cnpj := FAcbrNFE.SSL.CertCNPJ;
      RazaoSocial := FAcbrNFE.SSL.CertRazaoSocial;
      DataVencimento := FAcbrNFE.SSL.CertDataVenc;
    end;

    if Assigned(FOnSelecionarCertificado) then
      FOnSelecionarCertificado(
        NumeroCertificado,
        Cnpj,
        RazaoSocial,
        DataVencimento);
  except
    on E: Exception do
    begin
      if (Pos('CLASSE NÃO REGISTRADA', AnsiUpperCase(E.message)) > 0) then
      begin
        Application.MessageBox(PWideChar('Ocorreu um problema ao listar os certificados!'#13#10#13#10 +
          'Para tentar resolver este problema, instale o "capicom.exe". '#13#10#13#10 +
          'Erro: ' + E.Message), 'Mensagem', MB_OK + MB_ICONWARNING);
      end
      else
      if Pos(AnsiUpperCase('cancelled by the user'), AnsiUpperCase(E.Message)) > 0 then
        Application.MessageBox('Operação cancelada!'#13#10'Nenhum certificado foi selecionado.', 'Mensagem',
          MB_OK + MB_ICONWARNING)

      else
        Application.MessageBox(PWideChar('Ocorreu um problema ao listar os certificados!'#13#10 +
          'Erro: ' + E.Message + #13#10#13#10 +
          ' - Verificar se o certificado é compatível para NF-e.'#13#10 +
          ' - Verificar se o certificado está instalado corretamente.'), 'Mensagem', MB_OK + MB_ICONWARNING);
     end;
  end;
end;

end.
