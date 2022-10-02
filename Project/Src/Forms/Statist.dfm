inherited StatForm: TStatForm
  Caption = #1040#1056#1052' '#1089#1090#1072#1090#1080#1089#1090#1072
  PixelsPerInch = 120
  TextHeight = 16
  inherited SearchPanel: TPanel
    object DateSeachPanel: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 276
      Height = 71
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object DateEdit1: TDateTimePicker
        AlignWithMargins = True
        Left = 151
        Top = 8
        Width = 106
        Height = 24
        Date = 44833.660413148150000000
        Format = ' '
        Time = 44833.660413148150000000
        TabOrder = 1
        OnClick = DateEdit1Click
        OnChange = DateEdit1Change
        OnExit = DateEdit1Exit
        OnKeyPress = DateEdit1KeyPress
      end
      object DateEdit2: TDateTimePicker
        AlignWithMargins = True
        Left = 151
        Top = 38
        Width = 106
        Height = 24
        Date = 44833.660413148150000000
        Format = ' '
        Time = 44833.660413148150000000
        TabOrder = 2
        OnChange = DateEdit1Change
        OnExit = DateEdit1Exit
        OnKeyPress = DateEdit1KeyPress
      end
      object DateSearchGroup: TRadioGroup
        Left = 16
        Top = 0
        Width = 113
        Height = 65
        Caption = #1055#1086' '#1076#1072#1090#1077':'
        ItemIndex = 0
        Items.Strings = (
          #1088#1086#1078#1076#1077#1085#1080#1103
          #1079#1072#1085#1077#1089#1077#1085#1080#1103)
        TabOrder = 0
      end
    end
  end
  inherited PatientNavigator: TDBNavigator
    Hints.Strings = ()
    Visible = False
  end
  inherited BrowsePanel: TPanel
    inherited PatientPanel: TPanel
      inherited PatGrid: TDBGrid
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
      end
    end
    inherited CertPanel: TPanel
      inherited CertGrid: TDBGrid
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
      end
    end
  end
  inherited PgConnection: TFDConnection
    Left = 419
  end
  inherited PgPatientQuery: TFDQuery
    Left = 587
  end
  inherited PgCertQuery: TFDQuery
    Left = 651
    Top = 43
  end
  inherited PatientSource: TDataSource
    Left = 763
    Top = 3
  end
  inherited CertSource: TDataSource
    Left = 763
    Top = 35
  end
  inherited PgSearchQuery: TFDQuery
    SQL.Strings = (
      'SELECT * FROM db_test1.patients WHERE ')
    Left = 523
    Top = 11
  end
  inherited ChildActions: TActionList
    Left = 363
    Top = 11
  end
end
