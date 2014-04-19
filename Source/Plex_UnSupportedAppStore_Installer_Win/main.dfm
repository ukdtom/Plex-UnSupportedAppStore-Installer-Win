object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object panMain: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 540
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 176
    ExplicitTop = 48
    ExplicitWidth = 393
    ExplicitHeight = 405
    object rEdtMain: TRichEdit
      Left = 1
      Top = 1
      Width = 798
      Height = 538
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'Welcome to the Windows Installer for Plex UnSupportedAppstore.'
        ''
        'This app. was made by Dane22, a Plex Community member.'
        ''
        
          'This small application will download and install the UnSupported' +
          ' Application Store '
        'by Mikedm139 from the Plex Forums.'
        ''
        
          'This application is provided as is, meaning :" Use at your own r' +
          'isk "'
        ''
        'If proceding, you ackknowlegde to this.'
        ''
        'To continue, simply press the button named "GO" below')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      ExplicitLeft = 576
      ExplicitTop = 296
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 581
    Width = 800
    Height = 19
    Panels = <
      item
        Text = 'Status:'
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object PanButtom: TPanel
    Left = 0
    Top = 540
    Width = 800
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 448
    ExplicitTop = 496
    ExplicitWidth = 185
    object btnExit: TButton
      Left = 672
      Top = 10
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Exit'
      TabOrder = 0
      OnClick = btnExitClick
    end
    object btnGo: TButton
      Left = 552
      Top = 8
      Width = 75
      Height = 25
      Caption = '&GO'
      TabOrder = 1
    end
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 544
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'E&xit'
      end
    end
    object Settings1: TMenuItem
      Caption = '&Settings'
      object EnableDebug1: TMenuItem
        Caption = 'Enable &Debug'
        OnClick = EnableDebug1Click
      end
    end
    object About1: TMenuItem
      Caption = '&About'
      object AboutThis1: TMenuItem
        Caption = 'About &This'
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 56
    Top = 544
  end
end
