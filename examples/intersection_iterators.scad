render_part=2;

module pin_array(nx=4,ny=3,dx=5,dy=5) {
  for(ix=[0:nx-1]) for(jy=[0:ny-1]) {
    translate([ix*dx-(nx-1)*dx/2,jy*dy-(ny-1)*dy/2]) children();
  }
}

module join_array(dr=5.0,show=false) {
  if($children>1) {
	echo("Number of children:",$children);
	for(i=[0:$children-2]) for(j=[i+1:$children-1]) join_radius(dr=dr,show=show) {
	  children(i);
	  children(j);
	  minkowski() {
		children(i);
		sphere(r=dr,$fn=8);
	  }
	  minkowski() {
		children(j);
		sphere(r=dr,$fn=8);
	  }
	}
  } else {
	children(0);
  }
}

module join_radius(dr=5.0,show=false) {
  if($children>3) {
	  if(show) {
	    %minkowski() {
		children(0);
		sphere(r=dr,$fn=8);
	    }
	    %minkowski() {
		children(1);
		sphere(r=dr/10,$fn=8);
	    }
	  }
	  hull() intersection() {
		children(2);
		union() {
			children(0);
			children(1);
		}
	  }
	  hull() intersection() {
		children(3);
		union() {
			children(0);
			children(1);
		}
	  }
  }
}	


module mask() {
  difference() {
    scale([12,12,5]) sphere(r=1,center=true,$fn=32);
    scale([11.5,11.5,4]) sphere(r=1,center=true,$fn=32);
    translate([0,0,-10]) cube([30,30,20],center=true);
  }
}

if(render_part==1) {
  echo("Add render(union=false) option to explode sub-volumes into children()");
  %mask();
  join_array(dr=5) {
    render(union=false) intersection() {
      pin_array(nx=5,ny=5) {
        cylinder(r=0.5,h=10,center=true);
      }
      mask();
    }
  }
}


module joined_pin_array(nx=5,ny=5,dx=5,dy=5,dr=5) {
  for(ix1=[0:nx-1]) for(ix2=[0:nx-1]) for(jy1=[0:ny-1]) for(jy2=[0:ny-1]) if(ix1!=ix2 || jy1!=jy2) {
	echo(str("  Processing (",ix1,",",jy1,"),(",ix2,",",jy2,")"));
    join_array(dr=dr) {
	union() intersection() {
		children(0);
	    translate([ix1*dx-(nx-1)*dx/2,jy1*dy-(ny-1)*dy/2]) children(1);
	}
	union() intersection() {
		children(0);
	    translate([ix2*dx-(nx-1)*dx/2,jy2*dy-(ny-1)*dy/2]) children(1);
	}
    }
  }
}


if(render_part==2) {
  echo("Manually implemented version of what I'm trying to do via render(union=false).");
  %mask();
  joined_pin_array(nx=4,ny=3,dx=6,dy=5,dr=5) {
	mask();
	cylinder(r=0.5,h=10,center=true,$fn=4);
  }
  translate([0,0,5]) {
	%mask();
	joined_pin_array(nx=4,ny=3,dx=6,dy=5,dr=6) {
		mask();
		cylinder(r=0.5,h=10,center=true,$fn=4);
	}
  }
  translate([0,0,10]) {
	%mask();
	joined_pin_array(nx=4,ny=3,dx=6,dy=5,dr=sqrt(5*5+6*6)) {
		mask();
		cylinder(r=0.5,h=10,center=true,$fn=4);
	}
  }
}

if(render_part==3) {
  echo("Example of join_array() performed on multiple explicit children.");
  join_array(dr=8) {
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
}
