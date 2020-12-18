difference()
{
  union()
  {
    cylinder(h=17, d=4.15, $fn=40);
    cylinder(h=15, d=7.9, $fn=40);
  }
  translate([0,0,-0.01])
    union()
    {
      cylinder(h=3, d2=1.5, d1 = 3.0, $fn=40);
      cylinder(h=20, d=2.22, $fn=40);
  translate([0,4,7.5]) color("blue")cube([3,3,16], center = true);
    }
}
