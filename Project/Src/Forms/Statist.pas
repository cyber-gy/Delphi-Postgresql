{*******************************************************}
{                                                       }
{       АРМ статиста - наследник базовой                }
{         дочерней формы.                               }
{                                                       }
{       Copyright (C) 2022 Cyber-GY                     }
{                                                       }
{                * * *                                  }
{                                                       }
{      Имеет расширенные возможности поиска             }
{      Не способен модифицировать данные                }
{                                                       }
{*******************************************************}

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
    DateSearchPanel: TPanel;
    DateEdit1: TDateTimePicker;
    DateEdit2: TDateTimePicker;
    DateSearchGroup: TRadioGroup;
    procedure DateEditKeyPress(Sender: TObject; var Key: Char);
    procedure DateEditExit(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoSearch(var ADoExec: Boolean); override; // переопределение алгоритма поиска
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses
  CgyDtPicker;

constructor TStatForm.Create(AOwner: TComponent);

  procedure SubstControl(var AControl: TDateTimePicker);
  var
    tmp: TNullableDateTimePicker;
  begin
    tmp := TNullableDateTimePicker.Create(Self);
    with tmp do begin
      Parent := AControl.Parent;
      AlignWithMargins := AControl.AlignWithMargins;
      Left := AControl.Left;
      Top := AControl.Top;
      Width := AControl.Width;
      Height := AControl.Height;
      Date := AControl.Date;
      Format := AControl.Format;
      Time := AControl.Time;
      //TabOrder := AControl.TabOrder;
      OnKeyPress := DateEditKeyPress;
      OnExit := DateEditExit;
    end;
    FreeAndNil(AControl);
    AControl := tmp;
  end;

begin
  inherited Create(AOwner);

  DateEdit1.Date := Now();
  DateEdit2.Date := Now();

  SubstControl(DateEdit1);
  SubstControl(DateEdit2);

  DateEdit1.TabOrder := 1;
  DateEdit2.TabOrder := 2;
end;

{$REGION ' Поведение TDateTimePicker '}
procedure TStatForm.DateEditExit(Sender: TObject);
begin
  // Заполняем значением парный компонент "календарь"
  if (Sender = DateEdit1) and (DateEdit2 as TNullableDateTimePicker).IsEmpty
    and not (DateEdit1 as TNullableDateTimePicker).IsEmpty then
  begin
    DateEdit2.Date := DateEdit1.Date;
  end else
  if (Sender = DateEdit2) and (DateEdit1 as TNullableDateTimePicker).IsEmpty
    and not (DateEdit2 as TNullableDateTimePicker).IsEmpty then
  begin
    DateEdit1.Date := DateEdit2.Date;
  end;
end;

procedure TStatForm.DateEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_ESCAPE) then begin
    // Очищаем оба парных компонента
    if (Sender = DateEdit1) and not (DateEdit2 as TNullableDateTimePicker).IsEmpty then begin
      (DateEdit2 as TNullableDateTimePicker).Clear;
    end else
    if (Sender = DateEdit2) and not (DateEdit1 as TNullableDateTimePicker).IsEmpty then begin
      (DateEdit1 as TNullableDateTimePicker).Clear;
    end;
    SearchAction.Execute;
  end;
end;
{$ENDREGION}

{-------------------------------------------------------------------------------
  Процедура: TStatForm.DoSearch
  Автор: Cyber-GY
  Входные параметры: 
    ADoExec - определяет необходимость выполнения хранимой процедуры
  Результат: к базовому поиску по фамилии добавлены возможности фильтра по
             диапазону дат.
-------------------------------------------------------------------------------}
procedure TStatForm.DoSearch(var ADoExec: Boolean);
const
  SnAndBdSearchProcName = 'PatientsSearchBySurnameBirthdate';
  SnAndCrSearchProcName = 'PatientsSearchBySurnameCreated';

  procedure ClearParam(const AParamName: string);
  var
    p: TFDParam;
  begin
    p := PgSearchProc.FindParam(AParamName);
    if (p <> nil) then begin
      p.Clear();
    end;
  end;
  
var
  p: TFDParam;
begin

  if (DateEdit1 as TNullableDateTimePicker).IsEmpty
    or (DateEdit2 as TNullableDateTimePicker).IsEmpty then 
  begin
    if PgSearchProc.Prepared then begin
      ClearParam('i_date_first');
      ClearParam('i_date_last');      
    end;
    // поиск только по фамилии
    inherited DoSearch(ADoExec);
  end else begin
    // по датам
    case DateSearchGroup.ItemIndex of
      0: PgSearchProc.StoredProcName := SnAndBdSearchProcName;
      1: PgSearchProc.StoredProcName := SnAndCrSearchProcName;
    end;

    if not PgSearchProc.Prepared then begin
      PgSearchProc.Prepare;
    end;
    p := PgSearchProc.FindParam('i_date_first');
    if p <> nil then begin    
      p.AsDate := DateEdit1.Date;
      ADoExec := True;
    end else begin
      ADoExec := False;
    end;      
    p := PgSearchProc.FindParam('i_date_last');
    if (p <> nil) and ADoExec then 
    begin
      p.AsDate := DateEdit2.Date;
      ADoExec := True;
    end else begin
      ADoExec := False;
    end;      

    inherited DoSearch(ADoExec);
  end;
end;

end.
