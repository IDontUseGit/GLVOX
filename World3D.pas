unit World3D;

interface

type

  {��������� ������, �� ��������� �� ������������ ����������� ����������}
  TCamera3D=record
    {���������� ������ � ������� ������������}
    CX:integer;
    CY:integer;
    CZ:integer;
    {�������� ������ � ������� ������������}
    RX:integer;
    RY:integer;
    RZ:integer;
    {���� ������ - � ����� ����� ������ �������}
    TX:integer;
    TY:integer;
    TZ:integer;
  end;

  {���������, ���������� ��������� �����}
  TBrush3D=record
    {���������� ����� � ������� ������������}
    CX:integer;
    CY:integer;
    CZ:integer;
    {������ (������ �� ������) ����� � ������� ������������}
    SX:integer;
    SY:integer;
    SZ:integer;
    {���� �����}
    CR:byte;
    CB:byte;
    CG:byte;
  end;

implementation

end.
