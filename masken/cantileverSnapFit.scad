taperratio = .8; //the reduced base thickness

function cantileverPoly(x0, x1, y0, y1, tap, mask = 0) = [ 
  (mask >  0)?[0,0]:[x1-x0,0],
  (mask >  0)?[x0+mask,0]:[x0,0],
  (mask >  0)?[x0+2*mask,y0-2*mask]:[x0*tap,y0],
  (mask >  0)?[x1+mask,y0-2*mask]:[x1,y0],
  (mask >  0)?[x1+mask,y0+mask]:[x1,y0],
  (mask >  0)?[0,y1+y0+2*mask]:[x1-x0,y1+y0]
];


doubleCantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0.0);
module doubleCantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0, d = 2)
{
linear_extrude(height = d)
{
polygon(cantileverPoly(baseThick,headThick,cantL,headL,taperratio,mask));
mirror([1,0,0]) polygon(cantileverPoly(baseThick,headThick,cantL,headL,taperratio,mask));
}

}// module doubleCantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = taperratio, mask = 0)
