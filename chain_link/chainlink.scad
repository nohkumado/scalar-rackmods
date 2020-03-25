
//translate([50,0,0]) runden(width = 30, height= 30);
module chainlink(length = 25,width= 16.6, height=20, wall= 2, angle = 45,tol=.2)
{

  difference()
  {
    union()
    {
      cube([length,width, height],center = true);//base cube
    }
    union()
    {
      cube([length+4,width-4*wall-tol, height-4*wall-tol],center = true);//evider
      translate([length/4,0,0])
        cube([length/2+2,width-2*wall-tol, height-2*wall-tol],center = true);//evider cote grand
      translate([height/2,0,-height/2])
        runden(width = 30, height= 30);//abrunden
      translate([-height/2,0,height/2])
        rotate([0,180,0])
        runden(width = 30, height= 30);
      translate([length/4,0,-height/2-1])
        cylinder(d=height/4+tol,h=width+4);
      //articulation enfoncee
      difference()
      {
        union()
        {
          translate([-length/4,0,-height/2-tol])
            cylinder(d=height+tol/2,h=wall+2*tol);
          translate([-length/4,0,height/2-wall-tol])
            cylinder(d=height+tol/2,h=wall+2*tol);
        }
        translate([-length/4,0,-height/2-1])
          cylinder(d=height/4-2*tol,h=width+4);
      }
      //angle freedom big side
      translate([length-height*sin(angle),0,0])
        cube([length,width+wall+2, height-2*wall-tol],center = true);//base cube
      //angle freedom small side
      translate([-length+height*sin(angle),0,0])
        cube([length,width+wall+2, height-4*wall-2*tol],center = true);//base cube
    }
  }

}//module chainlink(width, height, wall)
module runden(height=20,width= 16.6)
{
  difference()
  {
    translate([height/2,0,height/2])
      cube([height+2,width+2, height+2],center = true);//base cube
    translate([0,0,-2])
      cylinder(d=height,h=width+8);
  }
}//module runden(height=20,width= 16.6)

//sum up recursively the values of a vector from index i to index s
function sumvec(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));
