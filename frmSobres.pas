unit frmSobres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, MSAccess, OLEDBAccess, OLEDBC, OLEDBIntf, DBAccess, MemDS, Shellapi;

type
  TfrmSobre = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Label5: TLabel;
    dbProprietaria: TMSTable;
    dbProprietariaEndereco: TStringField;
    dbProprietariaCidade: TStringField;
    dbProprietariaUF: TStringField;
    dbProprietariaCep: TStringField;
    dbProprietariaIE: TStringField;
    dbProprietariaCGC: TStringField;
    dbProprietariaTelefone: TStringField;
    dbProprietariaFax: TStringField;
    dsProprietaria: TDataSource;
    Label6: TLabel;
    Image1: TImage;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

uses frmPrincipal;
{$R *.DFM}

procedure TfrmSobre.FormShow(Sender: TObject);
begin
    dbProprietaria.Open;
    if dbProprietaria.RecordCount=0 then
    begin
        dbProprietaria.Insert;
        dbProprietaria.Post;
    end;
    dbProprietaria.First;

    Memo1.Lines.Clear;
    Memo1.Lines.Add(Trim(_Empresa));
    Memo1.Lines.Add(Trim(dbProprietariaEndereco.Text));
    Memo1.Lines.Add(Trim(dbProprietariaCidade.Text)+' - '+
                    Trim(dbProprietariaUF.Text)+' - Brasil');
    Memo1.Lines.Add('CNPJ:'+dbProprietariaCGC.value);
    Memo1.Lines.Add('IE:'+dbProprietariaIE.Text);
end;

procedure TfrmSobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    dbProprietaria.Close;
end;

procedure TfrmSobre.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Screen.Cursor := crHandPoint;
end;

procedure TfrmSobre.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Screen.Cursor := crDefault;
end;

procedure TfrmSobre.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Screen.Cursor := crDefault;
end;

procedure TfrmSobre.Label6Click(Sender: TObject);
begin
    ShellExecute(Handle , 'open','mailto:androsinfo@uol.com.br?subject=Sistema B+ Auditoria Médica', nil,
    nil,SW_SHOWDEFAULT);

end;

end.
