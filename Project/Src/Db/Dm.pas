unit Dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Moni.Base, FireDAC.Moni.FlatFile, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TPg = class(TDataModule)
    SessManager: TFDManager;
    pgConnection: TFDConnection;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Connect();
  end;

var
  Pg: TPg;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TPg }

procedure TPg.Connect;
begin
  with pgConnection.Params do begin
//    Clear;
//    Add('DriverName=PG');
//    Add('Database=c:\test.sdb');
    Add('MonitorBy=FlatFile');
  end;
  pgConnection.Connected := True;
end;

end.
