{%BuildCommand $(CompPath) $EdFile()}
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, BGRABitmap, BGRABitmapTypes, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    ScrollBar1: TScrollBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure Edit11EditingDone(Sender: TObject);
    procedure Edit12EditingDone(Sender: TObject);
    procedure Edit14EditingDone(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseLeave(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Mouse_down_x: Extended;
  Mouse_down_y: Extended;
  Mouse_down_r: Extended;
  Mouse_down_Active: integer;
  Mouse_down_oldx: Extended;
  Mouse_down_oldy: Extended;
  Mouse_down_newx: Extended;
  Mouse_down_newy: Extended;
const
  Po1: array[0..3, 0..1] of Extended =
    (
    (65, -8),
    (-11, -8),
    (-11, 7),
    (65, 7)
    );

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Extended;
  s : String;
begin
  i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
  i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
  Edit1.Text:=FloatToStr(i);
  i:=StrToFloat(Edit1.Text);
  s:=FormatFloat('####0',i);
  Edit13.Text:=s;
  ScrollBar1.Position := StrToInt(FloatToStr(((StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/2)*(ScrollBar1.Max/(StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text)))));
  if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
  i:=0
  else
  i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
  Edit5.Text := FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
  Label15.Caption:='= Actual '+Edit10.Text;
  Mouse_down_Active := 0;
  Mouse_down_oldx := 0;
  Mouse_down_oldy := 0;
  Mouse_down_newx := 0;
  Mouse_down_newy := 0;
  PageControl1.ActivePageIndex:=0;
  ScrollBar1Change(Sender);
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
  Mouse_down_Active := 0;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (X >= Mouse_down_x - (Mouse_down_r)) and (X <= Mouse_down_x + (Mouse_down_r)) and (Y >= Mouse_down_y-(Mouse_down_r)) and (Y <= Mouse_down_y + (Mouse_down_r)) Then
    begin
      //Button1.Caption:= 'Active'+' ' +FloatToStr(Mouse_down_x)+' ' +FloatToStr(Mouse_down_y)+' ' +IntToStr(X)+' ' +IntToStr(X);
      Mouse_down_Active := 1;
      Mouse_down_oldx := X;
      Mouse_down_oldy := Y;
      Mouse_down_newx := X;
      Mouse_down_newy := Y;
    end
  else
    begin
      //Button1.Caption:= 'Not Active'+' ' +FloatToStr(Mouse_down_x)+' ' +FloatToStr(Mouse_down_y)+' ' +IntToStr(X)+' ' +IntToStr(X);
      Mouse_down_Active := 0;
    end;
end;

procedure TForm1.FormMouseLeave(Sender: TObject);
begin
  Mouse_down_Active := 0;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  offset: Extended;

begin
  if Mouse_down_Active = 1 then
  begin
    Mouse_down_newx := X;
    Mouse_down_newy := Y;
    offset:=(ScrollBar1.Max/(ScrollBar1.Height-16));
    if Mouse_down_newx <= 0 then Mouse_down_newx := 0;
    if Mouse_down_newy <= 0 then Mouse_down_newy := 0;
    ScrollBar1.Position:=ScrollBar1.Position+StrToInt(FormatFloat('####0',(Mouse_down_newy-Mouse_down_oldy)*offset));//StrToInt(FloatToStr((Mouse_down_newy-Mouse_down_oldy) *(ScrollBar1.Max/ScrollBar1.Height)));
    //Button1.Caption:= FloatToStr(offset);
    //Button1.Caption:=FormatFloat('####0',(Mouse_down_newy-Mouse_down_oldy)*offset);
    Mouse_down_oldx := Mouse_down_newx;
    Mouse_down_oldy := Mouse_down_newy;
  end;

end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Mouse_down_Active := 0;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  bmp: TBGRABitmap;
  x_ : Extended;
  y_ : Extended;
  t : Extended;
  tem : Integer;
  tem2 : Extended;
  tem3 : Extended;
  i : Integer;
  i2 : Integer;
  c: TBGRAPixel;
  Po2: array[0..3, 0..1] of Extended;
  Orgx: integer;
  Orgy: integer;

begin

  Orgx := 122;
  Orgy := 99;
  bmp := TBGRABitmap.Create(140,198, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.lineWidth:=2;
  bmp.Canvas2D.arc(115+36,100,85,(Pi/2)+(Pi/16),(-Pi/2)-(Pi/16),false);
  bmp.Canvas2D.strokeStyle ('rgb(55,255,55)');
  bmp.Canvas2D.stroke();

  bmp.Canvas2D.lineWidth:=1;

  Po2:=Po1;
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);

  x_ :=((55)*cos(t));
  y_ :=((55)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;

  Mouse_down_x:=x_+2;
  Mouse_down_y:=y_+55;
  Mouse_down_r:=23;
  bmp.FillEllipseAntialias(x_,y_,23,23,BGRA(192,192,192,255));
  bmp.EllipseAntialias(x_,y_,23,23,BGRA(0,0,0,255),1.4);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,82,14,5);
  bmp.Canvas2D.fillRect(122,67,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,72,23,6);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,111,14,5);
  bmp.Canvas2D.fillRect(122,116,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,120,23,6);

  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);
  bmp.Canvas2D.fillStyle('rgb(255,255,128)');
  bmp.Canvas2D.translate(Orgx,Orgy);
  bmp.Canvas2D.rotate((t+pi)*(-1));

  c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText

  bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x_-13,y_+19)],c,1.3);

  bmp.DrawPolyLineAntialias([PointF(x_+23,y_+1), PointF(120,0)],c,1.3);

  bmp.Canvas2D.fillRect(-65,-8,76,15);

  bmp.FillEllipseAntialias(x_,y_,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,3,3,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy,3,3,BGRA(0,0,0,255),1);

  x_ :=((Po2[0,0])*cos(t)) - ((Po2[0,1])*sin(t));
  y_ :=((Po2[0,0])*sin(t)) + ((Po2[0,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[0,0] := x_;
  Po2[0,1] := y_;
  x_ :=((Po2[1,0])*cos(t)) - ((Po2[1,1])*sin(t));
  y_ :=((Po2[1,0])*sin(t)) + ((Po2[1,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[1,0] := x_;
  Po2[1,1] := y_;
  x_ :=((Po2[2,0])*cos(t)) - ((Po2[2,1])*sin(t));
  y_ :=((Po2[2,0])*sin(t)) + ((Po2[2,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[2,0] := x_;
  Po2[2,1] := y_;
  x_ :=((Po2[3,0])*cos(t)) - ((Po2[3,1])*sin(t));
  y_ :=((Po2[3,0])*sin(t)) + ((Po2[3,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[3,0] := x_;
  Po2[3,1] := y_;
  bmp.DrawPolygonAntialias([PointF(Po2[0,0],Po2[0,1]),PointF(Po2[1,0],Po2[1,1]),PointF(Po2[2,0],Po2[2,1]),PointF(Po2[3,0],Po2[3,1])],c,1);

  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);
  bmp.Canvas2D.resetTransform;

  x_ :=((20)*cos(t));
  y_ :=((20)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;

  bmp.FillEllipseAntialias(x_,y_,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,2,2,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy+62,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy+62,2,2,BGRA(0,0,0,255),1);

  x_ :=((((20)*cos(t))));
  y_ :=((((20)*sin(t))));
  Tem2:=Round(sqrt(sqr(x_)+sqr(y_)));
  Tem2:=(sqrt(sqr(x_)+sqr(y_+62)));
  if (x_=0) or (Tem2=0) then Tem3:=0 else Tem3:= arcsin(x_/Tem2);


  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.translate(Orgx,Orgy+62);
  bmp.Canvas2D.rotate(Tem3);
  bmp.Canvas2D.fillStyle(BGRA(158,158,158,255));
  bmp.Canvas2D.fillRect(-2,38-Tem2,4,-35);

  bmp.Canvas2D.fillStyle('rgb(168,168,168)');
  bmp.Canvas2D.fillRect(-7,-2,14,-5);
  bmp.Canvas2D.fillRect(-5,-6,10,-26);
  bmp.Canvas2D.fillRect(-7,-31,14,-5);

  bmp.Canvas2D.fillStyle('rgb(128,128,128)');
  bmp.Canvas2D.fillRect(-2,-7,4,-26);

  c := ColorToBGRA(ColorToRGB(TColor($37FF37)));
  bmp.DrawPolyLineAntialias([PointF(128,10), PointF(136,16), PointF(128,24)],c,2);
  bmp.DrawPolyLineAntialias([PointF(128,175), PointF(136,183), PointF(127,188)],c,2);

  bmp.Canvas2D.resetTransform;
  bmp.Draw(Canvas,2,55);//10,152
  bmp.Free;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  i : Extended;
  x : Extended;
  y : Extended;
  xy : Extended;
  CA : Extended;
  SA : Extended;
  c_ : Extended;
  t : Extended;
  t2 : Extended;
  s : String;
  F : Double;
  bmp: TBGRABitmap;
  c: TBGRAPixel;
  Po2: array[0..3, 0..1] of Extended;
  Orgx: integer;
  Orgy: integer;

begin
 // Orgx := 122;
 // Orgy := 97;
 // Po2 := Po1;
 // bmp := TBGRABitmap.Create(140,197, ColorToBGRA(ColorToRGB(clBtnFace))); //ColorToBGRA(ColorToRGB(clBtnFace)) // BGRA(239,239,239)  //88,195,BGRA(239,239,239)
 //
 // //t := (ScrollBar1.Position * (-0.78539816) / 10000) + 3.53429173;
 // t := (((pi/4)/10000)*(10000-ScrollBar1.Position))-(pi/8);  //(2*pi/10000)*ScrollBar1.Position;
 // x :=((-55)*cos(t))+Orgx;
 // y :=((-55)*sin(t))+Orgy;
 // //bmp.Canvas.pen.color := TColor($FFFFFF);
 // bmp.Canvas2D.strokeStyle ('rgb(55,255,55)');
 // bmp.Canvas2D.lineWidth:=2;
 // bmp.Canvas2D.arc(115+36,100,85,(Pi/2)+(Pi/16),(-Pi/2)-(Pi/16),false);
 // //bmp.Canvas2D.fill();
 // bmp.Canvas2D.stroke();
 // bmp.Canvas2D.lineWidth:=1;
 //
 // Mouse_down_x:=x+2;
 // Mouse_down_y:=y+55;
 // Mouse_down_r:=23;
 // bmp.FillEllipseAntialias(x,y,23,23,BGRA(192,192,192,255));
 // bmp.EllipseAntialias(x,y,23,23,BGRA(0,0,0,255),1.4);
 //
 // bmp.Canvas2D.fillStyle('rgb(120,120,120)');
 // bmp.Canvas2D.fillRect(118,80,14,5);
 // bmp.Canvas2D.fillRect(122,65,6,15);
 // bmp.Canvas2D.fillStyle('rgb(200,200,200)');
 // bmp.Canvas2D.fillRect(118,70,23,6);
 //
 // bmp.Canvas2D.fillStyle('rgb(120,120,120)');
 // bmp.Canvas2D.fillRect(118,109,14,5);
 // bmp.Canvas2D.fillRect(122,114,6,15);
 // bmp.Canvas2D.fillStyle('rgb(200,200,200)');
 // bmp.Canvas2D.fillRect(118,118,23,6);
 //
 // bmp.Canvas2D.fillStyle('rgb(255,255,128)');
 // bmp.Canvas2D.translate(Orgx,Orgy);
 // //bmp.Canvas.brush.style := bsClear;
 // //bmp.Canvas.pen.color := clBlack;
 // //bmp.Canvas2D.scale(1,1);
 // //bmp.Canvas2D.moveTo(0,0);
 //
 // bmp.Canvas2D.rotate(t);
 //
 // c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText
 // x :=((-55)*cos(t))+Orgx;
 // y :=((-55)*sin(t))+Orgy;
 // bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x-13,y+19)],c,1.3);
 //
 // x :=((-55)*cos(t))+Orgx;
 // y :=((-55)*sin(t))+Orgy;
 // bmp.DrawPolyLineAntialias([PointF(x+23,y+1), PointF(120,0)],c,1.3);
 //
 // //Button1.Caption:= FloatToStr(t);
 // bmp.Canvas2D.fillRect(-65,-8,76,15);
 //
 // //bmp.Canvas2D.lineWidth:=1;
 // //bmp.Canvas2D.strokeStyle ('rgb(0,0,0)');
 // //bmp.Canvas2D.strokeRect(-37,-8,74,16);
 //
 // bmp.FillEllipseAntialias(x,y,3,3,BGRA(128,128,128,255));
 // bmp.EllipseAntialias(x,y,3,3,BGRA(0,0,0,255),1);
 //
 // ////bmp.DrawPolyLineAntialias([PointF(x,y), PointF(Orgx,Orgy+61)],c,1.3);
 // //x := Orgx - x;
 // //y := Orgy - y;
 // //xy := sqrt(sqr(x)+sqr(y)-(2*x*y*cos((t*4)-pi)));
 // ////Button1.Caption:= FloatToStr(xy)  + ' ' + FloatToStr(t) + ' ' + FloatToStr((t*4));
 // ////CA := (sqr(y) + sqr(xy)- sqr(x))/2*y*xy;
 // ////SA := sin(t-pi)/y*xy;
 // //
 // ////t2 := (((-pi)/36/10000)*ScrollBar1.Position)+(pi/15) ;
 // t2 := ((10000-ScrollBar1.Position) * (-0.7853981) / 10000) + 3.53429173;
 // //c_ := sqrt(sqr(61)+sqr(20)-(2*61*20*cos(t2)));
 // //CA := (sqr(61) - sqr(20)+ sqr(c_))/(2*61*c_);
 // //SA := 20*sin(t2)/c_;
 // //x :=((-32)*cos(t2))-((-66)*sin(t2))+Orgx;
 // //y :=((-66)*cos(t2))+((-32)*sin(t2))+Orgy+61;
 // //x :=(10000-ScrollBar1.Position) * 12/10000 +12;
 // //y :=(10000-ScrollBar1.Position) * (-4)/10000 +63;
 // ////x := c_;
 // ////y := c_;
 // ////Button1.Caption:= FloatToStr(x) + ' ' + FloatToStr(y);
 // //x :=((-x)*CA)-((-y)*SA)+Orgx;
 // //y :=((-x)*SA)+((-y)*CA)+Orgy+61;
 // ////Button1.Caption:= FloatToStr(c_) + ' ' + FloatToStr(t2) + ' ' + FloatToStr(cos(t2));
 // ////Button1.Caption:= FloatToStr(sqr(61)+sqr(20)) + ' ' + FloatToStr((2*61*20*cos(t2)));
 // ////Button1.Caption:= FloatToStr(sqr(61) - sqr(20)+ sqr(c_) ) + ' ' + FloatToStr(2*61*c_) + ' ' + FloatToStr(c_);
 // ////Button1.Caption:= FloatToStr(CA) + ' ' + FloatToStr(SA);
 // ////Button1.Caption:= FloatToStr(c_);
 // //bmp.DrawPolyLineAntialias([PointF(Orgx,Orgy+61),PointF(x,y)],c,1.3);
 //
 // bmp.FillEllipseAntialias(Orgx,Orgy,3,3,BGRA(128,128,128,255));
 // bmp.EllipseAntialias(Orgx,Orgy,3,3,BGRA(0,0,0,255),1);
 //
 // x :=((Po2[0,0])*cos(t)) - ((Po2[0,1])*sin(t));
 // y :=((Po2[0,0])*sin(t)) + ((Po2[0,1])*cos(t));
 // Po2[0,0] := x+Orgx;
 // Po2[0,1] := y+Orgy;
 // x :=((Po2[1,0])*cos(t)) - ((Po2[1,1])*sin(t));
 // y :=((Po2[1,0])*sin(t)) + ((Po2[1,1])*cos(t));
 // Po2[1,0] := x+Orgx;
 // Po2[1,1] := y+Orgy;
 // x :=((Po2[2,0])*cos(t)) - ((Po2[2,1])*sin(t));
 // y :=((Po2[2,0])*sin(t)) + ((Po2[2,1])*cos(t));
 // Po2[2,0] := x+Orgx;
 // Po2[2,1] := y+Orgy;
 // x :=((Po2[3,0])*cos(t)) - ((Po2[3,1])*sin(t));
 // y :=((Po2[3,0])*sin(t)) + ((Po2[3,1])*cos(t));
 // Po2[3,0] := x+Orgx;
 // Po2[3,1] := y+Orgy;
 //
 // //bmp.RectangleAntialias(0,0,74,16,c,1);
 // //bmp.DrawPolyLineAntialias([PointF(Orgx,Orgy)],c,1);
 // bmp.DrawPolygonAntialias([PointF(Po2[0,0],Po2[0,1]),PointF(Po2[1,0],Po2[1,1]),PointF(Po2[2,0],Po2[2,1]),PointF(Po2[3,0],Po2[3,1])],c,1);
 //
 // bmp.Canvas2D.resetTransform;
 //// Button1.Caption:= FloatToStr(-t2);
 // bmp.Canvas2D.translate(Orgx,Orgy+62);
 // bmp.Canvas2D.rotate((ScrollBar1.Position*0.061/(-10000))-3.4019);
 //
 // bmp.Canvas2D.fillStyle(BGRA(158,158,158,255));
 // bmp.Canvas2D.fillRect(-2+sin((ScrollBar1.Position*pi/(-10000))+pi),((ScrollBar1.Position*15/(-10000))+70),4,-35);
 // //Button1.Caption:= FloatToStr((ScrollBar1.Position*15/(-10000))+70);
 //
 // bmp.Canvas2D.fillStyle('rgb(168,168,168)');
 // bmp.Canvas2D.fillRect(-7+sin((ScrollBar1.Position*pi/(-10000))+pi),7,14,-5);
 // bmp.Canvas2D.fillRect(-5+sin((ScrollBar1.Position*pi/(-10000))+pi),32,10,-26);
 // bmp.Canvas2D.fillRect(-7+sin((ScrollBar1.Position*pi/(-10000))+pi),36,14,-5);
 //
 // bmp.Canvas2D.fillStyle('rgb(128,128,128)');
 // bmp.Canvas2D.fillRect(-2+sin((ScrollBar1.Position*pi/(-10000))+pi),32,4,-26);
 //
 // c := ColorToBGRA(ColorToRGB(TColor($37FF37)));
 // bmp.DrawPolyLineAntialias([PointF(128,10), PointF(136,16), PointF(128,24)],c,2);
 // bmp.DrawPolyLineAntialias([PointF(128,175), PointF(136,183), PointF(127,188)],c,2);
 //
 // x :=((-20)*cos(t))+Orgx;
 // y :=((-20)*sin(t))+Orgy;
 //
 // bmp.FillEllipseAntialias(x,y,2,2,BGRA(128,128,128,255));
 // bmp.EllipseAntialias(x,y,2,2,BGRA(0,0,0,255),1);
 //
 // bmp.FillEllipseAntialias(Orgx,Orgy+62,2,2,BGRA(128,128,128,255));
 // bmp.EllipseAntialias(Orgx,Orgy+62,2,2,BGRA(0,0,0,255),1);
 //
 // //x :=(((-37)*x)+40);
 // //y :=((-37)*y)+40;
 //
 //
 // //Button1.Caption:= FloatToStr(((2*pi/10000)*ScrollBar1.Position)*(180/pi));
 // //bmp.DrawPolyLineAntialias([PointF(40,40),PointF(40-37,40)],c,1);
 // //bmp.DrawPolyLineAntialias([PointF(x,y+9),PointF(x,y-9)],c,1);
 // //x :=cos(((2*pi/10000)*ScrollBar1.Position)- (pi/2));   // - (pi/4)- (pi/2)
 // //y :=sin(((2*pi/10000)*ScrollBar1.Position)- (pi/2));   // - (pi/4)- (pi/2)
 // //bmp.DrawPolyLineAntialias([PointF((-9*x)+40,(-9*y)+40),PointF((9*x)+40,(9*y)+40)],c,1);
 //
 //
 // //x :=cos(((2*pi/10000)*ScrollBar1.Position)- (pi/4)- (pi/2));   // - (pi/4)- (pi/2)
 // //y :=sin(((2*pi/10000)*ScrollBar1.Position)- (pi/4)- (pi/2));   // - (pi/4)- (pi/2)
 // //x :=cos((pi/4));
 // //y :=sin((pi/4));
 // // bmp.DrawPolyLineAntialias([PointF(40,40),PointF((x*r3)+40,(y*r3)+40)],c,1);
 //
 // bmp.Draw(Canvas,2,55);//10,152
 // bmp.Free;
  form1.Refresh;

  if TryStrToFloat(Edit8.Text,F) and TryStrToFloat(Edit9.Text,F) Then
  begin
     i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
     i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
     Edit1.Text:=FloatToStr(i);
     if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then i:=0
  else
     i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
     s:=FormatFloat('####0.000',i + StrToFloat(Edit4.Text));
     if StrToFloat(s) = 0 then s := '0';
     Edit5.Text := s + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
  end;
  if TryStrToFloat(Edit1.Text,F) then
  begin
    i:=StrToFloat(Edit1.Text);
    s:=FormatFloat('####0',i);
    Edit13.Text:=s;
  end;
  if TryStrToFloat(Edit14.Text,F) and TryStrToFloat(Edit15.Text,F) and TryStrToFloat(Edit16.Text,F) and TryStrToFloat(Edit17.Text,F) Then
  begin
    i:= (((StrToFloat(Edit13.Text)-StrToFloat(Edit14.Text))*StrToFloat(Edit15.Text))/StrToFloat(Edit17.Text))+ StrToFloat(Edit16.Text);
    s:=FormatFloat('####0.000',i);
    Edit18.Text:=s;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   ScrollBar1.Position := StrToInt(FloatToStr(((StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/2)*(ScrollBar1.Max/(StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text)))));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
F:Double;
begin
   if TryStrToFloat(Edit6.Text,F) and TryStrToFloat(Edit7.Text,F) and TryStrToFloat(Edit8.Text,F) and TryStrToFloat(Edit9.Text,F) Then
      begin
      Edit2.Text:=FloatToStr(StrToFloat(Edit8.Text)-StrToFloat(Edit9.Text));
      Edit3.Text:=FloatToStr(StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text));
      Edit4.Text:=FloatToStr(StrToFloat(Edit8.Text)-(StrToFloat(Edit6.Text)*StrToFloat(Edit2.Text)/StrToFloat(Edit3.Text)));
      if (StrToFloat(Edit2.Text) < 0) and (StrToFloat(Edit3.Text) < 0) Then
         begin
            Edit2.Text := FloatToStr(StrToFloat(Edit2.Text) * (-1));
            Edit3.Text := FloatToStr(StrToFloat(Edit3.Text) * (-1));
         end;
      //Edit5.Text := FormatFloat('####0.000',i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
      end;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
var
  i2:String;
begin
 if CheckBox1.Checked = True then
 begin
    label6.Caption:= 'Min';
    label7.Caption:= 'Max';
    i2:=Edit6.Text;
    Edit6.Text:=Edit7.Text;
    Edit7.Text:=i2;
 end
 else
 begin
    label6.Caption:= 'Max';
    label7.Caption:= 'Min';
    i2:=Edit6.Text;
    Edit6.Text:=Edit7.Text;
    Edit7.Text:=i2;
 end;
end;

procedure TForm1.Edit10Change(Sender: TObject);
var
  i : Extended;
  F:Double;
  begin
     if TryStrToFloat(Edit8.Text,F) and TryStrToFloat(Edit9.Text,F) Then
        begin
  i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
  i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
  Edit1.Text:=FloatToStr(i);
  if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
  i:=0
  else
  i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
  Edit5.Text := FormatFloat('####0.000',i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
  Label15.Caption:='= Actual '+Edit10.Text;
  end;
  end;

procedure TForm1.Edit11EditingDone(Sender: TObject);
var
   F : Double;
begin
  if TryStrToFloat(Edit11.Text,F) and TryStrToFloat(Edit12.Text,F) Then
  begin
    Edit6.Text:=Edit11.Text;
    Edit6Change(Sender);
  end;
end;

procedure TForm1.Edit12EditingDone(Sender: TObject);
var
   F : Double;
begin
  if TryStrToFloat(Edit11.Text,F) and TryStrToFloat(Edit12.Text,F) Then
  begin
    Edit7.Text:=Edit12.Text;
    Edit7Change(Sender);
  end;
end;

procedure TForm1.Edit14EditingDone(Sender: TObject);
var
  F : Double;
begin
  if TryStrToFloat(Edit14.Text,F) and TryStrToFloat(Edit15.Text,F) and TryStrToFloat(Edit16.Text,F) and TryStrToFloat(Edit17.Text,F) Then
  begin
    ScrollBar1Change(Sender);
  end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
var
  i : Extended;
  s : String;
  F : Double;
begin
if TryStrToFloat(Edit2.Text,F) and TryStrToFloat(Edit3.Text,F) and TryStrToFloat(Edit4.Text,F) and TryStrToFloat(Edit6.Text,F) and TryStrToFloat(Edit7.Text,F) Then
begin
i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
Edit1.Text:=FloatToStr(i);
if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
i:=0
else
i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
s:=FormatFloat('####0.000',i + StrToFloat(Edit4.Text));
if StrToFloat(s) = 0 then s := '0';
Edit5.Text := s + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
end;
end;


procedure TForm1.Edit3Change(Sender: TObject);
var
  i : Extended;
  s : String;
  F : Double;
begin
if TryStrToFloat(Edit2.Text,F) and TryStrToFloat(Edit3.Text,F) and TryStrToFloat(Edit4.Text,F) and TryStrToFloat(Edit6.Text,F) and TryStrToFloat(Edit7.Text,F) Then
begin
i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
Edit1.Text:=FloatToStr(i);
if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
i:=0
else
i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
s:=FormatFloat('####0.000',i + StrToFloat(Edit4.Text));
if StrToFloat(s) = 0 then s := '0';
Edit5.Text := s + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
end;
end;
procedure TForm1.Edit4Change(Sender: TObject);
var
  i : Extended;
  s : String;
  F : Double;
begin
if TryStrToFloat(Edit2.Text,F) and TryStrToFloat(Edit3.Text,F) and TryStrToFloat(Edit4.Text,F) and TryStrToFloat(Edit6.Text,F) and TryStrToFloat(Edit7.Text,F) Then
begin
i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
Edit1.Text:=FloatToStr(i);
if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
i:=0
else
i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
s:=FormatFloat('####0.000',i + StrToFloat(Edit4.Text));
if StrToFloat(s) = 0 then s := '0';
Edit5.Text := s + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
end;
end;

procedure TForm1.Edit6Change(Sender: TObject);
var
  i : Extended;
  s : String;
  F : Double;
  begin
  if TryStrToFloat(Edit2.Text,F) and TryStrToFloat(Edit3.Text,F) and TryStrToFloat(Edit4.Text,F) and TryStrToFloat(Edit6.Text,F) and TryStrToFloat(Edit7.Text,F) Then
  begin
  i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
  i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
  Edit1.Text:=FloatToStr(i);
  if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
  i:=0
  else
  i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
  s:=FormatFloat('####0.000',i + StrToFloat(Edit4.Text));
  if StrToFloat(s) = 0 then s := '0';
  Edit5.Text := s + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
  end;
  Edit11.Text:=Edit6.Text;
end;

procedure TForm1.Edit7Change(Sender: TObject);
var
  i : Extended;
  s : String;
  F : Double;
  begin
  if TryStrToFloat(Edit2.Text,F) and TryStrToFloat(Edit3.Text,F) and TryStrToFloat(Edit4.Text,F) and TryStrToFloat(Edit6.Text,F) and TryStrToFloat(Edit7.Text,F) Then
  begin
  i := (StrToFloat(Edit6.Text)-StrToFloat(Edit7.Text))/ScrollBar1.Max;
  i := StrToFloat(Edit6.Text)-(i*ScrollBar1.Position);
  Edit1.Text:=FloatToStr(i);
  if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
  i:=0
  else
  i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
  s:=FormatFloat('####0.000',i + StrToFloat(Edit4.Text));
  if StrToFloat(s) = 0 then s := '0';
  Edit5.Text := s + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
  end;
  Edit12.Text:=Edit7.Text;
end;

procedure TForm1.Edit8Change(Sender: TObject);
begin

end;

procedure TForm1.Edit9Change(Sender: TObject);
begin

end;

end.

