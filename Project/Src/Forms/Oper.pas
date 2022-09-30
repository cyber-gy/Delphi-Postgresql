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
    PatBirthdateEdit: TDateTimePicker;
    PatRegEdit: TDateTimePicker;
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
    procedure PatButtonClick(Sender: TObject);
    procedure CertButtonClick(Sender: TObject);
    procedure PatientSourceStateChange(Sender: TObject);
    procedure CertSourceStateChange(Sender: TObject);
    procedure PgCertQueryBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  OperForm: TOperForm;

implementation

{$R *.dfm}

procedure TOperForm.CertButtonClick(Sender: TObject);
begin
  if Sender is TButton then begin
    CertNavigator.BtnClick(TNavigateBtn(TComponent(Sender).Tag));
  end;
end;

procedure TOperForm.CertSourceStateChange(Sender: TObject);
begin
  CertNewButton.Enabled := CertNavigator.Controls[CertNewButton.Tag].Enabled;
  CertDelButton.Enabled := CertNavigator.Controls[CertDelButton.Tag].Enabled;
  CertPostButton.Enabled := CertNavigator.Controls[CertPostButton.Tag].Enabled;
  CertCancelButton.Enabled := CertNavigator.Controls[CertCancelButton.Tag].Enabled;
end;

constructor TOperForm.Create(AOwner: TComponent);
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
end;

procedure TOperForm.PatButtonClick(Sender: TObject);
begin
  if Sender is TButton then begin
    PatientNavigator.BtnClick(TNavigateBtn(TComponent(Sender).Tag));
  end;
end;

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
    PgCertQueryid_patient.AsInteger := PgPatientQueryid.AsInteger
  end;
end;

end.
