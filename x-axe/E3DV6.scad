  //ptediam = 4.1; //on scalar printer
  ptediam = 4.6; //on ender 5 printer
//translate([37,6,-10])  rotate([0,0,180])rotate([90,180,0])
E3DV6();
function e3doffset(pos) = (pos == "top") ? -43 : (pos == "middle") ? 0 : 18;
module E3DV6(vulcan=false, offset = "middle", asmask = true)
{
  translate([0,0,e3doffset(offset)])
  {
    cylinder(d=22.2, h=26.5);//main body
    translate([0,0,30]) ColletRingMask(extend = 5,mask = true);

    //cylinder(d=16, h=33.9);
    //cylinder(d=12, h=43);
    //  translate([0,0,39])cylinder(d=16, h=4);
    translate([0,-4.6,-6])cube([16.25,23.8,12], center = true);
    translate([0,0,-18])cylinder(d2=8, d1=0.1, h=6);
    if(vulcan)
    {
      /*
         Gesamth 65.5
         mit Spitze 71
         Breite H 12
         Breite H 20
         Hoehr H 20
         Hoehe Heizkoepf Kuehler bis ausgang spitze 22.2

       */
    }//
  }
}// module E3DV6(vulcan=false)

function ptdiam(mask,luft) = (mask)? ptediam+luft : ptediam -luft;
module ColletRing(extend = 0,luft = 0.2,mask = false)
{
  difference()
  {
    ColletRingMask(extend, mask = mask);
    translate([0,0,-1]) cylinder(d=ptdiam(mask,luft), h= 15+extend, $fn = 64);
  }
}// module ColletRing()
function topRing(mask) = (mask) ? 4.6 : 3.9;
module ColletRingMask(extend = 0,mask = true)
{
  $fn =64;
  translate([0,0,-extend])
  {
    cylinder(d=16, h=3.0+extend);
    //color("green")
    cylinder(d=12, h=13.0+extend);
  }
  translate([0,0,9+4-topRing(mask)])cylinder(d=16, h=topRing(mask));

}// module ColletRingMask()
