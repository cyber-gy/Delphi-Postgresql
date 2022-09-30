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

uses Statist, Oper;

{ TMainForm }

procedure TMainForm.ActionCloseAllExecute(Sender: TObject);
var
  i: Integer;
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

procedure TMainForm.ActionWindowCloseLastExecute(Sender: TObject);
var
  ActionClientItem: TActionClientItem;
begin
  ActionClientItem := ActionToolBar1.ActionClient.Items[ActionToolBar1.ActionClient.Items.Count - 1];
  TChildForm(Pointer(ActionClientItem.Action.Tag)).Close;
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
  Action.Tag := Integer(Pointer(AForm));
  Action.ActionList := ActionList1;
  Action.OnExecute := AForm.BringToFront;

  ActionClientItem := ActionToolBar1.ActionClient.Items.Add;
  ActionClientItem.Action := Action;
//  ActionClientItem.Caption := Action.Caption;
  ActionManager1.AddAction(Action, nil);
  AForm.Show;
end;

end.
