object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Aula - Importando XML'
  ClientHeight = 493
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 13
    Width = 92
    Height = 13
    Caption = 'Nome do arquivo .:'
  end
  object Label2: TLabel
    Left = 536
    Top = 173
    Width = 156
    Height = 13
    Caption = 'Informa'#231#245'es extra'#237'das do XML .:'
  end
  object Label3: TLabel
    Left = 536
    Top = 127
    Width = 145
    Height = 13
    Caption = 'Digite o Nome do Cabe'#231'alho .:'
  end
  object edtArquivo: TEdit
    Left = 16
    Top = 32
    Width = 577
    Height = 21
    TabOrder = 0
  end
  object btnAbrir: TBitBtn
    Left = 608
    Top = 30
    Width = 75
    Height = 25
    Caption = 'Abrir XML'
    TabOrder = 1
    OnClick = btnAbrirClick
  end
  object TreeView1: TTreeView
    Left = 16
    Top = 72
    Width = 497
    Height = 413
    Indent = 19
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 535
    Top = 192
    Width = 218
    Height = 293
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object edtCabecalho: TEdit
    Left = 536
    Top = 146
    Width = 145
    Height = 21
    TabOrder = 4
  end
  object btnLer: TBitBtn
    Left = 687
    Top = 144
    Width = 66
    Height = 25
    Caption = 'Ler'
    TabOrder = 5
    OnClick = btnLerClick
  end
  object XMLDocument1: TXMLDocument
    Left = 592
    Top = 72
  end
end
