{*******************************************************}
{                                                       }
{       Компонент DBDateTimePicker                      }
{                                                       }
{       Copyright (C) 2022 Cyber-GY                     }
{                                                       }
{                  * * *                                }
{   Имеет способность получать и записывать             }
{    значения в источник данных СУБД                    }
{                                                       }
{*******************************************************}

unit CgyDtPicker;

interface

uses
  System.Classes, Vcl.ComCtrls, Vcl.DBCtrls, Data.DB;

type
  TNullableDateTimePicker = class(TDateTimePicker)
  private
  const
    FEmptyDateFormat = ' ';
  var
    FShortDateFormat: string;
  protected
    procedure Change; override;
    procedure Click; override;
    procedure DoEnter; override;
    procedure KeyPress(var Key: Char); override;
  public
    procedure Clear;
    function IsEmpty: Boolean;
    constructor Create(AOwner: TComponent); override;
  end;

  TDBDateTimePicker = class(TDateTimePicker)
  private
    FDataLink: TFieldDataLink;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    function GetDataField: string;
    procedure SetDataField(const Value: string);
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
  protected
    procedure Change; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;

  end;

implementation

uses
  Winapi.Windows;

{ TNullableDateTimePicker }

procedure TNullableDateTimePicker.Change;
begin
  if Format = FEmptyDateFormat then begin
    Format := FShortDateFormat;
    SetFocus;
  end;
  inherited Change;
end;

procedure TNullableDateTimePicker.Clear;
begin
  if FShortDateFormat <> Format then begin
    FShortDateFormat := Format
  end;
  Format := FEmptyDateFormat;
end;

procedure TNullableDateTimePicker.Click;
begin
  Change;
  inherited Click;
end;

constructor TNullableDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //FShortDateFormat = 'dd.MM.yyyy';
  FShortDateFormat := Format;
end;

procedure TNullableDateTimePicker.DoEnter;
begin
  inherited DoEnter;
  Change;
end;

function TNullableDateTimePicker.IsEmpty: Boolean;
begin
  Result := Format = FEmptyDateFormat;
end;

procedure TNullableDateTimePicker.KeyPress(var Key: Char);
begin
  case Key of
    Chr(VK_RETURN): Key := Char(VK_TAB);

    Chr(VK_ESCAPE): Clear;
  end;

  inherited KeyPress(Key);
end;

{ TDBDateTimePicker }

procedure TDBDateTimePicker.Change;
begin
  if FDataLink <> nil then begin
    FDataLink.Modified;
    //Perform(CM_CHANGED, 0, Winapi.Windows.LPARAM(Self));
    FDataLink.DataSource.Edit;
  end;
  inherited Change;
end;

constructor TDBDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.Control := Self;
end;

procedure TDBDateTimePicker.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then begin
    Date := FDataLink.Field.AsDateTime
  end else begin
    // set null
  end;
end;

destructor TDBDateTimePicker.Destroy;
begin
  FDataLink.Free;
  inherited Destroy;
end;

function TDBDateTimePicker.GetDataField: string;
begin
  Result := FDataLink.FieldName
end;

function TDBDateTimePicker.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBDateTimePicker.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil)
    and (AComponent = DataSource) then
  begin
    DataSource := nil
  end;
end;

procedure TDBDateTimePicker.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBDateTimePicker.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then begin
    Value.FreeNotification(Self);
  end;
end;

procedure TDBDateTimePicker.UpdateData(Sender: TObject);
begin
  // поскольку метод вызывается по событию FDataLink,
  // значит актуальность ссылки проверять нет необходимости
  if FDataLink.Field <> nil then begin
    FDataLink.Field.AsDateTime := Date;
  end;
end;

end.
