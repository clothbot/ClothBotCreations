// convex decomposition faked application

module fillet(r=1.0,steps=3,include=true) {
  if(include) for (k=[0:$children-1]) {
	children(k);
  }
  for (i=[0:$children-2] ) {
    for(j=[i+1:$children-1] ) {
	fillet_two(r=r,steps=steps) {
	  children(i);
	  children(j);
	  intersection() {
		children(i);
		children(j);
	  }
	}
    }
  }
}

module fillet_two(r=1.0,steps=3) {
  for(step=[1:steps]) {
	hull() {
	  render() intersection() {
		children(0);
		offset_3d(r=r*step/steps) children(2);
	  }
	  render() intersection() {
		children(1);
		offset_3d(r=r*(steps-step+1)/steps) children(2);
	  }
	}
  }
}

module offset_3d(r=1.0) {
  for(k=[0:$children-1]) minkowski() {
	children(k);
	sphere(r=r,$fn=8);
  }
}

module square_tube(inner=8,outer=10,h=10,center=false) {
    translate([0,0,(center?0.0:h/2)]) render() difference() {
        cube([outer,outer,h],center=true);
        cube([inner,inner,h+1],center=true);
    }
}

module convex_decomposition_faked(grid_min=[-5,-5,0],grid_max=[5,5,5],grid_step=[1,1,5],fillet_r=1,fillet_steps=3, fillet_include=true) {
    for(dx=[grid_min[0]:grid_step[0]:grid_max[0]],dy=[grid_min[1]:grid_step[1]:grid_max[1]],dz=[grid_min[2]:grid_step[2]:grid_max[2]]) {
        fillet(r=fillet_r,steps=fillet_steps,include=fillet_include) {
            children(0);
            render() intersection() {
                translate([dx,dy,dz]) cube(size=grid_step,center=false);
                children(1);
            }
        }
    }
}
convex_decomposition_faked() {
    difference() {
        cube([20,20,1],center=true);
        cube([8,8,2],center=true);
    }
    square_tube(inner=8, outer=10, h=6);
}
