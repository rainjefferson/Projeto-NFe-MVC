object FrNotasEnviar: TFrNotasEnviar
  Left = 0
  Top = 0
  Width = 768
  Height = 523
  TabOrder = 0
  Visible = False
  object Panel1: TPanel
    Left = 0
    Top = 489
    Width = 768
    Height = 34
    Align = alBottom
    TabOrder = 0
    object btnEnviarSefaz: TButton
      AlignWithMargins = True
      Left = 595
      Top = 4
      Width = 75
      Height = 26
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Enviar Sefaz'
      TabOrder = 0
    end
    object btnImprimir: TButton
      AlignWithMargins = True
      Left = 672
      Top = 4
      Width = 75
      Height = 26
      Margins.Left = 1
      Margins.Right = 20
      Align = alRight
      Caption = 'Imprimir'
      TabOrder = 1
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 768
    Height = 489
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 766
      Height = 487
      Align = alClient
      DataSource = dsoNotasEnviar
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object dsoNotasEnviar: TDataSource
    Left = 336
    Top = 248
  end
end
