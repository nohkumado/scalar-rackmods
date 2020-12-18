//use <fillet.scad>
height = 30;// height of the total flange
width = 10;// width of the total flange
thickness  = 2; //thickness of hinge-flange
start = 0.2;//start tolerance
end = 0.3; //end tolerance
div = 3; //number of divides of the hinge
hinge_out = 7; //hinge outer diameter, ideally 2* flange thickness (outd)
axe = 1*hinge_out/2; // axe diameter 
angle = -00; //openinng angle of hinge
maxangle = 90; //maximum opening angle
minangle = 0; //minimum opening angle
print= "both";//"left";//"both"; //which side of the hinge to print [both, left, right]
position = "bottom";//"bottom"; //"middle";//flange position, ["bottom", "middle", "top"]
label = "";//label to imprint on flange
fn  = 3; //resolution of flange excision (obsolete)
cutoutd = 2;//cylinder cut out in the flange, if >0, the value is the clearance


  translate([-25*start*10,0,0])
for(tol = [start:0.1:end])
{
  translate([25*tol*10,0,0])
  {
    if(print == "both" || print == "left")
      hinge(outd=hinge_out,axe= axe,h=height,parts=div, tol =tol,print="left", plate = position, opento = angle, label = str("t:",tol), fld=thickness, flb = width, maxalpha = maxangle -32, minalpha =minangle,cutoutd =cutoutd ); 
    if(print == "both" || print == "right")
      hinge(outd=hinge_out,axe= axe,h=height,parts=div, tol =tol,print="right", plate = position, opento = -angle, fld=thickness, flb = width, maxalpha = maxangle -32, minalpha =minangle,cutoutd =cutoutd); 
  }
}
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
  label add an optional labeon the plate
,cutoutd =cutoutd
 */
module hinge(outd,axe,h,parts, tol =0.1, print= "both", plate = "middle", flb = 10, fld =5, maxalpha = 90, minalpha =0, opento = 0, mask = 0, label = "", fn = 3, cutoutd =-1)
{
 echo("calling hinge with pr:",print);
  spacer = h/checkvalid(parts);
  difference()
  {
    union()
    {
      flansch(flb,h,fld,outd, axe, print = print, pos = plate, wd = max(fld,outd), angle  = opento, tol = tol, label=label, mask = mask, maxalpha = maxalpha);
      //color("red")
        translate([0,0,-mask/2]) cylinder(d=outd+mask,h=h+2*mask, $fn=200);//outer shape
    }
    union()
    {
      for( z = [left(print):2:checkvalid(parts)-1]) translate([0,0,z*spacer-tol])
      {
        color("blue")
          translate([0,0,-tol+.001])
          {
            
          cutx = flb+outd+2*tol;
          cutz = spacer+2*tol+mask;
          cuty = (plate == "middle")?(outd-fld)/2:(outd-fld)+2*tol;
          cylinder(d=outd+((cutoutd >0)?cutoutd:0)+2*tol+mask, h=cutz,$fn=200);
          translate([xoff(print)*cutx/2,(plate == "middle")?fld/2:0,cutz/2])
          cube([cutx, cuty, cutz],center = true);
            
          }
        //  echo("for(dw = [",minalpha,":",(maxalpha-minalpha)/fn,":",maxalpha,"]");
        //  for(dw = [minalpha:(maxalpha-minalpha)/fn:maxalpha])
        //    translate([0,0,tol])
        //      rotate([0,0,xoff(print)*dw]) translate([-xoff(print)*2*outd,0,spacer/2])cube([4*outd,fld+2*tol,spacer+2*tol],center=true); 
      }
      if(xoff(print) > 0) translate([0,0,-tol])cylinder(d=axe+1.5*tol,h=h+2*tol, $fn=200);
      //if(mask == 0)
      //{
      //   for(dw = [minalpha:(maxalpha-minalpha)/fn:maxalpha])
      //  rotate([0,0,-1*xoff(print)*dw])
      // translate([(outd-axe),0,0]) 
      // flansch(flb,h,fld, print = (print=="left")?"right":"left", pos = plate, wd = max(fld,outd), angle  = opento, tol = tol, mask = mask);
      //    hinge(outd,axe,h,parts, tol =tol, print= (print=="left")?"right":"left", plate = plate, flb = flb, fld =fld, maxalpha = maxalpha, minalpha =minalpha, opento = opento, mask = tol, label = label, fn = fn);
      //}
    }
  }
  if(xoff(print) < 0) cylinder(d=axe-1.5*tol,h=h, $fn=200);

}//module hinge(d,h,parts)

//   translate([0,0,-tol/2]) 
//   flansch(flb,h,fld,outd, axe, print = (print=="left")?"right":"left", pos = plate, wd = max(fld,outd), angle  = opento, tol = tol, mask = mask+tol);
module flansch(b= 10, h = 50, d =5, outd = 10, axe = 5, print = "right", pos = "top", wd = 2, angle  =0, tol = .1, label="", mask =0, maxalpha = 0)
{
  rotate([0,0,angle])
    translate([xoff(print)*axe/4,0,0])
    translate([xoff(print)*(b+0*mask)/2,yoff(pos,wd+2*mask),(h+2*mask)/2])
    {
      difference() //for embossed text
      {
        union()
        {
          translate([xoff(print)*tol/2,0,0]) 
            cube([b+2*mask-tol,d+2*mask,h+2*mask], center = true);
          if(mask == 0)
          {
            {
              teilr = min(sqrt(outd*outd/4- axe*axe/16), outd/2*cos(maxalpha)+d/4)-2*tol;
              keilpoly = 
              [
                 [(xoff(print) >0)? 0+tol:b,(pos == "bottom")? -teilr-tol: (pos == "top")? -teilr:0],
                 [(xoff(print) >0)? b:0+tol,(pos == "bottom")? -teilr-tol: (pos == "top")? teilr:0],
                 [(xoff(print) >0)? 0+tol:b,teilr-tol]
              ];
            translate([-b/2-tol,(pos == "bottom")?teilr+d/2: (pos == "top")?-teilr-d/2+tol:0,-h/2])
              linear_extrude(height= h)
              polygon(keilpoly);
            }
          }
        }
        if(len(label) > 0 && mask == 0)
          translate([-b/7,d/2-2*tol,0])
            rotate([-90, -90,0])
            linear_extrude(height=h)
            text(label, size = .5*b, halign= "center",valign ="center", $fn = 32);
      }
    }
}//module flansch()
