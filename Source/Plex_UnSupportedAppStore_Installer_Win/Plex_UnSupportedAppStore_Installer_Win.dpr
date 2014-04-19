program Plex_UnSupportedAppStore_Installer_Win;

uses
  Forms,
  main in 'main.pas' {Form1},
  debug in 'debug.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Windows Installer for the Plex UnSupportedAppStore';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
