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
{     В версии 1.1 функционал реализован через          }
{     хранимые процедуры СУБД.                          }
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
    PatientSource: TDataSource;
    CertSource: TDataSource;
    PatientNavigator: TDBNavigator;
    BrowsePanel: TPanel;
    PatGrid: TDBGrid;
    CertGrid: TDBGrid;
    BrowseSplitter: TSplitter;
    ChildActions: TActionList;
    SearchAction: TAction;
    PatientPanel: TPanel;
    CertPanel: TPanel;
    PgSearchProc: TFDStoredProc;
    PgPatientProc: TFDStoredProc;
    PgCertProc: TFDStoredProc;
    PgPatientProcid: TIntegerField;
    PgPatientProcsurname: TWideStringField;
    PgPatientProcFirstname: TWideStringField;
    PgPatientProcMiddlename: TWideStringField;
    PgPatientProcBirthdate: TDateField;
    PgPatientProcCreated: TDateField;
    PgCertProcid: TIntegerField;
    PgCertProcid_patient: TIntegerField;
    PgCertProcName: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure SearchActionExecute(Sender: TObject);
    procedure PgConnectionError(ASender, AInitiator: TObject;
      var AException: Exception);
    procedure PgCertProcBeforeRefresh(DataSet: TDataSet);
    procedure PgCertProcBeforeOpen(DataSet: TDataSet);
    procedure PgPatientProcAfterScroll(DataSet: TDataSet);
  private
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    SearchFrame: TSearchFrame;                          // Базовый фрейм поиска
    procedure DoSearch(var ADoExec: Boolean); virtual;  // Реализация поиска в СУБД
  public
    procedure BringToFront(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
  end;

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
  Входные параметры:
    ADoExec - определяет необходимость выполнения хранимой процедуры
  Результат: переключение master-источника данных на результаты поиска и обратно
-------------------------------------------------------------------------------}
procedure TChildForm.DoSearch(var ADoExec: Boolean);
var
  p: TFDParam;
  s: string;
begin
  s := Trim(SearchFrame.ValueEdit.Text);
  // поиск по значению
  if not PgSearchProc.Prepared then begin
    PgSearchProc.Prepare;
  end;
  p := PgSearchProc.Params.FindParam('i_surname');
  if p <> nil then begin
    if s <> '' then begin
      p.AsString := s;
    end else begin
      p.Clear;
    end;
    if not ADoExec then begin
      ADoExec := True;
    end;
  end;

  if ADoExec then begin
    if not PgSearchProc.Active then begin
      PgSearchProc.OpenOrExecute
    end else begin
      PgSearchProc.Refresh
    end;
      PatientSource.DataSet := PgSearchProc;
  end else begin
    // очистка поиска
    PatientSource.DataSet := PgPatientProc;
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
      PgPatientProc.OpenOrExecute;
    except on E: Exception do begin
      // write to log ...
      IsSuccess := False;
      ShowMessage('Ошибка доступа к таблице:'#10 + E.Message);
      end;
    end;
  end;

  if IsSuccess then begin
    try
      PgCertProc.Prepare;
      PgCertProc.OpenOrExecute;
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
procedure TChildForm.PgCertProcBeforeOpen(DataSet: TDataSet);
begin
  PgCertProcBeforeRefresh(DataSet);
end;

{-------------------------------------------------------------------------------
  Процедура: TChildForm.PgCertProcBeforeRefresh
  Автор: Cyber-GY
  Входные параметры: DataSet: TDataSet
  Результат: обновление ключа управляющего набора данных
-------------------------------------------------------------------------------}
procedure TChildForm.PgCertProcBeforeRefresh(DataSet: TDataSet);
var
  p: TFDParam;
begin
  p := PgCertProc.FindParam('i_id_patient');
  if p <> nil then begin
    p.AsInteger := PgPatientProcid.AsInteger;
  end;
end;

{-------------------------------------------------------------------------------
  Процедура: TChildForm.PgConnectionError
  Автор: Cyber-GY
  Входные параметры: ASender, AInitiator: TObject; var AException: Exception
  Результат: обработка ошибок подключения
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
  Close;
end;

{-------------------------------------------------------------------------------
  Процедура: TChildForm.PgPatientProcAfterScroll
  Автор: Cyber-GY
  Входные параметры: DataSet: TDataSet
  Результат: синхронизация подконтрольного набора данных
-------------------------------------------------------------------------------}
procedure TChildForm.PgPatientProcAfterScroll(DataSet: TDataSet);
begin
  if PgCertProc.Active then begin
    PgCertProc.Refresh;
  end;
end;

procedure TChildForm.SearchActionExecute(Sender: TObject);
var
  DoExecSearch: Boolean;
begin
  DoExecSearch := TrimRight(SearchFrame.ValueEdit.Text) > '';
  // выполнить поисковый запрос, если введено значение для поиска
  DoSearch(DoExecSearch);
end;

end.
