unit debug;

interface

Procedure DebugPrint(Sender: TObject; Info : String); Overload; Forward;
Procedure DebugPrint(Info : String); overload; Forward;
Procedure DebugPrint; overload; Forward;

implementation

Uses
  Dialogs,
  SysUtils;

Procedure DebugPrint(Sender: TObject; Info : String); overload;
Var
  MyFile : TextFile;
  MyInfo : String;
  DateTime : TDateTime;
  DebugFile : String;
Begin
  DebugFile := ExtractFileName(ParamStr(0)) + '.log';
  If Not FileExists(ExtractFilePath(ParamStr(0)) + DebugFile) Then
  Begin
    AssignFile(MyFile, ExtractFilePath(ParamStr(0)) + DebugFile);
    Rewrite(MyFile);
    CloseFile(MyFile);
  End;
  Begin
    AssignFile(MyFile, ExtractFilePath(ParamStr(0)) + DebugFile);
    Append(MyFile);
    DateTime := Time;  // store the current date and time
    MyInfo := DateToStr(Date) + ' ' + TimeToStr(DateTime) + '  Unit : ' + Sender.ClassName  + ' ' + Info;
    Writeln(MyFile, MyInfo);
    Flush(MyFile);  { ensures that the text was actually written to file }
    CloseFile(MyFile);
  End;
End;

Procedure DebugPrint(Info : String); overload;
//Write a string to the debug file
Var
  MyFile : TextFile;
  MyInfo : String;
  DateTime : TDateTime;
  DebugFile : String;
Begin
  DebugFile := ExtractFileName(ParamStr(0)) + '.log';
  If Not FileExists(ExtractFilePath(ParamStr(0)) + DebugFile) Then
  Begin
    AssignFile(MyFile, ExtractFilePath(ParamStr(0)) + DebugFile);
    Rewrite(MyFile);
    CloseFile(MyFile);
  End;
  Begin
    AssignFile(MyFile, ExtractFilePath(ParamStr(0)) + DebugFile);
    Append(MyFile);
    DateTime := Time;  // store the current date and time
    MyInfo := DateToStr(Date) + ' ' + TimeToStr(DateTime) + ' ' + Info;
    Writeln(MyFile, MyInfo);
    Flush(MyFile);  { ensures that the text was actually written to file }
    CloseFile(MyFile);
  End;
End;

Procedure DebugPrint; overload;
//Write an empty line to the debug file
Var
  MyFile : TextFile;
  DebugFile : String;
Begin
  DebugFile := ExtractFileName(ParamStr(0)) + '.log';
  If Not FileExists(ExtractFilePath(ParamStr(0)) + DebugFile) Then
  Begin
    AssignFile(MyFile, ExtractFilePath(ParamStr(0)) + DebugFile);
    Rewrite(MyFile);
    CloseFile(MyFile);
  End;
  Begin
    AssignFile(MyFile, ExtractFilePath(ParamStr(0)) + DebugFile);
    Append(MyFile);
    Writeln(MyFile, '');
    Flush(MyFile);  { ensures that the text was actually written to file }
    CloseFile(MyFile);
  End;
End;

end.
