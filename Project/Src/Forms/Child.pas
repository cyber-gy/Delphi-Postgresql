{*******************************************************}
{                                                       }
{       �������  �������� ����� ����������              }
{                                                       }
{       Copyright (C) 2022 Cyber-GY                     }
{                                                       }
{                      * * *                            }
{                                                       }
{     �������� ��������� ������ ����������� � ����      }
{     �� ���� ���������� ����-������ Db.                }
{     ����� ������� ����� ��������� ��� ������,         }
{     ������ � ������ �� �������� ����.                 }
{     � ������ 1.1 ���������� ���������� �����          }
{     �������� ��������� ����.                          }
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
    SearchFrame: TSearchFrame;                          // ������� ����� ������
    procedure DoSearch(var ADoExec: Boolean); virtual;  // ���������� ������ � ����
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

  // �������� ������ ������
  SearchFrame := TSearchFrame.Create(Self);
  SearchFrame.Parent := SearchPanel;
  SearchFrame.Align := alClient;
  SearchFrame.Init('�� �������:', SearchAction);
end;

{-------------------------------------------------------------------------------
  ���������: TChildForm.DoSearch
  ��������: ������� ����� �� �������
  �����: Cyber-GY
  ������� ���������:
    ADoExec - ���������� ������������� ���������� �������� ���������
  ���������: ������������ master-��������� ������ �� ���������� ������ � �������
-------------------------------------------------------------------------------}
procedure TChildForm.DoSearch(var ADoExec: Boolean);
var
  p: TFDParam;
  s: string;
begin
  s := Trim(SearchFrame.ValueEdit.Text);
  // ����� �� ��������
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
    // ������� ������
    PatientSource.DataSet := PgPatientProc;
  end;
end;

procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree
end;

{-------------------------------------------------------------------------------
  ���������: TChildForm.FormShow
  �����: Cyber-GY
  ������� ���������: Sender: TObject
  ���������: ��������� ����������� � ����, ������� ������
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
    ShowMessage('������ ����������� � ����:'#10 + E.Message);
  end;

  if IsSuccess then begin
    try
      PgPatientProc.OpenOrExecute;
    except on E: Exception do begin
      // write to log ...
      IsSuccess := False;
      ShowMessage('������ ������� � �������:'#10 + E.Message);
      end;
    end;
  end;

  if IsSuccess then begin
    try
      PgCertProc.Prepare;
      PgCertProc.OpenOrExecute;
    except on E: Exception do
      // write to log ...
      ShowMessage('������ ������� � �������:'#10 + E.Message);
    end;
  end;
end;

{-------------------------------------------------------------------------------
  ���������: TChildForm.PgConnectionError
  ��������: ���������� ��������� ������ ������ � ����
  �����: Cyber-GY
  ������� ���������:
    ASender - TFDConnection object
    AInitiator - ������-�������� �������������� ��������
    AException - ������ �������� �� �������������� ��������
  ���������: ����������� ������ ������ � ����
-------------------------------------------------------------------------------}
procedure TChildForm.PgCertProcBeforeOpen(DataSet: TDataSet);
begin
  PgCertProcBeforeRefresh(DataSet);
end;

{-------------------------------------------------------------------------------
  ���������: TChildForm.PgCertProcBeforeRefresh
  �����: Cyber-GY
  ������� ���������: DataSet: TDataSet
  ���������: ���������� ����� ������������ ������ ������
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
  ���������: TChildForm.PgConnectionError
  �����: Cyber-GY
  ������� ���������: ASender, AInitiator: TObject; var AException: Exception
  ���������: ��������� ������ �����������
-------------------------------------------------------------------------------}
procedure TChildForm.PgConnectionError(ASender, AInitiator: TObject;
  var AException: Exception);
var
  s: string;
begin
  s := '������: ';
  if AInitiator <> nil then begin
    if AInitiator is TComponent then begin
      s := s + TComponent(AInitiator).Name + ' (' + AInitiator.ClassName + ')';
    end else begin
      s := s + AInitiator.ClassName;
    end;
  end;
  // write to log ...
  ShowMessage('������ ������ � ����:'#10 + AException.Message + #10#10 + s);
  // Close connection?
  Close;
end;

{-------------------------------------------------------------------------------
  ���������: TChildForm.PgPatientProcAfterScroll
  �����: Cyber-GY
  ������� ���������: DataSet: TDataSet
  ���������: ������������� ��������������� ������ ������
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
  // ��������� ��������� ������, ���� ������� �������� ��� ������
  DoSearch(DoExecSearch);
end;

end.
