unit glvoxmain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, dglopengl, Math, Misc, DataIO, dglut, core, world3d,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.CheckLst, Vcl.ImgList, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnCamForward: TButton;
    btnCamLeft: TButton;
    btnCamRight: TButton;
    btnCamBack: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    GroupBox3: TGroupBox;
    rdBrushOneVox: TRadioButton;
    rdBrushQuad: TRadioButton;
    GroupBox4: TGroupBox;
    btnBrushForward: TButton;
    btnBrushLeft: TButton;
    btnBrushRight: TButton;
    btnBrushDown: TButton;
    lbBrushPos: TLabel;
    btnBrushPush: TButton;
    btnBrushPull: TButton;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox6: TGroupBox;
    lbBrushColor: TLabel;
    btnBrushApply: TButton;
    spBrushRed: TSpinEdit;
    spBrushGreen: TSpinEdit;
    spBrushBlue: TSpinEdit;
    CheckBox1: TCheckBox;
    GroupBox7: TGroupBox;
    spBrushYSize: TSpinEdit;
    spBrushZSize: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    spBrushXSize: TSpinEdit;
    Button1: TButton;
    btnSave: TButton;
    btnLoad: TButton;
    shBrushColor: TShape;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SetupGL();
    procedure Render();
    procedure DrawScenePoints();
    procedure SetCamera(cam:TCamera3D);
    procedure SetGrid();
    procedure SetBrush();
    procedure SetBrushColor(c:byte);
    procedure NextBrushColor(i:integer);
    procedure ApplyBrush();
    procedure DisplayInfo();
    procedure btnCamLeftClick(Sender: TObject);
    procedure btnCamRightClick(Sender: TObject);
    procedure btnCamForwardClick(Sender: TObject);
    procedure btnCamBackClick(Sender: TObject);
    procedure btnBrushForwardClick(Sender: TObject);
    procedure btnBrushLeftClick(Sender: TObject);
    procedure btnBrushRightClick(Sender: TObject);
    procedure btnBrushDownClick(Sender: TObject);
    procedure btnBrushPushClick(Sender: TObject);
    procedure btnBrushPullClick(Sender: TObject);
    procedure spBrushRedChange(Sender: TObject);
    procedure spBrushGreenChange(Sender: TObject);
    procedure spBrushBlueChange(Sender: TObject);
    procedure btnBrushApplyClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure spBrushXSizeChange(Sender: TObject);
    procedure spBrushYSizeChange(Sender: TObject);
    procedure spBrushZSizeChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  DC : HDC; //�������� ����������
  HRC : HGLRC; //�������� ����������

  curcam: TCamera3D;
  curbrush: TBrush3D;
  brushtype: integer;
  node: TByteNode;

  s,e,d:dword;

implementation

{$R *.dfm}

procedure SetDCPixelFormat(hdc : HDC);
var
  pfd: TPixelFormatDescriptor;
  nPixelFormat: Integer;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat:=ChoosePixelFormat(hdc, @pfd);
  SetPixelFormat(hdc, nPixelFormat, @pfd);
end;

procedure TForm1.SetupGL;
begin
  glClearColor(0.3,0.4,0.7,0.0); // ���� ���� �������
  glEnable(GL_DEPTH_TEST); //�������� ����� ���� �������
  glEnable(GL_CULL_FACE); //�������� ����� ����������� ������ �������� ������������
end;

procedure TForm1.spBrushBlueChange(Sender: TObject);
begin
  //curbrush.CB:=spBrushBlue.Value;
end;

procedure TForm1.spBrushGreenChange(Sender: TObject);
begin
  //curbrush.CG:=spBrushGreen.Value;
end;

procedure TForm1.spBrushRedChange(Sender: TObject);
var
  c:TVector3D;
begin
  //curbrush.CR:=spBrushRed.Value;
  c:=UnPackBytePalette(spBrushRed.Value);
  curbrush.CR:=c.X;
  curbrush.CG:=c.Y;
  curbrush.CB:=c.Z;
end;

procedure TForm1.spBrushXSizeChange(Sender: TObject);
begin
  curbrush.SX:=spBrushXSize.Value;
end;

procedure TForm1.spBrushYSizeChange(Sender: TObject);
begin
  curbrush.SY:=spBrushYSize.Value;
end;

procedure TForm1.spBrushZSizeChange(Sender: TObject);
begin
  curbrush.SZ:=spBrushZSize.Value;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  dc := GetDC(Handle); //�������� �������� ���������� �� ����� Form1

  //� InitOpenGL ���������������� OpenGL, ���� ��� �� ������� �� ���������� �����������
  if  not InitOpenGL then
    Application.Terminate;

  //��� ������ ������ �������� ����������
  hrc := CreateRenderingContext(dc,[opDoubleBuffered],32,24,0,0,0,0);

  ActivateRenderingContext(dc,hrc); //���������� �������� ����������
  SetupGL;                          //��������� ������� OpenGL
  //Application.OnIdle := IdleHandler;

  //glEnable(GL_LIGHTING);
  //glEnable(GL_LIGHT0);

  CurCam.CX:=0; CurCam.CY:=20; CurCam.CZ:=25;
  Curcam.TX:=0; Curcam.TY:=0;  CurCam.CZ:=25;
  CurCam.RY:=0;
  //CurCam.RZ:=25;

  node:=TByteNode.Create(64,64,64);
  //node.FillGrid(128);
  //node.FillGridRand();
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Case Key of
      VK_LEFT : if not (ssCtrl in Shift) then btnBrushLeftClick(Sender) else btnCamLeftClick(Sender);
      VK_RIGHT : if not (ssCtrl in Shift) then btnBrushRightClick(Sender) else btnCamRightClick(Sender);
      VK_UP : if not (ssCtrl in Shift) then btnBrushDownClick(Sender) else btnCamForwardClick(Sender);
      VK_DOWN : if not (ssCtrl in Shift) then btnBrushForwardClick(Sender) else btnCamBackClick(Sender);
      VK_PRIOR : btnBrushPullClick(Sender);
      VK_NEXT : btnBrushPushClick(Sender);
      48 : SetBrushColor(0);
      49 : SetBrushColor(3);
      50 : SetBrushColor(12);
      51 : SetBrushColor(48);
      52 : SetBrushColor(21);
      53 : SetBrushColor(42);
      54 : SetBrushColor(63);
      VK_ADD : NextBrushColor(1);
      VK_SUBTRACT : NextBrushColor(-1);
      //53 : SetBrushColor(51);
      //54 : SetBrushColor(60);
      //VK_ESCAPE: ShowInfoWindow();
      VK_SPACE: btnBrushApplyClick(Sender);
      //else ShowMessage('colour ����������!');
    end;
end;

procedure TForm1.Render;
begin
  glViewport(0,0,ClientWidth,ClientHeight);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(45.0,ClientWidth/ClientHeight,1.0,512.0);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;

  SetCamera(CurCam);
  //glPushMatrix();
  SetGrid();

  //glTranslatef(-node.GetXDim/2,-node.GetYDim/2,-node.GetZDim/2);
  DrawScenePoints();
  SetBrush();

  SwapBuffers(dc);

  DisplayInfo();
end;

procedure TForm1.btnCamLeftClick(Sender: TObject);
begin
  curcam.RY:=curcam.RY+15;
end;

procedure TForm1.btnCamRightClick(Sender: TObject);
begin
  curcam.RY:=curcam.RY-15;
end;

procedure TForm1.btnLoadClick(Sender: TObject);
var
  opendlg:TOpenDialog;
  fname:string;
begin
  opendlg := TOpenDialog.Create(self);
  opendlg.Title := '��������� ����� �� �����';
  opendlg.InitialDir := GetCurrentDir;
  opendlg.Filter := '������� ���������� ����� (plain voxel grid)|*.pvg';
  opendlg.DefaultExt := 'pvg';
  opendlg.FilterIndex := 1;
  opendlg.Execute();
  LoadNodeFromFile(node, opendlg.FileName);
  opendlg.Free;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  savedlg:TSaveDialog;
  fname:string;
begin
  savedlg := TSaveDialog.Create(self);
  savedlg.Title := '��������� ����� � ����';
  savedlg.InitialDir := GetCurrentDir;
  savedlg.Filter := '������� ���������� ����� (plain voxel grid)|*.pvg';
  savedlg.DefaultExt := 'pvg';
  savedlg.FilterIndex := 1;
  savedlg.Execute();
  SaveNodeToFile(node, savedlg.FileName);
  savedlg.Free;
end;

procedure SaveNodeToFile(fname:string);
//var
begin
  //d
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  self.ActiveControl:=nil;
end;

procedure TForm1.btnCamForwardClick(Sender: TObject);
begin
  curcam.CZ:=curcam.CZ-2;
end;

procedure TForm1.btnBrushApplyClick(Sender: TObject);
begin
  ApplyBrush();
end;

procedure TForm1.btnBrushDownClick(Sender: TObject);
begin
  if curbrush.CZ>0 then
    curbrush.CZ:=curbrush.CZ-1;
end;

procedure TForm1.btnBrushForwardClick(Sender: TObject);
begin
  if curbrush.CZ<node.GetZMax() then
    curbrush.CZ:=curbrush.CZ+1;
end;

procedure TForm1.btnBrushLeftClick(Sender: TObject);
begin
  if curbrush.CX>0 then
    curbrush.CX:=curbrush.CX-1;
end;

procedure TForm1.btnBrushPullClick(Sender: TObject);
begin
  if curbrush.CY<node.GetYMax() then
    curbrush.CY:=curbrush.CY+1;
end;

procedure TForm1.btnBrushPushClick(Sender: TObject);
begin
  if curbrush.CY>0 then
    curbrush.CY:=curbrush.CY-1;
end;

procedure TForm1.btnBrushRightClick(Sender: TObject);
begin
  if curbrush.CX<node.GetXMax() then
    curbrush.CX:=curbrush.CX+1;
end;

procedure TForm1.btnCamBackClick(Sender: TObject);
begin
  curcam.CZ:=curcam.CZ+2;
end;

procedure TForm1.SetCamera(cam:TCamera3D);
begin
  //gluLookAt(cam.CX, cam.CY, cam.CZ, cam.TX, cam.TY, cam.TZ, 0, 1, 0);
  gluLookAt(cam.CX, cam.CY, cam.CZ, curbrush.CX, curbrush.CY, curbrush.CZ, 0, 1, 0);
  glRotatef(cam.RY, 0, 1, 0);
  glRotatef(cam.RX, 1, 0, 0);
  glRotatef(cam.RZ, 0, 0, 1);
end;

procedure TForm1.SetGrid();
begin
  glLineWidth(5);
  glPointSize(50);
  glBegin(GL_LINES);
  glColor3f(1,0,0); glVertex3f(0,0,0); glVertex3f(50,0,0);
  glColor3f(0,1,0); glVertex3f(0,0,0); glVertex3f(0,50,0);
  glColor3f(0,0,1); glVertex3f(0,0,0); glVertex3f(0,0,50);
  glEnd;
  //glColor3f(1,1,1);
  //glutWireCube(50);
end;

procedure TForm1.SetBrush();
var
  x,y,z:integer;
begin
  glLineWidth(1);
  glColor3f(1,1,1);

  if rdBrushOneVox.Checked=true then
  begin
    glTranslatef(curbrush.CX,curbrush.CY,curbrush.CZ);
    glutWireCube(1);
    glTranslatef(-curbrush.CX,-curbrush.CY,-curbrush.CZ);
  end;

  if rdBrushQuad.Checked=true then
  begin
    for x := curbrush.CX to curbrush.CX+curbrush.SX do begin
      for y := curbrush.CY to curbrush.CY+curbrush.SY do begin
        for z := curbrush.CZ to curbrush.CZ+curbrush.SZ do begin
          glTranslatef(x,y,z);
          glutWireCube(1);
          glTranslatef(-x,-y,-z);
        end;
      end;
    end;
  end;
end;

procedure TForm1.ApplyBrush();
var
  v:TVoxel;
  x,y,z:integer;
begin
  //��� ������ �������������� ����� �� ���� �����
  //������� ����� ������� -- ��� �������
  if rdBrushOneVox.Checked=true then
  begin
    v:=spBrushRed.Value;
    node.SetVox(curbrush.CX,curbrush.CY,curbrush.CZ,v);
  end;
  if rdBrushQuad.Checked=true then
  begin
    //������� spBrushRed �� spBrushBlue
    v:=spBrushBlue.Value;
    for x := curbrush.CX to curbrush.CX+curbrush.SX do begin
      for y := curbrush.CY to curbrush.CY+curbrush.SY do begin
        for z := curbrush.CZ to curbrush.CZ+curbrush.SZ do begin
          node.SetVox(x,y,z,v);
        end;
      end;
    end;
  end;
end;

procedure TForm1.SetBrushColor(c:byte);
begin
  spBrushRed.Value:=c;
end;

procedure TForm1.NextBrushColor(i:integer);
begin
  spBrushRed.Value:=spBrushRed.Value+i;
end;

procedure TForm1.DisplayInfo();
begin
  //LBFPSDisplay.Caption:=inttostr(d)+' ��';
  lbBrushPos.Caption:='X: '+inttostr(curbrush.CX)+sLineBreak+
  'Y: '+inttostr(curbrush.CY)+sLineBreak+
  'Z: '+inttostr(curbrush.CZ);
  lbBrushColor.Caption:='�������: '+inttostr(curbrush.CR)+sLineBreak+
  '������: '+inttostr(curbrush.CG)+sLineBreak+
  '�����: '+inttostr(curbrush.CB);
  shBrushColor.Brush.Color:=RGB(curbrush.CR,curbrush.CG,curbrush.CB);
end;

procedure TForm1.DrawScenePoints();
var
  i,j,k:integer;
  v:byte;
  col:TVector3D;
begin
  s:=GetTickCount();
  glPointSize(25);
  //glBegin(GL_POINTS);
  for i := 0 to node.GetXMax() do begin
    for j := 0 to node.GetYMax() do begin
      for k := 0 to node.GetZMax() do begin
        glTranslatef(i,j,k);
        v:=node.GetVox(i,j,k);
        col:=UnPackBytePalette(v);
        if v<>0 then
        begin
           glColor3f(col.X/255,col.Y/255,col.Z/255);
           glutsolidcube(1);
        end;
        //glVertex3f(i,j,k);
        glTranslatef(-i,-j,-k);
      end;
    end;
  end;
  //glEnd();
  e:=GetTickCount();
  d:=e-s;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Render();
end;

end.
