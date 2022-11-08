unit ucDadosConexaoBase;

interface

uses
  IniFiles, udConsts_Geral;

type
  TDataConnect = class
  private
    FSenha: String;
    FBase: String;
    FUsuario: String;
    FServer: String;
  public
    property Base: String read FBase write FBase;
    property Server: String read FServer write FServer;
    property Usuario: String read FUsuario write FUsuario;
    property Senha: String read FSenha write FSenha;

    procedure CarregarInformacoesArquivoIni(oIni: TIniFile);
  end;

implementation

{ TDataConnect }

procedure TDataConnect.CarregarInformacoesArquivoIni(oIni: TIniFile);
begin
  if (Assigned(oIni)) then
  begin
    Self.FBase := oIni.ReadString(_SECTION_BASE_MS, _ID_SECTION_BASE, '');
    Self.FServer := oIni.ReadString(_SECTION_BASE_MS, _ID_SECTION_SERVER, '');
    Self.FUsuario := oIni.ReadString(_SECTION_BASE_MS, _ID_SECTION_USER, '');
    Self.FSenha := oIni.ReadString(_SECTION_BASE_MS, _ID_SECTION_PASSWORD, '');
  end;
end;

end.
