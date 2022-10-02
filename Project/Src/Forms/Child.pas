{*******************************************************}
{                                                       }
{       Базовая  дочерняя форма приложения              }
{                                                       }
{       Copyright (C) 2022 Cyber-GY                     }
{                                                       }
{                      * * *                            }
{                                                       }
{     Получает отдельную сессию подключения к СУБД      }
{     из пула соединений дата-модуля Db.                }
{     Имеет базовый набор компонент для чтения,         }
{     записи и поиска по таблицам СУБД.                 }
{     В текущей версии функционал реализован через      }
{     прямой доступ к ткблицам СУБД.                    }
{                                                       }
{*******************************************************}

unit Child;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, System.Actions, Vcl.ActnList,
  Search, FireDAC.Phys.PG, FireDAC.Phys.PGDef;

type
  TChildForm = class(TForm)
    SearchPanel: TPanel;
    PgConnection: TFDConnection;
    PgPatientQuery: TFDQuery;
    PgCertQuery: TFDQuery;
    PatientSource: TDataSource;
    CertSource: TDataSource;
    PatientNavigator: TDBNavigator;
    BrowsePanel: TPanel;
    PatGrid: TDBGrid;
    CertGrid: TDBGrid;
    BrowseSplitter: TSplitter;
    PgPatientQueryid: TIntegerField;
    PgPatientQuerysurname: TWideStringField;
    PgPatientQueryFirstname: TWideStringField;
    PgPatientQueryMiddlename: TWideStringField;
    PgPatientQueryBirthdate: TDateField;
    PgPatientQueryCreated: TDateField;
    PgCertQueryid: TIntegerField;
    PgCertQueryid_patient: TIntegerField;
    PgCertQueryName: TWideStringField;
    PgSearchQuery: TFDQuery;
    PgSearchQueryid: TIntegerField;
    PgSearchQuerysurname: TWideStringField;
    PgSearchQueryFirstname: TWideStringField;
    PgSearchQueryMiddlename: TWideStringField;
    PgSearchQueryBirthdate: TDateField;
    PgSearchQueryCreated: TDateField;
    ChildActions: TActionList;
    SearchAction: TAction;
    PatientPanel: TPanel;
    CertPanel: TPanel;
    procedure FormShow(Sender: TObject);
    procedure SearchActionExecute(Sender: TObject);
    procedure PgConnectionError(ASender, AInitiator: TObject;
      var AException: Exception);
  private
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    SearchFrame: TSearchFrame;                // Базовый фрейм поиска
    procedure DoSearch; virtual;              // Реализация поиска в СУБД
  public
    procedure BringToFront(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
  end;

var
  ChildForm: TChildForm;

implementation

{$R *.dfm}

uses Dm;

{ TChildForm }

procedure TChildForm.BringToFront(Sender: TObject);
begin
  Show
end;

constructor TChildForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnClose := FormClose;

  // Создание фрейма поиска
  SearchFrame := TSearchFrame.Create(Self);
  SearchFrame.Parent := SearchPanel;
  SearchFrame.Align := alClient;
  SearchFrame.Init('По фамилии:', SearchAction);
end;

{-------------------------------------------------------------------------------
  Процедура: TChildForm.DoSearch
  Описание: базовый поиск по фамилии
  Автор: Cyber-GY
  Входные параметры: Нет
  Результат: переключение master-источника данных на результаты поиска и обратно
-------------------------------------------------------------------------------}
procedure TChildForm.DoSearch;
var
  p: TFDParam;
  s: string;
begin
  s := Trim(SearchFrame.ValueEdit.Text);
  if s <> '' then begin
    // поиск по значению
    p := PgSearchQuery.Params.FindParam('p_surname');
    if p <> nil then begin
      p.AsString := s;
      if not PgSearchQuery.Active then begin
        PgSearchQuery.OpenOrExecute
      end else begin
        PgSearchQuery.Refresh
      end;
      PatientSource.DataSet := PgSearchQuery;
    end;
  end else begin
    // очистка поиска
    PatientSource.DataSet := PgPatientQuery;
  end;
end;

procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree
end;

{-------------------------------------------------------------------------------
  Процедура: TChildForm.FormShow
  Автор: Cyber-GY
  Входные параметры: Sender: TObject
  Результат: Установка подключения к базе, запросы данных
-------------------------------------------------------------------------------}
procedure TChildForm.FormShow(Sender: TObject);
var
  IsSuccess: Boolean;
begin
  IsSuccess := False;
  try
    PgConnection.Open();
    IsSuccess := PgConnection.Connected;
  except on E: Exception do
    // write to log ...
    ShowMessage('Ошибка подключения к СУБД:'#10 + E.Message);
  end;

  if IsSuccess then begin
    try
      PgPatientQuery.OpenOrExecute;
    except on E: Exception do begin
      // write to log ...
      IsSuccess := False;
      ShowMessage('Ошибка доступа к таблице:'#10 + E.Message);
      end;
    end;
  end;

  if IsSuccess then begin
    try
      PgCertQuery.OpenOrExecute;
    except on E: Exception do
      // write to log ...
      ShowMessage('Ошибка доступа к таблице:'#10 + E.Message);
    end;
  end;
end;

{-------------------------------------------------------------------------------
  Процедура: TChildForm.PgConnectionError
  Описание: глобальная обработка ошибок работы с СУБД
  Автор: Cyber-GY
  Входные параметры:
    ASender - TFDConnection object
    AInitiator - объект-источник исключительной ситуации
    AException - объект сведений об исключительной ситуации
  Результат: регистрация ошибок работы с СУБД
-------------------------------------------------------------------------------}
procedure TChildForm.PgConnectionError(ASender, AInitiator: TObject;
  var AException: Exception);
var
  s: string;
begin
  s := 'Объект: ';
  if AInitiator <> nil then begin
    if AInitiator is TComponent then begin
      s := s + TComponent(AInitiator).Name + ' (' + AInitiator.ClassName + ')';
    end else begin
      s := s + AInitiator.ClassName;
    end;
  end;
  // write to log ...
  ShowMessage('Ошибка работы с СУБД:'#10 + AException.Message + #10#10 + s);
  // Close connection?
end;

procedure TChildForm.SearchActionExecute(Sender: TObject);
begin
  DoSearch;
end;

end.
