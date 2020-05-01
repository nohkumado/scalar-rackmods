use <../masken/metrische_masken.scad>
GPdicke = 8.35;
GPbreite = 73.6; 
GPhoehe = 60.4 ;
bohrungen = [
  [7.5,9.15,-1,11.5,6], [7.5,49.5,-1,11.5,6],[66,9.15,-1,11.5,6],[66,49.5,-1,11.5,6],   //Eckbohrungen ul ol ur or
  [7.5,9.15,5], [7.5,49.5,5],[66,9.15,5],[66,49.5,5],   //Eckbohrungen ul ol ur or
  [21.0,54.9,-1,5,10,0], [51.0,54.9,-1,5,10,0], [18.35,39.85,-1,5,10,0], [55.25,39.85,-1,5,10,0], //5. Löcher
  [36.9,53.2,3], [36.9,45.15,3], [36.9,40.15,3], //3, Loeher mitte vertikal von oben 
  [22.0,35.15,3], [22.0,27.15,3], [22.0,22.15,3], //links vert von oben
  [52.00,35.18,3], [52.00,27.15,3], [52.00,22.15,3], //rechts von oben
  [4,20,1],[4,38.5,1],[70,20,1],[70,38.5,1]//Schrauben
];
ecken = [[0,0], [73.6,0],[73.6,60.4],[0,60.4]];
gausschnitte = [[29.65,11.1,15.25,23.3,10,0], [24.65,-1,24.2,8.5,10,1]]; //Kuehlerausschnitt, Hitzeblock
ausschnitte = [ 
            [12.1,23.3,6.1,10.35,10], //innenrechrts
            [07.95,25.1,5,6.75,40],//aussen rechts
            [-1,16.25,9,26.15,5],//lasche Rechts
            [55.4,23.3,6.1,10.35,10],
            [60.65,25.1,5,6.75,40],
            [65.6,16.25,9,26.15,5]
];

//sample = [7.5,9.15,-2,11.5,6];
  //        color("red")translate([sample[0], sample[1], sample[2]]) cylinder(d=sample[3], h=sample[4], $fn=90);

//translate([0,0,0.5])
//difference()
//{
//translate([1,1,-0.5]) 
Schlittenplatte(dicke = 5,baender = false);
//cube([2*GPbreite, 2*GPhoehe,30 ]);
//}
// color("magenta")
// translate([157.66,478,-61.5]) rotate([0,0,-90])
// import("CarriageRouletteFront2020.stl", convexity=3);

//color("green")
//translate([257.66,478,-61.5]) rotate([0,0,-90])
//import("CarriageRouletteFront2020.stl", convexity=3);
module Schlittenplatte(dicke = 8.35, baender = true)
{
  difference()
  {
    union()
    {
      GrundPlatte(dicke);
      if(baender)
      {
        translate([0,GPhoehe/2-1.415,dicke]) Bandhalterung();
        translate([GPbreite,GPhoehe/2-1.415,dicke]) mirror([90,0,0])Bandhalterung();
      }
    }
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
        if(len(pos) == 6)
        {
          translate([pos[0], pos[1], pos[2]]) 
          {
            cylinder(d=pos[3], h=pos[4], $fn=90);
            if(baender)
            {
              translate([0, 0, dicke-pos[3]/2]) metrische_mutter_schablone(pos[3],startw = pos[5], toleranz = 0.1); //creates a M5 nut, rotated by 30deg and with an added .1 width
            }
          }
        }
        else if(len(pos) == 5)
        {
          translate([pos[0], pos[1], pos[2]]) cylinder(d=pos[3], h=pos[4], $fn=90);
        }
        else if(len(pos) == 4)
        {
          translate([pos[0], pos[1], pos[2]]) cylinder(d=pos[3], h=10, $fn=90);
        }
        else
        {
          color("blue")
            translate([pos[0], pos[1], -1]) cylinder(d=pos[2], h=10, $fn=90);
        }
      }
      for(pos = ausschnitte)
      {
        translate([pos[0], pos[1], -1]) cube([pos[2],pos[3],pos[4]] );
      }
    }
  }
}
//color("blue") fillet(10,10);
module Bandhalterung()
{
difference()
{
  bloc = [12,11,3.67];
  union()
  {
    difference()
    {
      translate([bloc[0]/2,0,bloc[2]/2])
        cube(bloc,center = true);
      union()
      {
          translate([bloc[0]/2,-5.5,bloc[2]]) rotate([90,90,90]) fillet(r = 1.5, h = bloc[0]+0.2);
          translate([bloc[0]/2,5.5,bloc[2]]) rotate([90,180,90]) fillet(r = 1.5, h = bloc[0]+0.2);
      }
    }
    translate([bloc[0]/2,5.4,0]) rotate([90,0,90]) fillet(r = 1.5, h = bloc[0]);
    translate([bloc[0]/2,-5.4,0]) rotate([90,0,-90]) fillet(r = 1.5, h = bloc[0]);
    rundung();
    difference()
    {
      union()
      {
        translate([4.0,2.5,3.65]) rotate([90,0,90]) fillet(r = 1.5, h = 8);
        translate([4.0,-2.5,3.65]) rotate([90,0,-90]) fillet(r = 1.5, h = 8);
      }
      delta = 8.2;
      difference()
      {
        translate([delta/2-.1,0,5]) cube([delta,10,2.5], center = true);
        rundung();
      }
    }
  }
        color("blue")
    translate([-0.1,0,bloc[2]-1]) rotate([00,90,0]) cylinder(d=3, h=15, $fn =64);
}
}//module Bandhalterung()
module rundung()
{
  hull()
  {
    translate([3.05,2.5,3.6]) rotate([90,0,0]) cylinder(d=6.1, h=5, $fn =64);
    translate([4.96,2.5,3.6])
      rotate([90,0,0]) cylinder(d=6.1, h=5, $fn =64);
  }
}//module rundung()
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


module GrundPlatte(dicke = 8.35,breite = 73.6, hoehe = 60.4 )
{
  difference()
  {
    cube([breite,hoehe,dicke]);
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
