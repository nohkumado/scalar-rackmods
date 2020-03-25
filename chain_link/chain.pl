#!/usr/bin/perl
use Math::Trig;
$length = 60;
$width = 30; 
$height= 30 ; 
$wall=3; 
$angle = 45;
$tol=.6;
#$chainDef = [ 0, 0, 0, 30, 45, 30, 0, 0, ];
$chainDef = [ 0, 0, 0, 30, 45 , 30];

open(my $fh, ">", "computedchain.scad")
or die "Can't open > computedchain.scad: $!";
print $fh("use <chainlink.scad>;\n");
#  chain(chainDef,);
$lastx = 0 ;
$lasty = 0;
$radius =($length-$height)/2; 
foreach my $nextangle( @$chainDef)
{
  print $fh ("//next angle : $nextangle from($lastx,$lasty)\n");
  $xoff = $radius*cos(deg2rad($nextangle));
  $yoff = $radius*sin(deg2rad($nextangle));
  print $fh ("//offsets : $radius from($xoff,$yoff)\n");
  $lasty -= $yoff;
  $lastx -= $radius-$xoff;
  $cmd = "translate([$lastx,$lasty,0])
    rotate([0,0,-$nextangle])
    chainlink(length = $length,width = $width, height= $height , wall=$wall, angle = $angle, tol=$tol );\n";
  print $fh($cmd);
  if($yoff != 0 ){ $lastx += 2*$tol;}
  $lastx += 2*$xoff+$tol/2;
  $lasty -= $yoff;
  print $fh ("//update to : ($lastx,$lasty)\n");

}#foreach($nextangle in $chainDef)

close($fh) || warn "close failed: $!";
