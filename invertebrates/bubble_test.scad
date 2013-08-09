// Bubble Test
wall_th=0.4;

module hex_2d(d=10.0,rot=0) {
  rotate(rot) render() intersection() {
	square([d,2*d],center=true);
	rotate(60) square([d,2*d],center=true);
	rotate(-60) square([d,2*d],center=true);
  }
}

module spiral_bubbles_body(n=5,wall_th=wall_th) {
  for(i=[1:n]) assign(a1=60*i,r1=(i+wall_th+1)*(i+wall_th+2)/6-(i-1)/6
		,a2=60*(i+1),r2=(i+wall_th+2)*(i+wall_th+3)/6-i/6
	) {
	if(i<n) difference() {
		hull() {
			rotate(a1) translate([r1,0]) hex_2d(d=i);
			rotate(a2) translate([r2,0]) hex_2d(d=i+1);
		}
		hull() {
			rotate(a1) translate([r1,0]) hex_2d(d=i-2*wall_th);
			rotate(a2) translate([r2,0]) hex_2d(d=i+1-2*wall_th);
		}
	}
	difference() {
	  hull() {
			rotate(a1) translate([r1,0]) hex_2d(d=i+2*wall_th);
			hex_2d(d=2*wall_th);
	  }
	  render() hull() {
			rotate(a1) translate([r1,0]) hex_2d(d=i);
			hex_2d(d=1.0*wall_th);
	  }
	}
	rotate(a1) translate([r1,0]) hex_2d(d=i+2*wall_th);
  }
}

module spiral_bubbles_holes(n=5,wall_th=wall_th,fact=2) {
  for(i=[1:n]) assign(a1=60*i,r1=(i+wall_th+1)*(i+wall_th+2)/6-(i-1)/6) {
	rotate(a1) translate([r1,0]) hex_2d(d=i);
  }
}

module spiral_bubbles_outline(n=5,wall_th=wall_th,fact=2,h=1.0) {
  linear_extrude(height=h) difference() {
    spiral_bubbles_body(n=n,fact=fact,wall_th=wall_th);
    spiral_bubbles_holes(n=n,fact=fact,wall_th=wall_th);
  }
}

spiral_bubbles_outline(n=12,fact=0.0,wall_th=2*wall_th);
