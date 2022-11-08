unit ucProcessosNFeClass;

interface

uses
  Datasnap.Provider, Datasnap.DBClient, Vcl.StdCtrls, ACBrNFe, ACBrNFeDANFEFRDM, ACBrNFeDANFEFR, ACBrDFeSSL;

type
  TProcessosNFe = class(TObject)
  private
    FAcbrNFe: TACBrNFe;
    FAcbrDanfe: TACBrNFeDANFEFR;
    FNumeroNFe: Integer;
    FAmbienteProducao: Boolean;
    FNumeroCertificado: String;
    FCNPJCertificadoEmitente: String;
    FDataSet: TClientDataSet;
    FDataSetItens: TClientDataSet;

    procedure GerarNFe;
    procedure GravarDadosNotaFiscal;
    procedure LerDadosArquivoIni;
    procedure CarregarConfiguracoes;
  public
    function EnviarNotaSefaz(Sender: TObject; DataSet, DataSetItens: TClientDataSet): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  pcnConversao, pcnConversaoNFe, pcnNFe, udConsts_Geral, IWSystem, System.IniFiles, Vcl.Forms,
  Winapi.Windows, ACBrNFeNotasFiscais, System.SysUtils;

{ TProcessosNFe }

procedure TProcessosNFe.GerarNFe;
Var
  NotaF: NotaFiscal;
  Produto: TDetCollectionItem;
  Volume: TVolCollectionItem;
  Duplicata: TDupCollectionItem;
  ObsComplementar: TobsContCollectionItem;
  ObsFisco: TobsFiscoCollectionItem;
  Adicao: TAdiCollectionItem;
  Reboque: TreboqueCollectionItem;
  Lacre: TLacresCollectionItem;
  ProcReferenciado: TprocRefCollectionItem;
  Pagamento: TpagCollectionItem;
  SeqItem: Integer;
begin
  NotaF := FAcbrNFe.NotasFiscais.Add;

  //NotaF.NFe.Ide.cNF       := 0; Preendhido automaticamente
  NotaF.NFe.Ide.natOp     := 'VENDA ESTAB.';
  NotaF.NFe.Ide.indPag    := ipVista;
  NotaF.NFe.Ide.modelo    := 55;
  NotaF.NFe.Ide.serie     := 1;
  NotaF.NFe.Ide.nNF       := FNumeroNFe;
  NotaF.NFe.Ide.dEmi      := FDataSet.FieldByName('DATA').AsDateTime;
  NotaF.NFe.Ide.dSaiEnt   := Date;
  NotaF.NFe.Ide.hSaiEnt   := Now;
  NotaF.NFe.Ide.tpNF      := tnSaida;
  NotaF.NFe.Ide.tpEmis    := teNormal;//TpcnTipoEmissao(cbFormaEmissao.ItemIndex); /// teNormal, teContingencia, teSCAN, teDPEC, teFSDA, teSVCAN, teSVCRS, teSVCSP, teOffLine

  if FAmbienteProducao then
    NotaF.NFe.Ide.tpAmb := taProducao
  else
    NotaF.NFe.Ide.tpAmb := taHomologacao;

  NotaF.NFe.Ide.verProc   := '1.0.0.0'; //Versão do seu sistema
  NotaF.NFe.Ide.cUF       := UFtoCUF('PR');
  NotaF.NFe.Ide.cMunFG    := 4106902; // Código ibge da cidade
  NotaF.NFe.Ide.finNFe    := fnNormal;

  if Assigned(FAcbrNFe.DANFE) then
    NotaF.NFe.Ide.tpImp := FAcbrNFe.DANFE.TipoDANFE;

  /// Dados do emitente ///
  NotaF.NFe.Emit.CNPJCPF := FCNPJCertificadoEmitente; /// Cnpj da empresa emitente
  NotaF.NFe.Emit.IE := '2860427241'; /// IE da empresa emitente
  NotaF.NFe.Emit.xNome := 'Nome da empresa emitente'; /// Razão da empresa emitente
  NotaF.NFe.Emit.xFant := 'Fantasia da empresa emitente';  /// Fantasia da empresa emitente

  NotaF.NFe.Emit.EnderEmit.fone    := ''; /// Telefone da empresa emitente
  NotaF.NFe.Emit.EnderEmit.CEP     := 81850050;
  NotaF.NFe.Emit.EnderEmit.xLgr    := 'Logradouro do emitente';
  NotaF.NFe.Emit.EnderEmit.nro     := 'Nr endereco';
  NotaF.NFe.Emit.EnderEmit.xCpl    := '';
  NotaF.NFe.Emit.EnderEmit.xBairro := 'Bairro do emitente';
  NotaF.NFe.Emit.EnderEmit.cMun    := 4106902;
  NotaF.NFe.Emit.EnderEmit.xMun    := 'Cidade do emitente';
  NotaF.NFe.Emit.EnderEmit.UF      := 'PR';
  NotaF.NFe.Emit.enderEmit.cPais   := 1058;
  NotaF.NFe.Emit.enderEmit.xPais   := 'BRASIL';

  NotaF.NFe.Emit.IEST := '';
  NotaF.NFe.Emit.CRT := crtRegimeNormal;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)

  /// Dados do destinatário ///
  NotaF.NFe.Dest.CNPJCPF           := FDataSet.FieldByName('CGCENT').AsString;
  NotaF.NFe.Dest.IE                := FDataSet.FieldByName('INSCESTADUAL').AsString;
  NotaF.NFe.Dest.ISUF              := '';
  NotaF.NFe.Dest.xNome             := FDataSet.FieldByName('CLIENTE').AsString;

  NotaF.NFe.Dest.EnderDest.Fone    := '1133999999';
  NotaF.NFe.Dest.EnderDest.CEP     := 18270170;
  NotaF.NFe.Dest.EnderDest.xLgr    := 'Rua do destinatario';
  NotaF.NFe.Dest.EnderDest.nro     := '000';
  NotaF.NFe.Dest.EnderDest.xCpl    := '';
  NotaF.NFe.Dest.EnderDest.xBairro := 'Bairro do destinatario';
  NotaF.NFe.Dest.EnderDest.cMun    := 3554003;
  NotaF.NFe.Dest.EnderDest.xMun    := 'Cidade';
  NotaF.NFe.Dest.EnderDest.UF      := 'SP';
  NotaF.NFe.Dest.EnderDest.cPais   := 1058;
  NotaF.NFe.Dest.EnderDest.xPais   := 'BRASIL';

  /// Produtos ///
  SeqItem := 1;
  FDataSetItens.First;
  while not FDataSetItens.Eof do
  begin
    Produto := NotaF.NFe.Det.Add;

    Produto.Prod.nItem    := SeqItem;
    Produto.Prod.cProd    := FDataSetItens.FieldByName('CODPROD').AsString;
    Produto.Prod.cEAN     := '7896523206646';
    Produto.Prod.xProd    := FDataSetItens.FieldByName('DESCRICAO').AsString;
    Produto.Prod.NCM      := '94051010';

    Produto.Prod.EXTIPI   := '';
    Produto.Prod.CFOP     := '6102';
    Produto.Prod.uCom     := FDataSetItens.FieldByName('UNIDADE').AsString;
    Produto.Prod.qCom     := FDataSetItens.FieldByName('QT').AsCurrency;
    Produto.Prod.vUnCom   := FDataSetItens.FieldByName('PRECO_UNIT').AsFloat;
    Produto.Prod.vProd    := FDataSetItens.FieldByName('PRECO_UNIT').AsFloat;

    Produto.Prod.cEANTrib  := '7896523206646';
    Produto.Prod.uTrib     := FDataSetItens.FieldByName('UNIDADE').AsString;
    Produto.Prod.qTrib     := FDataSetItens.FieldByName('QT').AsCurrency;
    Produto.Prod.vUnTrib   := FDataSetItens.FieldByName('PRECO_UNIT').AsFloat;

    Produto.Prod.vOutro    := 0;
    Produto.Prod.vFrete    := 0;
    Produto.Prod.vSeg      := 0;
    Produto.Prod.vDesc     := 0;
    Produto.Prod.CEST      := '';

    Produto.infAdProd      := ''; /// Informação Adicional do Produto

    /// Imposto ///
    Produto.Imposto.ICMSUFDest.vBCUFDest      := 0.00;
    Produto.Imposto.ICMSUFDest.pFCPUFDest     := 0.00;
    Produto.Imposto.ICMSUFDest.pICMSUFDest    := 0.00;
    Produto.Imposto.ICMSUFDest.pICMSInter     := 0.00;
    Produto.Imposto.ICMSUFDest.pICMSInterPart := 0.00;
    Produto.Imposto.ICMSUFDest.vFCPUFDest     := 0.00;
    Produto.Imposto.ICMSUFDest.vICMSUFDest    := 0.00;
    Produto.Imposto.ICMSUFDest.vICMSUFRemet   := 0.00;

    FDataSetItens.Next;
    Inc(SeqItem);
  end;

  /// Totais da NF-e ///
  NotaF.NFe.Total.ICMSTot.vBC     := 0;
  NotaF.NFe.Total.ICMSTot.vICMS   := 0;
  NotaF.NFe.Total.ICMSTot.vBCST   := 0;
  NotaF.NFe.Total.ICMSTot.vST     := 0;
  NotaF.NFe.Total.ICMSTot.vProd   := FDataSet.FieldByName('VALOR_TOTAL_LIQ').AsCurrency;
  NotaF.NFe.Total.ICMSTot.vFrete  := 0;
  NotaF.NFe.Total.ICMSTot.vSeg    := 0;
  NotaF.NFe.Total.ICMSTot.vDesc   := 0;
  NotaF.NFe.Total.ICMSTot.vII     := 0;
  NotaF.NFe.Total.ICMSTot.vIPI    := 0;
  NotaF.NFe.Total.ICMSTot.vPIS    := 0;
  NotaF.NFe.Total.ICMSTot.vCOFINS := 0;
  NotaF.NFe.Total.ICMSTot.vOutro  := 0;
  NotaF.NFe.Total.ICMSTot.vNF     := FDataSet.FieldByName('VALOR_TOTAL_LIQ').AsCurrency;

  /// lei da transparencia de impostos
  NotaF.NFe.Total.ICMSTot.vTotTrib := 0;

  /// partilha do icms e fundo de probreza
  NotaF.NFe.Total.ICMSTot.vFCPUFDest   := 0.00;
  NotaF.NFe.Total.ICMSTot.vICMSUFDest  := 0.00;
  NotaF.NFe.Total.ICMSTot.vICMSUFRemet := 0.00;

  /// Transportadora ///
  NotaF.NFe.Transp.modFrete := mfContaEmitente;
  NotaF.NFe.Transp.Transporta.CNPJCPF  := '';
  NotaF.NFe.Transp.Transporta.xNome    := '';
  NotaF.NFe.Transp.Transporta.IE       := '';
  NotaF.NFe.Transp.Transporta.xEnder   := '';
  NotaF.NFe.Transp.Transporta.xMun     := '';
  NotaF.NFe.Transp.Transporta.UF       := '';

  /// Volumes ///
  Volume := NotaF.NFe.Transp.Vol.Add;
  Volume.qVol  := 1;
  Volume.esp   := 'Especie';
  Volume.marca := 'Marca';
  Volume.nVol  := 'Numero';
  Volume.pesoL := 100;
  Volume.pesoB := 110;

  /// Dados da cobrança e pagamento ///
  NotaF.NFe.Cobr.Fat.nFat  := 'Numero da Fatura';
  NotaF.NFe.Cobr.Fat.vOrig := FDataSet.FieldByName('VALOR_TOTAL_LIQ').AsCurrency;
  NotaF.NFe.Cobr.Fat.vDesc := 0;
  NotaF.NFe.Cobr.Fat.vLiq  := FDataSet.FieldByName('VALOR_TOTAL_LIQ').AsCurrency;

  Pagamento := NotaF.NFe.pag.Add;
  Pagamento.tPag := fpDinheiro;
  Pagamento.vPag := FDataSet.FieldByName('VALOR_TOTAL_LIQ').AsCurrency;

  if Pagamento.tPag = fpDuplicataMercantil then
  begin
    Duplicata := NotaF.NFe.Cobr.Dup.Add;
    Duplicata.nDup  := '1234';
    Duplicata.dVenc := now+10;
    Duplicata.vDup  := 50;

    Duplicata := NotaF.NFe.Cobr.Dup.Add;
    Duplicata.nDup  := '1235';
    Duplicata.dVenc := now+10;
    Duplicata.vDup  := 50;
  end;

  NotaF.NFe.InfAdic.infCpl := '';
  NotaF.NFe.InfAdic.infAdFisco := '';

  ObsComplementar := NotaF.NFe.InfAdic.obsCont.Add;
  ObsComplementar.xCampo := 'ObsCont';
  ObsComplementar.xTexto := 'Texto';

  ObsFisco := NotaF.NFe.InfAdic.obsFisco.Add;
  ObsFisco.xCampo := 'ObsFisco';
  ObsFisco.xTexto := 'Texto';

  FAcbrNFe.NotasFiscais.GerarNFe;
end;

procedure TProcessosNFe.GravarDadosNotaFiscal;
begin
  /// Gravar os dados na tabela NOTAFISCAL
end;

procedure TProcessosNFe.LerDadosArquivoIni;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(gsAppPath + _NOME_INI);
  try
    FNumeroNFe := ini.ReadInteger(_SECTION_NOTA, _ID_SECTION_NR_NFE, 0) + 1;
    ini.WriteInteger(_SECTION_NOTA, _ID_SECTION_NR_NFE, FNumeroNFe);

    FAmbienteProducao := (ini.ReadInteger(_SECTION_NOTA, _ID_SECTION_AMB_PROD, 0) = 1);
    FNumeroCertificado := ini.ReadString(_SECTION_NOTA, _ID_SECTION_CERTIFICADO, '');
    FCNPJCertificadoEmitente := ini.ReadString(_SECTION_NOTA, _ID_SECTION_CNPJ_CERTIFICADO, '');
  finally
    ini.DisposeOf;
  end;
end;

procedure TProcessosNFe.CarregarConfiguracoes;
begin
  /// Certificado ///
  FAcbrNFe.SSL.DescarregarCertificado;
  FAcbrNFe.Configuracoes.Certificados.NumeroSerie := FNumeroCertificado;

  /// Configurações Gerais ///
  FAcbrNFe.Configuracoes.Geral.SSLLib := libCapicom;
  FAcbrNFe.Configuracoes.Geral.SSLCryptLib := cryCapicom;
  FAcbrNFe.Configuracoes.Geral.SSLHttpLib := httpWinINet;
  FAcbrNFe.Configuracoes.Geral.SSLXmlSignLib := xsMsXmlCapicom;
  FAcbrNFe.Configuracoes.Geral.AtualizarXMLCancelado := False;
  FAcbrNFe.Configuracoes.Geral.ExibirErroSchema := True;
  FAcbrNFe.Configuracoes.Geral.RetirarAcentos := True;
  FAcbrNFe.Configuracoes.Geral.FormatoAlerta := '';
  FAcbrNFe.Configuracoes.Geral.FormaEmissao := teNormal;
  FAcbrNFe.Configuracoes.Geral.ModeloDF := moNFe;
  FAcbrNFe.Configuracoes.Geral.VersaoDF := ve400;//ve310, ve400;
  FAcbrNFe.Configuracoes.Geral.Salvar := True;

  /// Configurações do Webservices ///
  FAcbrNFe.Configuracoes.WebServices.UF := 'PR';
  FAcbrNFe.Configuracoes.WebServices.Ambiente := taHomologacao;
  if FAmbienteProducao then
    FAcbrNFe.Configuracoes.WebServices.Ambiente := taProducao;

  FAcbrNFe.Configuracoes.WebServices.Visualizar := True;
  FAcbrNFe.Configuracoes.WebServices.Salvar := False; /// Salvar SOAP
  FAcbrNFe.Configuracoes.WebServices.AjustaAguardaConsultaRet := True; /// Ajustar Automatico

  FAcbrNFe.Configuracoes.WebServices.AguardarConsultaRet := 5000;
  FAcbrNFe.Configuracoes.WebServices.Tentativas := 5;
  FAcbrNFe.Configuracoes.WebServices.IntervaloTentativas := 500;
  FAcbrNFe.Configuracoes.WebServices.TimeOut := 6000;
  FAcbrNFe.Configuracoes.WebServices.ProxyHost := '';
  FAcbrNFe.Configuracoes.WebServices.ProxyPort := '';
  FAcbrNFe.Configuracoes.WebServices.ProxyUser := '';
  FAcbrNFe.Configuracoes.WebServices.ProxyPass := '';

  /// Configurações de arquivos ///
  FAcbrNFe.Configuracoes.Arquivos.Salvar := True; /// Salvar arquivos
  FAcbrNFe.Configuracoes.Arquivos.SepararPorMes := True;
  FAcbrNFe.Configuracoes.Arquivos.AdicionarLiteral := False;
  FAcbrNFe.Configuracoes.Arquivos.EmissaoPathNFe := True;  /// Salvar NFe pelo campo Data de Emissão
  FAcbrNFe.Configuracoes.Arquivos.SalvarEvento := True;
  FAcbrNFe.Configuracoes.Arquivos.SepararPorCNPJ := True;
  FAcbrNFe.Configuracoes.Arquivos.SepararPorModelo := True;

  FAcbrNFe.Configuracoes.Arquivos.PathSalvar := gsAppPath + 'NFE_Log';
  if not DirectoryExists(FAcbrNFe.Configuracoes.Arquivos.PathSalvar) then
    ForceDirectories(FAcbrNFe.Configuracoes.Arquivos.PathSalvar);

  FAcbrNFe.Configuracoes.Arquivos.PathSchemas := gsAppPath + 'Schemas';
  if not DirectoryExists(FAcbrNFe.Configuracoes.Arquivos.PathSchemas) then
    ForceDirectories(FAcbrNFe.Configuracoes.Arquivos.PathSchemas);

  FAcbrNFe.Configuracoes.Arquivos.PathNFe := gsAppPath + 'NFE_Finalizadas';
  if not DirectoryExists(FAcbrNFe.Configuracoes.Arquivos.PathNFe) then
    ForceDirectories(FAcbrNFe.Configuracoes.Arquivos.PathNFe);

  FAcbrNFe.Configuracoes.Arquivos.PathInu := gsAppPath + 'NFE_Inutilizadas';
  if not DirectoryExists(FAcbrNFe.Configuracoes.Arquivos.PathInu) then
    ForceDirectories(FAcbrNFe.Configuracoes.Arquivos.PathInu);

  FAcbrNFe.Configuracoes.Arquivos.PathEvento := gsAppPath + 'NFE_Eventos';
  if not DirectoryExists(FAcbrNFe.Configuracoes.Arquivos.PathEvento) then
    ForceDirectories(FAcbrNFe.Configuracoes.Arquivos.PathEvento);
end;

constructor TProcessosNFe.Create;
begin
  FAcbrNFe := TACBrNFe.Create(nil);
  FAcbrDanfe := TACBrNFeDANFEFR.Create(nil);
  FAcbrNFe.DANFE := FAcbrDanfe;

  LerDadosArquivoIni;
  CarregarConfiguracoes;
end;

destructor TProcessosNFe.Destroy;
begin
  FAcbrDanfe.DisposeOf;
  FAcbrNFe.DisposeOf;
  inherited;
end;

function TProcessosNFe.EnviarNotaSefaz(Sender: TObject; DataSet, DataSetItens: TClientDataSet): Boolean;
begin
  result := False;

  FDataSet := DataSet;
  FDataSetItens := DataSetItens;

  TButton(Sender).Enabled := False;
  try
    FAcbrNFe.NotasFiscais.Clear;

    GerarNFe;

    FAcbrNFe.NotasFiscais.Assinar;

    GravarDadosNotaFiscal;

    FAcbrNFe.NotasFiscais.Items[0].GravarXML();
    try
      FAcbrNFe.Enviar(FNumeroNFe, True);
      if FAcbrNFe.NotasFiscais.Items[0].Confirmada then
        result := True;
    except
      on E: Exception do
      begin
        Application.MessageBox(PWideChar('Erro ao enviar nota fiscal!' + sLinebreak + sLineBreak +
          'Erro: ' + E.Message), 'NF-e', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    TButton(Sender).Enabled := True;
  end;
end;

end.
