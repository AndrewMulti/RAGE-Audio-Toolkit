object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'RAGE Audio Toolkit'
  ClientHeight = 635
  ClientWidth = 879
  Color = clBtnFace
  Constraints.MinHeight = 474
  Constraints.MinWidth = 706
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 536
    Top = 88
    Width = 105
    Height = 105
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 0
    Width = 879
    Height = 616
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    OnChange = PageControl2Change
    object TabSheet3: TTabSheet
      Caption = 'Metadata'
      object JvSplitter3: TJvSplitter
        Left = 273
        Top = 0
        Height = 588
        ResizeStyle = rsUpdate
        ExplicitTop = -2
        ExplicitHeight = 544
      end
      object GameLeftPanel: TPanel
        Left = 0
        Top = 0
        Width = 273
        Height = 588
        Align = alLeft
        TabOrder = 0
        DesignSize = (
          273
          588)
        object GameTypeGrid: TStringGrid
          Left = 3
          Top = 387
          Width = 261
          Height = 198
          Anchors = [akLeft, akRight, akBottom]
          ColCount = 2
          DefaultColWidth = 128
          DefaultRowHeight = 20
          RowCount = 9
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 0
          OnSetEditText = GameTypeGridSetEditText
          ColWidths = (
            128
            128)
          RowHeights = (
            20
            20
            20
            20
            20
            20
            20
            20
            20)
        end
        object PageControl1: TPageControl
          Left = 3
          Top = 27
          Width = 265
          Height = 354
          ActivePage = TabSheet1
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 1
          object TabSheet1: TTabSheet
            Caption = 'Meta'
            DesignSize = (
              257
              326)
            object Label1: TLabel
              Left = 3
              Top = 7
              Width = 33
              Height = 13
              Caption = 'Search'
            end
            object GameItems: TListBox
              Left = 0
              Top = 32
              Width = 257
              Height = 294
              Align = alBottom
              Anchors = [akLeft, akTop, akRight, akBottom]
              ItemHeight = 13
              MultiSelect = True
              PopupMenu = MetaPopup
              TabOrder = 0
              OnClick = GameItemsClick
            end
            object Edit3: TEdit
              Left = 40
              Top = 5
              Width = 214
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
              OnChange = Edit3Change
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Files'
            ImageIndex = 1
            object GamePathNames: TListBox
              Left = 0
              Top = 0
              Width = 257
              Height = 326
              Align = alClient
              ItemHeight = 13
              PopupMenu = FilesPopup
              TabOrder = 0
            end
          end
        end
        object FileSelect: TComboBox
          Left = 3
          Top = 0
          Width = 264
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          OnSelect = FileSelectSelect
        end
      end
      object GameRightPanel: TPanel
        Left = 276
        Top = 0
        Width = 595
        Height = 588
        Align = alClient
        TabOrder = 1
        DesignSize = (
          595
          588)
        object GameNameEnter: TLabel
          Left = 6
          Top = 9
          Width = 27
          Height = 13
          Caption = 'Name'
        end
        object GameHexLabel: TLabel
          Left = 6
          Top = 51
          Width = 44
          Height = 13
          Caption = 'Hex view'
        end
        object GameSaveInfo: TButton
          Left = 497
          Top = 556
          Width = 90
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Save'
          TabOrder = 0
          OnClick = GameSaveInfoClick
        end
        object GameResetInfo: TButton
          Left = 401
          Top = 556
          Width = 90
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Reset to default'
          TabOrder = 1
          OnClick = GameResetInfoClick
        end
        object GameName: TEdit
          Left = 6
          Top = 24
          Width = 580
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
        object GameHex: TStringGrid
          Left = 6
          Top = 66
          Width = 580
          Height = 484
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clBtnFace
          ColCount = 16
          DefaultColWidth = 23
          DefaultRowHeight = 20
          FixedCols = 0
          RowCount = 2
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goThumbTracking]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnDrawCell = GameHexDrawCell
          OnKeyPress = GameHexKeyPress
          OnMouseMove = GameHexMouseMove
          OnSelectCell = GameHexSelectCell
          OnSetEditText = GameHexSetEditText
          ColWidths = (
            23
            23
            23
            23
            23
            23
            23
            23
            23
            23
            23
            23
            23
            23
            23
            23)
          RowHeights = (
            20
            20)
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Speech'
      ImageIndex = 1
      object JvSplitter2: TJvSplitter
        Left = 265
        Top = 0
        Height = 588
        ResizeStyle = rsUpdate
        ExplicitTop = -2
        ExplicitHeight = 544
      end
      object SpeechLeftPanel: TPanel
        Left = 0
        Top = 0
        Width = 265
        Height = 588
        Align = alLeft
        TabOrder = 0
        object JvSplitter4: TJvSplitter
          Left = 1
          Top = 369
          Width = 263
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ResizeStyle = rsUpdate
          ExplicitTop = 401
          ExplicitWidth = 166
        end
        object SpeechCTop: TPanel
          Left = 1
          Top = 1
          Width = 263
          Height = 368
          Align = alTop
          TabOrder = 0
          DesignSize = (
            263
            368)
          object Label4: TLabel
            Left = 3
            Top = 24
            Width = 33
            Height = 13
            Caption = 'Entries'
          end
          object EntryList: TListBox
            Left = 1
            Top = 40
            Width = 261
            Height = 327
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 13
            PopupMenu = SpeechPopup
            TabOrder = 0
            OnClick = EntryListClick
          end
          object SpeechSelect: TComboBox
            Left = 3
            Top = 0
            Width = 259
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
            OnSelect = SpeechSelectSelect
          end
        end
        object SpeechCBottom: TPanel
          Left = 1
          Top = 372
          Width = 263
          Height = 215
          Align = alClient
          TabOrder = 1
          object Label9: TLabel
            Left = 3
            Top = 2
            Width = 21
            Height = 13
            Caption = 'Files'
          end
          object SpeechFL: TListBox
            Left = 1
            Top = 16
            Width = 261
            Height = 198
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 13
            PopupMenu = SpeechFLPopup
            TabOrder = 0
          end
        end
      end
      object SpeechRightPanel: TPanel
        Left = 268
        Top = 0
        Width = 603
        Height = 588
        Align = alClient
        TabOrder = 1
        DesignSize = (
          603
          588)
        object Label6: TLabel
          Left = 6
          Top = 92
          Width = 35
          Height = 13
          Caption = 'Sounds'
        end
        object Label5: TLabel
          Left = 6
          Top = 51
          Width = 87
          Height = 13
          Caption = 'Number of sounds'
        end
        object Label3: TLabel
          Left = 6
          Top = 9
          Width = 27
          Height = 13
          Caption = 'Name'
        end
        object SpeechSave: TButton
          Left = 510
          Top = 557
          Width = 89
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Save'
          TabOrder = 0
          OnClick = SpeechSaveClick
        end
        object SpeechGrid: TStringGrid
          Left = 6
          Top = 107
          Width = 592
          Height = 447
          Anchors = [akLeft, akTop, akRight, akBottom]
          ColCount = 4
          DefaultRowHeight = 21
          FixedCols = 0
          RowCount = 2
          GradientEndColor = clMedGray
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goThumbTracking]
          ScrollBars = ssVertical
          TabOrder = 1
          OnSelectCell = SpeechGridSelectCell
          ColWidths = (
            171
            159
            112
            137)
        end
        object SpeechDefault: TButton
          Left = 414
          Top = 557
          Width = 90
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Reset to default'
          TabOrder = 2
          OnClick = SpeechDefaultClick
        end
        object AudioBankNameEdit: TEdit
          Left = 6
          Top = 24
          Width = 590
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
        end
        object JvSpinEdit1: TJvSpinEdit
          Left = 6
          Top = 65
          Width = 121
          Height = 21
          MaxValue = 65535.000000000000000000
          Enabled = False
          TabOrder = 4
          OnChange = JvSpinEdit1Change
        end
        object SpeechFiles: TComboBox
          Left = 375
          Top = 65
          Width = 204
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 5
          OnChange = SpeechFilesChange
          OnExit = SpeechFilesExit
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'XML Editor'
      ImageIndex = 3
      DesignSize = (
        871
        588)
      object Splitter1: TSplitter
        Left = 0
        Top = 0
        Height = 588
        ExplicitLeft = 192
        ExplicitTop = 224
        ExplicitHeight = 100
      end
      object XMLSelect: TComboBox
        Left = 0
        Top = 0
        Width = 868
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnSelect = XMLSelectSelect
      end
      object SynEdit1: TSynEdit
        Left = 0
        Top = 27
        Width = 868
        Height = 558
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 1
        CodeFolding.GutterShapeSize = 11
        CodeFolding.CollapsedLineColor = clGrayText
        CodeFolding.FolderBarLinesColor = clGrayText
        CodeFolding.IndentGuidesColor = clGray
        CodeFolding.IndentGuides = True
        CodeFolding.ShowCollapsedLine = False
        CodeFolding.ShowHintMark = True
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = SynXMLSyn1
        FontSmoothing = fsmNone
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 616
    Width = 879
    Height = 19
    Panels = <
      item
        Width = 400
      end
      item
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Width = 400
      end>
  end
  object MainMenu1: TMainMenu
    Left = 392
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
      object Save2: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save2Click
      end
      object Save1: TMenuItem
        Caption = 'Save all'
        OnClick = Save1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object hisfiletooP1: TMenuItem
        Caption = 'File to oP'
        Visible = False
        OnClick = hisfiletooP1Click
      end
      object oPtofile1: TMenuItem
        Caption = 'oP to file'
        Visible = False
        OnClick = oPtofile1Click
      end
      object N2: TMenuItem
        Caption = '-'
        Visible = False
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Settings'
      object Setgamedirectory1: TMenuItem
        Caption = 'Set game directory'
        OnClick = Setgamedirectory1Click
      end
      object Makebackups1: TMenuItem
        AutoCheck = True
        Caption = 'Make backups'
      end
    end
    object About1: TMenuItem
      Caption = 'About'
      OnClick = About1Click
    end
  end
  object MetaPopup: TPopupMenu
    Left = 464
    Top = 8
    object Create1: TMenuItem
      Caption = 'Create'
      Visible = False
      object Audiostream1: TMenuItem
        Caption = 'Audio stream'
      end
    end
    object N4: TMenuItem
      Caption = '-'
      Visible = False
    end
    object Duplicate2: TMenuItem
      Caption = 'Duplicate'
      ShortCut = 16452
      OnClick = Duplicate2Click
    end
    object Duplicateto1: TMenuItem
      Caption = 'Duplicate to...'
    end
    object Delete2: TMenuItem
      Caption = 'Delete'
      ShortCut = 16430
      OnClick = Delete2Click
    end
    object Movetobottom1: TMenuItem
      Caption = '-'
    end
    object Movetotop1: TMenuItem
      Caption = 'Move to top'
      OnClick = Movetotop1Click
    end
    object Moveup1: TMenuItem
      Caption = 'Move up'
      ShortCut = 16465
      OnClick = Moveup1Click
    end
    object Movedown1: TMenuItem
      Caption = 'Move down'
      ShortCut = 16449
      OnClick = Movedown1Click
    end
    object Movetobottom2: TMenuItem
      Caption = 'Move to bottom'
      OnClick = Movetobottom2Click
    end
  end
  object FilesPopup: TPopupMenu
    Left = 464
    Top = 64
    object Insert1: TMenuItem
      Caption = 'Add'
      OnClick = Insert1Click
    end
    object Rename1: TMenuItem
      Caption = 'Rename'
      OnClick = Rename1Click
    end
    object Delete3: TMenuItem
      Caption = 'Delete'
      OnClick = Delete3Click
    end
  end
  object SynXMLSyn1: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 524
    Top = 8
  end
  object JvImageList1: TJvImageList
    Items = <>
    Left = 528
    Top = 64
    Bitmap = {
      494C010104001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F4F4F40BEEEE
      EE11EFEFEF10EFEFEF10EFEFEF10EFEFEF10EFEFEF10EEEEEE11F4F4F40B0000
      0000000000000000000000000000000000005791C3AB33C8FCFF33C8FCFF33C8
      FCFF33C8FCFF33C8FCFF34C9FCFF34C9FCFF34C9FCFF33C8FCFF33C8FCFF33C8
      FCFF33C8FCFFCCECF93D00000000000000009B7E80ABB17E81FFB17E81FFB17E
      81FFB17E81FFB17E81FFB27F82FFB27F82FFB27F82FFB17E81FFB17E81FFB17E
      81FFB17E81FFE9DCDC3D00000000000000000000000000000000B8B7B8FFB6B5
      B6FFB4B3B4FFB1B1B1FFAFAFAFFFADADAEFFABAAABFFA9A8AAFFA6A5A7FFA4A4
      A5FFA2A2A3FF00000000000000000000000000000000000000009E9E9EB28E8E
      8EBD8E8E8EBD8E8E8EBD8E8E8EBD8E8E8EBD8E8E8EBD8E8E8EC19B9B9B64E1E1
      E11E000000000000000000000000000000005E9AC7AB3BD0FDFF3BD0FDFF3CD1
      FDFF3BD0FDFF3BD0FDFF3BD0FDFF3BD0FDFF3BD0FDFF3BD0FDFF3CD1FDFF3CD1
      FDFF3CD1FDFF3DAED1FF0000000000000000A18284ABB58487FFB58487FFB584
      87FFB58487FFB58487FFB58487FFB58487FFB58487FFB58487FFB58487FFB584
      87FFB58487FFA56A6DFF00000000000000000000000000000000BAB9BAFFF6F6
      F6FFF5F5F5FFF4F4F4FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF0F0F0FFEFEF
      EFFFA4A4A5FF0000000000000000000000000000000000000000F0F1F1FFE5E5
      E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE0E0E0FFE2E2E2FF9C9C9CFF8E8E
      8E71DFDFDF20FEFEFE0100000000000000005E9AC7AB43D8FDFF43D8FDFF43D8
      FDFF43D8FDFF43D8FDFF43D8FDFF44D9FDFF43D8FDFF43D8FDFF43D8FDFF43D8
      FDFF43D8FDFF43DDFFFF0000000000000000A18284ABB8898CFFB8898CFFB889
      8CFFB8898CFFB8898CFFB8898CFFB8898CFFB8898CFFB8898CFFB8898CFFB889
      8CFFB8898CFFB88A8DFF00000000000000000000000000000000BCBBBCFFF6F6
      F6FFCB8700FFF09E00FFE49200FFBB7700FFF2F2F2FFF2F2F2FFF1F1F1FFF0F0
      F0FFA6A5A7FF0000000000000000000000000000000000000000F2E9E0FFE8D7
      C7FFE7E7E7FFE7E7E7FFE7E7E7FFE7E7E7FFE7E7E7FFEEEEEEFFE4E4E4FFB4B4
      B4FF8C8C8C73DFDFDF2000000000000000005C9DCBAA25A1D8FF4ADFFEFF4ADF
      FEFF4ADFFEFF4ADFFEFF4ADFFEFF4ADFFEFF4ADFFEFF4ADFFEFF4ADFFEFF4ADF
      FEFF4ADFFEFF4ADFFEFF0000000000000000A38486AA9D5F62FFBB8E90FFBB8E
      90FFBB8E90FFBB8E90FFBB8E90FFBB8E90FFBB8E90FFBB8E90FFBB8E90FFBB8E
      90FFBB8E90FFBB8E90FF00000000000000000000000000000000BEBDBDFFF7F7
      F7FFF1A800FFF9A700FFF9A100FFF69900FFCD9E4CFFF2F2F2FFF2F2F2FFF1F1
      F1FFA9A8AAFF00000000000000000000000000000000EFAF76FFD58C4FFFCE81
      42FFD4813DFFDB8139FFE18136FFE3A26EFFE9E1DBFFE9E9E9FFF5F5F5FFE3E3
      E3FFA9A9A9FFB2B2B24D000000000000000065AAD6A20580D2FF4FE5FFFF4FE5
      FFFF4FE5FFFF4FE4FFFF4FE5FFFF4FE5FFFF4FE5FFFF4FE5FFFF50E5FFFF4FE5
      FFFF4EE4FFFF4FE5FFFF55CBD6FF00000000AD8D8FA2865154FFBD9294FFBD92
      94FFBD9294FFBD9294FFBD9294FFBD9294FFBD9294FFBD9294FFBD9294FFBD92
      94FFBC9092FFBD9294FFAF7B7EFF000000000000000000000000C0BFBFFFF7F7
      F7FFCB8500FFFDAD00FFFDA800FFFBA000FFBD7800FFF3F3F3FFF2F2F2FFF2F2
      F2FFABAAABFF00000000000000000000000000000000F5BB86EDD08A53FFD98D
      51FFEAB892FFFCCB9FFFEBD2C0FFE8A36DFFD57D35FFDF7E30FFE8C0A1FFE9E9
      E9FFB8B8B8FFB0B0B04F000000000000000067B0D8A20786D3FF55EBFFFF55EB
      FFFF55EBFFFF55EBFFFF55EBFFFF55EBFFFF55EBFFFF55EBFFFF55EBFFFF55EB
      FFFF55EBFFFF55EBFFFF52E5FBFF00000000B08F91A2885255FFBF9597FFBF95
      97FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF95
      97FFBF9597FFBF9597FFBC9092FF000000000000000000000000C2C1C1FFF7F7
      F7FFF7F7F7FFD8AB5DFFC68100FFC17A00FFBE7900FFBC7800FFD3AD6AFFF2F2
      F2FFADADAEFF0000000000000000000000000000000000000000EAA670FFEBD2
      C0FFFADCBFFFFFA144FFFFA043FFEEEBE8FFEBECEEFFECECECFFE9A975FFDA7E
      36FFF9ECE0FFB3B3B34C000000000000000067B2DAA20B97D6FF63FBFFFF56EC
      FFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56EC
      FFFF56ECFFFF56ECFFFF56ECFFFF00000000B29092A28C5558FFC49EA0FFBF95
      97FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF95
      97FFBF9597FFBF9597FFBF9597FF000000000000000000000000C4C3C3FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFC27C00FFC07A00FFE4CEA8FFC67C00FFF3F3
      F3FFAFAFAFFF0000000000000000000000000000000000000000F9F7F7FFF492
      53FFFCDBBCFFFFA955FFFFA348FFFF9733FFFFBB78FFEDF5FDFFEDEDEDFFEDED
      EDFFE29250FFCD9F78A7000000000000000067B4DCA206A0E5FF049EE3FF56EC
      FFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56ECFFFF56EC
      FFFF56ECFFFF55E6F8FF4EC9DCFF88D9E5AFB29193A292585BFF90575AFFBF95
      97FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF9597FFBF95
      97FFBF9597FFBC9092FFAF7B7EFFC8A5A7AF0000000000000000C6C5C5FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFC47D00FFC27B00FFD4A85CFFD18100FFF4F4
      F4FFB1B1B1FF0000000000000000000000000000000000000000FCFCFCFFEFEF
      EFFFE2783FFFFFAE5FFFFFA956FFFFA64FFFFFA248FFFF9833FFFFE5CCFFF0F0
      EFFFFFFFFFFFD97B3CF0F7DBC848000000007CCCED9705A9ECFF05AAEDFF05AA
      EDFF05A9EDFF05AAEDFF05A9EDFF05AAEDFF05AAEDFF05AAEDFF05AAEDFF05AA
      EDFF05AAEDFF118FC8FF0000000000000000C6A2A397965B5EFF975B5EFF975B
      5EFF975B5EFF975B5EFF975B5EFF975B5EFF975B5EFF975B5EFF975B5EFF975B
      5EFF975B5EFF875255FF00000000000000000000000000000000C8C7C7FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFC67E00FFC47D00FFDF8800FFC3820FFFF5F5
      F5FFB4B3B4FF0000000000000000000000000000000000000000FFFFFFFFF9F9
      F9FFFFE5C7FFFFB872FFFFAE61FFFFAA5BFFFFAA56FFFF9C3FFFF1F0F1FFF2F2
      F2FFFFFFFFFFC1815EB3CC6327FC0000000082D3F28806B2F3FF06B2F3FF06B2
      F3FF06B2F3FF06B2F3FF06B2F3FF06B2F3FF06B2F3FF06B2F3FF05B5F7FF05B5
      F7FF05B5F7FF1299CEFF0000000000000000CAA9AB889B5E61FF9B5E61FF9B5E
      61FF9B5E61FF9B5E61FF9B5E61FF9B5E61FF9B5E61FF9B5E61FF9D5F62FF9D5F
      62FF9D5F62FF8C5558FF00000000000000000000000000000000CAC9C9FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFC87F00FFEE8F00FFD58400FFF3EFE7FFF6F6
      F6FFB6B5B6FF0000000000000000000000000000000000000000FFFFFFFFFCFC
      FCFFFFEBD6FFFFCE9AFFFFCA95FFFFB66BFFFCD6B0FFF4F8FCFFF3F3F3FFF3F3
      F3FFFFFFFFFFB5A9A261000000000000000083D4F18806B9F9FF06B9F9FF06B9
      F9FF07C2F8FF008FFFFF008FFFFF018EFAFF315F90FF305F91FF000000000000
      000000000000000000000000000000000000CAA9AB889F6063FF9F6063FF9F60
      63FF9F6063FF9F6063FF9F6063FF9C5E61FF78494CFF78494CFF000000000000
      0000000000000000000000000000000000000000000000000000CCCBCAFFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFCA8000FFDC8700FFF4EFE8FFF7F7F7FFF6F6
      F6FFB8B7B8FF0000000000000000000000000000000000000000FFFFFFFFFDFD
      FDFFFFE9D6FFFFCC95FFFFC790FFFCFEFFFFFAFAFAFFF9F9F9FFF9F9F9FFF8F8
      F8FFFFFFFFFFB3B3B34C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECDCCFFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFCB8200FFC98000FFFBFBFBFFAFAFAFFFAFAF
      AFFFB7B7B7FF0000000000000000000000000000000000000000FFFFFFFFFEFE
      FEFFFEFFFFFFFFF0E1FFFDFEFEFFFDFDFDFFFCFCFCFFFBFBFBFFFBFBFBFFFAFA
      FAFFFFFFFFFFB3B3B34C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0CFCEFFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFFBFBFBFFEAEAEAFFDCDC
      DCFFF2F2F2300000000000000000000000000000000000000000FFFFFFFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFDFDFDFFFDFDFDFFFDFDFDFFFCFCFCFFFCFC
      FCFFFFFFFFFFB3B3B34C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D2D1D0FFFBFB
      FBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFDFDFDFFDDDCDCFFF3F2
      F230000000000000000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFDFDFDFFFDFD
      FDFFFFFFFFFFB2B2B24D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFCECECE310000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFC01F00030003C007C00F
      00030003C007C00300030003C007C00300030003C007800300010001C0078003
      00010001C007C00300010001C007C00300000000C007C00100030003C007C001
      00030003C007C003003F003FC007C003FFFFFFFFC007C003FFFFFFFFC007C003
      FFFFFFFFC00FC003FFFFFFFFFFFFC00300000000000000000000000000000000
      000000000000}
  end
  object SpeechPopup: TPopupMenu
    Left = 592
    Top = 8
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
  object FBPopup: TPopupMenu
    Left = 392
    Top = 64
    object Create2: TMenuItem
      Caption = 'Create'
      object Audiofile1: TMenuItem
        Caption = 'Audio file'
      end
      object Soundbank1: TMenuItem
        Caption = 'Sound bank'
      end
    end
    object Extract1: TMenuItem
      Caption = 'Extract'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Delete4: TMenuItem
      Caption = 'Delete'
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'GTA IV Audio file (*.*)|*.*'
    Left = 592
    Top = 64
  end
  object BankPopup: TPopupMenu
    Left = 388
    Top = 120
    object Add2: TMenuItem
      Caption = 'Add'
    end
    object Replace1: TMenuItem
      Caption = 'Replace'
    end
    object Extract2: TMenuItem
      Caption = 'Extract'
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Delete5: TMenuItem
      Caption = 'Delete'
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'All supported files (*.wav; *.mp3; *.ogg)|*.wav;*.mp3;*.ogg|WAV ' +
      'files (*.wav)|*.wav;|MP3 files (*.mp3)|*.mp3;|Ogg Vorbis (*.ogg)' +
      '|*.ogg;'
    Left = 460
    Top = 120
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    Left = 524
    Top = 120
  end
  object SpeechFLPopup: TPopupMenu
    Left = 596
    Top = 120
    object Add3: TMenuItem
      Caption = 'Add'
      OnClick = Add3Click
    end
    object Delete6: TMenuItem
      Caption = 'Delete'
      OnClick = Delete6Click
    end
  end
  object OpenDialog2: TOpenDialog
    Left = 388
    Top = 176
  end
end
