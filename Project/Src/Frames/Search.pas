{*******************************************************}
{                                                       }
{       Фрейм поиска по одному текстовому значению      }
{                                                       }
{       Copyright (C) 2022 Cyber-GY                     }
{                                                       }
{*******************************************************}

unit Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ActnList;

type
  TSearchFrame = class(TFrame)
    SearchLabel: TLabel;
    ValueEdit: TEdit;
    SearchButton: TButton;
    procedure ValueEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    procedure Init(const ACaption: string; AAction: TCustomAction);
  end;

implementation

{$R *.dfm}

procedure TSearchFrame.Init(const ACaption: string; AAction: TCustomAction);
begin
  SearchLabel.Caption := ACaption;
  SearchButton.Action := AAction;
end;

procedure TSearchFrame.ValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    Chr(VK_RETURN): SearchButton.Click; // поиск по значению
    Chr(VK_ESCAPE): begin               // очистка фильтра
      ValueEdit.Text := '';
      SearchButton.Click;
    end;
  end;
end;

end.
