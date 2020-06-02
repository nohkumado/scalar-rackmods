taperratio = .8; //the reduced base thickness

function cantCheckX(x0,x1,tp,minArm = 0.9) = (x1-x0 < minArm*x0*tp)? x1-x0  : minArm*x0*tp; 
function cantileverPoly(x0, x1, y0, y1, tap, mask = 0, minArm = .9) = [ 
  (mask >  0)?[0,0]                :[cantCheckX(x0,x1,tap, minArm),0],
  (mask >  0)?[x0+mask,0]          :[x0,0],
  (mask >  0)?[x0+2*mask,y0-2*mask]:[x0*tap,y0],
  (mask >  0)?[x1+mask,y0-2*mask]  :[x1,y0],
  (mask >  0)?[x1+mask,y0+mask]    :[x1,y0],
  (mask >  0)?[0,y1+y0+2*mask]     :[cantCheckX(x0,x1,tap, minArm),y1+y0]
];


doubleCantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0.0);
module doubleCantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0, d = 2, minArmRatio = .9)
{
  linear_extrude(height = d)
  {
    polygon(cantileverPoly(baseThick,headThick,cantL,headL,taperratio,mask,minArmRatio));
    mirror([1,0,0]) polygon(cantileverPoly(baseThick,headThick,cantL,headL,taperratio,mask,minArmRatio));
  }

}// module doubleCantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0)

module cantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0, d = 2,minArmRatio = 0.9)
{
  linear_extrude(height = d)
  {
    polygon(cantileverPoly(baseThick,headThick,cantL,headL,taperratio,mask,minArmRatio));
  }
}// module cantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0)
