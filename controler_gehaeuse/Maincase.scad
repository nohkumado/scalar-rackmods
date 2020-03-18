include <arduino_mount/arduino.scad>;
boardType = MEGA2560;
height = 10;
topRadius = 5;
bottomRadius = 10;
holeRadius = 3;
mountType = TAPHOLE;// or PIN

offset =2;
wall = 2;
heightExtension=10;
cornerRadius= 5;

megaDimensions = boardDimensions( MEGA2560);
//arduino(boardType);
//bumper(boardType);
//enclosure(boardType, wall = 2, offset =2, heightExtension=10, cornerRadius= 90, mountType=TAPHOLE);
//enclosureLid(boardType =MEGA2560 , wall = 2, offset = 2 , cornerRadius = 90 , ventHoles =   true);
//enclosureLid(MEGA2560 , 2, 2 , 90 , true);
;
//arduino(boardType)

//boardType(MEGA2560);
//standoffs(boardType, height, topRadius, bottomRadius, holeRadius, mountType);
//boardShape( boardType, offset, height );

//boundingBox(boardType, offset, height, cornerRadius, include = BOARD);
//holePlacement(boardType);
