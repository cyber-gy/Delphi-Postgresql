object MainForm: TMainForm
  AlignWithMargins = True
  Left = 0
  Top = 0
  Align = alTop
  Caption = #1040#1056#1052#1099' '#1088#1072#1073#1086#1090#1099' '#1089' '#1057#1059#1041#1044' PostgreSQL'
  ClientHeight = 58
  ClientWidth = 850
  Color = clBtnFace
  Constraints.MaxHeight = 105
  Constraints.MinHeight = 85
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 850
    Height = 30
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 30
    Width = 850
    Height = 29
    ActionManager = ActionManager1
    Caption = 'ActionToolBar1'
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Spacing = 0
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Action = ActionCloseAll
          end
          item
            Action = ActionWindowCloseLast
          end
          item
            Visible = False
            Action = ActionWindowNew
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &browser'
          end
          item
            Action = ActionExit
          end>
      end
      item
        Items = <
          item
            Items = <
              item
                Action = ActionExit
              end>
            Caption = '&'#1055#1088#1086#1075#1088#1072#1084#1084#1072
          end
          item
            Items = <
              item
                Visible = False
                Action = ActionWindowNew
                Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &browser'
              end
              item
                Action = ActionWindowNewStat
              end
              item
                Action = ActionWindowNewOper
              end
              item
                Action = ActionWindowCloseLast
              end
              item
                Action = ActionCloseAll
              end>
            Caption = '&'#1054#1082#1085#1072
          end>
        ActionBar = ActionMainMenuBar1
      end
      item
        ActionBar = ActionToolBar1
      end>
    LinkedActionLists = <
      item
        ActionList = ActionList1
        Caption = 'ActionList1'
      end>
    Left = 256
    Top = 8
    StyleName = 'XP Style'
  end
  object ActionList1: TActionList
    Left = 192
    Top = 8
    object ActionExit: TAction
      Category = 'Main'
      Caption = #1042#1099#1093#1086#1076
      OnExecute = ActionExitExecute
    end
    object ActionWindowNew: TAction
      Category = 'Windows'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' browser'
      Visible = False
      OnExecute = ActionWindowNewExecute
    end
    object ActionWindowNewStat: TAction
      Category = 'Windows'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1040#1056#1052' '#1089#1090#1072#1090#1080#1089#1090#1072
      OnExecute = ActionWindowNewStatExecute
    end
    object ActionWindowNewOper: TAction
      Category = 'Windows'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1040#1056#1052' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      OnExecute = ActionWindowNewOperExecute
    end
    object ActionWindowCloseLast: TAction
      Category = 'Windows'
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1077#1077
      OnExecute = ActionWindowCloseLastExecute
    end
    object ActionCloseAll: TAction
      Category = 'Windows'
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
      OnExecute = ActionCloseAllExecute
    end
  end
end
