unit pProjAula01;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, IniFiles,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Vcl.ComCtrls, System.StrUtils;

type
  TForm1 = class(TForm)
    edtArquivo: TEdit;
    btnAbrir: TBitBtn;
    Label1: TLabel;
    TreeView1: TTreeView;
    XMLDocument1: TXMLDocument;
    Memo1: TMemo;
    Label2: TLabel;
    edtCabecalho: TEdit;
    Label3: TLabel;
    btnLer: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnLerClick(Sender: TObject);
  private
    { Private declarations }
    iniconf : TIniFile;
    caminho : string;

    procedure GerarTreeView(XMLNode: IXMLNode; TreeNode: TTreeNode);
    procedure CarregarXMLnaTree;
    procedure CarregarCabeçalhos(NomeCab : string);

    procedure LerIde;
    procedure LerEmit;
    procedure LerDest;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnAbrirClick(Sender: TObject);
begin
  Caminho := iniconf.ReadString('ler_xml','path','')+ edtArquivo.Text +'.xml';
  CarregarXMLnaTree;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  iniconf := TIniFile.Create(ExtractFilePath(Application.ExeName)+'conf.ini');
end;

procedure TForm1.GerarTreeView(XMLNode: IXMLNode; TreeNode: TTreeNode);
var
  NodeText : string;
  NovoTreeNode: TTreeNode;
  I : Integer;
begin
  if XMLNode.NodeType <> ntElement then
    Exit;

  NodeText := XMLNode.NodeName;

  if XMLNode.IsTextElement then
   NodeText := NodeText + '=' + XMLNode.NodeValue;

  NovoTreeNode := TreeView1.Items.AddChild(TreeNode, NodeText);

  if XMLNode.HasChildNodes then
    for I := 0 to XMLNode.ChildNodes.Count - 1 do
      GerarTreeView(XMLNode.ChildNodes[I], NovoTreeNode);
end;

procedure TForm1.LerDest;
var
  NodePai, Dest, enderDest : IXMLNode;
begin
  //carrega xml
  XMLDocument1.LoadFromFile(Caminho);
  XMLDocument1.Active:= True;

  //carrega primeira quebra do xml
  NodePai := XMLDocument1.DocumentElement.childNodes.FindNode('infNFe');
  if not (NodePai = nil) then
  begin
    //carrega a quebra do cabeçalho que busco
    Dest := NodePai.childNodes.FindNode('dest');
    if not (Dest = nil) then
    begin
      Memo1.Lines.Clear;
      memo1.Lines.Add('CNPJ: '+Dest.ChildNodes['CNPJ'].Text);
      memo1.Lines.Add('Razão Social: '+Dest.ChildNodes['xNome'].Text);
      memo1.Lines.Add('Fantasia: '+Dest.ChildNodes['xFant'].Text);
      enderDest := Dest.childNodes.FindNode('enderDest');
      if not (enderDest = nil) then
      begin
        memo1.Lines.Add('Endereço do Destinatário:');
        memo1.Lines.Add('Logradouro: '+enderDest.ChildNodes['xLgr'].Text);
        memo1.Lines.Add('nro: '+enderDest.ChildNodes['nro'].Text);
        memo1.Lines.Add('Complemento: '+enderDest.ChildNodes['xCpl'].Text);
        memo1.Lines.Add('Bairro: '+enderDest.ChildNodes['xBairro'].Text);
        memo1.Lines.Add('Cod. Mun: '+enderDest.ChildNodes['cMun'].Text);
        memo1.Lines.Add('Municipio: '+enderDest.ChildNodes['xMun'].Text);
        memo1.Lines.Add('UF: '+enderDest.ChildNodes['UF'].Text);
        memo1.Lines.Add('CEP: '+enderDest.ChildNodes['CEP'].Text);
        memo1.Lines.Add('Cod. Pais: '+enderDest.ChildNodes['cPais'].Text);
        memo1.Lines.Add('Pais: '+enderDest.ChildNodes['xPais'].Text);
        memo1.Lines.Add('Fone: '+enderDest.ChildNodes['fone'].Text);
      end;
      memo1.Lines.Add('Inscrição Estadual: '+Dest.ChildNodes['IE'].Text);
    end;
  end;
end;

procedure TForm1.LerEmit;
var
  NodePai, Emit, enderEmit : IXMLNode;
begin
  //carrega xml
  XMLDocument1.LoadFromFile(Caminho);
  XMLDocument1.Active:= True;

  //carrega primeira quebra do xml
  NodePai := XMLDocument1.DocumentElement.childNodes.FindNode('infNFe');
  if not (NodePai = nil) then
  begin
    //carrega a quebra do cabeçalho que busco
    Emit := NodePai.childNodes.FindNode('emit');
    if not (Emit = nil) then
    begin
      Memo1.Lines.Clear;
      memo1.Lines.Add('CNPJ: '+Emit.ChildNodes['CNPJ'].Text);
      memo1.Lines.Add('Razão Social: '+Emit.ChildNodes['xNome'].Text);
      memo1.Lines.Add('Fantasia: '+Emit.ChildNodes['xFant'].Text);
      enderEmit := Emit.childNodes.FindNode('enderEmit');
      if not (enderEmit = nil) then
      begin
        memo1.Lines.Add('Endereço do Emitente:');
        memo1.Lines.Add('Logradouro: '+enderEmit.ChildNodes['xLgr'].Text);
        memo1.Lines.Add('nro: '+enderEmit.ChildNodes['nro'].Text);
        memo1.Lines.Add('Complemento: '+enderEmit.ChildNodes['xCpl'].Text);
        memo1.Lines.Add('Bairro: '+enderEmit.ChildNodes['xBairro'].Text);
        memo1.Lines.Add('Cod. Mun: '+enderEmit.ChildNodes['cMun'].Text);
        memo1.Lines.Add('Municipio: '+enderEmit.ChildNodes['xMun'].Text);
        memo1.Lines.Add('UF: '+enderEmit.ChildNodes['UF'].Text);
        memo1.Lines.Add('CEP: '+enderEmit.ChildNodes['CEP'].Text);
        memo1.Lines.Add('Cod. Pais: '+enderEmit.ChildNodes['cPais'].Text);
        memo1.Lines.Add('Pais: '+enderEmit.ChildNodes['xPais'].Text);
        memo1.Lines.Add('Fone: '+enderEmit.ChildNodes['fone'].Text);
      end;
      memo1.Lines.Add('Inscrição Estadual: '+Emit.ChildNodes['IE'].Text);
    end;
  end;
end;

procedure TForm1.LerIde;
var
  NodePai, Ide : IXMLNode;
begin
  //carrega xml
  XMLDocument1.LoadFromFile(Caminho);
  XMLDocument1.Active:= True;

  //carrega primeira quebra do xml
  NodePai := XMLDocument1.DocumentElement.childNodes.FindNode('infNFe');
  if not (NodePai = nil) then
  begin
    //carrega a quebra do cabeçalho que busco
    Ide := NodePai.childNodes.FindNode('ide');
    if not (Ide = nil) then
    begin
      Memo1.Lines.Clear;
      memo1.Lines.Add('cUF: '+Ide.ChildNodes['cUF'].Text);
      memo1.Lines.Add('cNF: '+Ide.ChildNodes['cNF'].Text);
      memo1.Lines.Add('natOp: '+Ide.ChildNodes['natOp'].Text);
      memo1.Lines.Add('indPag: '+Ide.ChildNodes['indPag'].Text);
      memo1.Lines.Add('mod: '+Ide.ChildNodes['mod'].Text);
      memo1.Lines.Add('serie: '+Ide.ChildNodes['serie'].Text);
      memo1.Lines.Add('nNF: '+Ide.ChildNodes['nNF'].Text);
      memo1.Lines.Add('dEmi: '+Ide.ChildNodes['dEmi'].Text);
      memo1.Lines.Add('dSaiEnt: '+Ide.ChildNodes['dSaiEnt'].Text);
      memo1.Lines.Add('tpNF: '+Ide.ChildNodes['tpNF'].Text);
      memo1.Lines.Add('cMunFG: '+Ide.ChildNodes['cMunFG'].Text);
      memo1.Lines.Add('tpImp: '+Ide.ChildNodes['tpImp'].Text);
      memo1.Lines.Add('tpEmis: '+Ide.ChildNodes['tpEmis'].Text);
      memo1.Lines.Add('cDV: '+Ide.ChildNodes['cDV'].Text);
      memo1.Lines.Add('tpAmb: '+Ide.ChildNodes['tpAmb'].Text);
      memo1.Lines.Add('finNFe: '+Ide.ChildNodes['finNFe'].Text);
      memo1.Lines.Add('procEmi: '+Ide.ChildNodes['procEmi'].Text);
      memo1.Lines.Add('verProc: '+Ide.ChildNodes['verProc'].Text);
    end;
  end;
end;

procedure TForm1.btnLerClick(Sender: TObject);
begin
  Caminho := iniconf.ReadString('ler_xml','path','')+ edtArquivo.Text +'.xml';
  CarregarCabeçalhos(edtCabecalho.Text);
end;

procedure TForm1.CarregarCabeçalhos(NomeCab: string);
begin
  case AnsiIndexStr(UpperCase(NomeCab), ['IDE','EMIT','DEST']) of
    0 : LerIde;
    1 : LerEmit;
    2 : LerDest;
  end;
end;

procedure TForm1.CarregarXMLnaTree;
begin
  XMLDocument1.LoadFromFile(Caminho);
  TreeView1.Items.Clear;
  XMLDocument1.Active:= True;
  GerarTreeView(XMLDocument1.DocumentElement, nil);
  XMLDocument1.Active:= False;
end;

end.
