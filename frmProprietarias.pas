unit frmProprietarias;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, Db, DBTables, MSAccess, OLEDBAccess, OLEDBC, OLEDBIntf, DBAccess, MemDS;

type
  TfrmProprietaria = class(TForm)
    Panel1: TPanel;
    dbProprietaria: TMSTable;
    dbProprietariaCGC: TStringField;
    dsProprietaria: TDataSource;
    cmpRazao: TLabel;
    Label3: TLabel;
    cmpEndereco: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Panel10: TPanel;
    cmdAltera: TBitBtn;
    cmdGrava: TBitBtn;
    cmdCancela: TBitBtn;
    DBEdit22: TDBEdit;
    Label32: TLabel;
    DBEdit13: TDBEdit;
    Label13: TLabel;
    dbProprietariaEndereco: TStringField;
    dbProprietariaCidade: TStringField;
    dbProprietariaUF: TStringField;
    dbProprietariaCep: TStringField;
    dbProprietariaIE: TStringField;
    lblEmpresa: TLabel;
    dbProprietariaTelefone: TStringField;
    dbProprietariaFax: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    dbProprietariaNumSUSEP: TStringField;
    dbProprietariaUltimoArqMS: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dsProprietariaStateChange(Sender: TObject);
    procedure cmdAlteraClick(Sender: TObject);
    procedure cmdGravaClick(Sender: TObject);
    procedure cmdCancelaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProprietaria: TfrmProprietaria;

implementation

uses frmPrincipal;

{$R *.DFM}

procedure TfrmProprietaria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if dbProprietaria.State=dsEdit then
       dbProprietaria.Post;    
    dbProprietaria.Close;
end;

procedure TfrmProprietaria.FormShow(Sender: TObject);
begin
    dbProprietaria.Open;
    if dbProprietaria.RecordCount=0 then
    begin
       dbProprietaria.Insert;
       dbProprietaria.Post;
    end;
    dbProprietaria.First;
    lblEmpresa.Caption:=_Empresa;
end;

procedure TfrmProprietaria.dsProprietariaStateChange(Sender: TObject);
begin
     cmdGrava.Enabled:=dbProprietaria.State in [dsEdit];
     cmdAltera.Enabled:=(dbProprietaria.State=dsBrowse)
                         and (dbProprietaria.RecordCount<>0);
     cmdCancela.Enabled:=dbProprietaria.State in [dsEdit];
end;

procedure TfrmProprietaria.cmdAlteraClick(Sender: TObject);
begin
    dbProprietaria.Edit;
    cmpEndereco.SetFocus;
end;

procedure TfrmProprietaria.cmdGravaClick(Sender: TObject);
begin
    dbProprietaria.Post;
end;

procedure TfrmProprietaria.cmdCancelaClick(Sender: TObject);
begin
    dbProprietaria.Cancel;
end;

end.
