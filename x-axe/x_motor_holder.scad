use<../scalar_titan_adapter/fillet.scad>;
use<../masken/metrische_masken.scad>;
boardWidth = 78;
boardHeigth = 57.9;
boardthick = 5;

nemaWidth = 44.5;

loecher = 
[
  [-3.9,0,0],
  [-3.9,-12,0],
  [-3.9,-24,0],

  [11,-19],
  [21,-19],
  [33.5,-19],


  [11,  19],
  [21,  19],
  [33.5,19],
];

vloecher = 
[
  [-2.5,0.63*nemaWidth,3],
  [-nemaWidth+11,0.63*nemaWidth,3],
  [-nemaWidth/2+4.30,0.28*nemaWidth,24.5],
];

  //color("grey") translate([5,19.2,-40]) import("ZWheelHolder_Thermo.stl");

  x_motor_holder();


module x_motor_holder()
{

  difference()
  {
    union()
    {
      cube([boardWidth,boardHeigth,boardthick],center = true);
      translate([-nemaWidth+boardthick,7,-2.5])
        cube([nemaWidth,boardthick,0.81*nemaWidth]);
      kreissegment();
      translate([-nemaWidth+boardthick-1.5,0,0])
      {
        kreissegment();
        translate([boardthick+0,-0.240*nemaWidth,boardthick/2])
          rotate([90,0,0])
          fillet(r=11,h=0.81*nemaWidth);
      }
    }//positive
    union()//negative
    {
      //Abgerundete Ecken
      translate([boardWidth/2,boardHeigth/2,0.5]) rotate([0,0,180])fillet(r=9,h=boardthick+2);
      translate([boardWidth/2,-boardHeigth/2,0.5]) rotate([0,0,90])fillet(r=9,h=boardthick+2);
      translate([-nemaWidth/2+boardthick-0.8,boardHeigth/2-18.5/2+1.5,0.5])
        cube([nemaWidth-boardthick/2,18.5,boardthick+2],center = true);
      //Plattenschrauben
      for(pos = loecher)
      {
        translate([pos[0],pos[1],-boardthick/2-0.5])
          if(len(pos) ==3)
          {
            rotate([180,0,0])
              translate([0,0,-5.6])
              metrische_schraube_schablone(typ = pos[2], mass= 3,laenge = 10, toleranz = 0.1);
          }
          else
          {
            cylinder(d=3, h=boardthick+2, $fn=100);
          }
      }//for(pos = loecher)
      for(pos = vloecher)
      {
        translate([pos[0],boardWidth/2-(20+boardthick+.1),pos[1]])
          rotate([90,0,0])
          cylinder(d=pos[2], h=boardthick+2, $fn=100);
      }//for(pos = loecher)
eb = 13.5;
eh = 21.5;
ed = 0.6*boardthick;
trapez =
[
  [0,0],
  [eb,0],
  [eb-ed/2,boardthick/2],
  [eb-ed/2,boardthick],
  [ed/2,boardthick],
  [ed/2,boardthick/2],
];
      color("magenta")
        translate([1,0,02.5])
      linear_extrude(height = eh)
      rotate([0,0,-90])
        translate([-eb/2,0,00])
      polygon(trapez);
    }//union()//negative
  }//difference



}// module x_motor_holder()

module kreissegment()
{


  //color("red")
  difference()
  {
    translate([1.5,boardthick,-1.5])
      rotate([0,90,0])
      cylinder(r=0.81*nemaWidth, h=boardthick-1.5, $fn=200);
    union()
    {
      translate([1,0,-boardHeigth/2-boardthick/2])
        cube([2*boardthick+2,2*boardHeigth,boardHeigth],center = true);
      translate([1,boardHeigth/2+2*boardthick+2,0])
        cube([2*boardthick,boardHeigth,2*boardHeigth],center = true);
      translate([1,-boardHeigth,0])
        cube([2*boardthick,boardHeigth,2*boardHeigth],center = true);
    }
  }
}// module kreissegment()

