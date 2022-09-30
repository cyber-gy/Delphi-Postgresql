inherited OperForm: TOperForm
  Caption = 'OperForm'
  PixelsPerInch = 120
  TextHeight = 16
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
      Left = 836
      Height = 228
      ExplicitLeft = 836
      ExplicitHeight = 228
    end
    inherited PatientPanel: TPanel
      Height = 228
      ExplicitHeight = 228
      inherited PatGrid: TDBGrid
        Height = 123
      end
      object PatEditGridPanel: TGridPanel
        Left = 0
        Top = 129
        Width = 604
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
            Value = 16.666666666666680000
          end
          item
            Value = 16.666666666666680000
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
            Column = 1
            ColumnSpan = 2
            Control = PatBirthdateEdit
            Row = 2
          end
          item
            Column = 3
            Control = PatRegLabel
            Row = 2
          end
          item
            Column = 4
            ColumnSpan = 2
            Control = PatRegEdit
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
          end>
        TabOrder = 1
        object PatSurnameLabel: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 194
          Height = 12
          Align = alClient
          Caption = #1060#1072#1084#1080#1083#1080#1103
          ExplicitWidth = 53
          ExplicitHeight = 16
        end
        object PatFirstnameLabel: TLabel
          AlignWithMargins = True
          Left = 203
          Top = 3
          Width = 194
          Height = 12
          Align = alClient
          Caption = #1048#1084#1103
          ExplicitWidth = 23
          ExplicitHeight = 16
        end
        object PatMiddlenameLabel: TLabel
          AlignWithMargins = True
          Left = 403
          Top = 3
          Width = 198
          Height = 12
          Align = alClient
          Caption = #1054#1090#1095#1077#1089#1090#1074#1086
          ExplicitWidth = 55
          ExplicitHeight = 16
        end
        object PatSurnameEdit: TDBEdit
          AlignWithMargins = True
          Left = 3
          Top = 21
          Width = 194
          Height = 19
          Align = alClient
          DataField = 'surname'
          DataSource = PatientSource
          TabOrder = 0
          ExplicitHeight = 24
        end
        object PatFirstnameEdit: TDBEdit
          AlignWithMargins = True
          Left = 203
          Top = 21
          Width = 194
          Height = 19
          Align = alClient
          DataField = 'Firstname'
          DataSource = PatientSource
          TabOrder = 1
          ExplicitHeight = 24
        end
        object PatMiddlenameEdit: TDBEdit
          AlignWithMargins = True
          Left = 403
          Top = 21
          Width = 198
          Height = 19
          Align = alClient
          DataField = 'Middlename'
          DataSource = PatientSource
          TabOrder = 2
          ExplicitHeight = 24
        end
        object PatBdLabel: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 46
          Width = 94
          Height = 19
          Align = alClient
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076'.'
          Layout = tlCenter
          ExplicitLeft = 29
          ExplicitWidth = 68
          ExplicitHeight = 16
        end
        object PatBirthdateEdit: TDateTimePicker
          AlignWithMargins = True
          Left = 103
          Top = 46
          Width = 194
          Height = 19
          Align = alClient
          Date = 44833.935363819440000000
          Time = 44833.935363819440000000
          TabOrder = 3
        end
        object PatRegLabel: TLabel
          AlignWithMargins = True
          Left = 303
          Top = 46
          Width = 94
          Height = 19
          Align = alClient
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1088#1077#1075'.'
          Layout = tlCenter
          ExplicitLeft = 341
          ExplicitWidth = 56
          ExplicitHeight = 16
        end
        object PatRegEdit: TDateTimePicker
          AlignWithMargins = True
          Left = 403
          Top = 46
          Width = 198
          Height = 19
          Align = alClient
          Date = 44833.935409189810000000
          Time = 44833.935409189810000000
          TabOrder = 4
        end
        object PatNewButton: TButton
          AlignWithMargins = True
          Left = 3
          Top = 71
          Width = 94
          Height = 24
          Align = alClient
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 5
          OnClick = PatButtonClick
        end
        object PatDelButton: TButton
          AlignWithMargins = True
          Left = 103
          Top = 71
          Width = 94
          Height = 24
          Align = alClient
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 6
          OnClick = PatButtonClick
        end
        object PatPostButton: TButton
          AlignWithMargins = True
          Left = 203
          Top = 71
          Width = 94
          Height = 24
          Align = alClient
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          TabOrder = 7
          OnClick = PatButtonClick
        end
        object PatCancelButton: TButton
          AlignWithMargins = True
          Left = 303
          Top = 71
          Width = 94
          Height = 24
          Align = alClient
          Caption = #1054#1090#1084#1077#1085#1072
          TabOrder = 8
          OnClick = PatButtonClick
        end
      end
    end
    inherited CertPanel: TPanel
      Left = 606
      Height = 228
      Anchors = []
      ExplicitLeft = 606
      ExplicitHeight = 228
      inherited CertGrid: TDBGrid
        Height = 98
        Anchors = []
      end
      object CertEditGridPanel: TGridPanel
        Left = 0
        Top = 104
        Width = 230
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
          end>
        TabOrder = 1
        DesignSize = (
          230
          124)
        object CertNewButton: TButton
          Left = 0
          Top = 96
          Width = 57
          Height = 25
          Anchors = []
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 0
          OnClick = CertButtonClick
        end
        object CertDelButton: TButton
          Left = 57
          Top = 96
          Width = 57
          Height = 25
          Anchors = []
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 1
          OnClick = CertButtonClick
        end
        object CertPostButton: TButton
          Left = 114
          Top = 96
          Width = 57
          Height = 25
          Anchors = []
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          TabOrder = 2
          OnClick = CertButtonClick
        end
        object CertCancelButton: TButton
          Left = 171
          Top = 96
          Width = 59
          Height = 25
          Anchors = []
          Caption = #1054#1090#1084#1077#1085#1072
          TabOrder = 3
          OnClick = CertButtonClick
        end
        object CertNameEdit: TDBEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 24
          Align = alClient
          DataField = 'Name'
          DataSource = CertSource
          TabOrder = 4
        end
        object CertNoteEdit: TDBMemo
          AlignWithMargins = True
          Left = 3
          Top = 33
          Width = 224
          Height = 58
          Align = alClient
          DataField = 'notes'
          DataSource = CertSource
          TabOrder = 5
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
end
