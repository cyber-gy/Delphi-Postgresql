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
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink; // компонент для отладки
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;             // указатель на домашнюю директорию
                                                          //  клиента Postgre
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  end;

var
  Pg: TPg;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

const
  IniFileName = 'pg_connect.ini';
  TraceFileName = 'trace1.txt';
  ConnectFileName = 'pg_connect.ini';
  FDVendorHomeKeyName = 'PgClientHome';

  DefPgSettings = 'Database=postgres'#10 +
    'Server=localhost'#10 +
    'User_Name=postgres'#10 +
    'Password='#10 +
    'Protocol=TCPIP'#10 +
    'DriverID=PG'#10 +
    'Pooled=True';

  DefSettings = '[pg_connect.ini]'#10 +
    'Encoding=UTF8'#10 +

    '[PgParams]'#10 +
    DefPgSettings + #10 +
    ';MonitorBy=FlatFile'#10 +

    '[FDParams]'#10 +
    'PgClientHome=C:\Program Files (x86)\PostgreSQL\12';

{ TPg }

procedure TPg.DataModuleCreate(Sender: TObject);
var
  IsFileExists: Boolean;
  FileName: string;
  ini: TStringList;
  i: Integer;
begin
  // Путь к файлу отладки
  FileName := ExtractFilePath(ParamStr(0));
  FDMoniFlatFileClientLink1.FileName := FileName + TraceFileName;
  SessManager.ConnectionDefFileName := FileName + ConnectFileName;

  // Проверим настройку пути к драйверу клиента PG в конф. файле
  IsFileExists := True;
  FileName := FileName + IniFileName;
  ini := TStringList.Create();
  try
    if not FileExists(FileName) then begin
      // Try to create ini
      try
        ini.Text := DefSettings;
        ini.SaveToFile(FileName, TEncoding.UTF8);
      except on E: Exception do
        IsFileExists := False;
      end;
    end;

    if IsFileExists then begin
      ini.Clear;
      ini.LoadFromFile(FileName);
      i := ini.IndexOfName(FDVendorHomeKeyName);
      if i >= 0 then begin
        FDPhysPgDriverLink1.VendorHome := ini.ValueFromIndex[i];
      end;
      // активация отладочного лога сеанса СУБД
      FDMoniFlatFileClientLink1.Tracing := ini.IndexOfName('MonitorBy') >=0;
    end else begin
      // Set default settings
      ini.Text := DefPgSettings;
      SessManager.AddConnectionDef('PgParams', 'PG', ini);
      FDPhysPgDriverLink1.VendorHome := 'C:\Program Files (x86)\PostgreSQL\12';
    end;
  finally
    ini.Free;
  end;
end;

end.
