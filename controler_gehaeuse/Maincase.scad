//include <arduino_mount/arduino.scad>;
use <PiHoles/PiHoles.scad>;
use <../masken/metrische_masken.scad>;

//boardType = MEGA2560;//looked up =6
boardPi = "3B";
height = 10;
piHeight = 5;
topRadius = 5;
bottomRadius = 10;
holeRadius = 3;
//mountType = TAPHOLE;// or PIN

offset =2;
wall = 2;
heightExtension=10;
cornerRadius= 5;

piDim = piBoardDim(boardPi);
megaDim = [53.8,117,14.6];
megaHoles = [
  [2.8,15],
  [2.8,90.2],
  [50.8,14.3],
  [50.8,96.4],
  [18.3,65.75],
  [46.0,65.75]
];
echo("Mega dim = ",megaDim);
breite = megaDim[0]+30+piBoardDim("3B")[1];
tiefe = megaDim[1]+25;
hoehe = 63;
DIN912 = 3; // zylinder Kopf Schrauben


//gehaeuse();
//translate([0,0,hoehe]) 
  deckel();

module ventilator(lochmaske = false)
{
  $fn = 100;
  if(lochmaske)
  {
    translate([0,0,-wall-0.1])
      color("blue")
      cylinder(d1=55,d2=58,  h=4.1*wall);
    bohrungen = [

    ];
  }
  else 
  {
    difference()
    {
      union()
      {
        color("magenta")
          translate([0,0,wall-0.1])
          cylinder(d1=55+2*wall,d2=58+2*wall,  h=1*wall);//aussen
        color("green")
          cube([60,60,2*wall],center = true);
      }
      color("blue")
        translate([0,0,-wall-0.1])
        cylinder(d1=55,d2=58,  h=4.1*wall);
    }
  }
}
module deckel()
{
  color("magenta")
  //linear_extrude(height=5)
translate([0,0,200])
scale([200,200,200])
  import(file="Logo_Nohkumado_v2.svg", center=true);
  //v >05... import(file="Logo_Nohkumado_v2.svg", center=true, dpi=96);
  translate([40,+45,-1*wall]) ventilator(false);
  difference()
  {
    union()//positiv
    {
      cube([breite+wall,tiefe+wall,1*wall]);
      translate([-wall,0,-wall])
        cube([3*wall,tiefe+wall,2*wall]);
      translate([breite-wall,0,-wall])
        cube([3*wall,tiefe+wall,2*wall]);
      translate([0,0,-wall])
        cube([breite+wall,2*wall,2*wall]);
    }
    union()//negativ
    {
      translate([(breite+wall)/2,tiefe-8*wall,-wall])
        cylinder(d=20,h=4*wall);
      translate([0,0.9,-2.05]) cube([2.1,tiefe+2*wall,2.1]);//Schiene links
      translate([2,0.9,-0.95]) cube([1.1,tiefe+2*wall,1]);//Ge links
      translate([breite-1,0.9,-0.95]) cube([2.1,tiefe+2*wall,1]);//Schiene rechts
      translate([breite-0,0.9,-2.05]) cube([2.1,tiefe+2*wall,2.1]);//Geh rechts
      translate([40,+45,-1*wall]) ventilator(true);
    }
  }
}// module deckel()



module gehaeuse()
{
  //arduino(boardType); //arduino selber
  //echo("Dim Mega : ".megaDim, " fix " ,boardDimensions(6));
  //standoffs(boardType, height, topRadius, bottomRadius, holeRadius, mountType); //Abstandsstücke
  //holePlacement(boardType);
  //Bodenverstkungen
  color("magenta")
    translate([0,20,0]) cube([megaDim[0]+30+piBoardDim("3B")[1],10,2]);//Verstärkung unten hinten
  translate([0,0,0]) cube([megaDim[0]+30+piBoardDim("3B")[1],5,2]);//Verstärkung unten vorne;
  translate([2,0,hoehe-1]) cube([1,tiefe,1]);//Schiene links
  translate([breite-1,0,hoehe-1]) cube([2,tiefe,1]);//Schiene rechts
  translate([0,0,hoehe-38]) cube([megaDim[0]+30+piBoardDim("3B")[1],2,hoehe-30]);//Verstärkung mitte vorne;
  translate([0,0,hoehe-38]) cube([megaDim[0]+30+piBoardDim("3B")[1],10,2]);//Kante Verstärkung mitte;
  translate([breite/2-5,0,0]) cube([10,2,hoehe-15]);//Board trenner
  //Eckverstaerkungen
  {
    difference()
    {
      cube([10,wall,10]);
      translate([0,-1,10])
        rotate([0,45,0])cube([20,wall+2,20]);
    }
  }
  translate([breite-10,0,0])
  {
    difference()
    {
      cube([10,wall,10]);
      translate([0,-1,0])
        rotate([0,-45,0])cube([20,wall+2,20]);
    }

  }

  //motherboards
  translate([5,2,2])
  {
    bumper(megaDim,megaHoles);//Rähmchen
   color("red")
    translate([-5,0,0])
     cube([5,megaDim[1]+3,2]);//rähmchenverbinder
    //translate([megaDim[0]+piBoardDim("3B")[1]+10,0,0])
    translate([megaDim[0]+17,piBoardDim("3B")[0]+0,0])
      rotate([0,0,-90])
      {
        difference()
        {
          piBoard(boardPi);
          translate([piDim[0]*.05,piDim[1]*.10,-.1]) 
            scale([0.9,0.8,1.1])cube(piDim);
        }
        piPosts(boardPi, piHeight, preview =false);
   //color("red")
   //  cube([piDim[0],piDim[1],17]);

      }
  }

  difference()//linke Seitenwand
  {
    cube([2,tiefe,hoehe]);
    for ( i = [0 : 5] )
      translate([-1,10+i*20,5])
        auschnitt();
  }
  translate([breite,0,0])
    difference()//linke Seitenwand
    {
      cube([2,tiefe,hoehe]);
      for ( i = [0 : 5] )
        translate([-1,10+i*20,5])
          auschnitt();
    }

  difference()//Stirnwand
  {
    union()
    {
      translate([0,tiefe,0])
        cube([breite+2,2,hoehe]);
      translate([breite/2,piDim[0]-15,1])
        rotate([90,0,0])
        befestigungsstreifen();
    }

    union()
    {
      for ( j = [0 : 10] )
        for ( i = [1 : 27] )
        {
          x = 5*i+2.5*(j%2);
          z = 5+5*j;
          translate([x,tiefe+5,z]) rotate([90,0,00]) cylinder(d=1,h=10);
          //echo(str("mod: ",j%2," punkt(",i,",",j,")[",x,",",z,"]"));
        }
    }
  }
}

module befestigungsstreifen()
{
  streifenb = breite+48; 
  difference()
  {
    cube([streifenb,2,30], center = true);
    union()
    {
      translate([-streifenb/2,0,0])
        rotate([90,0,90])
        auschnittmaske(dm = 31);
      translate([streifenb/2,0,0])
        rotate([-90,0,90])
        auschnittmaske(dm = 31);
      translate([-streifenb/2+12.5,15,0]) rotate([90,0,00]) metrische_schraube_schablone(DIN912, mass=6,laenge = 15, toleranz = 0.3);
      translate([streifenb/2-12.5,15,0]) rotate([90,0,00]) metrische_schraube_schablone(DIN912, mass=6,laenge = 15, toleranz = 0.3);
    }
  }
}

module auschnitt()
{
  difference()
  {
    cube([4,4,hoehe-8]);
    union()
    {
      translate([1,2,0]) auschnittmaske();
      translate([1,2,hoehe-8]) rotate([180,0,0])auschnittmaske();
    }
  }
}
module auschnittmaske(dm = 4)
{
  difference()
  {
    cube([dm,dm,dm],center= true);
    translate([-dm,0,dm/2])
      rotate([0,90,0])
      cylinder(d=dm, h=2*dm, $fn=100);
  }
}
//Rähmchen
module bumper(dim,holes)
{
  difference()
  {
    cube([dim[0],dim[1],2]);
    translate([2,2,-1])
      cube([dim[0]-4,dim[1]-4,4]);
  }
  //Einclickrahmen
    translate([-2,0,0])
  difference()
  {
    cube([dim[0]+4,dim[1]+3,4]);
    translate([2,-1,-1])
      cube([dim[0],dim[1]+1,6]);
  }
  for(pos = holes)
  {
    translate([pos[0],pos[1],0])
    halter();
  }

   //color("red")
   //translate([37.3,0,14.2])
   //  cube([21,13,8]);
}//module bumper(dim,holes)
//Boardhalter
module halter()
{
 $fn = 100;
    cylinder(d=6, h=2);
    cylinder(d1=4, d2=2.8,h=5);
    translate([0,0,5])
    cylinder(d1=2.8, d2=2.9,h=3);
}//module bumper(dim,holes)
