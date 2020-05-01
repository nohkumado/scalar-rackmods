use <Schlittenplatte.scad>;
schienen = [
[14,8,-0.1],
[59.6,8,-0.1]
];



    SchlittenAdapter(5);
//WerkzeugHalter();
//WerkzeugAdapter();
//translate([37,6,-10])  rotate([0,0,180])rotate([90,180,0])Kuehlermodell();

module Kuehlermodell(vulcan=false)
{
color("green")
  cylinder(d=22.2, h=26.5);
  cylinder(d=16, h=33.9);
  cylinder(d=12, h=43);
  translate([0,0,39])cylinder(d=16, h=4);
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
}//module Kuehlermodell()
module WerkzeugAdapter()
{
color("blue")
   union()
   {
    translate([0,0,-2])GrundPlatte(2);
    translate(schienen[0])ext_trapez(10,7.5,2.5,52.5,0.5);
    translate(schienen[1])ext_trapez(10,7.5,2.5,52.5,0.5);
}
}//module WerkzeugAdapter()
//translate([73.6,0,0])rotate([180,0,180]) Schlittenplatte();

module WerkzeugHalter()
{
  difference()
  {
    SchlittenAdapter(5);
    //tenon(30,10);
    //trapez(10,5,10,30,2);
    union()
    {
      translate(schienen[0])ext_trapez(10.4,7.9,2.6,60,0.5);
      translate(schienen[1])ext_trapez(10.4,7.9,2.6,60,0.5);
    }//union()
  }//difference()
}//WerkzeugHalter


module trapez(oberbreite, unterbreite, hoehe, tiefe,rand)
{ 
 ecken = [
//vorne
    [-unterbreite/2,0,0], [unterbreite/2,0,0], //bodenlinie 0,1
    [oberbreite/2,0,hoehe-rand], [oberbreite/2,0,hoehe], //rechts hoch 2,3
    [-oberbreite/2,0,hoehe], [-oberbreite/2,0,hoehe-rand], //links runter hoch 4,5

//hinten
    [-unterbreite/2,tiefe,0], [unterbreite/2,tiefe,0], //bodenlinie 6,7
    [oberbreite/2,tiefe,hoehe-rand], [oberbreite/2,tiefe,hoehe], //rechts hoch 8,9
    [-oberbreite/2,tiefe,hoehe], [-oberbreite/2,tiefe,hoehe-rand], //links runter hoch 10,11
 ];

   flaechen = [

     [0,5,4,3,2,1], //vorne
     [0,1,7,6], //unten
     [4,10,9,3], //oben
     [6,7,8,9,10,11], //rueck
     [1,2,8,7], //seite links unten
     [2,3,9,8], //seite links open
     [0,6,11,5], //seite rechts unten
     [5,11,10,4], //seite rechts open
   ];
   polyhedron(ecken,flaechen);
}

module ext_trapez(oberbreite, unterbreite, hoehe, tiefe,rand)
{ 
 ecken = [
//vorne
    [-unterbreite/2,0], [unterbreite/2,0], //bodenlinie 0,1
    [oberbreite/2,hoehe-rand], [oberbreite/2,hoehe], //rechts hoch 2,3
    [-oberbreite/2,hoehe], [-oberbreite/2,hoehe-rand], //links runter hoch 4,5
 ];
   translate([0,tiefe/2,0])rotate([90,0,0]) linear_extrude(height = tiefe,center = true) polygon(ecken);

}

module tenon(laenge,breite)
{
  hoehe = 5/3*breite;
CubePoints = [
  [  0,  0,  0 ],  //0
  [ 5*breite,  0,  0 ],  //1
  [ 5*breite,  hoehe/5,  0 ],  //2
  [  4*breite,  hoehe/5,  0 ],  //3
  [  5*breite,  4*hoehe/5,  0 ],  //4
  [ 5*breite,  hoehe,  0 ],  //5
  [ 0,  hoehe,  0 ],  //6
  [  0,  4*hoehe/5,  0 ],//7
  [  breite,  hoehe/5,  0 ],//8
  [  0,  hoehe/5,  0 ],//9

  [  0,  0,  laenge ],  //10
  [ 5*breite,  0,  laenge ],  //11
  [ 5*breite,  hoehe/5,  laenge ],  //12
  [  4*breite,  hoehe/5,  laenge ],  //13
  [  5*breite,  4*hoehe/5,  laenge ],  //14
  [ 5*breite,  hoehe,  laenge ],  //15
  [ 0,  hoehe,  laenge ],  //16
  [  0,  4*hoehe/5,  laenge ],//17
  [  breite,  hoehe/5,  laenge ],//18
  [  0,  hoehe/5,  laenge ]//19
]; 
  
CubeFaces = [
  [0,1,2,3,4,5,6,7,8,9],  // face
  [10,19,18,17,16,15,14,13,12,11],  // back
  [6,5,15,16],  // top
  [1,0,10,11],// bottom
  [1,11,12,2],// lower side right
  [4,14,15,5],// upper side right
  [3,2,12,13],// cover lower right
  [3,13,14,4],// ramp lower right
  [0,9,19,10],// lower side left 
  [7,6,16,17],// upper side left 
  [9,8,18,19],// cover lower left
  [8,7,17,18],// ramp lower left
]; 
    translate([-5/2*breite,0,0])
      //color("magenta")
    //cube([5/3*breite,5*breite,laenge],center=true);
    polyhedron( CubePoints, CubeFaces );
    //rotate ([0,270,0])
}
