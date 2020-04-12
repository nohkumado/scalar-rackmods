use<hammernut.scad>
width = 5;//has to be less than 7.9 for 303 profile, otherwise crash!
//profile_knob(alpro = 30, width = width);
profile_clipser(alpro = 30, width = width,length=50,thick=2);
//pulley(d=60,h=10,axle = [5,40]);
rotate([0,0,90]) pulley_clip(d=60,h=10,axle = [5,30]);



module profile_knob(alpro=30, width)
{
  echo ("profile def : ",alpro," = ",profile(alpro));
  hammerhead_nut(alpro = profile(alpro), width = width+2, topalign = true);
  //aluInsert(alpro = profile(alpro), h = width);
  cylinder(d=7.5,h= 10,$fn =100);
  translate([0,0,10])rotate([90,0,0])
    translate([0,0,-10])cylinder(d=7.5,h= 20,$fn =100);
}//module profile_knob(alpro, width)

module profile_clipser(alpro=30, width,length,thick=2)
{
  translate([0,0,-2-thick])
  {
    hammerhead_nut(alpro = profile(alpro), width = width+2, topalign = true);
    //aluInsert(alpro = profile(alpro), h = width);
    cylinder(d=7.5,h= 2,$fn =100);
    translate([0,0,2+thick/2])cube([8,length,thick],center=true);
  }
}//module profile_knob(alpro, width)
module pulley(d,h,axle =[2,5],bearing = 8 )
{
  groovdiam = min(h/2,0.8*d);
  difference() // pulley with groove
  {
    rotate([90,0,0])
      translate([0,0,-h/2])
      cylinder(d=d,h=h,$fn = 100);
union()
{
    rotate([90,0,0])
      rotate_extrude()
      translate([d/2,0,0])
      circle(d=groovdiam,$fn=100);
    translate([0,2,0])
color("magenta")
rotate([90,0,0]) bearing(bearing, mask=.2);
 rotate([90,0,0])
   translate([0,0,-axle[1]/2])
   cylinder(d=axle[0],h=axle[1],$fn = 100);
}
  }
}//module pulley(w,l,h)
module pulley_clip(d,h,axle =[2,5] )
{
  translate([0,0,d/2+2])
    pulley(d=d,h=h,axle = axle);
  ws = (3*h - 1.2*h)/2;

  difference()
  {
    union()
    {
      //Unterplatte
      translate([0,0,-1])
        cube([1.2*d,3*h,2],center = true);
      //Seitenwände
      color("red")
        translate([0,-1.5*h+ws,1.5*h-2])
        rotate([90,30,0])
        cylinder(d=d,h=ws,$fn = 3);
      translate([0,1.5*h,1.5*h-2])
        rotate([90,30,0])
        cylinder(d=d,h=ws,$fn = 3);
    }
    //Bohrung
    translate([0,0,d/2+2])
      rotate([90,0,0])
      translate([0,0,-axle[1]/2-1])
      cylinder(d=1.1*axle[0],h=axle[1]+2,$fn = 100);
  }

}//module pulley(w,l,h)
function bearingdata(x) = x==8?[8, 22.1,7.1] : [1,1,1]; 
module bearing(d, mask=0)
{
  masse = bearingdata(d);
  if(mask!= 0)
  {
    cylinder(d=masse[1]+mask, h=masse[2]+mask);
  }
  else
  {
    difference()
    {
      cylinder(d=masse[1], h=masse[2]);
      translate([0,0,-masse[2]/2])
        cylinder(d=masse[0], h=2*masse[2]);
    }
  }
}

