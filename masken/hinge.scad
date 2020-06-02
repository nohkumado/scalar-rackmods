translate([-5,0,0])hinge(outd=5,axe= 2,h=50,parts=6, tol =0.1,print="left", plate = "bottom", opento = 000); 
hinge(outd=5,axe= 2,h=50,parts=5, tol =0.1,print="right", plate = "bottom", opento = 10); 
//raw_hinge(outd=5,axe= 5,h=50,parts=3, tol =0.1,print="right"); 
//hinge(outd=5,axe= 5,h=50,parts=5, tol =0.1,print="left"); 

function zoffset(pos, diam) = pos == "middle"? 0: pos == "top"? diam/2 :-diam/2;
function left(pos) = pos == "left"? 1: 0;
function xoff(pos) = pos == "left"? -1: 1;

function yoff(pos,d) = pos == "top" ? d/2 : pos == "middle" ? 0: -d/2 ;
function checkvalid(num) = num < 3? 3 : num%2 == 0 ? num+1 : num ;
/**
outd outer diameter 
axe  axe diameter 
h    height of the hinge
parts number of inerlocking, allways use impair number, otherwise the pin will be fixed on each hinge part, isntead of one
tol  tolerance to apply, make this bigger if the hinge sticks after the print
print which side to print (both, left, right
plate posiiton of the flange top,middle or bottom
flb  flange width
fld  flange thickness
maxalpha opening angle
minalpha closing angle
opento initial opening angle 0 for closed, 180 completely open

*/
module hinge(outd,axe,h,parts, tol =0.1, print= "both", plate = "middle", flb = 10, fld =5, maxalpha = 90, minalpha =0, opento = 0, mask = 0)
{
  spacer = h/checkvalid(parts);
  difference()
  {
    union()
    {
     //translate([xoff(print)*(5+1*tol),yoff(plate,max(fld,outd)),h/2])
     //  translate([-flb/2,0,0])
     //  rotate([0,0,opento])
     //  translate([flb/2,0,0])
        flansch(flb,h,fld, print = print, pos = plate, wd = max(fld,outd), angle  = opento, tol = tol);
        //flansch(flb,h,fld, print = print, pos = fld, wd = outd, tol = tol);
      translate([0,0,-mask/2])
      cylinder(d=outd+mask,h=h+2*mask, $fn=200);
    }
    for( z = [left(print):2:checkvalid(parts)-1]) translate([0,0,z*spacer-tol])
    {
      cylinder(d=outd+2*tol, h=spacer+2*tol,$fn=200);
      rotate([0,0,xoff(print)*maxalpha]) translate([-xoff(print)*2*outd,0,spacer/2])cube([4*outd,axe,spacer],center=true); 
      rotate([0,0,xoff(print)*minalpha]) translate([-xoff(print)*2*outd,0,spacer/2])cube([4*outd,axe,spacer],center=true); 
      if(xoff(print) > 0) cylinder(d=axe+2*tol,h=h, $fn=200);
    }
  }
  if(xoff(print) < 0) cylinder(d=axe+tol,h=h, $fn=200);

}//module hinge(d,h,parts)

module flansch(b= 10, h = 50, d =5, print = "right", pos = "top", wd = 2, angle  =0, tol = .1)
{
  if(print == "left")
  {
    color("green")
      rotate([0,0,angle])
      translate([xoff(print)*b/2,yoff(pos,wd),h/2])
      cube([b,d,h], center = true);
     //translate([xoff(print)*(5+1*tol),yoff(pos,wd),h/2])
     //translate([-b/2,0,0])
     //rotate([0,0,angle])
     //translate([b/2,0,0])
     //cube([b,d,h], center = true);
  }
  else
  {
      rotate([0,0,angle])
      translate([xoff(print)*b/2,yoff(pos,wd),h/2])
      cube([b,d,h], center = true);
  }
}//module flansch()
