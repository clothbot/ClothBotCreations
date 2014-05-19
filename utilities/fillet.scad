// Fillet function

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
		minkowski() {
			children(2);
			sphere(r=r*step/steps);
		}
	  }
	  render() intersection() {
		children(1);
		minkowski() {
			children(2);
			sphere(r=r*(steps-step+1)/steps);
		}
	  }
	}
  }
}

fillet(r=1,steps=5) {
	cylinder(r=5,h=10);
	cube([10,10,2]);
	rotate([30,30,30]) cylinder(r=1.0,h=50,center=true);
}
