object Form1: TForm1
  Left = 441
  Top = 140
  BorderStyle = bsToolWindow
  Caption = 'Form1'
  ClientHeight = 744
  ClientWidth = 1018
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 760
    Top = -15
    Width = 265
    Height = 760
    Ctl3D = True
    DockSite = True
    ParentCtl3D = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 8
      Top = 688
      Width = 241
      Height = 65
      Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1080' '#1079#1072#1075#1088#1091#1079#1082#1072
      TabOrder = 0
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 16
      Width = 241
      Height = 137
      Caption = #1050#1072#1084#1077#1088#1072
      TabOrder = 1
      object btnCamForward: TButton
        Left = 48
        Top = 18
        Width = 32
        Height = 32
        Caption = #8593
        TabOrder = 0
        OnClick = btnCamForwardClick
      end
      object btnCamLeft: TButton
        Left = 10
        Top = 56
        Width = 32
        Height = 32
        Caption = #8592
        TabOrder = 1
        OnClick = btnCamLeftClick
      end
      object btnCamRight: TButton
        Left = 86
        Top = 56
        Width = 32
        Height = 32
        Caption = #8594
        TabOrder = 2
        OnClick = btnCamRightClick
      end
      object btnCamBack: TButton
        Left = 48
        Top = 96
        Width = 32
        Height = 32
        Caption = #8595
        TabOrder = 3
        OnClick = btnCamBackClick
      end
      object Button5: TButton
        Left = 190
        Top = 18
        Width = 32
        Height = 32
        Caption = '?'
        TabOrder = 4
        OnClick = btnCamRightClick
      end
      object Button6: TButton
        Left = 190
        Top = 56
        Width = 32
        Height = 32
        Caption = '?'
        TabOrder = 5
        OnClick = btnCamRightClick
      end
      object Button7: TButton
        Left = 190
        Top = 94
        Width = 32
        Height = 32
        Caption = '?'
        TabOrder = 6
        OnClick = btnCamRightClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 159
      Width = 241
      Height = 66
      Caption = #1058#1080#1087' '#1082#1080#1089#1090#1080
      TabOrder = 2
    end
    object rdBrushOneVox: TRadioButton
      Left = 16
      Top = 176
      Width = 97
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = #1054#1076#1080#1085' '#1074#1086#1082#1089#1077#1083#1100
      Checked = True
      ParentBiDiMode = False
      TabOrder = 3
      TabStop = True
    end
    object rdBrushQuad: TRadioButton
      Left = 16
      Top = 199
      Width = 97
      Height = 17
      Caption = #1050#1074#1072#1076#1088#1072#1090
      TabOrder = 4
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 231
      Width = 241
      Height = 138
      Caption = #1055#1086#1083#1086#1078#1077#1085#1080#1077' '#1082#1080#1089#1090#1080
      TabOrder = 5
      object lbBrushPos: TLabel
        Left = 144
        Top = 25
        Width = 80
        Height = 13
        Caption = '<'#1050#1086#1086#1088#1076#1080#1085#1072#1090#1099'>'
      end
    end
    object btnBrushForward: TButton
      Left = 57
      Top = 248
      Width = 32
      Height = 32
      Caption = #8593
      TabOrder = 6
      OnClick = btnBrushForwardClick
    end
    object btnBrushLeft: TButton
      Left = 19
      Top = 286
      Width = 32
      Height = 32
      Caption = #8592
      TabOrder = 7
      OnClick = btnBrushLeftClick
    end
    object btnBrushRight: TButton
      Left = 95
      Top = 286
      Width = 32
      Height = 32
      Caption = #8594
      TabOrder = 8
      OnClick = btnBrushRightClick
    end
    object btnBrushDown: TButton
      Left = 57
      Top = 324
      Width = 32
      Height = 32
      Caption = #8595
      TabOrder = 9
      OnClick = btnBrushDownClick
    end
    object btnBrushPush: TButton
      Left = 19
      Top = 248
      Width = 32
      Height = 32
      Caption = 'Y-'
      TabOrder = 10
      OnClick = btnBrushPushClick
    end
    object btnBrushPull: TButton
      Left = 95
      Top = 248
      Width = 32
      Height = 32
      Caption = 'Y+'
      TabOrder = 11
      OnClick = btnBrushPullClick
    end
    object GroupBox5: TGroupBox
      Left = 8
      Top = 481
      Width = 241
      Height = 138
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1080#1089#1090#1080
      TabOrder = 12
      object Label1: TLabel
        Left = 16
        Top = 52
        Width = 48
        Height = 13
        Caption = #1050#1088#1072#1089#1085#1099#1081':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 106
        Width = 35
        Height = 13
        Caption = #1057#1080#1085#1080#1081':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 16
        Top = 78
        Width = 48
        Height = 13
        Caption = #1047#1077#1083#1077#1085#1099#1081':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbBrushColor: TLabel
        Left = 159
        Top = 44
        Width = 42
        Height = 13
        Caption = '<'#1062#1074#1077#1090'>'
      end
      object shBrushColor: TShape
        Left = 159
        Top = 103
        Width = 52
        Height = 22
        Cursor = crHandPoint
      end
      object spBrushRed: TSpinEdit
        Left = 87
        Top = 47
        Width = 58
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 0
        Value = 128
        OnChange = spBrushRedChange
      end
      object spBrushGreen: TSpinEdit
        Left = 87
        Top = 75
        Width = 58
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 1
        Value = 128
        OnChange = spBrushGreenChange
      end
      object spBrushBlue: TSpinEdit
        Left = 87
        Top = 103
        Width = 58
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 2
        Value = 128
        OnChange = spBrushBlueChange
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 24
        Width = 113
        Height = 17
        Caption = #1053#1077#1087#1091#1089#1090#1099#1077' '#1074#1086#1082#1089#1077#1083#1080
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
    end
    object GroupBox6: TGroupBox
      Left = 8
      Top = 625
      Width = 241
      Height = 57
      Caption = #1055#1088#1080#1084#1077#1085#1077#1085#1080#1077' '#1082#1080#1089#1090#1080
      TabOrder = 13
      object btnBrushApply: TButton
        Left = 88
        Top = 24
        Width = 75
        Height = 25
        Caption = #1053#1072#1083#1086#1078#1077#1085#1080#1077
        TabOrder = 0
        OnClick = btnBrushApplyClick
      end
    end
    object GroupBox7: TGroupBox
      Left = 8
      Top = 369
      Width = 241
      Height = 106
      Caption = #1056#1072#1079#1084#1077#1088' '#1082#1080#1089#1090#1080
      TabOrder = 14
      object Label4: TLabel
        Left = 16
        Top = 20
        Width = 63
        Height = 13
        Caption = #1056#1072#1079#1084#1077#1088' '#1087#1086' X:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 16
        Top = 51
        Width = 63
        Height = 13
        Caption = #1056#1072#1079#1084#1077#1088' '#1087#1086' Y:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 16
        Top = 82
        Width = 63
        Height = 13
        Caption = #1056#1072#1079#1084#1077#1088' '#1087#1086' Z:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object spBrushXSize: TSpinEdit
        Left = 85
        Top = 23
        Width = 57
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 0
        Value = 1
        OnChange = spBrushXSizeChange
      end
    end
    object spBrushYSize: TSpinEdit
      Left = 93
      Top = 420
      Width = 57
      Height = 22
      MaxValue = 255
      MinValue = 0
      TabOrder = 15
      Value = 1
      OnChange = spBrushYSizeChange
    end
    object spBrushZSize: TSpinEdit
      Left = 93
      Top = 448
      Width = 57
      Height = 22
      MaxValue = 255
      MinValue = 0
      TabOrder = 16
      Value = 1
      OnChange = spBrushZSizeChange
    end
    object Button1: TButton
      Left = 57
      Top = 286
      Width = 32
      Height = 32
      Caption = 'M'
      TabOrder = 17
      OnClick = Button1Click
    end
    object btnSave: TButton
      Left = 24
      Top = 712
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 18
      OnClick = btnSaveClick
    end
    object btnLoad: TButton
      Left = 160
      Top = 712
      Width = 75
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      TabOrder = 19
      OnClick = btnLoadClick
    end
  end
  object Timer1: TTimer
    Interval = 45
    OnTimer = Timer1Timer
    Left = 472
    Top = 728
  end
end
