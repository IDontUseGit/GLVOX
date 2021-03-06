unit Core;

interface

const
  TBMax: byte = 16; //������, ��� ����� ���� � �� ����������!

  TBXMax: byte = 255;
  TBYMax: byte = 255;
  TBZMax: byte = 255;

type
  {���������� ������� ��� ����, �� ���� ����� �������� ���� ����� ������
  �� ����� ������� ��� ��� ���� �� ������, TVoxel=array of byte;}
  {�������� TVoxel ���������� � 1, 0 ��������� ������ ��������}
  TVoxel=byte;

  TLongVoxel=long;

  TVoxPtr=record
    x: integer;
    y: integer;
    z: integer;
  end;

  {������� ����� ��� ���� �����}
  TNode=Class
  public
    {������� ������� ��� ��������� ������� �� �����������}
    function GetVox(x:integer; y:integer; z:integer): TVoxel; virtual; abstract;
    {������� ��������� ��������� ������� �� �����������}
    procedure SetVox(x:integer; y:integer; z:integer; v:TVoxel); virtual; abstract;
    {������� ������� ��������� ������� �� ���������, ������� ��������� �� ���� �������}
    function GetCurVox(): TVoxel; virtual; abstract;
    {������� ������� �������� ��������� �������� �������}
    procedure SetCurVoxPtr(ptr:TVoxPtr); virtual; abstract;
    {������� ������� ������ ��������� �������� �������}
    procedure ResetCurVoxPtr(); virtual; abstract;
    {������� �������� ��������� ��������� �� ������� �������}
    function GetCurVoxPtr(): TVoxPtr; virtual; abstract;
    {������� ������� ����������, ��������� �� ����� ������, ������ EOF}
    function IsEndOfData(): boolean; virtual; abstract;
    {������� ������� ��� ��������� �������� �� ����}
    function GetXDim(): integer; virtual; abstract;
    function GetYDim(): integer; virtual; abstract;
    function GetZDim(): integer; virtual; abstract;
    {������� ��� ��������� �������������� ����������}
    function GetGridSize(): integer; virtual; abstract;
    function GetMemoryUsed(): integer; virtual; abstract;
    {�����������}
    Constructor Create(sizex:integer; sizey:integer; sizez:integer); virtual; abstract;
  End;

  {���������� ���� �����, ��� ������ ������� ����������� ������, �.�. 255
  ����������, ������������ ����� ��������� ��� ���������� ������� �� ������}
  {�������� ����� ������ - ������ ���������� ������, ����� ����������� � ����
  ���������� ������� ������, ������ �������� ������� ������������ ��� ������
  ���������� �� ������ ��� ��� ��� ����� ���� ��� ����������� ��������������}
  TByteNode=Class(TNode)
  protected
    voxeldata: array[0..255] of array[0..255] of array[0..255] of byte; //������
    var gridsizex, gridsizey, gridsizez: integer; //������� �����
    curvoxptr: TVoxPtr; //��������� �� ��������� �������
    eod: boolean; //��������� �� ����� �����
  public
    {������� ��� ��������� �������� �� ����}
    function GetXDim(): integer; override;
    function GetYDim(): integer; override;
    function GetZDim(): integer; override;
    {������� ��� ��������� ������� �� ��� �����������}
    function GetVox(x:integer; y:integer; z:integer): TVoxel; override;
    {������� ��������� ������� �� ���������, ������� ��������� �� ���� �������}
    function GetCurVox(): TVoxel; override;
    function GetCurVoxMKII(): TVoxel;
    {������� �������� ��������� �������� �������}
    procedure SetCurVoxPtr(ptr:TVoxPtr); override;
    {�������� ��������� ��������� �� ������� �������}
    function GetCurVoxPtr(): TVoxPtr; override;
    {������� ������ ��������� �������� �������}
    procedure ResetCurVoxPtr(); override;
    {������� ����������, ��������� �� ����� ������, ������ EOF}
    function IsEndOfData(): boolean; override;
    {��������� ��������� ������� �� �����������}
    procedure SetVox(x:integer; y:integer; z:integer; v:TVoxel); override;
    {��������� ������� ���� �����}
    procedure ClearGrid();
    {��������� ������� ���� ����� ��������� ���������}
    procedure FillGrid(v:TVoxel);
    {��������� ������� ���� ����� ���������� ����������}
    procedure FillGridRand();
    {������� ��� ��������� �������������� ����������}
    function GetGridSize(): integer; override;
    function GetMemoryUsed(): integer; override;
    {����������� � ��������� �������}
    Constructor Create(sizex:integer; sizey:integer; sizez:integer); override;
  End;

  TScene=Class

  End;



implementation

{************************����� TByteNode***************************************}
  {�����������, �������� ������� �����, ������ ������� ������� �� ������}
  Constructor TByteNode.Create(sizex:integer; sizey:integer; sizez:integer);
  begin
    //�������� �������� �����
    gridsizex:=sizex;
    gridsizey:=sizey;
    gridsizez:=sizez;
    //������� �������� ��������� �� ������� ������� {0,0,0}
    curvoxptr.x:=0; curvoxptr.y:=0; curvoxptr.z:=0;
    eod:=false;
  end;

  {��������� ��������� ������� - � ������ ������ ����� �� ��������� �����������}
  {���������: 04.10.2015; ������������: ����������}
  {��������������: ���������� ���������� ������: ����������}
  {�������� �����������: ��������� ��������, ����������}
  procedure TByteNode.SetVox(x: Integer; y: Integer; z: Integer; v: Byte);
  begin
    {�������� �� ������������ ��������}                                                //�������� �����������?
    if x >= gridsizex then Exit;
    if x < 0 then Exit;
    if y >= gridsizey then Exit;
    if y < 0 then Exit;
    if z >= gridsizez then Exit;
    if z < 0 then Exit;
    {��������� �������� �������}
    voxeldata[x,y,z]:=v;
  end;

  {��������� ��������� ������� - � ������ ������ ����� �� ��������� �����������}
  {���������: 04.10.2015; ������������: ����������}
  {��������������: ���������� ���������� ������: ����������}
  {�������� �����������: ��������� ��������, ����������}
  function TByteNode.GetVox(x: Integer; y: Integer; z: Integer): TVoxel;
  begin
    {�������� �� ������������ ��������}                                                //�������� �����������?
    result:=0;
    if x >= gridsizex then Exit;
    if x < 0 then Exit;
    if y >= gridsizey then Exit;
    if y < 0 then Exit;
    if z >= gridsizez then Exit;
    if z < 0 then Exit;
    {��������� �������� �������}
    result:=voxeldata[x,y,z];
  end;

  {���� ����������� ������ ��������������}
  function TByteNode.GetCurVox(): TVoxel;
  begin
    //�������� �� ������������ �������� �� ������������
    result:=voxeldata[curvoxptr.x,curvoxptr.y,curvoxptr.z];
    //��������� ������� ��������� �� x
    inc(curvoxptr.x);
    //���������, �� ��������� �� ��������� �������
    if (curvoxptr.x>=gridsizex) and (not eod) then
    begin
      curvoxptr.x:=0;
      inc(curvoxptr.y);
      if curvoxptr.y>=gridsizey then
      begin
        curvoxptr.y:=0;
        inc(curvoxptr.z);
        if curvoxptr.z>=gridsizez then
          eod:=true;
      end;
    end
  end;

  function TByteNode.GetCurVoxMKII(): TVoxel;
  begin
    //�������� �� ������������ �������� �� ������������
    result:=voxeldata[curvoxptr.x,curvoxptr.y,curvoxptr.z];
    //��������� ������� ��������� �� x
    inc(curvoxptr.x);
    //���������, �� ��������� �� ��������� �������
    if (curvoxptr.x>=gridsizex) and (not eod) then
    begin
      curvoxptr.x:=0;
      inc(curvoxptr.y);
      if curvoxptr.y>=gridsizey then
      begin
        curvoxptr.y:=0;
        inc(curvoxptr.z);
        if curvoxptr.z>=gridsizez then
          eod:=true;
      end;
    end
  end;

  function TByteNode.GetXDim(): integer;
  begin
    Result:=gridsizex;
  end;

   function TByteNode.GetYDim(): integer;
  begin
    Result:=gridsizey;
  end;

   function TByteNode.GetZDim(): integer;
  begin
    Result:=gridsizeZ;
  end;

  procedure TByteNode.SetCurVoxPtr(ptr:TVoxPtr);
  begin
    //asd
  end;

  procedure TByteNode.ResetCurVoxPtr();
  begin
    curvoxptr.x:=0; curvoxptr.y:=0; curvoxptr.z:=0;
    eod:=false;
  end;

  function TByteNode.GetCurVoxPtr(): TVoxPtr;
  begin
    Result:=curvoxptr;
  end;

  function TByteNode.IsEndOfData(): boolean;
  begin
    Result:=eod;
  end;

  procedure TByteNode.ClearGrid();
  var
    i,j,k:integer;
  begin
    for i := 0 to TBXMax do begin
      for j := 0 to TBYMax do begin
        for k := 0 to TBZMax do begin
          voxeldata[i,j,k]:=0;
        end;
      end;
    end;
  end;

  procedure TByteNode.FillGrid(v:TVoxel);
  var
    i,j,k:integer;
  begin
    ClearGrid();
    for i := 0 to gridsizex-1 do begin
      for j := 0 to gridsizey-1 do begin
        for k := 0 to gridsizez-1 do begin
          voxeldata[i,j,k]:=v;
        end;
      end;
    end;
  end;

  procedure TByteNode.FillGridRand();
  var
    i,j,k:integer;
    r:integer;
  begin
    ClearGrid();
    for i := 0 to gridsizex-1 do begin
      for j := 0 to gridsizey-1 do begin
        for k := 0 to gridsizez-1 do begin
          r:=1+Random(2);
          if r=1 then
            voxeldata[i,j,k]:=Random(255)
          else
            voxeldata[i,j,k]:=0;
        end;
      end;
    end;
  end;

  function TByteNode.GetGridSize(): integer;
  begin
  //       asd
  end;

  function TByteNode.GetMemoryUsed(): integer;
  begin
  //sdad
  end;

end.
