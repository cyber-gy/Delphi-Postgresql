{*******************************************************}
{                                                       }
{       Основная форма приложения                       }
{                                                       }
{       Copyright (C) 2022 Cyber-GY                     }
{                                                       }
{                  * * *                                }
{                                                       }
{    Управляет и обслуживает дочерние формы - АРМы      }
{                                                       }
{*******************************************************}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPStyleActnCtrls, ActnList, ActnMan, ToolWin, ActnCtrls, ActnMenus,
  StdCtrls, System.Actions,
  Child;

type
  TMainForm = class(TForm)
    ActionManager1: TActionManager;
    ActionList1: TActionList;
    ActionExit: TAction;
    ActionWindowNew: TAction;
    ActionWindowCloseLast: TAction;
    ActionCloseAll: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    ActionWindowNewStat: TAction;
    ActionWindowNewOper: TAction;
    procedure ActionWindowNewExecute(Sender: TObject);
    procedure ActionWindowCloseLastExecute(Sender: TObject);

    procedure ActionCloseAllExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionWindowNewStatExecute(Sender: TObject);
    procedure ActionWindowNewOperExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AddNewWindow(const ACaption: string; AForm: TChildForm);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Statist, Oper;

{ TMainForm }

{-------------------------------------------------------------------------------
  Процедура: TMainForm.ActionCloseAllExecute
  Автор: Cyber-GY
  Входные параметры: Sender: TObject
  Результат: Закрытие всех дочерних форм
-------------------------------------------------------------------------------}
procedure TMainForm.ActionCloseAllExecute(Sender: TObject);
var
  i: NativeInt;
  ActionClientItem: TActionClientItem;
begin
  i := ActionToolBar1.ActionClient.Items.Count - 1;
  while i >= 0 do begin
    ActionClientItem := ActionToolBar1.ActionClient.Items[i];
    TChildForm(Pointer(ActionClientItem.Action.Tag)).Close;
    Dec(i);
  end;
end;

procedure TMainForm.ActionExitExecute(Sender: TObject);
begin
  Close
end;

{-------------------------------------------------------------------------------
  Процедура: TMainForm.ActionWindowCloseLastExecute
  Автор: Cyber-GY
  Входные параметры: Sender: TObject
  Результат: Закрытие последней открытой формы
-------------------------------------------------------------------------------}
procedure TMainForm.ActionWindowCloseLastExecute(Sender: TObject);
var
  i: NativeInt;
  ActionClientItem: TActionClientItem;
begin
  i := ActionToolBar1.ActionClient.Items.Count - 1;
  if i >= 0 then begin
    ActionClientItem := ActionToolBar1.ActionClient.Items[i];
    TChildForm(Pointer(ActionClientItem.Action.Tag)).Close;
  end;
end;

procedure TMainForm.ActionWindowNewExecute(Sender: TObject);
begin
  AddNewWindow('Просмотр данных', TChildForm.Create(Self));
end;

procedure TMainForm.ActionWindowNewOperExecute(Sender: TObject);
begin
  AddNewWindow('АРМ оператора', TOperForm.Create(Self))
end;

procedure TMainForm.ActionWindowNewStatExecute(Sender: TObject);
begin
  AddNewWindow('АРМ статиста', TStatForm.Create(Self))
end;

{-------------------------------------------------------------------------------
  Процедура: TMainForm.AddNewWindow
  Автор: Cyber-GY
  Входные параметры:
   ACaption: string - Название дочерней формы
   AForm: TChildForm - Экземпляр дочерней формы
  Результат: Открывает новую дочернюю форму
-------------------------------------------------------------------------------}
procedure TMainForm.AddNewWindow(const ACaption: string; AForm: TChildForm);
var
  Action: TCustomAction;
  ActionClientItem: TActionClientItem;
begin
  AForm.Caption := ACaption;

  Action := TCustomAction.Create(AForm);
  Action.Caption := AForm.Caption;
  Action.Category := 'DynamicWindows';
//  Action.Name := 'ActionShow' + AForm.Caption;
  Action.Tag := NativeInt(Pointer(AForm));
  Action.ActionList := ActionList1;
  Action.OnExecute := AForm.BringToFront;

  ActionClientItem := ActionToolBar1.ActionClient.Items.Add;
  ActionClientItem.Action := Action;
//  ActionClientItem.Caption := Action.Caption;
  ActionManager1.AddAction(Action, nil);
  AForm.Show;
end;

end.
