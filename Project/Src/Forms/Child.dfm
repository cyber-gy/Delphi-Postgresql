object ChildForm: TChildForm
  Left = 0
  Top = 0
  Caption = 'ChildForm'
  ClientHeight = 405
  ClientWidth = 850
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object SearchPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 844
    Height = 81
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
  end
  object PatientNavigator: TDBNavigator
    AlignWithMargins = True
    Left = 3
    Top = 368
    Width = 844
    Height = 34
    DataSource = PatientSource
    Align = alBottom
    TabOrder = 1
  end
  object BrowsePanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 90
    Width = 844
    Height = 272
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object BrowseSplitter: TSplitter
      Left = 606
      Top = 2
      Width = 6
      Height = 268
      Align = alRight
      ExplicitLeft = 594
      ExplicitTop = 0
    end
    object PatientPanel: TPanel
      Left = 2
      Top = 2
      Width = 604
      Height = 268
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object PatGrid: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 598
        Height = 262
        Align = alClient
        DataSource = PatientSource
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'surname'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Firstname'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Middlename'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Birthdate'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Created'
            Visible = True
          end>
      end
    end
    object CertPanel: TPanel
      Left = 612
      Top = 2
      Width = 230
      Height = 268
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object CertGrid: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 224
        Height = 262
        Align = alClient
        DataSource = CertSource
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'id_patient'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'Name'
            Visible = True
          end>
      end
    end
  end
  object PgConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=PgParams')
    OnError = PgConnectionError
    Left = 99
    Top = 27
  end
  object PatientSource: TDataSource
    DataSet = PgPatientProc
    Left = 675
    Top = 27
  end
  object CertSource: TDataSource
    DataSet = PgCertProc
    Left = 747
    Top = 27
  end
  object ChildActions: TActionList
    Left = 219
    Top = 27
    object SearchAction: TAction
      Caption = #1048#1089#1082#1072#1090#1100
      OnExecute = SearchActionExecute
    end
  end
  object PgSearchProc: TFDStoredProc
    Connection = PgConnection
    SchemaName = 'db_test1'
    StoredProcName = 'PatientsSearchBySurnameBirthdate'
    Left = 368
    Top = 24
    object PgSearchProcid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object PgSearchProcsurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      DisplayWidth = 20
      FieldName = 'surname'
      Size = 200
    end
    object PgSearchProcFirstname: TWideStringField
      DisplayLabel = #1048#1084#1103
      DisplayWidth = 20
      FieldName = 'Firstname'
      Size = 200
    end
    object PgSearchProcMiddlename: TWideStringField
      DisplayLabel = #1054#1090#1095#1077#1089#1090#1074#1086
      DisplayWidth = 20
      FieldName = 'Middlename'
      Size = 200
    end
    object PgSearchProcBirthdate: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      FieldName = 'Birthdate'
    end
    object PgSearchProcCreated: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1079#1072#1085#1077#1089#1077#1085#1080#1103
      FieldName = 'Created'
    end
  end
  object PgPatientProc: TFDStoredProc
    AfterScroll = PgPatientProcAfterScroll
    Connection = PgConnection
    SchemaName = 'db_test1'
    StoredProcName = 'GetPatientsAll'
    Left = 464
    Top = 24
    object PgPatientProcid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object PgPatientProcsurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      DisplayWidth = 20
      FieldName = 'surname'
      Size = 200
    end
    object PgPatientProcFirstname: TWideStringField
      DisplayLabel = #1048#1084#1103
      DisplayWidth = 20
      FieldName = 'Firstname'
      Size = 200
    end
    object PgPatientProcMiddlename: TWideStringField
      DisplayLabel = #1054#1090#1095#1077#1089#1090#1074#1086
      DisplayWidth = 20
      FieldName = 'Middlename'
      Size = 200
    end
    object PgPatientProcBirthdate: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      FieldName = 'Birthdate'
    end
    object PgPatientProcCreated: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1079#1072#1085#1077#1089#1077#1085#1080#1103
      FieldName = 'Created'
    end
  end
  object PgCertProc: TFDStoredProc
    BeforeOpen = PgCertProcBeforeOpen
    BeforeRefresh = PgCertProcBeforeRefresh
    MasterSource = PatientSource
    MasterFields = 'id'
    Connection = PgConnection
    SchemaName = 'db_test1'
    StoredProcName = 'GetCertificates'
    Left = 547
    Top = 27
    object PgCertProcid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object PgCertProcid_patient: TIntegerField
      DisplayLabel = 'Id '#1087#1072#1094#1080#1077#1085#1090#1072
      FieldName = 'id_patient'
      Visible = False
    end
    object PgCertProcName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 200
    end
  end
end
