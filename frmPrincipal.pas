unit frmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, DBTables, MSAccess, OLEDBAccess, OLEDBC, OLEDBIntf, DBAccess, MemDS, 
  StdCtrls, Buttons, DBCtrls, ImgList, ComCtrls,
  ToolWin, RpRenderPDF, RpRender, RpRenderHTML, RpBase, RpSystem, RpDefine,
  RpRave, RpFiler, RpRenderRTF, RpRenderText, RpCon, Variants,
  WinSkinData, DASQLMonitor, MSSQLMonitor, Grids, NetGradient, ExcelExport;

type
  TfrmMenu = class(TForm)
    lkuUsuario: TDBLookupComboBox;
    lblSenha: TEdit;
    cmdSenha: TBitBtn;
    dsUsuario: TDataSource;
    cmdSenhaok: TBitBtn;
    dadosaud: TMSConnection;
    NetGradient1: TNetGradient;
    NetGradient2: TNetGradient;
    dbLog: TMSQuery;
    dbLogRegistro: TIntegerField;
    dbLogModulo: TStringField;
    dbLogCliente: TIntegerField;
    dbLogCodigo1: TIntegerField;
    dbLogCodigo2: TIntegerField;
    dbLogCodigo3: TStringField;
    dbLogOperacao: TStringField;
    dbLogUsuario: TStringField;
    dbLogData: TDateTimeField;
    dbLogHora: TDateTimeField;
    dbLogCampos: TStringField;
    cmdAtuUsuario: TBitBtn;
    dbUsuario: TMSQuery;
    dbUsuarioUsuario: TStringField;
    dbUsuarioSenha: TStringField;
    dbUsuarioMasterAud: TBooleanField;
    dbUsuarioMasterFin: TBooleanField;
    dbUsuarioMasterAgenda: TBooleanField;
    dbUsuarioMasterISO: TBooleanField;
    SkinData: TSkinData;
    MSSQLMonitor: TMSSQLMonitor;
    dbUsuarioNomeUsuario: TStringField;
    dbUsuarioTipo: TStringField;
    dbUsuarioUsuarioI: TStringField;
    dbUsuarioDataInclusao: TDateTimeField;
    dbUsuarioBBAud: TBooleanField;
    dbUsuarioBBFin: TBooleanField;
    dbUsuarioBBAgenda: TBooleanField;
    dbUsuarioBBISO: TBooleanField;
    dbUsuarioMaster: TBooleanField;
    RvAcesso: TRvProject;
    RvSystem: TRvSystem;
    RvRenderPDF1: TRvRenderPDF;
    ExcelExport: TExcelExport;
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdSenhaClick(Sender: TObject);
    procedure cmdSenhaokClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbUsuarioGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dbUsuarioSetText(Sender: TField; const Text: String);
    procedure cmdAtuUsuarioClick(Sender: TObject);
  private
    { Private declarations }
  public
     function Log(xModulo: string; xcliente:integer; xCampo:string; xCodigo1:integer;xCodigo2:integer;xCodigo3:string;xOperacao:string):boolean;
  end;

var
  frmMenu: TfrmMenu;
  iUsuario,iDir, _Empresa:string;
  iMasterAud,iMasterFin,iMasterAge,iMasterIso:boolean;

implementation

uses frmAcessos;


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


function TfrmMenu.Log(xModulo: string;
                      xcliente:integer;
                      xCampo:string;
                      xCodigo1:integer;
                      xCodigo2:integer;
                      xCodigo3:string;
                      xOperacao:string):boolean;
begin
try
    dbLog.Insert;
    dbLogModulo.value:=xModulo;
    dbLogCliente.value:=xCliente;
    dbLogCampos.value:=xCampo;
    dbLogCodigo1.value:=xCodigo1;
    dbLogCodigo2.value:=xCodigo2;
    dbLogCodigo3.value:=xCodigo3;
    dbLogOperacao.value:=xOperacao;
    dbLogUsuario.value:=iUsuario;
    dbLogData.value:=date;
    dbLogHora.value:=time;
    dbLog.Post;
    Result:=true;
except
    ShowMessage('Houve uma falha ao tentar gravar o Log desta operaçao');
    Result:=false;
end;
end;


procedure TfrmMenu.Sair1Click(Sender: TObject);
var iResultado:integer;
begin
     iResultado:=Application.MessageBox('Deseja realmente sair?',
     'Aviso', mb_yesno+ mb_iconExclamation);
     if(iResultado=id_no) then abort;

     if iUsuario<>'Convidado' then
         Log('Fim de Sessão',0,'',0,0,'','S');
     Application.Terminate;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
var iservidor:Tstringlist;
var iconexao,idirSql:string;
begin
   CurrencyString:='R$';
   CurrencyFormat:=0; //simbolo a esquerda
   ThousandSeparator:='.';
   DecimalSeparator:=',';
   ShortDateFormat:='dd/mm/yyyy';
   LongMonthNames[1]:='Janeiro';
   LongMonthNames[2]:='Fevereiro';
   LongMonthNames[3]:='Março';
   LongMonthNames[4]:='Abril';
   LongMonthNames[5]:='Maio';
   LongMonthNames[6]:='Junho';
   LongMonthNames[7]:='Julho';
   LongMonthNames[8]:='Agosto';
   LongMonthNames[9]:='Setembro';
   LongMonthNames[10]:='Outubro';
   LongMonthNames[11]:='Novembro';
   LongMonthNames[12]:='Dezembro';
   LongDateFormat:='dd mmmm yyyy';

   iDir:=ExtractFilePath(Application.ExeName);
   iservidor:=tstringlist.create;
   iservidor.clear;

    if not FileExists(idirSql+'servidor.ini') then
    begin
        ShowMessage('Identificação do Servidor não encontrada');
        abort;
    end
    else iServidor.LoadFromFile(idirSql+'servidor.ini');

    iconexao:='Provider=SQLOLEDB.1;User ID=androsadm;Password=andros@2012;'+
              'Data Source='+iservidor.values['SERVIDOR']+';'+
              'Initial Catalog=BBAud;'+
              'Persist Security Info=True';

//Provider=SQLOLEDB.1;User ID=androsadm;Password=andros@2012;
//Data Source=ANDROS-VOSTRO\SQLEXPRESS;Initial Catalog=BBAud;Persist Security Info=True
   try
      dadosaud.ConnectString:=iconexao;
      dadosaud.Connected:=true;

      ShortDateFormat:='dd/mm/yyyy';

      _Empresa:='B+ Auditoria Médica';

      dbUsuario.Open;
      if not dbUsuario.Locate('Usuario',' ANDROS',[]) then
      begin
        dbUsuario.Insert;
        dbUsuarioUsuario.value:=' ANDROS';
        dbUsuarioNomeUsuario.value:='Andros Informática';
        dbUsuarioTipo.value:='T';
        dbUsuarioMaster.value:=true;
        dbUsuarioBBAud.value:=true;
        dbUsuarioMasterAud.value:=true;
        dbUsuarioBBFin.value:=true;
        dbUsuarioMasterFin.value:=true;
        dbUsuarioBBAgenda.value:=true;
        dbUsuarioMasterAgenda.value:=true;
        dbUsuarioBBIso.value:=true;
        dbUsuarioMasterIso.value:=true;
        dbUsuarioUsuarioI.value:=' ANDROS';
        dbUsuarioDataInclusao.value:=date;
        dbUsuarioSenha.value:=Encrypt('1217');
        dbUsuario.Post;
    end;
      dbUsuario.Locate('Usuario','Convidado',[]);
      iUsuario:=dbUsuarioUsuario.Text;
      iMasterAud:=dbUsuarioMasterAud.Value;
      iMasterFin:=dbUsuarioMasterFin.Value;
      iMasterAge:=dbUsuarioMasterAgenda.Value;
      iMasterIso:=dbUsuarioMasterIso.Value;
      dbLog.SQL.Text:='Select * from LogA where Data=:iData ';
      dbLog.ParamByName('iData').asdate:=date;
      dbLog.Open;

      rvAcesso.ProjectFile:=idir+'BBAcesso.rav';
      rvAcesso.Open;
//      SkinData.SkinFile:=idir+'Skin\SKINAZUL.skn';  //Auditoria

   finally
     Screen.Cursor := crDefault;
     lkuUsuario.KeyValue:='Convidado';
     lkuUsuario.Enabled:=false;
     lblSenha.Enabled:=false;
     cmdSenhaok.Visible:=false;
   end;                            
end;

procedure TfrmMenu.cmdSenhaClick(Sender: TObject);
begin
     lkuUsuario.Enabled:=true;
     lblSenha.Enabled:=true;
     cmdSenha.Visible:=false;
     cmdSenhaok.Visible:=true;
     lkuUsuario.SetFocus;
end;

procedure TfrmMenu.cmdSenhaokClick(Sender: TObject);
var iSenha:string;
begin
     dbUsuario.Refresh;
     dbUsuario.Locate('Usuario',lkuUsuario.KeyValue,[]);
     iSenha:=Encrypt(dbUsuarioSenha.Text);

     if iSenha<>lblSenha.Text then
     begin
        ShowMessage('Senha inválida!');
        Log('Senha inválida',0,'',0,0,'','A');
        abort;
     end;
     iUsuario:=dbUsuarioUsuario.Text;
     iMasterAud:=dbUsuarioMasterAud.Value;
     iMasterFin:=dbUsuarioMasterFin.Value;
     iMasterAge:=dbUsuarioMasterAgenda.Value;
     iMasterIso:=dbUsuarioMasterIso.Value;
     lkuUsuario.Enabled:=false;
     lblSenha.Text:='';
     lblSenha.Enabled:=false;
     cmdSenha.Visible:=true;
     cmdSenhaok.Visible:=false;

     if iUsuario<>'Convidado' then
         Log('Início de Sessão',0,'',0,0,'','S');
     if frmAcesso=nil then
          Application.CreateForm(TfrmAcesso, frmAcesso);
     frmAcesso.ShowModal;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     dbUsuario.Close;
     dbLog.Close;

     dadosaud.Connected:=false;
     RvAcesso.Close;
     Application.Terminate;


end;

procedure TfrmMenu.dbUsuarioGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
    if sender.value=true then
       text:='Sim';
    if sender.value=false then
       text:='Não';
end;

procedure TfrmMenu.dbUsuarioSetText(Sender: TField; const Text: String);
begin
    if text='Sim' then
        sender.value:=true;
    if text='Não' then
        sender.value:=false;

end;

procedure TfrmMenu.cmdAtuUsuarioClick(Sender: TObject);
begin
    dbUsuario.Refresh;
end;

end.
