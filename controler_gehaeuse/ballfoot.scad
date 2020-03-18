use <../../profile_30x30/extrusion_profile.scad>;//https://www.thingiverse.com/thing:884966
$fn = 100;
balld = 35.8;
vier = [
  //[-30,20], [30,20], [30,-20], [-30,-20]
  [0,0] 
];
for(pos = vier)
{
  translate([pos[0], pos[1], 0]) fuss();
}

module fuss()
{
  difference()
  {
    drawCube(balld);
    union()
    {
      //translate([-50,0,25]) rotate([0,90,0])scale([1.05,1.05,1.05])extrusion_profile(height=100, size=30);
      //translate([1,9.5,17])cube([100,11,12], center = true);//rechts begradigung
      //translate([-1,-9.5,17])cube([100,12,12], center = true);//linksbegradigung
      //translate([-1,12,20])rotate([45,0,0])cube([32,10,10], center = true);
      //translate([-1,-12,20])rotate([45,0,0])cube([32,10,10], center = true);
      translate([0,0,-balld/2]) sphere(d=balld);
      translate([-50,0,-5])ausschnitt() ;
if(balld <= 30) rotate([0,0,90])translate([-50,0,-5])ausschnitt() ;
      translate([breite(balld)/2,-15.5,-breite(balld)/2-3])rotate([45,0,45])cube([7,7,7], center = true);
      translate([-breite(balld)/2,-15.5,-breite(balld)/2-3])rotate([45,0,-45])cube([7,7,7], center = true);
      translate([-breite(balld)/2,15.5,-breite(balld)/2-3])rotate([45,0,45])cube([7,7,7], center = true);
      translate([breite(balld)/2,15.5,-breite(balld)/2-3])rotate([-45,0,-45])cube([7,7,7], center = true);
      translate([0,0,6.1]) rotate([180,0,0])schraube(laenge = 12, zoff = 4, schuhz = 10, schuhd = 18);
    }

  }
}

function breite(d) = (d > 30) ? d+7 : d;
module drawCube(durch)
{
  laenge = 30;
  hoehe = 30;
  if(balld > 30) 
  { 
    laenge = balld + 6;
    //hoehe = 3*balld/5  + 22;
    hoehe = 9*balld/10  ;
    //echo("ist breiter", balld, " l:", laenge, " h: ", hoehe);
    color("blue") translate([0,0,-hoehe/4+0.4])cube([laenge,30,hoehe], center = true);
  }
  else 
    color("blue") translate([0,0,-hoehe/2+20])cube([laenge,30,hoehe], center = true);
    color("magenta") translate([0,0,hoehe/2-5.3])cube([breite(balld)-1.0,8,3], center = true);
}
module ausschnitt()
{
  rotate([0,90,0]) cylinder(d=12,h=100);
  translate([0,-2.5,-50]) cube([100,5,50]);
}
module schraube(laenge = 12, zoff = 3, schuhz = 10, schuhd = 8)
{
  color("red") cylinder(d=11,h=2*balld);
  translate([0,0,-6]) color("red") cylinder(d=6.5,h=laenge);
  translate([0,0,-schuhz-zoff]) 
    cylinder(d = schuhd,h = schuhz);
}
