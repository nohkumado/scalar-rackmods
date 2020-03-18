$fn = 100;
b = 150; h = 56; d = 5;
rahmen = 5;
    Hauptplatine(b = b, h = h, d = d, loch=false);

module Hauptplatine(b = 150, h = 55.7, d = 5, loch = true)
{
  lochv = 2.3;
  if(loch)
  {
    difference()
    {
      cube([b,h,d], center = true); //Hauptplatine
      trous = [
        [-b/2+lochv, -h/2+lochv], 
        [b/2-lochv, -h/2+lochv],
        [b/2-lochv, h/2-lochv],
        [-b/2+lochv, h/2-lochv]
      ];
        for(pos = trous)
        {
          translate([pos[0],pos[1],-d])cylinder(d=3.3, h=d+4);
        }
    }
    translate([-b/2,-20.9,-d/2-3.9]) cube([30,27,5]); //SD Card reader
    translate([-b/2+45.7,-5,-d-7]) cube([21,10,10]); //Verbinder
    translate([-b/2+68.5,-5,-d-7]) cube([21,10,10]); //Verbinder
    translate([b/2-13.8,h/2-11.35,+d/2-.1]) 
    {
      cylinder(d=13, h=10);//Lautsprecher
    }
    translate([b/2-13.8,-h/2+8.300,+d/2-.1]) 
    {
      cylinder(d=4, h=8);//Knopf
    }
  }
  else
  {
    cube([b,h,d], center = true); //Hauptplatine
    trous = [
      [-b/2+lochv, -h/2+lochv], 
      [b/2-lochv, -h/2+lochv],
      [b/2-lochv, h/2-lochv],
      [-b/2+lochv, h/2-lochv]
    ];
      for(pos = trous)
      {
        translate([pos[0],pos[1],-d])cylinder(d=3.3, h=d+40);
      }
      translate([-b/2-10,-20.9,-d/2-3.9]) cube([40,27,5]); //SD Card reader
      translate([-b/2+45.7,-5,-d-7]) cube([23,12,12]); //Verbinder
      translate([-b/2+68.5,-5,-d-7]) cube([23,12,12]); //Verbinder
      translate([b/2-13.8,h/2-11.35,+d/2-.1]) 
      {
        cylinder(d=13, h=10);//Lautsprecher
        cylinder(d=3, h=50);//Damit der Ton rauskann...
      }
      translate([b/2-13.8,-h/2+8.300,+d/2-.1]) 
      {
        cylinder(d=8, h=50);//Knopf
      }
  }
  //translate([-b/2+14.2,-20,+d/2-.1]) 
  translate([-b/2+14.7,-h/2-7.5,+d/2-.1]) 
    cube([98.3,60,6]); //Verbinder
color("black")
  translate([b/2-12.8,h/2-30,+d/2-.1]) 
    cylinder(d=15, h=29);//Steuerung
color("blue")
  translate([-b/2+14.7,-25,d/2+d]) 
    cube([98,40,10]);//Display

}
