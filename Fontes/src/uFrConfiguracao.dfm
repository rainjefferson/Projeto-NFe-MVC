object FrConfiguracao: TFrConfiguracao
  Left = 0
  Top = 0
  Width = 800
  Height = 458
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 424
    Width = 800
    Height = 34
    Align = alBottom
    TabOrder = 0
    object btnConfirmar: TButton
      AlignWithMargins = True
      Left = 704
      Top = 4
      Width = 75
      Height = 26
      Margins.Right = 20
      Align = alRight
      Caption = 'Confirmar'
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 424
    Align = alClient
    TabOrder = 1
    ExplicitTop = -2
    object Label25: TLabel
      Left = 10
      Top = 20
      Width = 181
      Height = 13
      Caption = 'N'#250'mero de S'#233'rie do Certificado Digital'
    end
    object lblDataValidadeCertificado: TLabel
      Left = 10
      Top = 62
      Width = 481
      Height = 18
      AutoSize = False
      Caption = 'Validade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnProcurarCertificado: TSpeedButton
      Left = 502
      Top = 35
      Width = 25
      Height = 21
      Hint = 'Selecionar Certificado'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFDCDCDCCCCCCCCCCCCCCCCCCCDCDCDCFFFFFFDCDCDCCCCC
        CCCCCCCCCCCCCCDCDCDCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF938F8D706E6C6A
        6765676363828180FFFFFF939290706E6C6B676767636382817FFFFFFFF4F4F4
        F5F5F5F5F5F5F8F8F87B726BC4C2BFBDBCBA8584825F5B5BCCCCCC787573C3C3
        C1BDBCBA858482615E5DD0D0D0AFC1CDB0C1CDB2C2CDB9C5CE7A6F67BFBDBAB7
        B6B480807D5C58586E6C69757270BEBDBBB7B6B481807E5F5C5B4E9DD14398D2
        4094D03E93D03A96D8796D65E5E3E1DFDEDDBDBCBC595452BBB7B6726F6CE4E2
        E1E0DFDEBFBFBE5F5C5B4499D23F94D0ABFBFF9BF4FF91F7FF7968616C666363
        605D5F5A596C98A1B9B4B27AA7B06A666465626164605E625E5C4397D156ACDD
        8EDAF5A2EEFF82E9FF84F3FF776A66CBC7C49996945C5453BBB6B3756F6CCAC7
        C49B9795625B57FFFFFF4296D171C4EA6CBCE6BBF2FF75DFFE77E5FF7499A36C
        6662655F5D6B96A26E646078A4B06D696668615D567488EDEDED4095D090DDF8
        44A0D8DDFCFFDAFAFFDBFDFFDCFFFF776D68B9B5B160555075F2FF786D68B8B4
        B05F56507ECDF9A4C3D83E93CFB2F6FF51ACDE358ACA358ACA358CCC3591D47C
        6B616D60595E4E4768E5FF756760675D585B4E46ACE9FF64A2CF3D92CFB8F3FF
        77DFFE7BE0FE7CE1FE7CE1FF7CE4FF51B1E755C2F5DAFFFFD6FCFFD5FEFFD5FF
        FFD6FFFFDCFFFF3E95D13C92CFC0F3FF70D9FB73DAFB74DAFB74DAFB74DBFC76
        DEFF4FABDE368CCC358CCC338CCD338DCE3891D03D94D07EB8DF3B92CFCAF6FF
        69D5F96CD5F96AD4F969D4F969D5F96AD6FA6BD8FB6BD9FC6BDAFD69DAFDDAFD
        FF3C93D0D9E6EFFFFFFF3B92CFD5F7FF60D1F961D0F8B4EBFDD9F6FFDAF8FFDA
        F8FFDAF9FFDBF9FFDAF9FFDAFAFFDFFEFF3D94D0D8E9F5FFFFFF3D94D0DCFCFF
        D8F7FFD8F7FFDBFAFF358ECD3991CE3A92CF3A92CF3A92CF3A92CF3A92CF3D94
        D0519FD4FFFFFFFFFFFF4E9DD43D94D03A92CF3A92CF3D94D054A1D5DFEDF7DA
        EAF6D9EAF5D9EAF5D9EAF5D9EAF5D6E8F5FFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnProcurarCertificadoClick
    end
    object lblCnpj: TLabel
      Left = 10
      Top = 82
      Width = 481
      Height = 18
      AutoSize = False
      Caption = 'Cnpj'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object lblRazaoSoc: TLabel
      Left = 10
      Top = 104
      Width = 481
      Height = 18
      AutoSize = False
      Caption = 'RazaoSoc'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object edtNumSerie: TEdit
      Left = 10
      Top = 35
      Width = 486
      Height = 21
      TabOrder = 0
    end
  end
end
