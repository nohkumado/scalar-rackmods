dicke = 2;
lochx = 10.00;
mgnx = 45;
mgny = 27.5;
function leftRight(x,mod = 2)= (x%mod >= mod/2)? 1: -1;
difference()
{
  cube([mgnx,mgny,dicke], center = true);
  color("red")
    for(n = [0:3]) 
      translate([leftRight(n)*lochx,leftRight(n,4)*lochx,-dicke])cylinder(d=3.5, h=2*dicke, $fn=10);
}
 mosqy  =1.5*dicke;
color("magenta")
  translate([0,-mgny/2-mosqy/2,-12.5+dicke/2])
  cube([26,mosqy,25], center = true);
