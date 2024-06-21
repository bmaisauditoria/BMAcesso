program BMAcesso;

uses
  Forms,
  frmAcessos in 'frmAcessos.pas' {frmAcesso},
  frmPrincipal in 'frmPrincipal.pas' {frmMenu},
  frmProprietarias in 'frmProprietarias.pas' {frmProprietaria},
  frmSenhas in 'frmSenhas.pas' {frmSenha},
  frmSenhasAltera in 'frmSenhasAltera.pas' {frmSenhaAltera},
  frmSobres in 'frmSobres.pas' {frmSobre},
  frmFiliais in 'frmFiliais.pas' {frmFilial};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
