width = 5;//has to be less than 7.9 for 303 profile, otherwise crash!

AL3030 = 
[
[0,0],
[4.1,0],
[7.9,4.1],
[7.9,6.6],
[4.1,6.6],
[4.1,9.1],
[0,9.1]
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

module aluInsert(alpro,h)
{
  translate([0,h/2,-alpro[6][1]])
  rotate([90,0,0])
    linear_extrude(height=h)
    union()
    {
      polygon(alpro);
      mirror([1,0,0]) polygon(alpro);
    }
}//module aluInsert(alpro,h)
