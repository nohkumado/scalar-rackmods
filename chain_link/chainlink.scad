$fn = 100;
chainlink(length = 30,width= 16.6, height=25, wall= 2, angle = 75,tol=.3);
//translate([50,0,0]) runden(width = 30, height= 30);
//translate([50,0,0]) runden(width = 16.6, height= 20);
module chainlink(length = 25,width= 16.6, height=20, wall= 2, angle = 45,tol=.2)
{

  difference()
  {
    union()
    {
      color("green")
        cube([length,width, height],center = true);//base cube
    }
    union()
    {
      cube([length+4,width-2*wall-tol, height-4*wall-tol],center = true);//evider
      translate([length/2-1.0,0,0]) runden(width = width, height= height+2);//abrunden
      translate([-length/2,0,00]) rotate([0,180,0]) runden(width = width, height= height+2);
      //evider cote grand
      translate([max(length/2-width/2, length/2-3*wall),0,-(height-2*wall+tol)/2])
      {
        rotate([0,0,angle])
          gelmaske(length,width, height, wall, tol);
        rotate([0,0,-angle])
          gelmaske(length,width, height, wall, tol);
      }
      //articulation enfoncee
      translate([min(-length/4, -length/2+2*wall),00,0])
        difference()
        {
          union()
          {
            translate([0,0,-height/2-tol])
            {

              rotate([0,0,angle])
                scheibmaske(length,width, height, wall, tol);
              rotate([0,0,-angle])
                scheibmaske(length,width, height, wall, tol);
            }
            translate([0,0,height/2-wall-tol])
            {
              rotate([0,0,angle])
                scheibmaske(length,width, height, wall, tol);
              rotate([0,0,-angle])
                scheibmaske(length,width, height, wall, tol);
            }
          }
          translate([0,0,-height/2-1])
            cylinder(d=width/4-1*tol,h=height+4);
        }

    }
  }

}//module chainlink(width, height, wall)
module runden(height=20,width= 16.6)
{
  ch = max(height,width);
    translate([-width/2,0,0])
  difference()
  {
    //translate([height/2,0,height/2])
    translate([height/2,0,0])
      cube([height+2,width+2, height+2],center = true);//base cube
    translate([0,0,-2-ch/2]) cylinder(d=width,h=ch+8);
  }
}//module runden(height=20,width= 16.6)

//sum up recursively the values of a vector from index i to index s
function sumvec(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));
module gelmaske(length,width, height, wall, tol)
{
  cylinder(d=width+tol/2,h=height-2*wall+tol);
  translate([0,0,-4])
    cylinder(d=width/4+3*tol,h=height+8);
  translate([length/2,0,(height-2*wall+tol)/2])
    cube([length,width,height-2*wall+tol],center = true);
}

module scheibmaske(length,width, height, wall, tol)
{
  cylinder(d=width+tol/2,h=wall+2*tol);
  translate([-(width+tol/2)/2,0,(wall+2*tol)/2])
    cube([width+tol/2,width+tol/2,wall+2*tol],center=true);
}
