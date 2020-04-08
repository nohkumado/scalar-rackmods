//points = [[1,4.4],];
h=107;
difference()
{
abek1Mask( dg = 44, dk = 28, h=h);
translate([0,0,-1])
scale([0.8,0.8,1])
abek1Mask( dg = 44, dk = 28, h=h, dz =3);
}

//cube([35,85,1],center = true);
module abek1Mask(dg = 44, dk = 28, h=h, dz = 1 )
{
  hull()
  {
    translate([-dg/2, h/2-dg/2,0]) cylinder(d=dg,h =dz);
    translate([dg/2, h/2-dg/2,0]) cylinder(d=dg,h =dz);
    translate([0, h/2-1.9*dg/2+3,0]) cylinder(d=1.9*dg,h =dz);
    translate([-dk/2, -h/2+dk/2,0]) cylinder(d=dk,h =dz);
    translate([dk/2, -h/2+dk/2,0]) cylinder(d=dk,h =dz);
  }
}//module abek1Mask(dg = 44, dk = 28)

