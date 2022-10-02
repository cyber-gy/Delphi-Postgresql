object Pg: TPg
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 220
  Width = 283
  object SessManager: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 48
    Top = 16
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
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
