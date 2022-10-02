inherited OperForm: TOperForm
  Caption = #1040#1056#1052' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
  ExplicitWidth = 868
  ExplicitHeight = 452
  PixelsPerInch = 120
  TextHeight = 16
  inherited SearchPanel: TPanel
    object TypeSearchPanel: TPanel
      Left = 2
      Top = 2
      Width = 151
      Height = 77
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object SearchTypeGroup: TRadioGroup
        Left = 16
        Top = 5
        Width = 113
        Height = 65
        Caption = #1055#1086#1080#1089#1082':'
        ItemIndex = 0
        Items.Strings = (
          #1087#1086' '#1092#1072#1084#1080#1083#1080#1080
          '10 '#1087#1086#1089#1083#1077#1076#1085#1080#1093)
        TabOrder = 0
      end
    end
  end
  inherited PatientNavigator: TDBNavigator
    Top = 328
    Hints.Strings = ()
    TabOrder = 2
    Visible = False
    ExplicitTop = 328
  end
  inherited BrowsePanel: TPanel
    Height = 232
    TabOrder = 1
    ExplicitHeight = 232
    inherited BrowseSplitter: TSplitter
      Height = 228
      ExplicitLeft = 606
      ExplicitHeight = 228
    end
    inherited PatientPanel: TPanel
      Height = 228
      ExplicitHeight = 228
      inherited PatGrid: TDBGrid
        Height = 117
      end
      object PatEditGridPanel: TGridPanel
        AlignWithMargins = True
        Left = 3
        Top = 126
        Width = 598
        Height = 99
        Align = alBottom
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 16.666666666666670000
          end
          item
            Value = 16.666666666666670000
          end
          item
            Value = 16.666666666666670000
          end
          item
            Value = 16.666666666666670000
          end
          item
            Value = 16.666666666666670000
          end
          item
            Value = 16.666666666666670000
          end>
        ControlCollection = <
          item
            Column = 0
            ColumnSpan = 2
            Control = PatSurnameLabel
            Row = 0
          end
          item
            Column = 2
            ColumnSpan = 2
            Control = PatFirstnameLabel
            Row = 0
          end
          item
            Column = 4
            ColumnSpan = 2
            Control = PatMiddlenameLabel
            Row = 0
          end
          item
            Column = 0
            ColumnSpan = 2
            Control = PatSurnameEdit
            Row = 1
          end
          item
            Column = 2
            ColumnSpan = 2
            Control = PatFirstnameEdit
            Row = 1
          end
          item
            Column = 4
            ColumnSpan = 2
            Control = PatMiddlenameEdit
            Row = 1
          end
          item
            Column = 0
            Control = PatBdLabel
            Row = 2
          end
          item
            Column = 3
            Control = PatRegLabel
            Row = 2
          end
          item
            Column = 0
            Control = PatNewButton
            Row = 3
          end
          item
            Column = 1
            Control = PatDelButton
            Row = 3
          end
          item
            Column = 2
            Control = PatPostButton
            Row = 3
          end
          item
            Column = 3
            Control = PatCancelButton
            Row = 3
          end
          item
            Column = 1
            ColumnSpan = 2
            Control = PatBirthdatePanel
            Row = 2
          end
          item
            Column = 4
            ColumnSpan = 2
            Control = PatRegPanel
            Row = 2
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 18.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 8.000000000000000000
          end>
        TabOrder = 1
        OnClick = PatEditGridPanelClick
        ExplicitLeft = 0
        ExplicitTop = 129
        ExplicitWidth = 604
        object PatSurnameLabel: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 192
          Height = 12
          Align = alClient
          Caption = #1060#1072#1084#1080#1083#1080#1103
          ExplicitWidth = 53
          ExplicitHeight = 16
        end
        object PatFirstnameLabel: TLabel
          AlignWithMargins = True
          Left = 201
          Top = 3
          Width = 192
          Height = 12
          Align = alClient
          Caption = #1048#1084#1103
          ExplicitLeft = 203
          ExplicitWidth = 23
          ExplicitHeight = 16
        end
        object PatMiddlenameLabel: TLabel
          AlignWithMargins = True
          Left = 399
          Top = 3
          Width = 196
          Height = 12
          Align = alClient
          Caption = #1054#1090#1095#1077#1089#1090#1074#1086
          ExplicitLeft = 403
          ExplicitWidth = 55
          ExplicitHeight = 16
        end
        object PatSurnameEdit: TDBEdit
          AlignWithMargins = True
          Left = 3
          Top = 21
          Width = 192
          Height = 15
          Align = alClient
          DataField = 'surname'
          DataSource = PatientSource
          TabOrder = 0
          ExplicitWidth = 194
          ExplicitHeight = 24
        end
        object PatFirstnameEdit: TDBEdit
          AlignWithMargins = True
          Left = 201
          Top = 21
          Width = 192
          Height = 15
          Align = alClient
          DataField = 'Firstname'
          DataSource = PatientSource
          TabOrder = 1
          ExplicitLeft = 203
          ExplicitWidth = 194
          ExplicitHeight = 24
        end
        object PatMiddlenameEdit: TDBEdit
          AlignWithMargins = True
          Left = 399
          Top = 21
          Width = 196
          Height = 15
          Align = alClient
          DataField = 'Middlename'
          DataSource = PatientSource
          TabOrder = 2
          ExplicitLeft = 403
          ExplicitWidth = 198
          ExplicitHeight = 24
        end
        object PatBdLabel: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 42
          Width = 93
          Height = 15
          Align = alClient
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076'.'
          Layout = tlCenter
          ExplicitLeft = 29
          ExplicitTop = 46
          ExplicitWidth = 68
          ExplicitHeight = 16
        end
        object PatRegLabel: TLabel
          AlignWithMargins = True
          Left = 300
          Top = 42
          Width = 93
          Height = 15
          Align = alClient
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1088#1077#1075'.'
          Layout = tlCenter
          ExplicitLeft = 341
          ExplicitTop = 46
          ExplicitWidth = 56
          ExplicitHeight = 16
        end
        object PatNewButton: TButton
          AlignWithMargins = True
          Left = 3
          Top = 63
          Width = 93
          Height = 24
          Align = alClient
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 5
          OnClick = PatButtonClick
          ExplicitTop = 71
          ExplicitWidth = 94
        end
        object PatDelButton: TButton
          AlignWithMargins = True
          Left = 102
          Top = 63
          Width = 93
          Height = 24
          Align = alClient
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 6
          OnClick = PatButtonClick
          ExplicitLeft = 103
          ExplicitTop = 71
          ExplicitWidth = 94
        end
        object PatPostButton: TButton
          AlignWithMargins = True
          Left = 201
          Top = 63
          Width = 93
          Height = 24
          Align = alClient
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          TabOrder = 7
          OnClick = PatButtonClick
          ExplicitLeft = 203
          ExplicitTop = 71
          ExplicitWidth = 94
        end
        object PatCancelButton: TButton
          AlignWithMargins = True
          Left = 300
          Top = 63
          Width = 93
          Height = 24
          Align = alClient
          Caption = #1054#1090#1084#1077#1085#1072
          TabOrder = 8
          OnClick = PatButtonClick
          ExplicitLeft = 303
          ExplicitTop = 71
          ExplicitWidth = 94
        end
        object PatBirthdatePanel: TPanel
          Left = 99
          Top = 39
          Width = 198
          Height = 21
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 3
          ExplicitLeft = 100
          ExplicitTop = 43
          ExplicitWidth = 200
          ExplicitHeight = 25
        end
        object PatRegPanel: TPanel
          Left = 396
          Top = 39
          Width = 202
          Height = 21
          Align = alClient
          Anchors = []
          BevelOuter = bvNone
          TabOrder = 4
          ExplicitLeft = 400
          ExplicitTop = 43
          ExplicitWidth = 204
          ExplicitHeight = 25
        end
      end
    end
    inherited CertPanel: TPanel
      Height = 228
      Anchors = []
      ExplicitLeft = 606
      ExplicitHeight = 228
      object CertGridSplitter: TSplitter [0]
        Left = 0
        Top = 94
        Width = 230
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 95
      end
      inherited CertGrid: TDBGrid
        Height = 88
        Anchors = []
      end
      object CertEditGridPanel: TGridPanel
        AlignWithMargins = True
        Left = 3
        Top = 101
        Width = 224
        Height = 124
        Align = alBottom
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 25.000000000000000000
          end
          item
            Value = 25.000000000000000000
          end
          item
            Value = 25.000000000000000000
          end
          item
            Value = 25.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = CertNewButton
            Row = 2
          end
          item
            Column = 1
            Control = CertDelButton
            Row = 2
          end
          item
            Column = 2
            Control = CertPostButton
            Row = 2
          end
          item
            Column = 3
            Control = CertCancelButton
            Row = 2
          end
          item
            Column = 0
            ColumnSpan = 4
            Control = CertNameEdit
            Row = 0
          end
          item
            Column = 0
            ColumnSpan = 4
            Control = CertNoteEdit
            Row = 1
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
          end
          item
            Value = 100.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 30.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 12.000000000000000000
          end>
        TabOrder = 1
        ExplicitLeft = 0
        ExplicitTop = 104
        ExplicitWidth = 230
        DesignSize = (
          224
          124)
        object CertNewButton: TButton
          Left = 0
          Top = 84
          Width = 56
          Height = 25
          Anchors = []
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 0
          OnClick = CertButtonClick
          ExplicitTop = 96
        end
        object CertDelButton: TButton
          Left = 56
          Top = 84
          Width = 56
          Height = 25
          Anchors = []
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 1
          OnClick = CertButtonClick
          ExplicitLeft = 57
          ExplicitTop = 96
        end
        object CertPostButton: TButton
          Left = 112
          Top = 84
          Width = 56
          Height = 25
          Anchors = []
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          TabOrder = 2
          OnClick = CertButtonClick
          ExplicitLeft = 114
          ExplicitTop = 96
        end
        object CertCancelButton: TButton
          Left = 168
          Top = 84
          Width = 56
          Height = 25
          Anchors = []
          Caption = #1054#1090#1084#1077#1085#1072
          TabOrder = 3
          OnClick = CertButtonClick
          ExplicitLeft = 171
          ExplicitTop = 96
        end
        object CertNameEdit: TDBEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 218
          Height = 24
          Align = alClient
          DataField = 'Name'
          DataSource = CertSource
          TabOrder = 4
          ExplicitWidth = 224
        end
        object CertNoteEdit: TDBMemo
          AlignWithMargins = True
          Left = 3
          Top = 33
          Width = 218
          Height = 46
          Align = alClient
          DataField = 'notes'
          DataSource = CertSource
          TabOrder = 5
          ExplicitWidth = 224
          ExplicitHeight = 58
        end
      end
    end
  end
  object CertNavigator: TDBNavigator [3]
    AlignWithMargins = True
    Left = 3
    Top = 368
    Width = 844
    Height = 34
    DataSource = CertSource
    Align = alBottom
    TabOrder = 3
    Visible = False
  end
  inherited PgConnection: TFDConnection
    Left = 195
  end
  inherited PgCertQuery: TFDQuery
    BeforePost = PgCertQueryBeforePost
    object PgCertQuerynotes: TWideStringField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077
      DisplayWidth = 20
      FieldName = 'notes'
      Size = 2040
    end
  end
  inherited PatientSource: TDataSource
    OnStateChange = PatientSourceStateChange
  end
  inherited CertSource: TDataSource
    OnStateChange = CertSourceStateChange
  end
  inherited PgSearchQuery: TFDQuery
    Left = 387
  end
  inherited ChildActions: TActionList
    Left = 275
  end
end
