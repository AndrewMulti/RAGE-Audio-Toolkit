object AStreamCreate: TAStreamCreate
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create Audio Stream'
  ClientHeight = 359
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    467
    359)
  PixelsPerInch = 96
  TextHeight = 13
  object OKButton: TButton
    Left = 303
    Top = 326
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    TabOrder = 0
    OnClick = OKButtonClick
  end
  object CheckRadio: TCheckBox
    Left = 11
    Top = 55
    Width = 97
    Height = 17
    Caption = 'Is Radio Stream'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 355
    Height = 41
    Caption = 'Stream Full Name'
    TabOrder = 2
    DesignSize = (
      355
      41)
    object MainName: TEdit
      Left = 3
      Top = 16
      Width = 349
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 367
    Top = 8
    Width = 97
    Height = 42
    Caption = 'Duration'
    TabOrder = 3
    object MaskEdit1: TMaskEdit
      Left = 2
      Top = 16
      Width = 92
      Height = 21
      EditMask = '!90:00:00;1;_'
      MaxLength = 8
      TabOrder = 0
      Text = '  :  :  '
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 78
    Width = 129
    Height = 43
    Caption = 'Channels'
    TabOrder = 4
    object JvSpinEdit1: TJvSpinEdit
      Left = 5
      Top = 19
      Width = 121
      Height = 21
      MaxValue = 10.000000000000000000
      TabOrder = 0
      OnChange = JvSpinEdit1Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 143
    Top = 78
    Width = 316
    Height = 43
    Caption = 'File Path'
    TabOrder = 5
    object FileList: TComboBox
      Left = 3
      Top = 19
      Width = 310
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object ChannelsGrid: TStringGrid
    Left = 8
    Top = 127
    Width = 451
    Height = 193
    ColCount = 2
    DefaultRowHeight = 21
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssNone
    TabOrder = 6
    ColWidths = (
      203
      212)
  end
  object Button1: TButton
    Left = 384
    Top = 326
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 7
    OnClick = Button1Click
  end
end
