program PgARMsProject;

uses
  Forms,
  Dm in 'Db\Dm.pas' {Pg: TDataModule},
  Main in 'Forms\Main.pas' {MainForm},
  Child in 'Forms\Child.pas' {ChildForm},
  Search in 'Frames\Search.pas' {SearchFrame: TFrame},
  Statist in 'Forms\Statist.pas' {StatForm},
  Oper in 'Forms\Oper.pas' {OperForm},
  CgyDtPicker in 'Components\CgyDtPicker.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TPg, Pg);
  Application.Run;
end.
