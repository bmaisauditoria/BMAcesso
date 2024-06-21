unit frmFiliais;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, DBTables, MSAccess, OLEDBAccess, OLEDBC, OLEDBIntf, DBAccess, MemDS, Grids, DBGrids, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, ToolWin;

type
  TfrmFilial = class(TForm)
    dbBBEmp: TMSTable;
    dsBBEmp: TDataSource;
    grdBBEmp: TDBGrid;
    Label18: TLabel;
    dbBBEmpFilial: TIntegerField;
    dbBBEmpNome: TStringField;
    dbBBEmpServidor: TStringField;
    dbBBEmpBancoDados: TStringField;
    Label2: TLabel;
    Label3: TLabel;
    dbBBEmpCidade: TStringField;
    dbBBEmpSkin: TSmallintField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFilial: TfrmFilial;

implementation

uses frmPrincipal;

{$R *.DFM}

function Encrypt( Senha:String ): String;
begin
end;


procedure TfrmFilial.FormClose(Sender: TObject; var Action: TCloseAction);
begin

     if dbBBEmp.State in [dsInsert,dsEdit] then
        dbBBEmp.Cancel;
     dbBBEmp.Close;

end;

procedure TfrmFilial.FormShow(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   try
      dbBBEmp.Open;
   finally
     Screen.Cursor := crDefault;
   end;

end;

end.
