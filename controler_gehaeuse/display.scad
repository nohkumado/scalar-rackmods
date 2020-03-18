use <Hauptplatine.scad>;
$fn = 100;
b = 150.5; h = 56.5; d = 5;
rahmen = 5;

points = 
[
  [h/2+rahmen,d/2],
  [-h/2-rahmen,d/2],
  [-h/2-rahmen,d/2+2],
  [h/2+rahmen-sin(45)*30,d/2+cos(45)*30],
];
points2 = 
[
  [b/2+rahmen/2+25,0],
  [-b/2-rahmen/2-25,0],
  [-b/2-rahmen/2-25,30],
  [b/2+rahmen/2+25,30],
];

points3 = 
[
  [b/2+rahmen/2,0],
  [-b/2-rahmen/2,0],
  [-b/2-rahmen/2,2],
  [b/2+rahmen/2,2],
];



difference()
{
//Rücken
translate([0,11,-24])
rotate([45,0,0])
{
linear_extrude(height = 2,center=true)
polygon(points2);
color("red")translate([0,-17.16,44.5])rotate([21.9,0,0])linear_extrude(height = 2,center=true)
polygon(points3);
//
//rotate([-25.5,0,0])cube([b+rahmen,2,2],center= true);
translate([0,+15,-1.9])
cube([b+rahmen+50,8,2],center= true);
}

union()//Eckenabrundung
{
translate([-b/2-rahmen-25+2.5,11,-24]) rotate([45,0,0]) fillet(10, 8); 
translate([b/2+rahmen+25-2.5,11,-24]) rotate([45,0,0]) rotate([0,0,90])fillet(10, 8); 
translate([-b/2-rahmen-25+2.5,33,-3.3]) rotate([45,0,0]) rotate([0,0,-90])fillet(10, 8); 
translate([b/2+rahmen+25-2.5,33,-3.3]) rotate([45,0,0]) rotate([0,0,180])fillet(10, 8); 
//LBohrlöcher
color("red")
translate([-b/2-rahmen-9,28.3,-20]) rotate([45,0,0]) cylinder(d=6.5, h=20); 
color("red")
translate([+b/2+rahmen+9,28.3,-20]) rotate([45,0,0]) cylinder(d=6.5, h=20); 

}
}


difference()
{
union()
{
  translate([0,0,0])cube([b+rahmen,h+2*rahmen,6], center = true); //Unterer Rahmen
translate([b/2+rahmen-2,0,0])
rotate([-90,0,90])linear_extrude(height = 2)polygon(points);
translate([-b/2,0,0])
rotate([-90,0,90])linear_extrude(height = 2)polygon(points);
}


  union()
  {
    translate([0,0,2.1])Hauptplatine(b = b, h = h, d = d, loch=false);
    translate([0,0,-1])
      difference()
      {
        Hauptplatine(b = b, h = h, d = d, loch=true);
        union()
        {
          translate([-75+0,h/2-0,0])rotate([0,0,45])cube([14,14,14], center = true);
          translate([-75+0,-h/2+0,0])rotate([0,0,-45])cube([14,14,14], center = true);
          translate([75+0,-h/2+0,0])rotate([0,0,45])cube([14,14,14], center = true);
          translate([75+0,h/2+0,0])rotate([0,0,-45])cube([14,14,14], center = true);
        }
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
