use <Hauptplatine.scad>;
$fn = 100;
b = 150.5; h = 56.5; d = 5;
rahmen = 5;
gesb = 63;

difference()
{

  color("red")
    translate([0,-rahmen,d/2]) cube([b+2*rahmen,gesb+4*rahmen,d+12],center = true);
  union()
  {
  color("magenta")
    translate([0,-rahmen,d/2-2]) cube([b+rahmen,gesb+2*rahmen,d+12],center = true);
    translate([0,0,-d/2])Hauptplatine(b = b, h = h, d = d, loch=false);
    translate([-40,18,d])
    {
      difference()
      {
        linear_extrude(height = 10) text("SCALAR");
        translate([23.5,3.5,0])cube([2,2,90],center = true);
        translate([40.0,3.5,0])cube([2,2,90],center = true);
        translate([48.0,4.5,0])cube([2,2,90],center = true);
      }
    }
translate([(b+rahmen)/2-22,-22,d+5]) 
{
zunge(laenge =30, breite = 16,dicke= 15); 
}
  }

}

  color("green")
translate([(b+rahmen)/2-22.6,-22,d+5.5]) 
{
difference()
{
zunge(laenge =29, breite = 15,dicke= 1); 
translate([-7,-3,-.1]) 
        linear_extrude(height = 10) text(size=5,"STOP");
}
}

module zunge(laenge =28, breite = 15,dicke) 
{
  difference()
  {
    cube([laenge,breite,dicke],center = true);
    union()
    {
      translate([laenge/2,-breite/2,-1]) 
        rotate([0,0,90])fillet(breite/2,10*dicke);
      translate([laenge/2,breite/2,-1]) 
        rotate([0,0,180])fillet(breite/2,10*dicke);
    }
  }
}
module fillet(r, h) 
{
  translate([r / 2, r / 2, 0])

    difference() {
      cube([r + 0.01, r + 0.01, h], center = true);

      translate([r/2, r/2, 0])
        cylinder(r = r, h = h + 1, center = true, $fn=64);

    }
}
