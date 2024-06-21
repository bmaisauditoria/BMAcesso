unit frmSenhas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, DBTables, MSAccess, OLEDBAccess, OLEDBC, OLEDBIntf, DBAccess, MemDS, Grids, DBGrids, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, ToolWin;

type
  TfrmSenha = class(TForm)
    dsUsuario: TDataSource;
    dbUsuario: TMSTable;
    dbUsuarioUsuario: TStringField;
    dbUsuarioNomeUsuario: TStringField;
    dbUsuarioMaster: TBooleanField;
    dbUsuarioSenha: TStringField;
    dbAcesso: TMSTable;
    dsAcesso: TDataSource;
    dbAcessoUsuario: TStringField;
    dbAcessoModulo: TStringField;
    dbAcessoGravacao: TBooleanField;
    dbModulo: TMSTable;
    dsModulo: TDataSource;
    dbModuloModulo: TStringField;
    grdAcesso: TDBGrid;
    grdUsuario: TDBGrid;
    dbAcessoModuloBusca: TStringField;
    dbUsuarioMasterTexto: TStringField;
    CoolBar1: TCoolBar;
    Label18: TLabel;
    Label1: TLabel;
    DBText1: TDBText;
    Edit1: TEdit;
    dbUsuarioSenha1: TStringField;
    Panel1: TPanel;
    Panel2: TPanel;
    cmdNovoUsu: TBitBtn;
    cmdGravaUsu: TBitBtn;
    cmdCancelaUsu: TBitBtn;
    cmdExcluiUsu: TBitBtn;
    cmdSenha: TBitBtn;
    cmdNovoMod: TBitBtn;
    cmdGravaMod: TBitBtn;
    cmdCancelaMod: TBitBtn;
    cmdExcluiMod: TBitBtn;
    procedure cmdNovoUsuClick(Sender: TObject);
    procedure cmdGravaUsuClick(Sender: TObject);
    procedure cmdExcluiUsuClick(Sender: TObject);
    procedure cmdCancelaUsuClick(Sender: TObject);
    procedure cmdNovoModClick(Sender: TObject);
    procedure cmdGravaModClick(Sender: TObject);
    procedure cmdExcluiModClick(Sender: TObject);
    procedure cmdCancelaModClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbUsuarioBeforeDelete(DataSet: TDataSet);
    procedure dbAcessoAfterInsert(DataSet: TDataSet);
    procedure dsUsuarioStateChange(Sender: TObject);
    procedure dsAcessoStateChange(Sender: TObject);
    procedure dbUsuarioAfterInsert(DataSet: TDataSet);
    procedure dbUsuarioCalcFields(DataSet: TDataSet);
    procedure dbUsuarioBeforePost(DataSet: TDataSet);
    procedure dbUsuarioAfterCancel(DataSet: TDataSet);
    procedure dbUsuarioAfterPost(DataSet: TDataSet);
    procedure dbAcessoBeforeInsert(DataSet: TDataSet);
    procedure cmdSenhaClick(Sender: TObject);
    procedure grdUsuarioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdUsuarioDblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure dbAcessoGravacaoGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dbAcessoGravacaoSetText(Sender: TField; const Text: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSenha: TfrmSenha;

implementation

uses frmPrincipal, frmSenhasAltera;

{$R *.DFM}

function Encrypt( Senha:String ): String;
Const
    Chave : String = 'Jesus';
Var
    x,y : Integer;
    NovaSenha : String;
begin
   for x := 1 to Length( Chave ) do begin
      NovaSenha := '';
      for y := 1 to Length( Senha ) do
         NovaSenha := NovaSenha + chr( (Ord(Chave[x]) xor Ord(Senha[y])));
      Senha := NovaSenha;
   end;
   result := Senha;
end;


procedure TfrmSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if dbUsuario.State in [dsInsert,dsEdit] then
        dbUsuario.Cancel;
     dbUsuario.Close;

     if dbAcesso.State in [dsInsert,dsEdit] then
        dbAcesso.Cancel;
     dbAcesso.Close;

     dbModulo.Close;
end;

procedure TfrmSenha.FormShow(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   try
      dbUsuario.Open;
      dbAcesso.Open;
      dbModulo.Open;
   finally
     Screen.Cursor := crDefault;
   end;

end;

procedure TfrmSenha.cmdNovoUsuClick(Sender: TObject);
begin
     dbUsuario.Insert;
     grdUsuario.SetFocus;
end;

procedure TfrmSenha.cmdGravaUsuClick(Sender: TObject);
begin
     dbUsuario.Post;
end;

procedure TfrmSenha.cmdExcluiUsuClick(Sender: TObject);
var iResultado:integer;
begin
   iResultado:=Application.MessageBox('Confirme a Exclusão!',
   'Aviso', mb_yesno+ mb_iconExclamation);

   if(iResultado=id_yes) then
   dbUsuario.Delete;
end;

procedure TfrmSenha.cmdCancelaUsuClick(Sender: TObject);
begin
     dbUsuario.Cancel;
end;

procedure TfrmSenha.cmdNovoModClick(Sender: TObject);
begin
     dbAcesso.Insert;
     grdAcesso.SetFocus;
end;

procedure TfrmSenha.cmdGravaModClick(Sender: TObject);
begin
     dbAcesso.Post;
end;

procedure TfrmSenha.cmdExcluiModClick(Sender: TObject);
var iResultado:integer;
begin
     iResultado:=Application.MessageBox('Confirme a Exclusão!',
     'Aviso', mb_yesno+ mb_iconExclamation);

     if(iResultado=id_yes) then
     dbAcesso.Delete;
end;

procedure TfrmSenha.cmdCancelaModClick(Sender: TObject);
begin
     dbAcesso.Cancel;
end;

procedure TfrmSenha.dbUsuarioBeforeDelete(DataSet: TDataSet);
begin
   if dbUsuarioUsuario.Text='Convidado' then
   begin
      ShowMessage('Registro de Controle do Sistema. Impossível Excluir!');
      abort;
   end;

     dbAcesso.First;
     while not dbAcesso.eof do dbAcesso.Delete;
end;

procedure TfrmSenha.dbAcessoAfterInsert(DataSet: TDataSet);
begin
     dbAcessoUsuario.Text:=dbUsuarioUsuario.Text;
     dbAcessoModulo.Text:=dbAcessoModuloBusca.Text;
     dbAcessoGravacao.Value:=true;
end;

procedure TfrmSenha.dsUsuarioStateChange(Sender: TObject);
begin
     cmdNovoUsu.Enabled:=dbUsuario.State in [dsEdit,dsBrowse,dsInsert];
     cmdExcluiUsu.Enabled:=(dbUsuario.State in [dsEdit,dsBrowse,dsInsert])
                                       and (dbUsuario.RecordCount<>0);
     cmdGravaUsu.Enabled:=dbUsuario.State in [dsEdit,dsInsert];
     cmdCancelaUsu.Enabled:=dbUsuario.State in [dsEdit,dsInsert];

end;

procedure TfrmSenha.dsAcessoStateChange(Sender: TObject);
begin
     cmdNovoMod.Enabled:=dbAcesso.State in [dsEdit,dsBrowse,dsInsert];
     cmdExcluiMod.Enabled:=(dbAcesso.State in [dsEdit,dsBrowse,dsInsert])
                                       and (dbAcesso.RecordCount<>0);
     cmdGravaMod.Enabled:=dbAcesso.State in [dsEdit,dsInsert];
     cmdCancelaMod.Enabled:=dbAcesso.State in [dsEdit,dsInsert];
end;

procedure TfrmSenha.dbUsuarioAfterInsert(DataSet: TDataSet);
begin
     ShowMessage('A senha inicial do novo Usuário será 0000');
     dbUsuarioUsuario.ReadOnly:=false;
     dbUsuarioSenha.Text:='0000';
     dbUsuarioMaster.Value:=true;
end;

procedure TfrmSenha.dbUsuarioCalcFields(DataSet: TDataSet);
begin
     if dbUsuarioMaster.Value=true then
        dbUsuarioMasterTexto.Text:='Sim'
      else
        dbUsuarioMasterTexto.Text:='Não';
     dbUsuarioSenha1.value:=Encrypt(dbUsuarioSenha.Text);
end;

procedure TfrmSenha.dbUsuarioBeforePost(DataSet: TDataSet);
begin
    if dbUsuario.State=dsInsert then
       dbUsuarioSenha.Text:=Encrypt(dbUsuarioSenha.Text);
end;

procedure TfrmSenha.dbUsuarioAfterCancel(DataSet: TDataSet);
begin
     dbUsuarioUsuario.ReadOnly:=true;
end;

procedure TfrmSenha.dbUsuarioAfterPost(DataSet: TDataSet);
begin
     dbUsuarioUsuario.ReadOnly:=true;
end;

procedure TfrmSenha.dbAcessoBeforeInsert(DataSet: TDataSet);
begin
     if dbUsuarioMaster.Value=true then
     begin
        ShowMessage('Usuário Master não necessita de acesso a Módulos!');
        abort;
     end;
     if dbUsuarioUsuario.Text='Convidado' then
     begin
        ShowMessage('Registro de Controle do Sistema. Não permite inclusão de Modulos!');
        abort;
     end;
end;

procedure TfrmSenha.cmdSenhaClick(Sender: TObject);
begin
    if frmSenhaAltera=nil then
       Application.CreateForm(TfrmSenhaAltera, frmSenhaAltera);
    frmSenhaAltera.ShowModal;
end;

procedure TfrmSenha.grdUsuarioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
     if dbUsuarioMaster.Value=true then
        grdUsuario.Canvas.Font.Color:=clRed;

     grdUsuario.DefaultDrawDataCell(Rect,grdUsuario.Columns[DataCol].field,State);
end;

procedure TfrmSenha.grdUsuarioDblClick(Sender: TObject);
begin
    dbUsuario.Edit;
    if dbUsuarioMaster.value=true then
       dbUsuarioMaster.value:=false
    else
       dbUsuarioMaster.value:=true;
    dbUsuario.Post;
end;

procedure TfrmSenha.Edit1Change(Sender: TObject);
begin
    dbUsuario.Locate('Usuario',trim(edit1.Text),[])
end;

procedure TfrmSenha.dbAcessoGravacaoGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
    if dbAcessoGravacao.value=true then
       text:='Sim';
    if dbAcessoGravacao.value=false  then
       text:='Não';

end;

procedure TfrmSenha.dbAcessoGravacaoSetText(Sender: TField;
  const Text: String);
begin
    if text='Sim' then
        dbAcessoGravacao.value:=true;
    if text='Não' then
        dbAcessoGravacao.value:=false;

end;

end.
