object InstForm: TInstForm
  Left = 0
  Top = 0
  Caption = 'Installer creator'
  ClientHeight = 304
  ClientWidth = 321
  Color = clBtnFace
  Constraints.MinHeight = 210
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    321
    304)
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 47
    Top = 8
    Width = 266
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 39
    Width = 33
    Height = 41
    Caption = '+'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 86
    Width = 33
    Height = 41
    Caption = '-'
    TabOrder = 2
  end
  object Save: TButton
    Left = 256
    Top = 271
    Width = 57
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    TabOrder = 3
  end
end
