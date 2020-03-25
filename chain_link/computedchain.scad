use <chainlink.scad>;
//next angle : 0 from(0,0)
//offsets : 15 from(15,0)
translate([0,0,0])
    rotate([0,0,-0])
    chainlink(length = 60,width = 30, height= 30 , wall=3, angle = 45, tol=0.6 );
//update to : (30.3,0)
//next angle : 0 from(30.3,0)
//offsets : 15 from(15,0)
translate([30.3,0,0])
    rotate([0,0,-0])
    chainlink(length = 60,width = 30, height= 30 , wall=3, angle = 45, tol=0.6 );
//update to : (60.6,0)
//next angle : 0 from(60.6,0)
//offsets : 15 from(15,0)
translate([60.6,0,0])
    rotate([0,0,-0])
    chainlink(length = 60,width = 30, height= 30 , wall=3, angle = 45, tol=0.6 );
//update to : (90.9,0)
//next angle : 30 from(90.9,0)
//offsets : 15 from(12.9903810567666,7.5)
translate([88.8903810567666,-7.5,0])
    rotate([0,0,-30])
    chainlink(length = 60,width = 30, height= 30 , wall=3, angle = 45, tol=0.6 );
//update to : (116.3711431703,-15)
//next angle : 45 from(116.3711431703,-15)
//offsets : 15 from(10.6066017177982,10.6066017177982)
translate([111.977744888098,-25.6066017177982,0])
    rotate([0,0,-45])
    chainlink(length = 60,width = 30, height= 30 , wall=3, angle = 45, tol=0.6 );
//update to : (134.690948323694,-36.2132034355964)
//next angle : 30 from(134.690948323694,-36.2132034355964)
//offsets : 15 from(12.9903810567666,7.5)
translate([135.681329380461,-43.7132034355964,0])
    rotate([0,0,-30])
    chainlink(length = 60,width = 30, height= 30 , wall=3, angle = 45, tol=0.6 );
//update to : (160.162091493994,-51.2132034355964)
