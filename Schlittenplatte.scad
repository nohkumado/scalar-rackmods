bohrungen = [
  [7.5,9.15,-1,11.5,6], [7.5,49.5,-1,11.5,6],[66,9.15,-1,11.5,6],[66,49.5,-1,11.5,6],   //Eckbohrungen ul ol ur or
  [7.5,9.15,5], [7.5,49.5,5],[66,9.15,5],[66,49.5,5],   //Eckbohrungen ul ol ur or
  [21.0,54.9,4.8], [51.0,54.9,4.8], [18.35,39.85,4.8], [55.25,39.85,4.8], //5. Löcher
  [36.9,53.2,3], [36.9,45.15,3], [36.9,40.15,3], //3, Loeher mitte vertikal von oben 
  [22.0,35.15,3], [22.0,27.15,3], [22.0,22.15,3], //links vert von oben
  [52.00,35.18,3], [52.00,27.15,3], [52.00,22.15,3], //rechts von oben
  [4,20,1],[4,38.5,1],[70,20,1],[70,38.5,1]//Schrauben
];
ecken = [[0,0], [73.6,0],[73.6,60.4],[0,60.4]];
gausschnitte = [[29.65,11.1,15.25,23.3,10,0], [24.65,-1,24.2,8.5,10,1]]; //Kuehlerausschnitt, Hitzeblock
ausschnitte = [ 
            [12.1,23.3,6.1,10.35,10],[07.95,25.1,5,6.75,10],[-1,16.25,9,26.15,5],
            [55.4,23.3,6.1,10.35,10],[60.65,25.1,5,6.75,10],[65.6,16.25,9,26.15,5]
];

//sample = [7.5,9.15,-2,11.5,6];
  //        color("red")translate([sample[0], sample[1], sample[2]]) cylinder(d=sample[3], h=sample[4], $fn=90);

Schlittenplatte();
color("magenta")
translate([157.66,478,-61.5]) rotate([0,0,-90])
import("CarriageRouletteFront2020.stl", convexity=3);

color("green")
translate([257.66,478,-61.5]) rotate([0,0,-90])
import("CarriageRouletteFront2020.stl", convexity=3);
module Schlittenplatte()
{
  difference()
  {
    GrundPlatte();
    //cube([73.6,60.4,8.35]);
    union()
    {
      //for(pos = [0 : 1 : 3])
      //{
      //  translate([ecken[pos][0], ecken[pos][1], 4]) rotate([0,0,pos*90])fillet(10,10);
      //}
      for(pos = bohrungen)
      {
        //echo ("pos is  ",pos,"x/y ",bohrungen[pos]," x=",bohrungen[pos][0]);
        //translate([bohrungen[pos][0], bohrungen[pos][1], -1]) cylinder(d=11.5, h=10, $fn=90);
        if(len(pos) == 5)
        {
          translate([pos[0], pos[1], pos[2]]) cylinder(d=pos[3], h=pos[4], $fn=90);
        }
        else if(len(pos) == 4)
        {
          translate([pos[0], pos[1], pos[2]]) cylinder(d=pos[3], h=10, $fn=90);
        }
        else
        {
          translate([pos[0], pos[1], -1]) cylinder(d=pos[2], h=10, $fn=90);
        }
      }
     //color("blue")
     //  for(pos = ausschnitte)
     //  {
     //    translate([pos[0], pos[1], -1]) cube([pos[2],pos[3],pos[4]] );
     //  }
    }
  }
}
//color("blue") fillet(10,10);
module SchlittenAdapter(dicke =2)
{
  difference()
  {
    union()
    {
      GrundPlatte(dicke);
      for(pos = bohrungen)
      {
        if(pos[2] == 11.5)
          translate([pos[0], pos[1], dicke]) cylinder(d2=0.8*pos[2], d1=pos[2], h=1, $fn=90);
        if(pos[2] == 4.8)
          //translate([pos[0], pos[1], -8]) cylinder( d=pos[2], h=8, $fn=90);
          translate([pos[0], pos[1], dicke]) cylinder(d2=0.8*pos[2], d1=pos[2], h=8, $fn=90);
      }
    }//union()
    union()
    {
      pos1 = ausschnitte[2];
      translate([pos1[0], pos1[1], dicke -pos1[4] +1 ]) cube([pos1[2],pos1[3],pos1[4]] );
      pos2 = ausschnitte[5];
      translate([pos2[0], pos2[1], dicke -pos1[4] +1]) cube([pos2[2],pos2[3],pos2[4]] );
      color("red")for(pos = bohrungen)
      {
        if(pos[2] == 3)
          translate([pos[0], pos[1], -0.5]) cylinder(d=pos[2], h=dicke+2, $fn=90);
      }
    }
  }//difference
}//module  SchlittenAdapter


module GrundPlatte(dicke = 8.35)
{
  difference()
  {
    cube([73.6,60.4,dicke]);
    union()
    {
      for(pos = [0 : 1 : 3])
      {
        translate([ecken[pos][0], ecken[pos][1], 4]) rotate([0,0,pos*90])fillet(10,10);
      }
      union()
      {
        for(pos = gausschnitte)
        {
          difference()
          {
            union()
            {
              translate([pos[0], pos[1], -1]) cube([pos[2],pos[3],pos[4]] );
              if(pos[5] ==1) translate([pos[0], pos[1], 4]) rotate([0,0,1*90])fillet(5,10);
              if(pos[5] ==1) translate([pos[0]+pos[2], pos[1], 4]) rotate([0,0,0*90])fillet(5,10);
            }
            union()
            {
              if(pos[5] ==0) translate([pos[0], pos[1], 4]) rotate([0,0,0*90])fillet(3,12);
              if(pos[5] ==0) translate([pos[0]+pos[2], pos[1], 4]) rotate([0,0,1*90])fillet(3,12);
              translate([pos[0]+pos[2], pos[1]+pos[3], 4]) rotate([0,0,2*90])fillet(3,12);
              translate([pos[0], pos[1]+pos[3], 4]) rotate([0,0,3*90])fillet(3,12);
            }//union
          }//difference()
        }// for(pos = gausschnitte)
      }//union()
    }//union()
  }//difference()
}


module fillet(r, h) 
{
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true, $fn=100);

        }
}
