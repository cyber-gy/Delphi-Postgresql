object Pg: TPg
  OldCreateOrder = False
  Height = 220
  Width = 283
  object SessManager: TFDManager
    ConnectionDefFileName = 
      '\\VBoxSvr\Projects\Recruiting\Komtek\Project\Out\bin\pg_connect.' +
      'ini'
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 48
    Top = 16
  end
  object pgConnection: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Server=localhost'
      'ExtendedMetadata=True'
      'Database=postgres'
      'Pooled=True'
      'MetaCurSchema=db_test1'
      'ConnectionDef=PgParams'
      'MonitorBy=FlatFile')
    LoginPrompt = False
    Left = 48
    Top = 88
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
    FileName = '\\VBoxSvr\Projects\Recruiting\Komtek\Project\Out\bin\trace1.txt'
    ShowTraces = False
    Left = 168
    Top = 16
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'C:\Program Files (x86)\PostgreSQL\12'
    Left = 168
    Top = 80
  end
end
