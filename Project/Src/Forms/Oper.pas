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
    PatSurnameEdit: TEdit;
    PatFirstnameEdit: TEdit;
    PatMiddlenameEdit: TEdit;
    CertNameEdit: TEdit;
    CertNoteEdit: TMemo;
    CertNewButton: TButton;
    CertDelButton: TButton;
    CertPostButton: TButton;
    CertCancelButton: TButton;
    PatSurnameLabel: TLabel;
    PatFirstnameLabel: TLabel;
    PatMiddlenameLabel: TLabel;
    PatBdLabel: TLabel;
    PatRegLabel: TLabel;
    PatEditGridPanel: TGridPanel;
    CertEditGridPanel: TGridPanel;
    PatBirthdatePanel: TPanel;
    PatRegPanel: TPanel;
    SearchTypeGroup: TRadioGroup;
    TypeSearchPanel: TPanel;
    CertGridSplitter: TSplitter;
    PgCertProcnotes: TWideStringField;
    PgSetCertProc: TFDStoredProc;
    PgDelCertProc: TFDStoredProc;
    PgSetPatientProc: TFDStoredProc;
    PgDelPatientProc: TFDStoredProc;
    procedure CertChangeButtonClick(Sender: TObject);
    procedure CertDelButtonClick(Sender: TObject);
    procedure CertCancelButtonClick(Sender: TObject);
    procedure PatChangeButtonClick(Sender: TObject);
    procedure PatDelButtonClick(Sender: TObject);
    procedure PatCancelButtonClick(Sender: TObject);
    procedure PgPatientProcAfterScroll(DataSet: TDataSet);
    procedure CertSourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    PatBirthdateEdit: TDateTimePicker;
    PatCreatedEdit: TDateTimePicker;
  protected
    procedure DoSearch(var ADoExec: Boolean); override; // переопределение алгоритма поиска
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses CgyDtPicker;

{$REGION ' Методы по изменению данных справок '}
procedure TOperForm.CertCancelButtonClick(Sender: TObject);
begin
  CertNameEdit.Text := '';
  CertNoteEdit.Clear;
end;

procedure TOperForm.CertDelButtonClick(Sender: TObject);
begin
  with PgDelCertProc do begin
    ParamByName('i_id').AsInteger := PgCertProcid.AsInteger;
    try
      Execute;
    except on E: Exception do
      ShowMessage('Ошибка удаления справки:'#10 + E.Message);
    end;
  end;
  PgCertProc.Refresh;
end;

procedure TOperForm.CertSourceDataChange(Sender: TObject; Field: TField);
begin
  if PgCertProc.Active and not PgCertProc.IsEmpty then begin
    CertNameEdit.Text := PgCertProcName.AsWideString;
    CertNoteEdit.Text := PgCertProcnotes.AsWideString;
  end else begin
    CertCancelButton.Click;
  end;
end;

procedure TOperForm.CertChangeButtonClick(Sender: TObject);
var
  IsValidSender: Boolean;
begin
  IsValidSender := True;
  //PgSetCertProc.Prepare;
  with PgSetCertProc do begin
    if Sender = CertNewButton then begin
      ParamByName('i_id').Clear;
    end else
    if Sender = CertPostButton then begin
      ParamByName('i_id').AsInteger := PgPatientProcid.AsInteger;
    end else begin
      IsValidSender := False;
    end;

    if IsValidSender then begin
      ParamByName('i_id').Clear;
      ParamByName('i_id_patient').AsInteger := PgPatientProcid.AsInteger;
      ParamByName('i_name').AsWideString := CertNameEdit.Text;
      ParamByName('i_notes').AsWideString := CertNoteEdit.text;
      try
        Execute;
      except on E: Exception do
        ShowMessage('Ошибка добавления справки:'#10 + E.Message);
      end;
    end;
  end;
  PgCertProc.Refresh;
end;
{$ENDREGION}

constructor TOperForm.Create(AOwner: TComponent);

  procedure NewDtPicker(const AFieldName: string; var AComponent: TDateTimePicker;
    AParent: TWinControl);
  begin
    AComponent := TNullableDateTimePicker.Create(Self);
    with AComponent do begin
      //DataSource := PatientSource;
      //DataField := AFieldName;
      AlignWithMargins := True;
      Align := alClient;
      Parent := AParent;
    end;
  end;

begin
  inherited Create(AOwner);

  // create custom DateTimePicker components
  NewDtPicker(PgPatientProcBirthdate.FieldName, PatBirthdateEdit, PatBirthdatePanel);
  NewDtPicker(PgPatientProcCreated.FieldName, PatCreatedEdit, PatRegPanel);
end;

{-------------------------------------------------------------------------------
  Процедура: TOperForm.DoSearch
  Автор: Cyber-GY
  Входные параметры:
    ADoExec - определяет необходимость выполнения хранимой процедуры
  Результат: к базовому поиску по фамилии добавлена возможность вывода
             последних 10 записей по дате внесения.
-------------------------------------------------------------------------------}
procedure TOperForm.DoSearch(var ADoExec: Boolean);
const
  SnAndBdSearchProcName = 'PatientsSearchBySurnameBirthdate';
  SnSearchLast10ByProcName = 'PatientsSearchBySurnameLastCreated';
begin
  case SearchTypeGroup.ItemIndex of
    0: begin
      // поиск всех по фамилии
      if PgSearchProc.StoredProcName <> SnAndBdSearchProcName then begin
        PgSearchProc.StoredProcName := SnAndBdSearchProcName;
      end;
    end;
    1: begin
      // поиск последних 10 по фамилии
      if PgSearchProc.StoredProcName <> SnSearchLast10ByProcName then begin
        PgSearchProc.StoredProcName := SnSearchLast10ByProcName;
      end;
      if not ADoExec then begin
        ADoExec := True;
      end;
    end;
  end;
  inherited DoSearch(ADoExec);
end;

{$REGION ' Методы по изменению данных пациентов '}
procedure TOperForm.PatCancelButtonClick(Sender: TObject);
begin
  PatSurnameEdit.Text := '';
  PatFirstnameEdit.Text := '';
  PatMiddlenameEdit.Text := '';
  (PatBirthdateEdit as TNullableDateTimePicker).Clear;
  (PatCreatedEdit as TNullableDateTimePicker).Clear;
end;

procedure TOperForm.PatChangeButtonClick(Sender: TObject);
var
  IsValidSender: Boolean;
begin
  IsValidSender := True;
  with PgSetPatientProc do begin
    if Sender = PatNewButton then begin
      ParamByName('i_id').Clear;
    end else
    if Sender = PatPostButton then begin
      ParamByName('i_id').AsInteger := PgPatientProcid.AsInteger;
    end else begin
      IsValidSender := False;
    end;

    if IsValidSender then begin
      ParamByName('i_surname').AsWideString := PatSurnameEdit.Text;
      ParamByName('i_firstname').AsWideString := PatFirstnameEdit.Text;
      ParamByName('i_middlename').AsWideString := PatMiddlenameEdit.Text;
      ParamByName('i_birthdate').AsDate := PatBirthdateEdit.Date;
      ParamByName('i_created').AsDate := PatCreatedEdit.Date;
      try
        Execute;
      except on E: Exception do
        ShowMessage('Ошибка добавления пациента:'#10 + E.Message);
      end;
    end;
  end;
  PgPatientProc.Refresh;
end;

procedure TOperForm.PatDelButtonClick(Sender: TObject);
begin
  with PgDelPatientProc do begin
    ParamByName('i_id').AsInteger := PgPatientProcid.AsInteger;
    try
      Execute;
    except on E: Exception do
      ShowMessage('Ошибка удаления пациента:'#10 + E.Message);
    end;
  end;
  PgPatientProc.Refresh;
end;

procedure TOperForm.PgPatientProcAfterScroll(DataSet: TDataSet);
begin
  if DataSet.Active and not DataSet.IsEmpty then begin
    PatSurnameEdit.Text := PgPatientProcSurName.AsWideString;
    PatFirstnameEdit.Text := PgPatientProcFirstName.AsWideString;
    PatMiddlenameEdit.Text := PgPatientProcMiddleName.AsWideString;
    PatBirthDateEdit.Date := PgPatientProcBirthdate.AsDateTime;
    PatCreatedEdit.Date := PgPatientProcCreated.AsDateTime;
  end else begin
    PatCancelButton.Click;
  end;
  inherited;
end;
{$ENDREGION}

end.
