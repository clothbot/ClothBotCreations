// test read_xyz() and pointset()

pointset_xyz=read_xyz("oni.xyz" );

echo(pointset_xyz);
echo(str("len(pointset_xyz) = ",len(pointset_xyz)));
echo(str("  len(pointset_xyz[0]) = ",len(pointset_xyz[0])));
echo(str("  len(pointset_xyz[1]) = ",len(pointset_xyz[1])));
pointset(points=pointset_xyz[0]);
//cube();
