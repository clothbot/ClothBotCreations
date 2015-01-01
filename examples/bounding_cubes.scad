// bounding cubes test.

module bounding_cubes() {
  for(index=[0:$children-1]) {
      echo(str("bounding cube ",index,": [",$xmin,",",$ymin,",",$zmin,"], [",$xmax,",",$ymax,",",$zmin,"]"));
      render() children(index);
      translate([$xmin,$ymin,$zmin]) # cube([$xmax-$xmin,$ymax-$ymin,$zmax-$zmin],center=false);
  }
}

bounding_cubes() {
    translate([-10,-10,-10]) sphere(d=3);
    translate([3,3,0]) cylinder(r=1,h=20);
}
