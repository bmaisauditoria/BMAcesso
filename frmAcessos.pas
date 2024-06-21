unit frmAcessos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, StdCtrls, ToolWin, ExtCtrls, Buttons,
  DB, MemDS, DBAccess, MSAccess, Menus, RpDefine, RpCon, RpConDS;

type
  TfrmAcesso = class(TForm)
    dsModuloA: TDataSource;
    dbModuloA: TMSQuery;
    dbModuloATipo: TStringField;
    dbModuloAModulo: TStringField;
    dsAcessoA: TDataSource;
    dbAcessoA: TMSQuery;
    dbAcessoAUsuario: TStringField;
    dbAcessoATipo: TStringField;
    dbAcessoAModulo: TStringField;
    dbAcessoAGravacao: TBooleanField;
    dbAcessoAModuloBusca: TStringField;
    tabOrdemAuditor: TTabControl;
    lblUsuarioLinha: TLabel;
    Label1: TLabel;
    lblUsuario: TLabel;
    Panel24: TPanel;
    rdgAtivo: TRadioGroup;
    CoolBar3: TCoolBar;
    txtAuditor: TEdit;
    PageControl2: TPageControl;
    tabAud: TTabSheet;
    grdAud: TDBGrid;
    Panel57: TPanel;
    cmdExcluiA: TBitBtn;
    cmdGravaA: TBitBtn;
    cmdNovoA: TBitBtn;
    tabFin: TTabSheet;
    tabAge: TTabSheet;
    tabISO: TTabSheet;
    MainMenu1: TMainMenu;
    cmdBBAud: TMenuItem;
    cmdBBFin: TMenuItem;
    cmdBBAgenda: TMenuItem;
    cmdBBIso: TMenuItem;
    Proprietria1: TMenuItem;
    LogdeAcessos1: TMenuItem;
    LogdeAcessos2: TMenuItem;
    LogdeAcessos3: TMenuItem;
    LogdeAcessos4: TMenuItem;
    grdFin: TDBGrid;
    Panel1: TPanel;
    cmdExcluiF: TBitBtn;
    cmdGravaF: TBitBtn;
    cmdNovoF: TBitBtn;
    grdAgenda: TDBGrid;
    Panel2: TPanel;
    cmdExcluiE: TBitBtn;
    cmdGravaE: TBitBtn;
    cmdNovoE: TBitBtn;
    grdIso: TDBGrid;
    Panel3: TPanel;
    cmdExcluiI: TBitBtn;
    cmdGravaI: TBitBtn;
    cmdNovoI: TBitBtn;
    dbAcessoF: TMSQuery;
    dbAcessoFUsuario: TStringField;
    dbAcessoFTipo: TStringField;
    dbAcessoFModulo: TStringField;
    dbAcessoFGravacao: TBooleanField;
    dbAcessoFModuloBusca: TStringField;
    dbModuloF: TMSQuery;
    dbModuloFTipo: TStringField;
    dbModuloFModulo: TStringField;
    dsModuloF: TDataSource;
    dsAcessoF: TDataSource;
    Panel4: TPanel;
    grdUsuario: TDBGrid;
    Panel5: TPanel;
    cmdExcluiU: TBitBtn;
    cmdGravaU: TBitBtn;
    cmdNovoU: TBitBtn;
    dbUsuario: TMSTable;
    dbUsuarioUsuario: TStringField;
    dbUsuarioNomeUsuario: TStringField;
    dbUsuarioMaster: TBooleanField;
    dbUsuarioSenha: TStringField;
    dbUsuarioBBAud: TBooleanField;
    dbUsuarioMasterAud: TBooleanField;
    dbUsuarioBBFin: TBooleanField;
    dbUsuarioMasterFin: TBooleanField;
    dbUsuarioBBAgenda: TBooleanField;
    dbUsuarioMasterAgenda: TBooleanField;
    dbUsuarioBBISO: TBooleanField;
    dbUsuarioMasterISO: TBooleanField;
    dbUsuarioTipo: TStringField;
    dbUsuarioUsuarioI: TStringField;
    dbUsuarioUsuarioA: TStringField;
    dbUsuarioUsuarioE: TStringField;
    dbUsuarioDataInicio: TDateTimeField;
    dbUsuarioDataFim: TDateTimeField;
    dbUsuarioDataInclusao: TDateTimeField;
    dbUsuarioDataAlteracao: TDateTimeField;
    dbUsuarioDataExclusao: TDateTimeField;
    dsUsuario: TDataSource;
    dbAcessoE: TMSQuery;
    dsAcessoE: TDataSource;
    dsModuloE: TDataSource;
    dbModuloE: TMSQuery;
    dbAcessoI: TMSQuery;
    dsAcessoI: TDataSource;
    dsModuloI: TDataSource;
    dbModuloI: TMSQuery;
    dbModuloETipo: TStringField;
    dbModuloEModulo: TStringField;
    dbModuloITipo: TStringField;
    dbModuloIModulo: TStringField;
    dbAcessoEUsuario: TStringField;
    dbAcessoETipo: TStringField;
    dbAcessoEModulo: TStringField;
    dbAcessoEGravacao: TBooleanField;
    dbAcessoEModuloBusca: TStringField;
    dbAcessoIModuloBusca: TStringField;
    dbAcessoIUsuario: TStringField;
    dbAcessoITipo: TStringField;
    dbAcessoIModulo: TStringField;
    dbAcessoIGravacao: TBooleanField;
    Label2: TLabel;
    menuSenha: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    dbUsuarioSenhaOpen: TStringField;
    Label3: TLabel;
    Sobre1: TMenuItem;
    cmdAlteraU: TBitBtn;
    chkAud: TCheckBox;
    chkFin: TCheckBox;
    chkAgenda: TCheckBox;
    chkISO: TCheckBox;
    Label4: TLabel;
    BitBtn10: TBitBtn;
    BitBtn1: TBitBtn;
    qryAcesso: TMSQuery;
    qryAcessoUsuario: TStringField;
    qryAcessoNomeUsuario: TStringField;
    qryAcessoBBAud: TBooleanField;
    qryAcessoMasterAud: TBooleanField;
    qryAcessoBBFin: TBooleanField;
    qryAcessoMasterFin: TBooleanField;
    qryAcessoBBAgenda: TBooleanField;
    qryAcessoMasterAgenda: TBooleanField;
    qryAcessoBBISO: TBooleanField;
    qryAcessoMasterISO: TBooleanField;
    qryAcessoModulo: TStringField;
    qryAcessoGravacao: TBooleanField;
    rvAcesso: TRvDataSetConnection;
    qryAcessoDataInicio: TDateTimeField;
    qryAcessoTipo_1: TStringField;
    qryAcessoTipoTexto: TStringField;
    qryAcessoAudTexto: TStringField;
    qryAcessoFinTexto: TStringField;
    qryAcessoAgendaTexto: TStringField;
    qryAcessoISOTexto: TStringField;
    qryAcessoGravacaoTexto: TStringField;
    qryAcessoDataFim: TDateTimeField;
    BitBtn2: TBitBtn;
    GrupoBBB1: TMenuItem;
    procedure grdUsuarioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure GetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure SetText(Sender: TField; const Text: String);
    procedure tabOrdemAuditorChange(Sender: TObject);
    procedure txtAuditorChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbUsuarioTipoGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dbUsuarioTipoSetText(Sender: TField; const Text: String);
    procedure dbUsuarioFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure rdgAtivoClick(Sender: TObject);
    procedure cmdNovoAClick(Sender: TObject);
    procedure cmdGravaAClick(Sender: TObject);
    procedure cmdExcluiAClick(Sender: TObject);
    procedure dbAcessoAAfterInsert(DataSet: TDataSet);
    procedure dbAcessoABeforePost(DataSet: TDataSet);
    procedure dsAcessoAStateChange(Sender: TObject);
    procedure cmdNovoFClick(Sender: TObject);
    procedure cmdGravaFClick(Sender: TObject);
    procedure cmdExcluiFClick(Sender: TObject);
    procedure cmdNovoEClick(Sender: TObject);
    procedure cmdGravaEClick(Sender: TObject);
    procedure cmdExcluiEClick(Sender: TObject);
    procedure cmdNovoIClick(Sender: TObject);
    procedure cmdGravaIClick(Sender: TObject);
    procedure cmdExcluiIClick(Sender: TObject);
    procedure dsAcessoFStateChange(Sender: TObject);
    procedure dsAcessoEStateChange(Sender: TObject);
    procedure dsAcessoIStateChange(Sender: TObject);
    procedure dbAcessoFAfterInsert(DataSet: TDataSet);
    procedure dbAcessoEAfterInsert(DataSet: TDataSet);
    procedure dbAcessoIAfterInsert(DataSet: TDataSet);
    procedure dbAcessoFBeforePost(DataSet: TDataSet);
    procedure dbAcessoEBeforePost(DataSet: TDataSet);
    procedure dbAcessoIBeforePost(DataSet: TDataSet);
    procedure cmdNovoUClick(Sender: TObject);
    procedure cmdGravaUClick(Sender: TObject);
    procedure cmdExcluiUClick(Sender: TObject);
    procedure dbUsuarioBeforeDelete(DataSet: TDataSet);
    procedure dbUsuarioAfterInsert(DataSet: TDataSet);
    procedure dbUsuarioAfterCancel(DataSet: TDataSet);
    procedure dbUsuarioAfterPost(DataSet: TDataSet);
    procedure dbUsuarioAfterEdit(DataSet: TDataSet);
    procedure dbUsuarioBeforePost(DataSet: TDataSet);
    procedure dsUsuarioStateChange(Sender: TObject);
    procedure dbUsuarioCalcFields(DataSet: TDataSet);
    procedure dbUsuarioAfterScroll(DataSet: TDataSet);
    procedure Sobre1Click(Sender: TObject);
    procedure Proprietria1Click(Sender: TObject);
    procedure cmdAlteraUClick(Sender: TObject);
    procedure chkAudClick(Sender: TObject);
    procedure chkFinClick(Sender: TObject);
    procedure chkAgendaClick(Sender: TObject);
    procedure chkISOClick(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure qryAcessoCalcFields(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure GrupoBBB1Click(Sender: TObject);
  private
    iDataFim:TDate;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAcesso: TfrmAcesso;

implementation

uses frmPrincipal, frmSobres, frmProprietarias, frmSenhasAltera,
  frmFiliais;

{$R *.dfm}

Function Encrypt( Senha:String ): String;
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


procedure TfrmAcesso.grdUsuarioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
     if gdSelected in state then
        grdUsuario.Canvas.Brush.Color:=clSkyBlue;

     grdUsuario.Columns[3].Color:=$00FFD9B3;
     grdUsuario.Columns[4].Color:=$00FFD9B3;

     grdUsuario.Columns[5].Color:=$00CAFFCA;
     grdUsuario.Columns[6].Color:=$00CAFFCA;

     grdUsuario.Columns[7].Color:=$00D7FFFF;
     grdUsuario.Columns[8].Color:=$00D7FFFF;

     grdUsuario.Columns[9].Color:=$00DDBBFF;
     grdUsuario.Columns[10].Color:=$00DDBBFF;

     if (Column.Field.FieldName='NomeUsuario') and
        (not dbUsuarioDataFim.isnull) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='DataFim') and
        (not dbUsuarioDataFim.isnull) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='BBAud') and
        (dbUsuarioBBAud.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='BBFin') and
        (dbUsuarioBBFin.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='BBAgenda') and
        (dbUsuarioBBAgenda.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='BBISO') and
        (dbUsuarioBBISO.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='MasterAud') and
        (dbUsuarioMasterAud.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='MasterFin') and
        (dbUsuarioMasterFin.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='MasterAgenda') and
        (dbUsuarioMasterAgenda.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     if (Column.Field.FieldName='MasterISO') and
        (dbUsuarioMasterISO.value=false) then
        grdUsuario.Canvas.Font.Color:=clRed;

     grdUsuario.DefaultDrawDataCell(Rect,grdUsuario.Columns[DataCol].field,State);

end;

procedure TfrmAcesso.FormShow(Sender: TObject);
var i:integer;
begin
    lblUsuario.Caption:=iUsuario;
    dbUsuario.Open;
    dbAcessoA.Open;
    dbModuloA.Open;
    dbAcessoF.Open;
    dbModuloF.Open;
    dbAcessoE.Open;
    dbModuloE.Open;
    dbAcessoI.Open;
    dbModuloI.Open;

    lblUsuarioLinha.Caption:=dbUsuarioUsuario.value;
    for i:=3 to 10 do
        grdUsuario.Columns[i].Visible:=false;

    tabAud.TabVisible:=false;
    tabFin.TabVisible:=false;
    tabAge.TabVisible:=false;
    tabIso.TabVisible:=false;

    if iMasterAud then
    begin
        grdUsuario.Columns[3].Visible:=true;
        grdUsuario.Columns[4].Visible:=true;
        tabAud.TabVisible:=true;
    end;

    if iMasterFin then
    begin
        grdUsuario.Columns[5].Visible:=true;
        grdUsuario.Columns[6].Visible:=true;
        tabFin.TabVisible:=true;
    end;

    if iMasterAge then
    begin
        grdUsuario.Columns[7].Visible:=true;
        grdUsuario.Columns[8].Visible:=true;
        tabAge.TabVisible:=true;
    end;

    if iMasterIso then
    begin
        grdUsuario.Columns[9].Visible:=true;
        grdUsuario.Columns[10].Visible:=true;
        tabIso.TabVisible:=true;
    end;
    tabOrdemAuditor.TabIndex:=0;

    chkAud.Visible:=iMasterAud;
    chkFin.Visible:=iMasterFin;
    chkAgenda.Visible:=iMasterAge;
    chkIso.Visible:=iMasterIso;

    if iUsuario=' ANDROS' then
        grdUsuario.Columns[19].Visible:=true
    else
        grdUsuario.Columns[19].Visible:=false;

    cmdBBAud.Visible:=iMasterAud;
    cmdBBFin.Visible:=iMasterFin;
    cmdBBAgenda.Visible:=iMasterAge;
    cmdBBIso.Visible:=iMasterIso;

end;

procedure TfrmAcesso.GetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
    if sender.value=true then
       text:='Sim';
    if sender.value=false then
       text:='Não';

end;

procedure TfrmAcesso.SetText(Sender: TField;
  const Text: String);
begin
    if text='Sim' then
        sender.value:=true;
    if text='Não' then
        sender.value:=false;

end;

procedure TfrmAcesso.tabOrdemAuditorChange(Sender: TObject);
begin
    case tabOrdemAuditor.TabIndex of
    0:dbUsuario.IndexFieldNames:='Usuario';
    1:dbUsuario.IndexFieldNames:='NomeUsuario';
    2:dbUsuario.IndexFieldNames:='Tipo;Usuario';
    3:dbUsuario.IndexFieldNames:='DataInicio;Usuario';
    4:dbUsuario.IndexFieldNames:='DataFim;Usuario';
    end;
    case tabOrdemAuditor.TabIndex of
    0,1:txtAuditor.Visible:=true;
    2,3,4:txtAuditor.Visible:=false;
    end;
end;

procedure TfrmAcesso.txtAuditorChange(Sender: TObject);
begin
    case tabOrdemAuditor.TabIndex of
    0:dbUsuario.Locate('Usuario',txtAuditor.Text,[loCaseInsensitive,loPartialKey]);
    1:dbUsuario.Locate('NomeUsuario',txtAuditor.Text,[loCaseInsensitive,loPartialKey]);
    end;

end;

procedure TfrmAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    dbAcessoA.Close;
    dbModuloA.Close;
    dbAcessoF.Close;
    dbModulof.Close;
    frmMenu.dadosaud.Connected:=false;
    frmMenu.RvAcesso.close;
    Application.Terminate; 

end;

procedure TfrmAcesso.dbUsuarioTipoGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
    if dbUsuarioTipo.value='A' then
       text:='Administrativo';
    if dbUsuarioTipo.value='M' then
       text:='Médico';
    if dbUsuarioTipo.value='E' then
       text:='Enfermeiro';
    if dbUsuarioTipo.value='T' then
       text:='Terceiro';
end;

procedure TfrmAcesso.dbUsuarioTipoSetText(Sender: TField;
  const Text: String);
begin
    if text='Administrativo' then
        dbUsuarioTipo.value:='A';
    if text='Médico' then
        dbUsuarioTipo.value:='M';
    if text='Enfermeiro' then
        dbUsuarioTipo.value:='E';
    if text='Terceiro' then
        dbUsuarioTipo.value:='T';
end;

procedure TfrmAcesso.dbUsuarioFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var ichkAud,ichkFin,ichkAgenda,ichkIso:boolean;
begin
    ichkAud:=true;
    if chkAud.Checked then
        ichkAud:=dbUsuarioBBAud.value=true;

    ichkFin:=true;
    if chkFin.Checked then
        ichkFin:=dbUsuarioBBFin.value=true;

    ichkAgenda:=true;
    if chkAgenda.Checked then
        ichkAgenda:=dbUsuarioBBAgenda.value=true;

    ichkISO:=true;
    if chkISO.Checked then
        ichkISO:=dbUsuarioBBISO.value=true;

    case rdgAtivo.ItemIndex of
    0:accept:=(dbUsuarioDataFim.isnull) and ichkAud and ichkFin and ichkAgenda and ichkISo;
    1:accept:=(not dbUsuarioDataFim.isnull) and ichkAud and ichkFin and ichkAgenda and ichkISo;
    2:accept:=(true) and  ichkAud and ichkFin and ichkAgenda and ichkISo;
    end;
end;

procedure TfrmAcesso.rdgAtivoClick(Sender: TObject);
begin
    dbUsuario.Refresh;
end;

procedure TfrmAcesso.cmdNovoAClick(Sender: TObject);
begin
    dbAcessoA.Insert;
    grdAud.SetFocus;
end;

procedure TfrmAcesso.cmdGravaAClick(Sender: TObject);
begin
    dbAcessoA.Post;
end;

procedure TfrmAcesso.cmdExcluiAClick(Sender: TObject);
var iResultado:integer;
begin
    iResultado:=Application.MessageBox('Confirme a exclusão','Aviso', mb_yesno+ mb_iconExclamation);

    if(iResultado=id_yes) then
        dbAcessoA.Delete;
end;

procedure TfrmAcesso.dbAcessoAAfterInsert(DataSet: TDataSet);
begin
    dbAcessoATipo.value:='A';
    dbAcessoAUsuario.value:=dbUsuarioUsuario.value;
    dbAcessoAGravacao.value:=false;
end;

procedure TfrmAcesso.dbAcessoABeforePost(DataSet: TDataSet);
begin
    if dbAcessoAModulo.value='' then
    begin
        ShowMessage('Selecione um modulo de acesso');
        abort;
    end;
end;

procedure TfrmAcesso.dsAcessoAStateChange(Sender: TObject);
begin
     cmdNovoA.Default:=dbAcessoA.State in [dsBrowse];
     cmdExcluiA.Enabled:=(dbAcessoA.State in [dsEdit,dsBrowse,dsInsert])
                                       and (dbAcessoA.RecordCount<>0);
     cmdGravaA.Enabled:=dbAcessoA.State in [dsEdit,dsInsert];
end;

procedure TfrmAcesso.cmdNovoFClick(Sender: TObject);
begin
    dbAcessoF.Insert;
end;

procedure TfrmAcesso.cmdGravaFClick(Sender: TObject);
begin
    dbAcessoF.Post;
end;

procedure TfrmAcesso.cmdExcluiFClick(Sender: TObject);
var iResultado:integer;
begin
    iResultado:=Application.MessageBox('Confirme a exclusão','Aviso', mb_yesno+ mb_iconExclamation);

    if(iResultado=id_yes) then
        dbAcessoF.Delete;
end;

procedure TfrmAcesso.cmdNovoEClick(Sender: TObject);
begin
    dbAcessoE.Insert;
end;

procedure TfrmAcesso.cmdGravaEClick(Sender: TObject);
begin
    dbAcessoE.Post;
end;

procedure TfrmAcesso.cmdExcluiEClick(Sender: TObject);
var iResultado:integer;
begin
    iResultado:=Application.MessageBox('Confirme a exclusão','Aviso', mb_yesno+ mb_iconExclamation);

    if(iResultado=id_yes) then
        dbAcessoE.Delete;
end;

procedure TfrmAcesso.cmdNovoIClick(Sender: TObject);
begin
    dbAcessoI.Insert;
end;

procedure TfrmAcesso.cmdGravaIClick(Sender: TObject);
begin
    dbAcessoI.Post;
end;

procedure TfrmAcesso.cmdExcluiIClick(Sender: TObject);
var iResultado:integer;
begin
    iResultado:=Application.MessageBox('Confirme a exclusão','Aviso', mb_yesno+ mb_iconExclamation);

    if(iResultado=id_yes) then
        dbAcessoI.Delete;
end;

procedure TfrmAcesso.dsAcessoFStateChange(Sender: TObject);
begin
     cmdNovoF.Default:=dbAcessoF.State in [dsBrowse];
     cmdExcluiF.Enabled:=(dbAcessoF.State in [dsEdit,dsBrowse,dsInsert])
                                       and (dbAcessoF.RecordCount<>0);
     cmdGravaF.Enabled:=dbAcessoF.State in [dsEdit,dsInsert];
end;

procedure TfrmAcesso.dsAcessoEStateChange(Sender: TObject);
begin
     cmdNovoE.Default:=dbAcessoE.State in [dsBrowse];
     cmdExcluiE.Enabled:=(dbAcessoE.State in [dsEdit,dsBrowse,dsInsert])
                                       and (dbAcessoE.RecordCount<>0);
     cmdGravaE.Enabled:=dbAcessoE.State in [dsEdit,dsInsert];
end;

procedure TfrmAcesso.dsAcessoIStateChange(Sender: TObject);
begin
     cmdNovoI.Default:=dbAcessoI.State in [dsBrowse];
     cmdExcluiI.Enabled:=(dbAcessoI.State in [dsEdit,dsBrowse,dsInsert])
                                       and (dbAcessoI.RecordCount<>0);
     cmdGravaI.Enabled:=dbAcessoI.State in [dsEdit,dsInsert];
end;

procedure TfrmAcesso.dbAcessoFAfterInsert(DataSet: TDataSet);
begin
    dbAcessoFTipo.value:='F';
    dbAcessoFUsuario.value:=dbUsuarioUsuario.value;
    dbAcessoFGravacao.value:=true;
end;

procedure TfrmAcesso.dbAcessoEAfterInsert(DataSet: TDataSet);
begin
    dbAcessoETipo.value:='E';
    dbAcessoEUsuario.value:=dbUsuarioUsuario.value;
    dbAcessoEGravacao.value:=false;
end;

procedure TfrmAcesso.dbAcessoIAfterInsert(DataSet: TDataSet);
begin
    dbAcessoITipo.value:='I';
    dbAcessoIUsuario.value:=dbUsuarioUsuario.value;
    dbAcessoIGravacao.value:=true;
end;

procedure TfrmAcesso.dbAcessoFBeforePost(DataSet: TDataSet);
begin
    dbAcessoFGravacao.value:=true;
    if dbAcessoFModulo.value='' then
    begin
        ShowMessage('Selecione um modulo de acesso');
        abort;
    end;
end;

procedure TfrmAcesso.dbAcessoEBeforePost(DataSet: TDataSet);
begin
    if dbAcessoEModulo.value='' then
    begin
        ShowMessage('Selecione um modulo de acesso');
        abort;
    end;
end;

procedure TfrmAcesso.dbAcessoIBeforePost(DataSet: TDataSet);
begin
    dbAcessoIGravacao.value:=true;
    if dbAcessoIModulo.value='' then
    begin
        ShowMessage('Selecione um modulo de acesso');
        abort;
    end;
end;

procedure TfrmAcesso.cmdNovoUClick(Sender: TObject);
begin
    dbUsuario.Insert;
    grdUsuario.SetFocus;
end;

procedure TfrmAcesso.cmdAlteraUClick(Sender: TObject);
begin
    dbUsuario.Edit;
end;

procedure TfrmAcesso.cmdGravaUClick(Sender: TObject);
begin
    dbUsuario.Post;
end;

procedure TfrmAcesso.cmdExcluiUClick(Sender: TObject);
var iResultado:integer;
begin
    iResultado:=Application.MessageBox('Atenção! Exclua apenas usuarios sem movimentação, caso contrario inative. Confirme a exclusão','Aviso', mb_yesno+ mb_iconExclamation);

    if(iResultado=id_yes) then
        dbUsuario.Delete;
end;

procedure TfrmAcesso.dbUsuarioBeforeDelete(DataSet: TDataSet);
begin
    if dbUsuarioTipo.value<>'T' then
    begin
        ShowMessage('Permitido excluir somente [Terceiros].');
        abort;
    end;
    if (dbUsuarioUsuario.value=' ANDROS') and (iUsuario<>' ANDROS') then
    begin
        ShowMessage('Usuário Administrador. Impossivel excluir');
        abort;
    end;
    if (dbUsuarioUsuario.value='Convidado') then
    begin
        ShowMessage('Usuário de Sistema. Impossivel excluir');
        abort;
    end;
end;

procedure TfrmAcesso.dbUsuarioAfterInsert(DataSet: TDataSet);
begin
    grdUsuario.Columns[0].ReadOnly:=false;
    grdUsuario.Columns[1].ReadOnly:=false;
    grdUsuario.Columns[2].ReadOnly:=false;
    grdUsuario.Columns[11].ReadOnly:=false;
    grdUsuario.Columns[12].ReadOnly:=false;
    dbUsuarioTipo.value:='T';
    dbUsuarioMaster.value:=false;
    dbUsuarioBBAud.value:=false;
    dbUsuarioMasterAud.value:=false;
    dbUsuarioBBFin.value:=false;
    dbUsuarioMasterFin.value:=false;
    dbUsuarioBBAgenda.value:=false;
    dbUsuarioMasterAgenda.value:=false;
    dbUsuarioBBIso.value:=false;
    dbUsuarioMasterIso.value:=false;
    dbUsuarioUsuarioI.value:=iUsuario;
    dbUsuarioDataInclusao.value:=date;
    dbUsuarioDataInicio.value:=date;
    dbUsuarioSenha.value:=Encrypt('0000');
end;

procedure TfrmAcesso.dbUsuarioAfterCancel(DataSet: TDataSet);
begin
    grdUsuario.Columns[0].ReadOnly:=true;
    grdUsuario.Columns[1].ReadOnly:=true;
    grdUsuario.Columns[2].ReadOnly:=true;
    grdUsuario.Columns[11].ReadOnly:=true;
    grdUsuario.Columns[12].ReadOnly:=true;
end;

procedure TfrmAcesso.dbUsuarioAfterPost(DataSet: TDataSet);
begin
    grdUsuario.Columns[0].ReadOnly:=true;
    grdUsuario.Columns[1].ReadOnly:=true;
    grdUsuario.Columns[2].ReadOnly:=true;
    grdUsuario.Columns[11].ReadOnly:=true;
    grdUsuario.Columns[12].ReadOnly:=true;
end;

procedure TfrmAcesso.dbUsuarioAfterEdit(DataSet: TDataSet);
begin
    if (dbUsuarioUsuario.value=' ANDROS') and (iUsuario<>' ANDROS') then
    begin
        ShowMessage('Usuário Administrador. Impossivel aterar');
        abort;
    end;
    if (dbUsuarioUsuario.value='Convidado') then
    begin
        ShowMessage('Usuário de Sistema. Impossivel alterar');
        abort;
    end;
    if dbUsuarioTipo.value='T' then
    begin
        grdUsuario.Columns[2].ReadOnly:=false;
        grdUsuario.Columns[11].ReadOnly:=false;
        grdUsuario.Columns[12].ReadOnly:=false;
    end;    
    dbUsuarioUsuarioA.Value:=iUsuario;
    dbUsuarioDataAlteracao.value:=date;
    iDataFim:=dbUsuarioDataFim.value;
end;

procedure TfrmAcesso.dbUsuarioBeforePost(DataSet: TDataSet);
begin
    if dbUsuarioUsuario.value=' ANDROS' then
        dbUsuarioDataFim.isnull;
    if ((iDataFim=null) or (iDataFim=0)) and (not dbUsuarioDataFim.isnull) then
    begin
        dbUsuarioDataExclusao.value:=date;
        dbUsuarioUsuarioE.value:=iUsuario;
    end;
end;

procedure TfrmAcesso.dsUsuarioStateChange(Sender: TObject);
begin
     cmdNovoU.Default:=dbUsuario.State in [dsBrowse];
     cmdAlteraU.Enabled:=(dbUsuario.State=dsBrowse)
                         and (dbUsuario.RecordCount<>0);
     cmdExcluiU.Enabled:=(dbUsuario.State in [dsEdit,dsBrowse,dsInsert])
                                       and (dbUsuario.RecordCount<>0);
     cmdGravaU.Enabled:=dbUsuario.State in [dsEdit,dsInsert];
end;

procedure TfrmAcesso.dbUsuarioCalcFields(DataSet: TDataSet);
begin
    dbUsuarioSenhaOpen.value:=Encrypt(dbUsuarioSenha.value);
end;

procedure TfrmAcesso.dbUsuarioAfterScroll(DataSet: TDataSet);
begin
    lblUsuarioLinha.Caption:=dbUsuarioUsuario.value;
end;

procedure TfrmAcesso.Sobre1Click(Sender: TObject);
begin
    if frmSobre=nil then
      Application.CreateForm(TfrmSobre, frmSobre);
    frmSobre.ShowModal;
end;

procedure TfrmAcesso.Proprietria1Click(Sender: TObject);
begin
    if frmProprietaria=nil then
       Application.CreateForm(TfrmProprietaria, frmProprietaria);
    frmProprietaria.ShowModal;
end;


procedure TfrmAcesso.chkAudClick(Sender: TObject);
begin
    dbUsuario.Refresh;
end;

procedure TfrmAcesso.chkFinClick(Sender: TObject);
begin
    dbUsuario.Refresh;
end;

procedure TfrmAcesso.chkAgendaClick(Sender: TObject);
begin
    dbUsuario.Refresh;
end;

procedure TfrmAcesso.chkISOClick(Sender: TObject);
begin
    dbUsuario.Refresh;
end;

procedure TfrmAcesso.BitBtn10Click(Sender: TObject);
begin
    if frmSenhaAltera=nil then
       Application.CreateForm(TfrmSenhaAltera, frmSenhaAltera);
    frmSenhaAltera.ShowModal;
end;

procedure TfrmAcesso.BitBtn1Click(Sender: TObject);
begin
    qryAcesso.Open;
    frmMenu.rvAcesso.SelectReport('RelAcessos',true);
    frmMenu.rvAcesso.Execute;

end;

procedure TfrmAcesso.qryAcessoCalcFields(DataSet: TDataSet);
begin
    if qryAcessoTipo_1.value='A' then
       qryAcessoTipoTexto.value:='Auditoria';
    if qryAcessoTipo_1.value='F' then
       qryAcessoTipoTexto.value:='Financeiro';
    if qryAcessoTipo_1.value='E' then
       qryAcessoTipoTexto.value:='Agenda';
    if qryAcessoTipo_1.value='I' then
       qryAcessoTipoTexto.value:='ISO';

    if qryAcessoMasterAud.value=true then
       qryAcessoAudTexto.value:='Sim'
    else
       qryAcessoAudTexto.value:='Não';

    if qryAcessoMasterFin.value=true then
       qryAcessoFinTexto.value:='Sim'
    else
       qryAcessoFinTexto.value:='Não';

    if qryAcessoMasterAgenda.value=true then
       qryAcessoAgendaTexto.value:='Sim'
    else
       qryAcessoAgendaTexto.value:='Não';

    if qryAcessoMasterISO.value=true then
       qryAcessoISOTexto.value:='Sim'
    else
       qryAcessoISOTexto.value:='Não';


    if qryAcessoGravacao.value=false then
       qryAcessoGravacaoTexto.value:='Somente consulta';
    if qryAcessoGravacao.value=true then
       qryAcessoGravacaoTexto.value:='Total(inclusão/exclusão)';
    if qryAcessoGravacao.isnull then
       qryAcessoGravacaoTexto.value:='';

end;

procedure TfrmAcesso.BitBtn2Click(Sender: TObject);
begin
    qryAcesso.Open;

    frmMenu.ExcelExport.Dataset:=qryAcesso;
    frmMenu.ExcelExport.ExcelVisible:=true;
    frmMenu.ExcelExport.ExportDataset;
    frmMenu.ExcelExport.Disconnect;

end;

procedure TfrmAcesso.GrupoBBB1Click(Sender: TObject);
begin
    if frmFilial=nil then
        Application.CreateForm(TfrmFilial, frmFilial);
    frmFilial.ShowMOdal;
end;

end.
