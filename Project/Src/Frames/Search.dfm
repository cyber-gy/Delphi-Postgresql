object SearchFrame: TSearchFrame
  Left = 0
  Top = 0
  Width = 398
  Height = 76
  TabOrder = 0
  DesignSize = (
    398
    76)
  object SearchLabel: TLabel
    Left = 16
    Top = 16
    Width = 70
    Height = 16
    Caption = 'SearchLabel'
  end
  object ValueEdit: TEdit
    Left = 16
    Top = 38
    Width = 273
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnKeyPress = ValueEditKeyPress
  end
  object SearchButton: TButton
    Left = 304
    Top = 38
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1087#1086#1080#1089#1082
    TabOrder = 1
  end
end
