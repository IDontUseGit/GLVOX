program glvox;

uses
  Vcl.Forms,
  glvoxmain in 'glvoxmain.pas' {Form1},
  Core in 'Core.pas',
  World3D in 'World3D.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
