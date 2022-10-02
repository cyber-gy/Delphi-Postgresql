{*******************************************************}
{                                                       }
{       АРМ оператора - наследник базовой               }
{         дочерней формы.                               }
{                                                       }
{       Copyright (C) 2022 Cyber-GY                     }
{                                                       }
{                * * *                                  }
{                                                       }
{      Имеет возможностm редактировать данные           }
{                                                       }
{*******************************************************}

unit Oper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Child, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, System.Actions, Vcl.ActnList, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, FireDAC.Phys.PG, FireDAC.Phys.PGDef;

type
  TOperForm = class(TChildForm)
    PatNewButton: TButton;
    PatDelButton: TButton;
    PatPostButton: TButton;
    PatCancelButton: TButton;
    PatSurnameEdit: TDBEdit;
    PatFirstnameEdit: TDBEdit;
    PatMiddlenameEdit: TDBEdit;
    CertNameEdit: TDBEdit;
    CertNoteEdit: TDBMemo;
    CertNewButton: TButton;
    CertDelButton: TButton;
    CertPostButton: TButton;
    CertCancelButton: TButton;
    PgCertQuerynotes: TWideStringField;
    PatSurnameLabel: TLabel;
    PatFirstnameLabel: TLabel;
    PatMiddlenameLabel: TLabel;
    PatBdLabel: TLabel;
    PatRegLabel: TLabel;
    PatEditGridPanel: TGridPanel;
    CertEditGridPanel: TGridPanel;
    CertNavigator: TDBNavigator;
    PatBirthdatePanel: TPanel;
    PatRegPanel: TPanel;
    SearchTypeGroup: TRadioGroup;
    TypeSearchPanel: TPanel;
    CertGridSplitter: TSplitter;
    procedure PatButtonClick(Sender: TObject);
    procedure CertButtonClick(Sender: TObject);
    procedure PatientSourceStateChange(Sender: TObject);
    procedure CertSourceStateChange(Sender: TObject);
    procedure PgCertQueryBeforePost(DataSet: TDataSet);
    procedure PatEditGridPanelClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoSearch; override; // переопределение алгоритма поиска
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  OperForm: TOperForm;

implementation

{$R *.dfm}

uses CgyDtPicker;

procedure TOperForm.CertButtonClick(Sender: TObject);
begin
  if Sender is TButton then begin
    CertNavigator.BtnClick(TNavigateBtn(TComponent(Sender).Tag));
  end;
end;

{-------------------------------------------------------------------------------
  Процедура: TOperForm.CertSourceStateChange
  Автор: Cyber-GY
  Входные параметры: Sender: TObject
  Результат: меняет состояние кнопок операций с данными о справках
-------------------------------------------------------------------------------}
procedure TOperForm.CertSourceStateChange(Sender: TObject);
begin
  CertNewButton.Enabled := CertNavigator.Controls[CertNewButton.Tag].Enabled;
  CertDelButton.Enabled := CertNavigator.Controls[CertDelButton.Tag].Enabled;
  CertPostButton.Enabled := CertNavigator.Controls[CertPostButton.Tag].Enabled;
  CertCancelButton.Enabled := CertNavigator.Controls[CertCancelButton.Tag].Enabled;
end;

constructor TOperForm.Create(AOwner: TComponent);

  procedure NewDBPicker(const AFieldName: string; AParent: TWinControl);
  begin
    with TDBDateTimePicker.Create(Self) do begin
      DataSource := PatientSource;
      DataField := AFieldName;
      AlignWithMargins := True;
      Align := alClient;
      Parent := AParent;
    end;
  end;

begin
  inherited Create(AOwner);
  PatNewButton.Tag := NativeInt(Vcl.DBCtrls.nbInsert);
  PatDelButton.Tag := NativeInt(Vcl.DBCtrls.nbDelete);
  PatPostButton.Tag := NativeInt(Vcl.DBCtrls.nbPost);
  PatCancelButton.Tag := NativeInt(Vcl.DBCtrls.nbCancel);

  CertNewButton.Tag := NativeInt(Vcl.DBCtrls.nbInsert);
  CertDelButton.Tag := NativeInt(Vcl.DBCtrls.nbDelete);
  CertPostButton.Tag := NativeInt(Vcl.DBCtrls.nbPost);
  CertCancelButton.Tag := NativeInt(Vcl.DBCtrls.nbCancel);

  // create custom DBDateTimePicker components
  NewDBPicker(PgPatientQueryBirthdate.FieldName, PatBirthdatePanel);
  NewDBPicker(PgPatientQueryCreated.FieldName, PatRegPanel);
end;

{-------------------------------------------------------------------------------
  Процедура: TOperForm.DoSearch
  Автор: Cyber-GY
  Входные параметры: Нет
  Результат: к базовому поиску по фамилии добавлена возможность вывода
             последних 10 записей по дате внесения.
-------------------------------------------------------------------------------}
procedure TOperForm.DoSearch;
const
  ConditionCount = 'ORDER BY created DESC'#10#13'FETCH FIRST 1 ROWS ONLY';
var
  s: string;
  p: TFDParam;
begin
  // очистка условий запроса
  while PgSearchQuery.SQL.Count > 1 do begin
    PgSearchQuery.SQL.Delete(1);
  end;

  case SearchTypeGroup.ItemIndex of
    0: begin
      // поиск только по фамилии
      inherited DoSearch;
    end;
    1: begin
      s := Trim(SearchFrame.ValueEdit.Text);
      p := PgSearchQuery.FindParam('p_surname');
      if s <> '' then begin
        // доп. фильтр по фамилии
        p.AsString := s;
      end else begin
        p.AsString := '%'
      end;
      // выбор последних 10 занесённых с/без фильтра по фамилии
      PgSearchQuery.SQL.Add(ConditionCount);
      PgSearchQuery.OpenOrExecute;
      PatientSource.DataSet := PgSearchQuery;
    end;
  end;
end;

procedure TOperForm.PatButtonClick(Sender: TObject);
begin
  if Sender is TButton then begin
    PatientNavigator.BtnClick(TNavigateBtn(TComponent(Sender).Tag));
  end;
end;

procedure TOperForm.PatEditGridPanelClick(Sender: TObject);
begin
  inherited;

end;

{-------------------------------------------------------------------------------
  Процедура: TOperForm.PatientSourceStateChange
  Автор: Cyber-GY
  Входные параметры: Sender: TObject
  Результат: меняет состояние кнопок операций с данными о пациентах
-------------------------------------------------------------------------------}
procedure TOperForm.PatientSourceStateChange(Sender: TObject);
begin
  PatNewButton.Enabled := PatientNavigator.Controls[PatNewButton.Tag].Enabled;
  PatDelButton.Enabled := PatientNavigator.Controls[PatDelButton.Tag].Enabled;
  PatPostButton.Enabled := PatientNavigator.Controls[PatPostButton.Tag].Enabled;
  PatCancelButton.Enabled := PatientNavigator.Controls[PatCancelButton.Tag].Enabled;
end;

procedure TOperForm.PgCertQueryBeforePost(DataSet: TDataSet);
begin
  if PgCertQueryid_patient.IsNull then begin
    PgCertQueryid_patient.AsInteger := PgPatientQueryid.AsInteger // внешний ключ таблицы
  end;
end;

end.
