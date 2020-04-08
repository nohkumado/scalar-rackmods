offset = 20;
cw = 15;
bedx = 400;
bedy = 300;
d = .2;
cube([cw,cw,d], center = true);
translate( [bedx/2-cw/2-offset, bedy/2-cw/2-offset,d/2] )cube([15,15,d], center = true);
translate( [-bedx/2+cw/2+offset, bedy/2-cw/2-offset,d/2] )cube([15,15,d], center = true);

translate( [bedx/2-cw/2-offset, -bedy/2+cw/2+offset,d/2] )cube([15,15,d], center = true);
translate( [-bedx/2+cw/2+offset, -bedy/2+cw/2+offset,d/2] )cube([15,15,d], center = true);


rad = 2*bedx;
alpha = asin((bedy-offset/2)/(2*rad));
deltax = rad*cos(alpha);
beta = asin((bedx-offset/2)/(2*rad));
deltay = rad*cos(beta);
//echo(str("alpha ",alpha," dx = ",deltax, " a sin de 1 " , asin(1)));

//x boegen
 // color("red")
  translate( [(bedx-cw-2*offset)/2+deltax, 0,0] ) 
union()
{
  difference()
  {
    cylinder(r=rad, h=d,$fn=400);
    union()
      translate( [0, 0,-d/2] ) cylinder(r=rad-4,h=2*d, $fn=400);
    translate( [(rad-deltax-offset/10), 0,-0.1] ) cube([2*rad,3*rad,4*d],center = true);
  }

}

  color("red")
  translate( [(-bedx+cw+2*offset)/2-deltax, 0,0] ) 
union()
{
  difference()
  {
    cylinder(r=rad, h=d,$fn=400);
    union()
      translate( [0, 0,-d/2] ) cylinder(r=rad-4,h=2*d, $fn=400);
    translate( [-(rad-deltax-offset/9), 0,-d/2] ) cube([2*rad,3*rad,4*d],center = true);
  }

}

//y boegen
  color("red")
translate( [0,(bedy-cw-2*offset)/2+deltay, 0] ) 
union()
{
  difference()
  {
    cylinder(r=rad, h=d,$fn=400);
    union()
      translate( [0, 0,-d/2] ) cylinder(r=rad-4,h=2*d, $fn=400);
    translate( [ 0,(rad-deltay-offset/6),-d/2] ) cube([3*rad,2*rad,4*d],center = true);
  }
}

  color("red")
  translate( [0,(-bedy+cw+2*offset)/2-deltay, 0] ) 
union()
{
  difference()
  {
    cylinder(r=rad, h=d,$fn=400);
    union()
      translate( [0, 0,-d/2] ) cylinder(r=rad-4,h=2*d, $fn=400);
    translate( [ 0,-(rad-deltay-offset/6),-d/2] ) cube([3*rad,2*rad,4*d],center = true);
  }
}
