// Hypothetical geometric selection and operation example
//  Required enhanced operators:
//	offset_3d();
//   explode();

module radial_pairs_filter(dr=1.0,solid=false) {
  if($children>1) for(i=[0:$children-2]) for(j=[i:$children-1]) {
	echo(str(" radial_pairs_filter: child ",i," vs child ",j));
	union() filter(solid=solid) {
		children(i);
		children(j);
		intersection() {
			offset_3d(delta=dr) children(i);
			children(j);
		} // if no intersection, expect no 3rd child passed to filter()
	}
  } else {
	echo("Only one child detected.");
  }
}

module explode() {
	// place-holder
	children();
}

module filter(solid=false) {
  if($children>2) {
	union() {
	  children(0);
	  children(1);
	}
	if(solid) {
		hull() {children(0);children(2);}
	} else {
		%hull() {children(0);children(2);}
	}
  } else {
	echo("  Empty intersection; don't pair; return nothing.");
  }
}

module offset_3d(delta=1.0) {
	// positive offset equivalent
	minkowski() {
		children();
		sphere(r=delta,$fn=8);
	}
}

module shapes() {
	translate([-10,-10,0]) cylinder(r=1,h=2,center=true);
	translate([0,-10,0]) cylinder(r=1,h=2,center=true);
	translate([10,-10,0]) cylinder(r=1,h=2,center=true);
	translate([-10,0,0]) cylinder(r=1,h=2,center=true);
	translate([0,0,0]) cylinder(r=1,h=2,center=true);
	translate([3,5,4]) cylinder(r=0.1,h=5,center=false);
	translate([10,0,0]) cylinder(r=1,h=2,center=true);
	translate([-10,10,0]) cylinder(r=1,h=2,center=true);
	translate([0,10,0]) cylinder(r=1,h=2,center=true);
	translate([10,10,0]) cylinder(r=1,h=2,center=true);
}

module hull_pairs() {
  for(k=[0:$children-1])
	hull() children(k);
}

//hull_pairs() radial_pairs_filter(dr=8+16*$t) explode() shapes();
//%shapes();

radial_pairs_filter(dr=8+16*$t,solid=true) {
	translate([-10,-10,0]) cylinder(r=1,h=2,center=true);
	translate([0,-10,0]) cylinder(r=1,h=2,center=true);
	translate([10,-10,0]) cylinder(r=1,h=2,center=true);
	translate([-10,0,0]) cylinder(r=1,h=2,center=true);
	translate([0,0,0]) cylinder(r=1,h=2,center=true);
	translate([3,5,4]) cylinder(r=0.1,h=5,center=false);
	translate([10,0,0]) cylinder(r=1,h=2,center=true);
	translate([-10,10,0]) cylinder(r=1,h=2,center=true);
	translate([0,10,0]) cylinder(r=1,h=2,center=true);
	translate([10,10,0]) cylinder(r=1,h=2,center=true);
}
