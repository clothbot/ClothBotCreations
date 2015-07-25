// Animation Test; main

include <variables.scad>;
echo(str("Translate: ",mv_x,",",mv_y,",",mv_z));
echo(str("  Rotate: ",rot_x,",",rot_y,",",rot_z));
echo(str("Time: ",$t));
echo("Viewport:");
echo(str("  $vpr=",$vpr));
echo(str("  $vpt=",$vpt));
echo(str("  $vpd=",$vpd));

translate([0,0,20]) translate([mv_x,mv_y,mv_z]*$t) rotate([rot_x,rot_y,rot_z]*$t) {
    cube([10,10,10],center=false);
    translate([0,0,10]) cylinder(r1=10,r2=0,h=10,center=false);
}

surface("surface.dat");
