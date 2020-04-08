d = 50;
h=0.2;
$fn=200;

difference()
{
cylinder(d=d, h=h);
translate([0,0,-h/2]) cylinder(d=d-0.5, h=2*h);
}
translate([0,0,h/2]) cube([d,1,h],center=true);
translate([0,0,h/2]) cube([1,d,h],center=true);
