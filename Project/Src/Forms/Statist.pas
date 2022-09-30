unit Statist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Child, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, System.Actions, Vcl.ActnList,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TStatForm = class(TChildForm)
    DateSeachPanel: TPanel;
    DateEdit1: TDateTimePicker;
    DateEdit2: TDateTimePicker;
    DateSearchGroup: TRadioGroup;
    procedure DateEdit1Change(Sender: TObject);
    procedure DateEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoSearch; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  StatForm: TStatForm;

implementation

{$R *.dfm}

const
  EmptyDateFormat = ' ';
  ShortDateFormat = 'dd.MM.yyyy';

constructor TStatForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DateEdit1.Date := Now();
  DateEdit2.Date := Now();
end;

procedure TStatForm.DateEdit1Change(Sender: TObject);
begin
  if TDateTimePicker(Sender).Format = EmptyDateFormat then begin
    TDateTimePicker(Sender).Format := ShortDateFormat;
  end;    
end;

procedure TStatForm.DateEdit1Click(Sender: TObject);
begin
  DateEdit1Change(Sender);
end;

procedure TStatForm.DateEdit1Exit(Sender: TObject);
begin
  if (Sender = DateEdit1) and (DateEdit2.Format = EmptyDateFormat) 
    and (DateEdit1.Format <> EmptyDateFormat) then
  begin
    DateEdit2.Format := ShortDateFormat;
    DateEdit2.Date := DateEdit1.Date;
  end else 
  if (Sender = DateEdit2) and (DateEdit1.Format = EmptyDateFormat) 
    and (DateEdit2.Format <> EmptyDateFormat) then
  begin
    DateEdit1.Format := ShortDateFormat;
    DateEdit1.Date := DateEdit2.Date;
  end;
end;

procedure TStatForm.DateEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    Chr(VK_RETURN): SearchAction.Execute;
    Chr(VK_ESCAPE): begin
      DateEdit1.Format := EmptyDateFormat;
      DateEdit2.Format := EmptyDateFormat;
      SearchAction.Execute;
    end;
  end;
end;

procedure TStatForm.DoSearch;
const
  ConditionStr = 'surname LIKE ''%'' ||:p_surname|| ''%''';
  ConditionDate1 = 'birthdate BETWEEN :p_date1 AND :p_date2';
  ConditionDate2 = 'created BETWEEN :p_date1 AND :p_date2';

var
  s: string;
  p: TFDParam;
begin
  // очистка
  while PgSearchQuery.SQL.Count > 1 do begin
    PgSearchQuery.SQL.Delete(1);
  end;
  PgSearchQuery.Params.Clear;

  if DateEdit1.Format = EmptyDateFormat then begin
    // поиск только по фамилии
    PgSearchQuery.Params.Add('p_surname', ftString, 200, ptInput);
    PgSearchQuery.SQL.Add(ConditionStr);
    inherited DoSearch;
  end else begin
    s := Trim(SearchFrame.ValueEdit.Text);
    if s <> '' then begin
      // поиск по фамилии и...
      p := PgSearchQuery.Params.Add('p_surname', ftString, 200, ptInput);
      p.AsString := s;
      PgSearchQuery.SQL.Add(ConditionStr);
      PgSearchQuery.SQL.Add(' AND ');
    end;

    // по датам
    p := PgSearchQuery.Params.Add('p_date1', Data.DB.ftDate, -1, ptInput);
    p.AsDate := DateEdit1.Date;
    p := PgSearchQuery.Params.Add('p_date2', Data.DB.ftDate, -1, ptInput);
    p.AsDate := DateEdit2.Date;
    case DateSearchGroup.ItemIndex of
      0: PgSearchQuery.SQL.Add(ConditionDate1);
      1: PgSearchQuery.SQL.Add(ConditionDate2);
    end;

    if not PgSearchQuery.Active then begin
      PgSearchQuery.OpenOrExecute
    end else begin
      PgSearchQuery.Refresh
    end;
    PatientSource.DataSet := PgSearchQuery;
  end;
end;

end.
