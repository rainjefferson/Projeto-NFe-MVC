object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 348
  Width = 370
  object conPrincipal: TFDConnection
    Params.Strings = (
      
        'Database=D:\Desenvolvimento\Projetos Workana\Projeto Renan NFe\F' +
        'ontes\bin\bd\nfe.FDB'
      'User_Name=SYSDBA'
      'Password=r41n'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 144
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 248
    Top = 32
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidos'
    Left = 144
    Top = 96
    object cdsPedidosNUMPED: TIntegerField
      FieldName = 'NUMPED'
      Required = True
    end
    object cdsPedidosDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsPedidosCODCLI: TIntegerField
      FieldName = 'CODCLI'
    end
    object cdsPedidosFANTASIA: TStringField
      FieldName = 'FANTASIA'
      ReadOnly = True
      Size = 100
    end
    object cdsPedidosCLIENTE: TStringField
      FieldName = 'CLIENTE'
      ReadOnly = True
      Size = 100
    end
    object cdsPedidosCGCENT: TStringField
      FieldName = 'CGCENT'
      ReadOnly = True
      Size = 14
    end
    object cdsPedidosENDERCOM: TStringField
      FieldName = 'ENDERCOM'
      ReadOnly = True
      Size = 100
    end
    object cdsPedidosINSCESTADUAL: TStringField
      FieldName = 'INSCESTADUAL'
      ReadOnly = True
    end
    object cdsPedidosCODUSUR: TIntegerField
      FieldName = 'CODUSUR'
    end
    object cdsPedidosDTENTREGA: TDateField
      FieldName = 'DTENTREGA'
    end
    object cdsPedidosCODFILIAL: TIntegerField
      FieldName = 'CODFILIAL'
    end
    object cdsPedidosTOTPESO: TFMTBCDField
      FieldName = 'TOTPESO'
      Precision = 18
      Size = 6
    end
    object cdsPedidosTOTVOLUME: TFMTBCDField
      FieldName = 'TOTVOLUME'
      Precision = 18
      Size = 6
    end
    object cdsPedidosVALOR_TOTAL_LIQ: TBCDField
      FieldName = 'VALOR_TOTAL_LIQ'
      Precision = 18
      Size = 2
    end
    object cdsPedidosHORA: TIntegerField
      FieldName = 'HORA'
    end
    object cdsPedidosMINUTO: TIntegerField
      FieldName = 'MINUTO'
    end
    object cdsPedidosNUMSEQENTREGA: TIntegerField
      FieldName = 'NUMSEQENTREGA'
    end
    object cdsPedidosNUMNOTA: TIntegerField
      FieldName = 'NUMNOTA'
    end
    object cdsPedidosDTFAT: TDateField
      FieldName = 'DTFAT'
    end
  end
  object dspPedidos: TDataSetProvider
    DataSet = qryPedidos
    Options = [poPropogateChanges, poAllowCommandText, poUseQuoteChar]
    Left = 248
    Top = 96
  end
  object qryPedidos: TFDQuery
    Connection = conPrincipal
    SQL.Strings = (
      'SELECT '
      '  '
      '  PCPEDC.NUMPED,'
      '  PCPEDC.DATA,'
      '  PCPEDC.CODCLI,'
      '  PCCLIENT.FANTASIA,'
      '  PCCLIENT.CLIENTE,'
      '  PCCLIENT.CGCENT,'
      '  PCCLIENT.ENDERCOM,'
      '  PCCLIENT.INSCESTADUAL,'
      '  PCPEDC.CODUSUR,'
      '  PCPEDC.DTENTREGA,'
      '  PCPEDC.CODFILIAL,'
      '  PCPEDC.TOTPESO,'
      '  PCPEDC.TOTVOLUME,'
      '  PCPEDC.VALOR_TOTAL_LIQ,'
      '  PCPEDC.HORA,'
      '  PCPEDC.MINUTO,'
      '  PCPEDC.NUMSEQENTREGA,'
      '  PCPEDC.NUMNOTA,'
      '  PCPEDC.DTFAT'
      'FROM PCPEDC'
      '     INNER JOIN PCCLIENT ON PCCLIENT.CODCLI = PCPEDC.CODCLI'
      'WHERE (POSICAO = '#39'F'#39')')
    Left = 48
    Top = 96
  end
  object cdsItensPedidos: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'NUMPED'
        ParamType = ptInput
      end>
    ProviderName = 'dspItensPedidos'
    Left = 144
    Top = 160
    object cdsItensPedidosNUMPED: TIntegerField
      FieldName = 'NUMPED'
      Required = True
    end
    object cdsItensPedidosCODPROD: TIntegerField
      FieldName = 'CODPROD'
    end
    object cdsItensPedidosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ReadOnly = True
      Size = 100
    end
    object cdsItensPedidosUNIDADE: TStringField
      FieldName = 'UNIDADE'
      ReadOnly = True
      Size = 3
    end
    object cdsItensPedidosQT: TBCDField
      FieldName = 'QT'
      Precision = 18
      Size = 3
    end
    object cdsItensPedidosPRECO_UNIT: TBCDField
      FieldName = 'PRECO_UNIT'
      Precision = 18
    end
    object cdsItensPedidosALIQICMS1: TBCDField
      FieldName = 'ALIQICMS1'
      Precision = 18
      Size = 2
    end
    object cdsItensPedidosALIQICMS2: TBCDField
      FieldName = 'ALIQICMS2'
      Precision = 18
      Size = 2
    end
    object cdsItensPedidosPERCIPI: TBCDField
      FieldName = 'PERCIPI'
      Precision = 18
      Size = 2
    end
    object cdsItensPedidosVLIPI: TBCDField
      FieldName = 'VLIPI'
      Precision = 18
      Size = 2
    end
  end
  object dspItensPedidos: TDataSetProvider
    DataSet = qryItensPedidos
    Options = [poPropogateChanges, poAllowCommandText, poUseQuoteChar]
    Left = 248
    Top = 160
  end
  object qryItensPedidos: TFDQuery
    Connection = conPrincipal
    SQL.Strings = (
      'SELECT '
      '   PCPEDI.NUMPED,'
      '   PCPEDI.CODPROD,'
      '   PCPRODUT.DESCRICAO,'
      '   PCPRODUT.UNIDADE,'
      '   PCPEDI.QT,'
      '   PCPEDI.PRECO_UNIT,'
      '   PCPEDI.ALIQICMS1,'
      '   PCPEDI.ALIQICMS2,'
      '   PCPEDI.PERCIPI,'
      '   PCPEDI.VLIPI'
      'FROM PCPEDI'
      '     INNER JOIN PCPEDC ON PCPEDI.NUMPED = PCPEDC.NUMPED'
      '     INNER JOIN PCPRODUT ON PCPRODUT.CODPROD = PCPEDI.CODPROD'
      'WHERE PCPEDC.NUMPED = :NUMPED'
      '  AND (PCPEDC.POSICAO = '#39'F'#39')')
    Left = 48
    Top = 160
    ParamData = <
      item
        Name = 'NUMPED'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object cdsNotas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspNotas'
    Left = 144
    Top = 224
    object cdsNotasNUMPED: TIntegerField
      FieldName = 'NUMPED'
      Required = True
    end
    object cdsNotasDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsNotasCODCLI: TIntegerField
      FieldName = 'CODCLI'
    end
    object cdsNotasFANTASIA: TStringField
      FieldName = 'FANTASIA'
      ReadOnly = True
      Size = 100
    end
    object cdsNotasCLIENTE: TStringField
      FieldName = 'CLIENTE'
      ReadOnly = True
      Size = 100
    end
    object cdsNotasINSCESTADUAL: TStringField
      FieldName = 'INSCESTADUAL'
      ReadOnly = True
    end
    object cdsNotasDTENTREGA: TDateField
      FieldName = 'DTENTREGA'
    end
    object cdsNotasVALOR_TOTAL_LIQ: TBCDField
      FieldName = 'VALOR_TOTAL_LIQ'
      Precision = 18
      Size = 2
    end
    object cdsNotasNUMNOTA: TIntegerField
      FieldName = 'NUMNOTA'
      ReadOnly = True
    end
    object cdsNotasCHAVE: TStringField
      FieldName = 'CHAVE'
      ReadOnly = True
      Size = 44
    end
  end
  object dspNotas: TDataSetProvider
    DataSet = qryNotas
    Options = [poPropogateChanges, poAllowCommandText, poUseQuoteChar]
    Left = 248
    Top = 224
  end
  object qryNotas: TFDQuery
    Connection = conPrincipal
    SQL.Strings = (
      'SELECT '
      '  '
      '  P.NUMPED,'
      '  P.DATA,'
      '  P.CODCLI,'
      '  C.FANTASIA,'
      '  C.CLIENTE,'
      '  C.INSCESTADUAL,'
      '  P.DTENTREGA,'
      '  P.VALOR_TOTAL_LIQ,'
      '  N.NUMNOTA,'
      '  N.CHAVE'
      'FROM PCPEDC P'
      '     INNER JOIN PCCLIENT C ON (C.CODCLI = P.CODCLI)'
      '     INNER JOIN NOTAFISCAL N ON (N.NUMPED = P.NUMPED)'
      'WHERE (N.POSICAO = '#39'F'#39')')
    Left = 48
    Top = 224
  end
end
