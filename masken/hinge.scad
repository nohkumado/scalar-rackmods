translate([-5,0,0])hinge(outd=5,axe= 2,h=50,parts=5, tol =0.1,print="left"); 
hinge(outd=5,axe= 2,h=50,parts=5, tol =0.1,print="right"); 
//raw_hinge(outd=5,axe= 5,h=50,parts=3, tol =0.1,print="right"); 
//hinge(outd=5,axe= 5,h=50,parts=5, tol =0.1,print="left"); 

function zoffset(pos, diam) = pos == "middle"? 0: pos == "top"? diam/2 :-diam/2;
function left(pos) = pos == "left"? 1: 0;
function xoff(pos) = pos == "left"? -1: 1;

module hinge(outd,axe,h,parts, tol =0.1, print= "both", plate = "middle", flb = 10, fld =5, maxalpha = 90, minalpha =0)
{
  spacer = h/parts;
  difference()
  {
    union()
    {
      translate([xoff(print)*(5+1*tol),0,h/2])flansch(flb,h,fld);
      cylinder(d=outd,h=h, $fn=200);
    }
    for( z = [left(print):2:parts-1]) translate([0,0,z*spacer-tol])
    {
      cylinder(d=outd+2*tol, h=spacer+2*tol,$fn=200);
      rotate([0,0,xoff(print)*maxalpha]) translate([-xoff(print)*2*outd,0,spacer/2])cube([4*outd,axe,spacer],center=true); 
      rotate([0,0,xoff(print)*minalpha]) translate([-xoff(print)*2*outd,0,spacer/2])cube([4*outd,axe,spacer],center=true); 
      if(xoff(print) > 0) cylinder(d=axe+2*tol,h=h, $fn=200);
    }
  }
  if(xoff(print) < 0) cylinder(d=axe+tol,h=h, $fn=200);

}//module hinge(d,h,parts)

module flansch(b= 10, h = 50, d =5)
{
 cube([b,d,h], center = true);
}//module flansch()
