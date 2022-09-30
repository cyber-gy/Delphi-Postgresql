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
    Left = 99
    Top = 27
  end
  object PgPatientQuery: TFDQuery
    Connection = PgConnection
    SQL.Strings = (
      'SELECT * FROM db_test1.patients')
    Left = 475
    Top = 27
    object PgPatientQueryid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object PgPatientQuerysurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      DisplayWidth = 20
      FieldName = 'surname'
      Size = 200
    end
    object PgPatientQueryFirstname: TWideStringField
      DisplayLabel = #1048#1084#1103
      DisplayWidth = 20
      FieldName = 'Firstname'
      Size = 200
    end
    object PgPatientQueryMiddlename: TWideStringField
      DisplayLabel = #1054#1090#1095#1077#1089#1090#1074#1086
      DisplayWidth = 20
      FieldName = 'Middlename'
      Size = 200
    end
    object PgPatientQueryBirthdate: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      FieldName = 'Birthdate'
    end
    object PgPatientQueryCreated: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1079#1072#1085#1077#1089#1077#1085#1080#1103
      FieldName = 'Created'
    end
  end
  object PgCertQuery: TFDQuery
    MasterSource = PatientSource
    MasterFields = 'id'
    DetailFields = 'id_patient'
    Connection = PgConnection
    SQL.Strings = (
      'SELECT * FROM db_test1.certificates WHERE id_patient=:id')
    Left = 555
    Top = 27
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
        Value = Null
      end>
    object PgCertQueryid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object PgCertQueryid_patient: TIntegerField
      DisplayLabel = 'Id '#1087#1072#1094#1080#1077#1085#1090#1072
      FieldName = 'id_patient'
      Visible = False
    end
    object PgCertQueryName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 200
    end
  end
  object PatientSource: TDataSource
    DataSet = PgPatientQuery
    Left = 675
    Top = 27
  end
  object CertSource: TDataSource
    DataSet = PgCertQuery
    Left = 747
    Top = 27
  end
  object PgSearchQuery: TFDQuery
    Connection = PgConnection
    SQL.Strings = (
      
        'SELECT * FROM db_test1.patients WHERE surname LIKE '#39'%'#39' ||:p_surn' +
        'ame|| '#39'%'#39)
    Left = 347
    Top = 27
    ParamData = <
      item
        Name = 'P_SURNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object PgSearchQueryid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object PgSearchQuerysurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      DisplayWidth = 20
      FieldName = 'surname'
      Size = 200
    end
    object PgSearchQueryFirstname: TWideStringField
      DisplayLabel = #1048#1084#1103
      DisplayWidth = 20
      FieldName = 'Firstname'
      Size = 200
    end
    object PgSearchQueryMiddlename: TWideStringField
      DisplayLabel = #1054#1090#1095#1077#1089#1090#1074#1086
      DisplayWidth = 20
      FieldName = 'Middlename'
      Size = 200
    end
    object PgSearchQueryBirthdate: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      FieldName = 'Birthdate'
    end
    object PgSearchQueryCreated: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1079#1072#1085#1077#1089#1077#1085#1080#1103
      FieldName = 'Created'
    end
  end
  object ChildActions: TActionList
    Left = 219
    Top = 27
    object SearchAction: TAction
      Caption = #1048#1089#1082#1072#1090#1100
      OnExecute = SearchActionExecute
    end
  end
end
