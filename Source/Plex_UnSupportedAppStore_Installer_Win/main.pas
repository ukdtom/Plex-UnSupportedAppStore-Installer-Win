unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, XPMan, StdCtrls;

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
    procedure FormCreate(Sender: TObject);
    procedure EnableDebug1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
    function findPlugInDir : Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  PlexPlugInDir : WideString;

implementation

uses debug;

{$R *.dfm}

procedure TForm1.btnExitClick(Sender: TObject);
begin
  self.Close;
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

function TForm1.findPlugInDir : Boolean;
{This function will populate the global var named PlexPlugInDir with the location
 of the PlugIn Directory, and if success, return true, else false}
begin
  screen.Cursor := crHourglass;
  if EnableDebug1.Checked then DebugPrint('Starting to locate the plug-in directory');


  screen.Cursor := crDefault;
end;

end.
