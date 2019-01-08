object FrmPrincipal: TFrmPrincipal
  Left = 511
  Top = 229
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SecurityRobot Tool'
  ClientHeight = 350
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BtnAtivar: TButton
    Left = 88
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Ativar'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BtnAtivarClick
  end
  object BtnProcurar: TButton
    Left = 8
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Procurar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BtnProcurarClick
  end
  object MmoLog: TMemo
    Left = 8
    Top = 8
    Width = 313
    Height = 305
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object SePorta: TSpinEdit
    Left = 168
    Top = 322
    Width = 153
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 4
    MaxValue = 1024
    MinValue = 1
    ParentFont = False
    TabOrder = 3
    Value = 900
  end
end
