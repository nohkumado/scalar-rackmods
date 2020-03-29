/*

   Sechskantmuttern nach DIN 934
   change the m variable below to adjust to the M value you want
   startw is the angle to add, if you want a certain orientation of the nut shape

   add use <muttern934.scad> in your source to add this library
   metrische_mutter_schablone(5,startw = 30, toleranz = 0.1); //creates a M5 nut, rotated by 30deg and with an added .1 width

 */
use<threads.scad>;
//  metrische_mutter_schablone(5,startw = 30, toleranz = 0.1); //creates a M5 nut, rotated by 30deg and with an added .1 width
//translate ([12,00,0])metrische_schraube_schablone(typ = DIN7991, mass= 5,laenge = 30, toleranz = 0.1);



// metrische_mutter(5,startw = 30); //creates a M5 nut, rotated by 30deg and with an added .1 width
// translate ([0,12,0]) metrische_schraube(DIN912, 5,laenge = 19);
// translate ([12,0,0])metrische_mutter(6,startw = 30); //creates a M5 nut, rotated by 30deg and with an added .1 width
// translate ([12,12,0])metrische_schraube(DIN912, 6,laenge = 19);
// translate ([28,12,0]) metrische_t_mutter(4,startw = 30);
// translate ([28,0,0]) metrische_t_mutter(6,startw = 30);
// translate ([42,0,0]) rotate([0,0,90])metrische_t_mutter(8,startw = 30);
for(y= [1 : 1]) 
{
for(x= [1 : 1]) 
{
 translate ([x*18,y*24,0]) metrische_schraube(DIN912, 6,laenge = 19);
 translate ([x*18,y*24+12,0]) metrische_t_mutter(6,startw = 30);
}
}


DIN7991 = 0;
ISO10642 = 1;
DIN965  = 2; //Phillips-Kreuzschlitz PH, DIN 965 (austauschbar mit ISO 7046) Technische Daten für DIN 965 
DIN912 = 3; // zylinder Kopf Schrauben
DIN933 = 4; //sechskantkopf


//name dicke zangenbreite
masse = [
  [1,  0,8,2,5], //M1
  [1.2,    1, 3], //M1.2
  [1.4,    1,2, 3	 ], //M1.4
  [1.6,    1,3, 3,2], //M1.6
  [1.7,    1,4, 3,5], //M1.7
  [2,    1,6, 4	 ], //M2
  [2.3,    1,8, 4,5], //M2.3
  [2.5,  2, 5], //M2.5
  [2.6,  2, 5], //M2.6
  [3,  2.4, 5.5], //M3
  [3.5,  2.8, 6  ], //M3.5
  [4  ,  3.2, 7  ], //M4  
  [5  ,  4  , 8  ], //M5  
  [6  ,  5  , 10 ], //M6  
  [7  ,  5.5, 11 ], //M7  
  [8  ,  6.5, 13 ], //M8  
  [10 ,  8  , 17 ], //M10 
  [12 ,  10 , 19 ], //M12 
  [14 ,  11 , 22 ], //M14 
  [16 ,  13 , 24 ], //M16 
  [18 ,  15 , 27 ], //M18 
  [20 ,  16 , 30 ], //M20 
  [22 ,  18 , 32 ], //M22 
  [24 ,  19 , 36 ], //M24 
  [26 ,  22 , 41 ], //M26 
  [27 ,  22 , 41 ], //M27 
  [30 ,  24 , 46 ], //M30 
  [33 ,  26 , 50 ], //M33 
  [36 ,  29 , 55 ], //M36 
  [39 ,  31 , 60 ], //M39 
  [42 ,  34 , 65 ], //M42 
  [45 ,  36 , 70 ], //M45 
  [48 ,  38 , 75 ], //M48 
  [50 ,  38 , 75 ], //M50 
  [52 ,  42 , 80 ], //M52 
  [56 ,  45 , 85 ], //M56 
  [60 ,  48 , 90 ], //M60 
  [64 ,  51 , 95 ], //M64 
  [68 ,  54 , 100], //M68 
  [72 ,  58 , 105], //M72 
  [76 ,  61 , 110], //M76 
  [80 ,  64 , 115], //M80 
  [85 ,  68 , 120], //M85 
  [90 ,  72 , 130], //M90 
  [95 ,  75 , 135], //M95 
  [100,  80 , 145], //M100
  [105,  82 , 150], //M105
  [110 ,  88 , 155], //M110 
  [120 ,  95 , 175], //M120 
  ];
muttern = 
[
//Hammerkopfmuttern
//M versatz d mutter b      tiefe
  [
[4,1  ,6  ,4,11.6,5.9],
//[6,1.5,8  ,6,16.5,7.9],//official
[6,1.5,8  ,6,16.0,7.9],//mine
[8,3  ,8.7,10,19.4,8.1]
  ]
];

/*

a -0,3/-0,5	d	e	h	k	für T-Nuten DIN 650
5	M 4	-	-	9 -0,5	6,5	3 -0,3	5
6	M 5	-	-	10 -0,5	8	4 -0,5	6
8	M 6	-	-	13 -0,5	10	6 -0,5	8
10	M 6	M 8	-	15 -0,5	12	6 -0,5	10
12	M 8	M 10	-	18 -0,5	14	7 -0,5	12
14	M 10	M 12	-	22 -0,5	16	8 -0,5	14
16	M 10	M 12	M 14	25 -0,5	18	9 -0,5	16
18	M 12	M 14	M 16	28 -0,5	20	10 -0,5	18
20	M 12	M 16	M 18	32 -0,5	24	12 -0,5	20
22	M 16	M 20	-	35 -0,5	28	14 -0,5	22
24	M 20	M 22	-	40 -0,5	32	16 -0,5	24
28	M 20	M 24	-	44 -1	36	18 -1	28
36*	M 30	-	-	54 -1	44	22 -1	36
42*	M 36	-	-	65 -1	52	26 -1	42



*/


schrauben = 
[
  //Senkschraubendaten nach DIN 7991
  // M  ∅ Senkloch,∅ Durchgang, min. Senk-Tiefe
  [
    [  3,	 6.00,	 3.40,	1.70,],
    [  4,  8.00,	 4.50,	2.30,],
    [  5, 10.00,   5.50 , 2.80 ],
    [  6, 12.00,	 6.60 , 3.30 ],
    [  8, 16.00,   9.00,  4.40 ],
    [ 10, 20.00,	11.00,	5.50 ],
    [ 12, 24.00,	13.50,	6.50 ],
    [ 14, 30.00,  15.50,  7.50 ],
    [ 16, 30.00,	17.50,	7.50 ],
    [ 20, 36.00 , 22.00 , 8.50 ],
    [ 22, 36.00,  24.00, 13.10 ],
    [ 24,39,00 ,  26.00 ,14.00 ]
  ],
  //Bohrtabelle für Senkschrauben nach DIN-EN-ISO 10642 – Form B∅ 
  [
    //Gewinde	        ∅ Senkloch	    ∅ Durchgang	    min. Senk-Tiefe	
    [ 3	,  6.72,	 3.40, 	1.90],
    [ 4	,  9.00,	 4.50, 	2.50],
    [ 5	, 11.20,	 5.50, 	3.10],
    [ 6	, 13.50,	 6.60, 	3.80],
    [ 8	, 18.00,	 9.00, 	5.00],
    [ 10, 22.40,	11.00, 	6.20],
    [ 12, 26.80,	13.50, 	7.45],
    [ 14, 30.88,	15.50, 	8.80],
    [ 20, 40.32,	22.00, 10.20],
    [ 22, 36.00,	24.00, 13.10],
    [ 24, 39.00,  26.00, 14.00] 
  ],
  [
    //Senkschrauben mit Phillips-Kreuzschlitz PH DIN 965 (austauschbar mit ISO 7046) Technische Daten für DIN 965 
    //Maße	,   dk	      durch	 ,  kopfhoehe	        
    [ 1,  2.3, 1.6, 0.96],
    [ 2,  3.8, 2,   1.2	],
    [ 3,  5.6, 3,   1.65 ],
    [ 4,  7.5, 4,   2.2  ],
    [ 5,  9.2, 5,   2.5	],
    [ 6, 11,   6,   3	],
    [ 8, 14.5, 8,   4	],
    [10, 18  ,10,   5	 ],
    [12, 22	 ,12,   6	],
    [16, 29  ,16,   8]
  ],
  [
    //DIN 912 Technisches Datenblatt Innensechskantschrauben nach Norm mit ISO Regelgewinde oder ISO Feingewinde
    //Gewinde Kopfdurchmesser Kopfdurchmesser Kopfhöhe
    [1.4 	,2.60,2.60,1.40],
    [1.6 	,3.00,3.00,1.60],
    [2	 	,3.80,3.80,2.00],
    [2.5 	,4.50,4.50,2.50],
    [3	 	,5.50,5.50,3.00],
    [4	 	,7.00,7.00,4.00],
    [5	 	,8.50,8.50,5.00],
    [6	 	,10.0,10.0,6.00],
    [8	 	,13.0,13.0,8.00],
    [10	 	,16.0,16.0,10.0],
    [12	 	,18.0,18.0,12.0],
    [14	 	,21.0,21.0,14.0],
    [16	 	,24.0,24.0,16.0],
    [18	 	,27.0,27.0,18.0],
    [20	 	,30.0,30.0,20.0],
    [22	 	,33.0,33.0,22.0],
    [24	 	,36.0,36.0,24.0],
    [27	 	,41.0,41.0,27.0],
    [30	 	,45.0,45.0,30.0],
    [33	 	,51.0,51.0,33.0],
    [36	 	,54.0,54.0,36.0],
    [42	 	,63.0,63.0,42.0],
    [48	 	,72.0,72.0,48.0],
    [56	 	,84.0,84.0,56.0]
    ],
    //Sechskantschrauben DIN 933
    [
      [2, 4, 4, 1.4],
      [3, 5.5, 5.5, 2],
      [4, 7, 7, 2.8],
      [5, 8, 8, 3.5],
      [6, 10, 10, 4],
      [7, 11, 11, 4.8],
      [8, 13, 13, 5.3],
      [10, 17, 17, 6.4],
      [12, 19, 19, 7.5],
      [14, 22, 22, 8.8],
      [16, 24, 24, 10],
      [18, 27, 27, 11.5],
      [20, 30, 30, 12.5],
      [22, 32, 32, 14]
    ]
    ];


//name dicke zangenbreite
function  mmuttermass(mass)= masse[search(mass, masse, num_returns_per_match=0, index_col_num=0)[0]];
module metrische_mutter_schablone(mass,startw = 30, toleranz = 0, ueberlaenge = false)
{
  winkel = 360/6;		// 6 Ecken

  data = masse[search(mass, masse, num_returns_per_match=0, index_col_num=0)[0]];
  //echo("benutze Daten ",data);

  sechseck= [for(i = [1 : 6]) [
    (data[0]+toleranz)*cos(i*winkel+startw), (data[0]+toleranz)*sin(i*winkel+startw)] ];
  //(data[2]+toleranz)*cos(i*winkel+startw), (data[2]+toleranz)*sin(i*winkel+startw)] ];
  if(ueberlaenge)
  {
    linear_extrude(height = 2*data[1]+2*toleranz) polygon(sechseck);
  }
  else
  {
    linear_extrude(height = data[1]+2*toleranz) polygon(sechseck);
  }
}
module metrische_mutter(mass,startw = 30,  ueberlaenge = false)
{
  difference()
  {
    metrische_mutter_schablone(mass,startw, 0, ueberlaenge);
    translate([0,0,-1]) scale([1.1,1.1,1])metric_thread (diameter=mass, pitch=1, length=mass+2, internal=true, leadin=2);
  }

}//module metrische_mutter(mass,startw = 30, toleranz = 0, ueberlaenge = false)
module metrische_t_mutter(mass,startw = 30)
{
  data = muttern[0][search(mass, muttern[0], num_returns_per_match=0, index_col_num=0)[0]];
  echo("Hammermutter: ",data);
  // M versatz d   mutter b      breite
  //[6, 1.5,   8,   6,    16.5,  7.9],
  // 0  1     2     3     4      5
  p = [
    [data[2]/2,0],
    [data[2]/2,data[1]],
    [data[4]/2,data[1]],
    [data[4]/2,2*data[3]/3],
    [5.5,data[3]],
    [-5.5,data[3]],
    [-data[4]/2,2*data[3]/3],
    [-data[4]/2,data[1]],
    [-data[2]/2,data[1]],
    [-data[2]/2,0],
  ];
      translate([0,0,data[3]])
        rotate([180,0,0])
    difference()
    {
      translate([0,data[5]/2,0])
        rotate([90,0,0])
        linear_extrude(height=data[5])
        polygon(p);
      union()
      {
        translate([0,0,-1]) metric_thread (diameter=mass, pitch=1, length=data[3]+2, internal=true);
        translate([data[4]/2,data[5]/2+data[3]/4,data[3]/2])
          rotate([0,0,-30])
          color("blue")
          cube([data[4],data[3],data[3]], center=true);

        translate([-data[4]/2,-data[5]/2-data[3]/4,data[3]/2])
          rotate([0,0,-30])
          color("blue")
          cube([data[4],data[3],data[3]], center=true);
      }
    }

}//module metrische_mutter(mass,startw = 30, toleranz = 0, ueberlaenge = false)
  // M  ∅ Senkloch,∅ Durchgang, min. Senk-Tiefe
function defined(a) = str(a) != "undef"; 
function  mschraubmass(typ,mass)= schrauben[typ][search(mass, schrauben[typ], num_returns_per_match=0, index_col_num=0)[0]];
module metrische_schraube_schablone(typ, mass,laenge = 30, toleranz = 0)
{
  $fn = 100;
  data = schrauben[typ][search(mass, schrauben[typ], num_returns_per_match=0, index_col_num=0)[0]];
  if(!defined(data)) {
  data = schrauben[DIN7991][search(mass, schrauben[typ], num_returns_per_match=0, index_col_num=0)[0]];
}
  if(typ == DIN933)
  {
    metrische_mutter_schablone(mass=data[0], startw = 30, toleranz = toleranz, ueberlaenge = false);
  }
  else
  {
    cylinder(d1=data[1]+toleranz, d2=data[2]+toleranz, h= 2*data[3]);
  }

  translate([0,0,data[3]]) cylinder(d=data[0]+toleranz, h= laenge);
}
module metrische_schraube(typ, mass,laenge = 30)
{
  difference()
  {
    metrische_schraube_schablone(typ, mass,laenge = 0,  0);
    color("red")
      translate([0,0,-0.1])
      metrische_mutter_schablone(mass-3,startw = 30, ueberlaenge=true); //creates a M5 nut, rotated by 30deg and with an added .1 width
  }
  data = schrauben[typ][search(mass, schrauben[typ], num_returns_per_match=0, index_col_num=0)[0]];
  translate([0,0,data[3]]) scale([0.95,0.95,1])translate([0,0,-1]) metric_thread (diameter=mass, pitch=1, length=laenge, internal=false, leadin=1);
}
