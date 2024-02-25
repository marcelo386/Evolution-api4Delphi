program EvolutionAPI4DelphiDEMO;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uRetMensagem in '..\Source\uRetMensagem.pas',
  uEvolutionAPI in '..\Source\uEvolutionAPI.pas',
  uWhatsAppBusinessClasses in '..\Source\uWhatsAppBusinessClasses.pas',
  uEventsMessageClasses in '..\Source\uEventsMessageClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
