width = 5;//has to be less than 7.9 for 303 profile, otherwise crash!

AL3030 = 
[
  [0,0],       //0
  [4.1,0],     //1
  [7.9,4.1],   //2
  [7.9,6.6],   //3
  [4.1,6.6],   //4
  [4.1,9.1],   //5
  [0,9.1]      //6
];
AL2020 = [];
AL1010 = [];
AL4040 = [];
fittol = 0.8;

function profile(x) = x == 40 ? AL4040 : x == 30 ? AL3030 : x == 20 ? AL2020: x == 10 ? AL1010: [];

//echo("trigo = ", 7.9*cos(asin(5/7.9)), " short = ",7.9*sqrt(1-pow(5/7.9,2)));

maxlength = AL3030[2][0]*sqrt(1-pow(width/AL3030[2][0],2));

//scale([maxlength/alpro[2][0],fittol,1]) 
hammerhead_nut(alpro = AL3030, width = width+2);
translate([40,0,0]) aluprofil(30,30);
translate([80,0,0]) aluInsert(AL3030,30, mask=true);
translate([0,40,0])aluprofil_einsatz(30, 30);

function zoffset(x,def) = x == true? -def[6][1] : 0;
module hammerhead_nut(alpro, width, topalign = false)
{
  translate([0,-width/2,zoffset(topalign,alpro)])
    intersection()
    {
      union()
      {
        translate([0,width,0]) 
        {
          difference()
          {
            translate([0,-width/2,+alpro[6][1]])
              aluInsert(alpro,h=width);
            scale([1.01,1.01,1.01])
              translate([0,-width/2,(alpro[4][1])-.0])
              {
                difference()
                {
                  color("blue")
                    translate([0,0,(alpro[6][1]-alpro[4][1])/2-.1])
                    cube([2*alpro[1][0]+.4, width+.2,alpro[6][1]-alpro[4][1]+.2],center = true);
                  translate([0,0,-1])
                    color("red")
                    cylinder(r=alpro[1][0], h= alpro[6][1]-alpro[4][1]+4, $fn=100);
                }
              }
          }
        }
      }
      union()
      {
        difference()
        {
          cylinder(r=alpro[2][0], h= alpro[6][1], $fn=100);
          translate([2.5*alpro[2][0]/2,0,alpro[6][1]/2-.1])
            cube([2.5*alpro[2][0],2.5*alpro[2][0],alpro[6][1]+2],center=true);
        }
        //color("blue")
        translate([0,width,0])
        {
          difference()
          {
            cylinder(r=alpro[2][0], h= alpro[6][1], $fn=100);
            translate([-2.5*alpro[2][0]/2,0,alpro[6][1]/2-.1])
              cube([2.5*alpro[2][0],2.5*alpro[2][0],alpro[6][1]+2],center=true);
          }
        }
      }
    }
}// module hammerhead_nut()

module aluInsert(alpro,h, mask=false)
{
 translate([0,h/2,-alpro[6][1]])
   rotate([90,0,0])
   linear_extrude(height=h)
    union()
    {
      polygon(alpro);
      mirror([1,0,0]) polygon(alpro);
      if(mask) translate([0,alpro[5][1]+.4,0])square([alpro[1][0]*2,1],center = true);
    }
}//module aluInsert(alpro,h)
module aluprofil(alpro, h)
{
  difference()
  {
    cube([alpro,alpro,h],center = true);

    union()
    {
      color("blue")
        translate([0,0,-1])
        difference()
        {
          cube([alpro+1,alpro+1,h+3],center = true);
          translate([0,0,-h/2-2])
            cylinder(r=sqrt(2*pow(alpro/2,2))-1,h=h+4,$fn=400);
        }
      color("red")
        translate([0,0,-.5])
        aluprofil_einsatz(alpro, h+2, mask = true);
      color("magenta")
      translate([0,0,-h/2-2])
            cylinder(r=profile(alpro)[1][0]-0.5,h=h+4,$fn=400);
    }
  }
}//module aluprofi(alpro)
module aluprofil_einsatz(alpro, h, mask = false)
{
  data = profile(alpro);

  translate([0,alpro/2,0]) rotate([-90,0,0]) aluInsert(alpro = data,h=h, mask = true);//oben
  translate([0,-alpro/2,0]) rotate([90,0,0]) aluInsert(alpro = data,h=h, mask = true);//unten
  translate([alpro/2,0,0]) rotate([90,0,90]) aluInsert(alpro = data,h=h, mask = true);//rechts
  translate([-alpro/2,0,0]) rotate([90,0,-90]) aluInsert(alpro = data,h=h, mask = true);//links
}// module aluprofil_einsatz(alpro, h)
