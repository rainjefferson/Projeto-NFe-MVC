object FrNotasCanceladas: TFrNotasCanceladas
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
    Visible = False
    ExplicitTop = 206
    ExplicitWidth = 320
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 424
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 320
    ExplicitHeight = 206
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 798
      Height = 422
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
