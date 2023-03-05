program pAula01;

uses
  Vcl.Forms,
  pProjAula01 in 'pProjAula01.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
