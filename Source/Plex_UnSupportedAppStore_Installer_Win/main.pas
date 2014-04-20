unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, XPMan, StdCtrls, AbBase, AbBrowse,
  AbZBrows, AbUnzper;

type
  TForm1 = class(TForm)
    panMain: TPanel;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    AboutThis1: TMenuItem;
    Settings1: TMenuItem;
    EnableDebug1: TMenuItem;
    XPManifest1: TXPManifest;
    rEdtMain: TRichEdit;
    PanButtom: TPanel;
    btnExit: TButton;
    btnGo: TButton;
    AbUnZipper1: TAbUnZipper;
    procedure FormCreate(Sender: TObject);
    procedure EnableDebug1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
    function findPlugInDir(var myPlugInsDir : String) : Boolean;
    function getFromGitHub : boolean;
    function extractZip(myPlugInsDir : String) : Boolean;
    procedure cleanUp(myPlugInsDir : String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PlexPlugInDir : WideString;

implementation


uses debug, URLMon;

Const
  urlGitHub = 'https://github.com/mikedm139/UnSupportedAppstore.bundle/archive/master.zip';


{$R *.dfm}

procedure TForm1.btnExitClick(Sender: TObject);
begin
  self.Close;
end;

procedure TForm1.btnGoClick(Sender: TObject);
var
  myPlugInsDir : String;
begin
  // Check for PlugIn Dir
  if self.findPlugInDir(myPlugInsDir) Then
  begin
    getFromGitHub;
    self.extractZip(myPlugInsDir);
    self.cleanUp(myPlugInsDir);
  end
  else
    ShowMessage('Not Found');
end;

procedure TForm1.EnableDebug1Click(Sender: TObject);
begin
  // Enable-Disable Debug logging
  EnableDebug1.Checked :=  Not(EnableDebug1.Checked)
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If MessageDlg('Do you really want to exit ' + Application.Title + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
  Begin
    if EnableDebug1.Checked then DebugPrint('Ending Program');
    Action := caFree
  End
  else
    Action := caNone;
end;

procedure TForm1.FormCreate(Sender: TObject);
// Executed when the form is created
begin
  screen.Cursor := crHourglass;
  self.StatusBar1.Panels[1].Text := 'Initalizing.....Please wait';
  self.Caption := Application.Title;
  if EnableDebug1.Checked then DebugPrint('Starting');
  self.StatusBar1.Panels[1].Text := 'Waiting for my Master to click a button';
  screen.Cursor := crDefault;
end;

function TForm1.findPlugInDir(var myPlugInsDir : String) : Boolean;
{This function will populate the global var named PlexPlugInDir with the location
 of the PlugIn Directory, and if success, return true, else false}
begin
  screen.Cursor := crHourglass;
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('Starting to locate the Plex Media Server PlugIns directory');
  self.StatusBar1.Panels[1].Text := 'Starting to locate the Plex Media Server PlugIns directory';
  self.StatusBar1.Refresh;
  self.rEdtMain.Refresh;
  if EnableDebug1.Checked then DebugPrint('Starting to locate the plug-in directory');
  // Let's start by looking at the default directory below the %LOCALAPPDATA%'
  myPlugInsDir := GetEnvironmentVariable(pWideChar('LOCALAPPDATA')) + '\Plex Media Server\Plug-ins';
  result := DirectoryExists(myPlugInsDir);
  if result then
  begin
    self.rEdtMain.Lines.Append('');
    self.rEdtMain.Lines.Append('Found Plex Media Server PlugIns directory here:');
    self.rEdtMain.Lines.Append(myPlugInsDir);
    self.StatusBar1.Panels[1].Text := 'Plex Media Server PlugIns directory located';
    self.StatusBar1.Refresh;
    self.rEdtMain.Refresh;
  end
  else
  begin
    self.rEdtMain.Lines.Append('');
    self.rEdtMain.Lines.Append('ERROR.....Failed to locate the PlugIns directory');
      self.rEdtMain.Refresh;
  end;
  screen.Cursor := crDefault;
end;

function TForm1.getFromGitHub : boolean;
// Fetch the bundle directly from GitHub
var
  targetDir : String;
begin
  screen.Cursor := crHourglass;
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('Creating temp directory');
  self.rEdtMain.Refresh;
  // Let's start by creating a directory in users temp dir to store the download in
  targetDir := GetEnvironmentVariable(pWideChar('TEMP')) + '\PlexTmp';
  ForceDirectories(targetDir);
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('Downloading from GitHub');
  self.StatusBar1.Panels[1].Text := 'Downloading';
  self.StatusBar1.Refresh;
  self.rEdtMain.Refresh;
  URLDownloadToFile(nil,
                  urlGitHub,
                  PChar(targetDir + '\bundle.zip'),
                  0,
                  nil);
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('Download completed');
  self.StatusBar1.Panels[1].Text := 'Waiting for my Master to click a button';
  self.StatusBar1.Refresh;
  self.rEdtMain.Refresh;
  screen.Cursor := crDefault;
end;

function TForm1.extractZip(myPlugInsDir : String) : Boolean;
// This will extract the downloaded zip file
begin
  screen.Cursor := crHourglass;
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('Extracting Unsupported AppStore');
  self.StatusBar1.Panels[1].Text := 'Extracting';
  self.StatusBar1.Refresh;
  self.rEdtMain.Refresh;
  self.AbUnZipper1.BaseDirectory := myPlugInsDir;
  self.AbUnZipper1.FileName := GetEnvironmentVariable(pWideChar('TEMP')) + '\PlexTmp\bundle.zip';
  self.AbUnZipper1.ExtractFiles( '*.*' );
  self.AbUnZipper1.CloseArchive;
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('Unsupported AppStore has been installed');
  self.StatusBar1.Panels[1].Text := 'Extracted AppStore';
  self.StatusBar1.Refresh;
  self.rEdtMain.Refresh;
  screen.Cursor := crDefault;
end;

procedure TForm1.cleanUp(myPlugInsDir : String);
var
  myTmpDir : String;
begin
  screen.Cursor := crHourglass;
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('Cleanup of unneeded files');
  self.StatusBar1.Panels[1].Text := '´Cleanup';
  self.StatusBar1.Refresh;
  self.rEdtMain.Refresh;
  // Remove the Temp directory again
  myTmpDir := GetEnvironmentVariable(pWideChar('TEMP')) + '\PlexTmp';
  // Remove downloaded file first
  DeleteFile(myTmpDir + '\bundle.zip');
  // Now for the Directory itself
  rmDir(myTmpDir);
  // All we need now, is to rename the extracted zip directory
  RenameFile(myPlugInsDir + '\UnSupportedAppstore.bundle-master', myPlugInsDir + '\UnSupportedAppstore.bundle');
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('UnSupported AppStore has been installed');
  self.rEdtMain.Lines.Append('If already running a browser against Plex Media Server, you');
  self.rEdtMain.Lines.Append('might have to refresh your browser');
  self.rEdtMain.Lines.Append('');
  self.rEdtMain.Lines.Append('You may close this program....And enjoy all the nice channels :-)');
  self.StatusBar1.Panels[1].Text := 'All done....You may close me';
  self.StatusBar1.Refresh;
  self.rEdtMain.Refresh;
  screen.Cursor := crDefault;

end;

end.
