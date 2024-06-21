unit frmSenhasAltera;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons;

type
  TfrmSenhaAltera = class(TForm)
    pnSenha: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBText1: TDBText;
    cmdGravaPreco: TBitBtn;
    cmdCancelaTab: TBitBtn;
    lblSenha: TEdit;
    lblSenhaNova: TEdit;
    lblSenhaNova1: TEdit;
    procedure cmdCancelaTabClick(Sender: TObject);
    procedure cmdGravaPrecoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  frmSenhaAltera: TfrmSenhaAltera;


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

procedure TfrmSenhaAltera.cmdCancelaTabClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmSenhaAltera.cmdGravaPrecoClick(Sender: TObject);
var iSenha:string;
begin
     iSenha:=Encrypt(frmAcesso.dbUsuarioSenha.Text);
     if iSenha<>lblSenha.Text then
     begin
        ShowMessage('Senha Atual incorreta!');
        lblSenha.Clear;
        lblSenhaNova.Clear;
        lblSenhaNova1.Clear;
        abort;
     end;

     if (lblSenhaNova.Text='0000') or
        (lblSenhaNova1.Text='0000') then
     begin
        ShowMessage('Senha de usuário novo inválida');
        lblSenha.Clear;
        lblSenhaNova.Clear;
        lblSenhaNova1.Clear;
        abort;
     end;

     if lblSenhaNova.Text<>lblSenhaNova1.Text then
     begin
        ShowMessage('Confirmação da senha nova não confere');
        lblSenha.Clear;
        lblSenhaNova.Clear;
        lblSenhaNova1.Clear;
        abort;
     end;

     frmAcesso.dbUsuario.Edit;
     frmAcesso.dbUsuarioSenha.Text:=Encrypt(lblSenhaNova.Text);
     frmAcesso.dbUsuario.Post;

     ShowMessage('Senha alterada com Sucesso!');
     Close;
end;

procedure TfrmSenhaAltera.FormShow(Sender: TObject);
begin
    lblSenha.Clear;
    lblSenhaNova.Clear;
    lblSenhaNova1.Clear;
end;

end.
