unit udmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Forms, Winapi.Windows;

type
  TdtmPrincipal = class(TDataModule)
    conPrincipal: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    cdsPedidos: TClientDataSet;
    dspPedidos: TDataSetProvider;
    qryPedidos: TFDQuery;
    cdsItensPedidos: TClientDataSet;
    dspItensPedidos: TDataSetProvider;
    qryItensPedidos: TFDQuery;
    cdsNotas: TClientDataSet;
    dspNotas: TDataSetProvider;
    qryNotas: TFDQuery;
    cdsPedidosNUMPED: TIntegerField;
    cdsPedidosDATA: TDateField;
    cdsPedidosCODCLI: TIntegerField;
    cdsPedidosFANTASIA: TStringField;
    cdsPedidosCLIENTE: TStringField;
    cdsPedidosCGCENT: TStringField;
    cdsPedidosENDERCOM: TStringField;
    cdsPedidosINSCESTADUAL: TStringField;
    cdsPedidosCODUSUR: TIntegerField;
    cdsPedidosDTENTREGA: TDateField;
    cdsPedidosCODFILIAL: TIntegerField;
    cdsPedidosTOTPESO: TFMTBCDField;
    cdsPedidosTOTVOLUME: TFMTBCDField;
    cdsPedidosVALOR_TOTAL_LIQ: TBCDField;
    cdsPedidosHORA: TIntegerField;
    cdsPedidosMINUTO: TIntegerField;
    cdsPedidosNUMSEQENTREGA: TIntegerField;
    cdsPedidosNUMNOTA: TIntegerField;
    cdsPedidosDTFAT: TDateField;
    cdsItensPedidosNUMPED: TIntegerField;
    cdsItensPedidosCODPROD: TIntegerField;
    cdsItensPedidosDESCRICAO: TStringField;
    cdsItensPedidosUNIDADE: TStringField;
    cdsItensPedidosQT: TBCDField;
    cdsItensPedidosPRECO_UNIT: TBCDField;
    cdsItensPedidosALIQICMS1: TBCDField;
    cdsItensPedidosALIQICMS2: TBCDField;
    cdsItensPedidosPERCIPI: TBCDField;
    cdsItensPedidosVLIPI: TBCDField;
    cdsNotasNUMPED: TIntegerField;
    cdsNotasDATA: TDateField;
    cdsNotasCODCLI: TIntegerField;
    cdsNotasFANTASIA: TStringField;
    cdsNotasCLIENTE: TStringField;
    cdsNotasINSCESTADUAL: TStringField;
    cdsNotasDTENTREGA: TDateField;
    cdsNotasVALOR_TOTAL_LIQ: TBCDField;
    cdsNotasNUMNOTA: TIntegerField;
    cdsNotasCHAVE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FDataVencimentoCertificado: TDateTime;
    FNumeroCertificado: String;
    FRazaoSocialCertificado: String;
    FCnpjCertificado: String;

    procedure ConectarBancoDados;
    procedure SetNumeroCertificado(const Value: String);
    procedure SetCnpjCertificado(const Value: String);
  public
    { Public declarations }
    property DataVencimentoCertificado: TDateTime read FDataVencimentoCertificado write FDataVencimentoCertificado;
    property NumeroCertificado: String read FNumeroCertificado write SetNumeroCertificado;
    property CnpjCertificado: String read FCnpjCertificado write SetCnpjCertificado;
    property RazaoSocialCertificado: String read FRazaoSocialCertificado write FRazaoSocialCertificado;
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

uses
  ucDadosConexaoBase, ucDadosConexaoUtil, System.IniFiles, udConsts_Geral, IWSystem;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmPrincipal.ConectarBancoDados;
var
  DadosBase: TDataConnect;
  ini: TIniFile;
  db: TDB;
begin
  if (not FileExists(gsAppPath + _NOME_INI)) then
  begin
     Application.MessageBox(PWideChar('Não é possível conectar a base de dados!' + sLinebreak +
      'Arquivo INI "' + _NOME_INI + '" não encontrado!'), 'Mensagem', MB_OK + MB_ICONWARNING);
      Exit;
  end;

  DadosBase := TDataConnect.Create;
  ini := TIniFile.Create(gsAppPath + _NOME_INI);
  db := TDB.Create;
  try
    DadosBase.CarregarInformacoesArquivoIni(ini);
    try
      db.ConectarBaseDados(DadosBase, conPrincipal);
    except
      on E:Exception do
      begin
        Application.MessageBox(PWideChar('Problemas ao conectar na base de dados!' + sLineBreak + sLineBreak +
          'Verifique o Arquivo INI "' + _NOME_INI + '" as informações:' + sLineBreak + sLineBreak +
          'Base: ' + DadosBase.Base + sLineBreak +
          'Server: ' + DadosBase.Server + sLineBreak +
          'Usuario: ' + DadosBase.Usuario + sLineBreak +
          'Senha: ' + DadosBase.Senha + sLineBreak + sLineBreak +
          'Erro: ' +  E.Message), 'Mensagem', MB_OK + MB_ICONWARNING);
      end;
    end;
  finally
    DadosBase.DisposeOf;
    ini.DisposeOf;
    db.DisposeOf;
  end;
end;

procedure TdtmPrincipal.DataModuleCreate(Sender: TObject);
begin
  ConectarBancoDados;
end;

procedure TdtmPrincipal.SetNumeroCertificado(const Value: String);
var
  ini: TIniFile;
begin
  FNumeroCertificado := Value;
  ini := TIniFile.Create(gsAppPath + _NOME_INI);
  try
     ini.WriteString(_SECTION_NOTA, _ID_SECTION_CERTIFICADO, FNumeroCertificado);
  finally
    ini.DisposeOf;
  end;
end;

procedure TdtmPrincipal.SetCnpjCertificado(const Value: String);
var
  ini: TIniFile;
begin
  FCnpjCertificado := Value;
  ini := TIniFile.Create(gsAppPath + _NOME_INI);
  try
     ini.WriteString(_SECTION_NOTA, _ID_SECTION_CNPJ_CERTIFICADO, FCnpjCertificado);
  finally
    ini.DisposeOf;
  end;
end;

end.
