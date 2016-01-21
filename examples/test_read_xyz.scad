// test read_xyz() and pointset()

pointset_xyz=read_xyz("oni.xyz" );
not_file=read_xyz("invalid.xyz");

echo(pointset_xyz);
echo(str("len(pointset_xyz) = ",len(pointset_xyz)));
echo(str("  len(pointset_xyz[0]) = ",len(pointset_xyz[0])));
echo(str("  len(pointset_xyz[1]) = ",len(pointset_xyz[1])));
echo(not_file);
translate([-0.5,0,0]) pointset(points=pointset_xyz[0]);
translate([0.5,0,0]) difference() {
    pointset(points=pointset_xyz);
    cube([0.1,2,2],center=true);
}
//cube();
