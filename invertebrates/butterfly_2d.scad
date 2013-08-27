// Butterfly Wing Parts 2D
use <../utilities/shell_2d.scad>;

render_part="butterfly_wingpart_polygon";
render_part="butterfly_wingpart_outline";
render_part="butterfly_wingpart_hull";
render_part="butterfly_wingpart_2d";
render_part="butterfly_wingparts_2d";
//render_part="butterfly_traverse_wingpart";
//render_part="butterfly_traverse_wingparts";

function butterfly_wingpart_points() = [ [0,0],[3,0],[6,3],[6,4],[1,4],[0,3] ];
function butterfly_wingpart_paths() = [[0,1,2,3,4,5,6]];
function butterfly_wingpart_bbox() = [[0,0],[6,4]];
function butterfly_wingpart_grid() = [[1,1],[3,1],[6,4],[2,4],[1,3]];
//function butterfly_wingpart_grid() = [[1,1],[2,1],[3,1],[4,2],[5,3],[6,4],[4,4],[2,4],[1,3]];
function butterfly_wingmounts_grid() = [[0.5,0.5],[6.5,4.5],[0.5,1.5],[5.5,4.5]]; // [front_mount_point,rear_mount_point]
function butterfly_wingmounts_grid_indicies() = [0,2];

module butterfly_wingpart_polygon() {
    polygon(points=butterfly_wingpart_points(),paths=butterfly_wingpart_paths(),convexity=10);
}

if(render_part=="butterfly_wingpart_polygon") {
  echo("Rendering butterfly_wingpart_polygon()");
  butterfly_wingpart_polygon();
}

if(render_part=="butterfly_wingpart_outline") {
  shell_2d(th=0.25,n=8) butterfly_wingpart_polygon();
}

module butterfly_wingpart_hull(grid_w=1.0,grid_h=1.0) {
  for(i=[0:$children-1]) {
    hull() {
	for(j=[0:len(butterfly_wingpart_grid())-1]) 
		translate([butterfly_wingpart_grid()[j][0]*grid_w-grid_w/2,butterfly_wingpart_grid()[j][1]*grid_h-grid_h/2])
			child(i);
    }
  }
}

if(render_part=="butterfly_wingpart_hull") {
  difference() {
	butterfly_wingpart_hull() circle(r=0.5,$fn=16);
	butterfly_wingpart_hull() circle(r=0.25,$fn=16);
  }
}


module butterfly_wingpart_2d(grid_w=8.0,grid_h=8.0,peg_d=5.0,wall_th=(8.0-5.0)/2,solid=false) {
 difference() {
  union() {
    difference() {
        butterfly_wingpart_hull(grid_w=grid_w,grid_h=grid_h) scale([grid_w,grid_h]) circle(r=0.5,$fn=16);
        if(!solid) butterfly_wingpart_hull(grid_w=grid_w,grid_h=grid_h) scale([grid_w-2*wall_th,grid_h-2*wall_th]) circle(r=0.5,$fn=16);
    }
    for(i=[0:len(butterfly_wingmounts_grid())-1]) for(j=[0:len(butterfly_wingmounts_grid())-1]) if(i!=j) assign(pti=[butterfly_wingmounts_grid()[i][0]*grid_w-grid_w/2,butterfly_wingmounts_grid()[i][1]*grid_h-grid_h/2],ptj=[butterfly_wingmounts_grid()[j][0]*grid_w-grid_w/2,butterfly_wingmounts_grid()[j][1]*grid_h-grid_h/2])
	if( sqrt((pti-ptj)*(pti-ptj))<sqrt(2*grid_w*grid_h) ) {
		hull() {
			translate(pti) scale([grid_w,grid_h]) circle(r=0.5,$fn=16);
			translate(ptj) scale([grid_w,grid_h]) circle(r=0.5,$fn=16);
		}
	} else {
		translate(pti)
			scale([grid_w,grid_h]) circle(r=0.5,$fn=16);
	}
  }
  if(!solid) for(i=[0:len(butterfly_wingmounts_grid())-1]) for(j=[0:len(butterfly_wingmounts_grid())-1]) if(i!=j) assign(pti=[butterfly_wingmounts_grid()[i][0]*grid_w-grid_w/2,butterfly_wingmounts_grid()[i][1]*grid_h-grid_h/2],ptj=[butterfly_wingmounts_grid()[j][0]*grid_w-grid_w/2,butterfly_wingmounts_grid()[j][1]*grid_h-grid_h/2])
	if( sqrt((pti-ptj)*(pti-ptj))<sqrt(2*grid_w*grid_h) ) {
		hull() {
			translate(pti) circle(r=peg_d/2,$fn=16);
			translate(ptj) circle(r=peg_d/4,$fn=16);
		}
	} else {
		translate(pti) circle(r=peg_d/2,$fn=16);
	}
 }
}

if(render_part=="butterfly_wingpart_2d") {
  butterfly_wingpart_2d();
}


module butterfly_wingparts_2d(grid_w=8.0,grid_h=8.0,peg_d=5.0,wall_th=(8.0-5.0)/2,solid=false) {
	translate([grid_w/2,grid_h/2]) translate([-butterfly_wingmounts_grid()[0][0]*grid_w+grid_w,-butterfly_wingmounts_grid()[0][1]*grid_h+grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,solid=solid);
	translate([grid_w/2,-grid_h/2]) rotate(90) translate([-butterfly_wingmounts_grid()[1][0]*grid_w,-butterfly_wingmounts_grid()[1][1]*grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,solid=solid);
  mirror([1,0]) {
	translate([grid_w/2,grid_h/2]) translate([-butterfly_wingmounts_grid()[0][0]*grid_w+grid_w,-butterfly_wingmounts_grid()[0][1]*grid_h+grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,solid=solid);
	translate([grid_w/2,-grid_h/2]) rotate(90) translate([-butterfly_wingmounts_grid()[1][0]*grid_w,-butterfly_wingmounts_grid()[1][1]*grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,solid=solid);
  }
}

if(render_part=="butterfly_wingparts_2d") {
  % butterfly_wingparts_2d(solid=true);
  butterfly_wingparts_2d(solid=false);
}

