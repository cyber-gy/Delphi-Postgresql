inherited OperForm: TOperForm
  Caption = #1040#1056#1052' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
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
    Hints.Strings = ()
    TabOrder = 2
    Visible = False
  end
  inherited BrowsePanel: TPanel
    TabOrder = 1
    inherited BrowseSplitter: TSplitter
      ExplicitLeft = 606
      ExplicitHeight = 228
    end
    inherited PatientPanel: TPanel
      inherited PatGrid: TDBGrid
        Height = 157
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
      end
      object PatEditGridPanel: TGridPanel
        AlignWithMargins = True
        Left = 3
        Top = 166
        Width = 598
        Height = 99
        Align = alBottom
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 16.666666666666660000
          end
          item
            Value = 16.666666666666660000
          end
          item
            Value = 16.666666666666660000
          end
          item
            Value = 16.666666666666660000
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
          ExplicitWidth = 55
          ExplicitHeight = 16
        end
        object PatSurnameEdit: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 21
          Width = 192
          Height = 15
          Align = alClient
          TabOrder = 0
          ExplicitHeight = 24
        end
        object PatFirstnameEdit: TEdit
          AlignWithMargins = True
          Left = 201
          Top = 21
          Width = 192
          Height = 15
          Align = alClient
          TabOrder = 1
          ExplicitHeight = 24
        end
        object PatMiddlenameEdit: TEdit
          AlignWithMargins = True
          Left = 399
          Top = 21
          Width = 196
          Height = 15
          Align = alClient
          TabOrder = 2
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
          ExplicitLeft = 28
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
          ExplicitLeft = 337
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
          OnClick = PatChangeButtonClick
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
          OnClick = PatDelButtonClick
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
          OnClick = PatChangeButtonClick
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
          OnClick = PatCancelButtonClick
        end
        object PatBirthdatePanel: TPanel
          Left = 99
          Top = 39
          Width = 198
          Height = 21
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 3
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
        end
      end
    end
    inherited CertPanel: TPanel
      Anchors = []
      object CertGridSplitter: TSplitter [0]
        Left = 0
        Top = 134
        Width = 230
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 95
      end
      inherited CertGrid: TDBGrid
        Height = 128
        Anchors = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
      end
      object CertEditGridPanel: TGridPanel
        AlignWithMargins = True
        Left = 3
        Top = 141
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
          OnClick = CertChangeButtonClick
        end
        object CertDelButton: TButton
          Left = 56
          Top = 84
          Width = 56
          Height = 25
          Anchors = []
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 1
          OnClick = CertDelButtonClick
        end
        object CertPostButton: TButton
          Left = 112
          Top = 84
          Width = 56
          Height = 25
          Anchors = []
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          TabOrder = 2
          OnClick = CertChangeButtonClick
        end
        object CertCancelButton: TButton
          Left = 168
          Top = 84
          Width = 56
          Height = 25
          Anchors = []
          Caption = #1054#1090#1084#1077#1085#1072
          TabOrder = 3
          OnClick = CertCancelButtonClick
        end
        object CertNameEdit: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 218
          Height = 24
          Align = alClient
          TabOrder = 4
        end
        object CertNoteEdit: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 33
          Width = 218
          Height = 46
          Align = alClient
          TabOrder = 5
        end
      end
    end
  end
  inherited PgConnection: TFDConnection
    Left = 195
  end
  inherited CertSource: TDataSource
    OnDataChange = CertSourceDataChange
  end
  inherited ChildActions: TActionList
    Left = 275
  end
  inherited PgSearchProc: TFDStoredProc
    Left = 352
    Top = 0
  end
  inherited PgPatientProc: TFDStoredProc
    AfterOpen = PgPatientProcAfterScroll
    Left = 400
    Top = 8
  end
  inherited PgCertProc: TFDStoredProc
    Left = 451
    Top = 19
    object PgCertProcnotes: TWideStringField
      DisplayLabel = #1044#1072#1085#1085#1099#1077
      DisplayWidth = 10
      FieldName = 'notes'
      Size = 2040
    end
  end
  object PgSetCertProc: TFDStoredProc
    Connection = PgConnection
    SchemaName = 'db_test1'
    StoredProcName = 'SetCertificate'
    Left = 507
    Top = 3
    ParamData = <
      item
        Name = 'i_id'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInputOutput
      end
      item
        Name = 'i_id_patient'
        DataType = ftInteger
        FDDataType = dtUInt32
        ParamType = ptInput
      end
      item
        Name = 'i_name'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
      end
      item
        Name = 'i_notes'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
      end>
  end
  object PgDelCertProc: TFDStoredProc
    Connection = PgConnection
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    SchemaName = 'db_test1'
    StoredProcName = 'DelCertificate'
    Left = 531
    Top = 19
    ParamData = <
      item
        Name = 'i_id'
        DataType = ftInteger
        FDDataType = dtUInt32
        ParamType = ptInput
      end>
  end
  object PgSetPatientProc: TFDStoredProc
    Connection = PgConnection
    SchemaName = 'db_test1'
    StoredProcName = 'SetPatient'
    Left = 587
    Top = 3
    ParamData = <
      item
        Name = 'i_id'
        DataType = ftInteger
        FDDataType = dtUInt32
        ParamType = ptInputOutput
      end
      item
        Name = 'i_surname'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
      end
      item
        Name = 'i_firstname'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
      end
      item
        Name = 'i_middlename'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
      end
      item
        Name = 'i_birthdate'
        DataType = ftDate
        FDDataType = dtDate
        ParamType = ptInput
      end
      item
        Name = 'i_created'
        DataType = ftDate
        FDDataType = dtDate
        ParamType = ptInput
      end>
  end
  object PgDelPatientProc: TFDStoredProc
    Connection = PgConnection
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    SchemaName = 'db_test1'
    StoredProcName = 'DelPatient'
    Left = 611
    Top = 19
    ParamData = <
      item
        Name = 'i_id'
        DataType = ftInteger
        FDDataType = dtUInt32
        ParamType = ptInput
      end>
  end
end
