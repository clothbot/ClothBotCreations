// Butterfly Wing Parts
use <../utilities/shell_2d.scad>;

render_part="butterfly_wingpart_polygon";
render_part="butterfly_wingpart_outline";
render_part="butterfly_wingpart_hull";
render_part="butterfly_wingpart_2d";
render_part="butterfly_wingparts_2d";
render_part="butterfly_wingparts_3d";
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

module butterfly_wingpart_lattice_2d(grid_w=8.0,grid_h=8.0,peg_d=5.0,wall_th=(8.0-5.0)/2,radials=true) {
  pts=len(butterfly_wingpart_grid());
  for(i=[0:pts-1]) assign(curpt_idx=(pts+i)%pts
        ,ptp1_idx=(pts+(i+1))%pts
        ,ptp2_idx=(pts+(i+2))%pts
        ,ptp3_idx=(pts+(i+3))%pts
        )
    assign(
        ptn=butterfly_wingpart_grid()[curpt_idx]
        ,ptnp1=butterfly_wingpart_grid()[ptp1_idx]
        ,ptnp2=butterfly_wingpart_grid()[ptp2_idx]
        ,ptnp3=butterfly_wingpart_grid()[ptp3_idx]
        ) {
    difference() {
      union() {
	    if(radials==true) {
		render() hull() {
	        translate([ptnp1[0]*grid_w-grid_w/2,ptnp1[1]*grid_h-grid_h/2]) circle(r=grid_w/2);
	        translate([[grid_w,0],[0,grid_h]]*(ptn+(ptnp2-ptn)/4)-[grid_w/2,grid_h/2]) circle(r=2*wall_th);
		}
	    }
	    hull() {
	        translate([[grid_w,0],[0,grid_h]]*(ptn+(ptnp2-ptn)/4)-[grid_w/2,grid_h/2]) circle(r=wall_th/2);
	        translate([[grid_w,0],[0,grid_h]]*(ptnp1+(ptnp3-ptnp1)/4)-[grid_w/2,grid_h/2]) circle(r=wall_th/2);
	    }
	  }
	  if(radials==true) {
		hull() {
	       translate([ptnp1[0]*grid_w-grid_w/2,ptnp1[1]*grid_h-grid_h/2]) circle(r=grid_w/2-wall_th);
	       translate([[grid_w,0],[0,grid_h]]*(ptn+(ptnp2-ptn)/4)-[grid_w/2,grid_h/2]) circle(r=wall_th);
		}
	  }
    }
  }
}

module butterfly_wingpart_2d(grid_w=8.0,grid_h=8.0,peg_d=5.0,wall_th=(8.0-5.0)/2,lattice=false) {
 difference() {
  union() {
    if(lattice) butterfly_wingpart_lattice_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th);
    difference() {
        butterfly_wingpart_hull(grid_w=grid_w,grid_h=grid_h) scale([grid_w,grid_h]) circle(r=0.5,$fn=16);
        butterfly_wingpart_hull(grid_w=grid_w,grid_h=grid_h) scale([grid_w-2*wall_th,grid_h-2*wall_th]) circle(r=0.5,$fn=16);
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
  for(i=[0:len(butterfly_wingmounts_grid())-1]) for(j=[0:len(butterfly_wingmounts_grid())-1]) if(i!=j) assign(pti=[butterfly_wingmounts_grid()[i][0]*grid_w-grid_w/2,butterfly_wingmounts_grid()[i][1]*grid_h-grid_h/2],ptj=[butterfly_wingmounts_grid()[j][0]*grid_w-grid_w/2,butterfly_wingmounts_grid()[j][1]*grid_h-grid_h/2])
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


module butterfly_wingparts_2d(grid_w=8.0,grid_h=8.0,peg_d=5.0,wall_th=(8.0-5.0)/2,lattice=false) {
	translate([grid_w/2,grid_h/2]) translate([-butterfly_wingmounts_grid()[0][0]*grid_w+grid_w,-butterfly_wingmounts_grid()[0][1]*grid_h+grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,lattice=lattice);
	translate([grid_w/2,-grid_h/2]) rotate(90) translate([-butterfly_wingmounts_grid()[1][0]*grid_w,-butterfly_wingmounts_grid()[1][1]*grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,lattice=lattice);
  mirror([1,0]) {
	translate([grid_w/2,grid_h/2]) translate([-butterfly_wingmounts_grid()[0][0]*grid_w+grid_w,-butterfly_wingmounts_grid()[0][1]*grid_h+grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,lattice=lattice);
	translate([grid_w/2,-grid_h/2]) rotate(90) translate([-butterfly_wingmounts_grid()[1][0]*grid_w,-butterfly_wingmounts_grid()[1][1]*grid_h])
		butterfly_wingpart_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,lattice=lattice);
  }
}

if(render_part=="butterfly_wingparts_2d") {
  butterfly_wingparts_2d();
}

module butterfly_wingparts_3d(grid_w=8.0,grid_h=8.0,peg_d=5.0,wall_th=(8.0-5.0)/2,lattice=false,h=0.8) {
  linear_extrude(height=h) butterfly_wingparts_2d(grid_w=grid_w,grid_h=grid_h,peg_d=peg_d,wall_th=wall_th,lattice=lattice);
}

if(render_part=="butterfly_wingparts_3d") {
  butterfly_wingparts_3d(lattice=false);
}


module butterfly_traverse_wingpart(grid_w=8.0,grid_h=8.0,dir=-1,mount_index=0,start_d=8.0,end_d=2.0,mount_hole_d=5.0,start_h=2.0,end_h=1.0) {
  $fn=16;
  pts=len(butterfly_wingpart_grid());
  difference() {
    union() for(i=[0:pts-1]) assign(curpt_idx=(pts+mount_index+dir*i)%pts,nextpt_idx=(pts+mount_index+dir*(i+1))%pts) 
	assign(curpt=butterfly_wingpart_grid()[curpt_idx],nextpt=butterfly_wingpart_grid()[nextpt_idx]) {
	hull() {
		if(i==0) {
			translate([grid_w*curpt[0]-grid_w/2,grid_h*curpt[1]-grid_h/2]) hull() {
				cylinder( r=(start_d-(start_d-end_d)*i/pts)/2,h=start_h-(start_h-end_h)*i/pts,center=false);
				//translate([start_d/4,start_d/4]) cylinder(r=start_d/4,h=start_h,center=false);
				//translate([start_d/4,-start_d/4]) cylinder(r=start_d/4,h=start_h,center=false);
				//translate([-start_d/4,-start_d/4]) cylinder(r=start_d/4,h=start_h,center=false);
				//translate([-start_d/4,start_d/4]) cylinder(r=start_d/4,h=start_h,center=false);
			}
		} else {
			translate([grid_w*curpt[0]-grid_w/2,grid_h*curpt[1]-grid_h/2]) cylinder( r1=(start_d-(start_d-end_d)*i/pts)/2,r2=(start_d-(start_d-end_d)*(i+1)/pts)/2,h=start_h-(start_h-end_h)*i/pts,center=false);
		}
		translate([grid_w*nextpt[0]-grid_w/2,grid_h*nextpt[1]-grid_h/2]) cylinder( r1=(start_d-(start_d-end_d)*(i+1)/pts)/2,r2=(start_d-(start_d-end_d)*(i+2)/pts)/2,h=start_h-(start_h-end_h)*(i+1)/pts,center=false);
	}
    }
    translate([grid_w*butterfly_wingpart_grid()[mount_index][0]-grid_w/2,grid_h*butterfly_wingpart_grid()[mount_index][1]-grid_h/2]) cylinder(r=mount_hole_d/2,h=2*(start_h+end_h),center=true);
    for(i=[0:pts-1]) assign(curpt_idx=(pts+mount_index+dir*i)%pts,nextpt_idx=(pts+mount_index+dir*(i+1))%pts) 
	assign(curpt=butterfly_wingpart_grid()[curpt_idx],nextpt=butterfly_wingpart_grid()[nextpt_idx]) {
	hull() {
		translate([grid_w*curpt[0]-grid_w/2,grid_h*curpt[1]-grid_h/2]) cylinder( r1=(end_d-end_d*i/pts)/2,r2=(end_d-end_d*(i+1)/pts)/2,h=start_h-(start_h-end_h)*(i-1)/pts,center=false);
		translate([grid_w*nextpt[0]-grid_w/2,grid_h*nextpt[1]-grid_h/2]) cylinder( r1=(end_d-end_d*(i+1)/pts)/2,r2=(end_d-end_d*(i+2)/pts)/2,h=start_h-(start_h-end_h)*i/pts,center=false);
	}
    }
  }
}

if(render_part=="butterfly_traverse_wingpart") {
  butterfly_traverse_wingpart(dir=-1,mount_index=0,mount_hole_d=5.2,start_d=5.2+0.8*4,end_d=2.0,start_h=0.8,end_h=0.4);
}

module butterfly_traverse_wingparts(grid_w=8.0,grid_h=8.0,start_d=8.0,end_d=2.0,mount_hole_d=5.0,start_h=0.8,end_h=0.4) {
	translate([grid_w/2,grid_h/2]) translate([-butterfly_wingmounts_grid()[0][0]*grid_w+grid_w,-butterfly_wingmounts_grid()[0][1]*grid_h+grid_h])
		butterfly_traverse_wingpart(grid_w=grid_w,grid_h=grid_h,start_d=start_d,end_d=end_d,mount_hole_d=mount_hole_d,start_h=start_h,end_h=end_h,dir=-1,mount_index=butterfly_wingmounts_grid_indicies()[0]);
	translate([grid_w/2,-grid_h/2]) rotate(90) translate([-butterfly_wingmounts_grid()[1][0]*grid_w,-butterfly_wingmounts_grid()[1][1]*grid_h])
		butterfly_traverse_wingpart(grid_w=grid_w,grid_h=grid_h,start_d=start_d,end_d=end_d,mount_hole_d=mount_hole_d,start_h=start_h,end_h=end_h,dir=-1,mount_index=butterfly_wingmounts_grid_indicies()[1]);
  mirror([1,0]) {
	translate([grid_w/2,grid_h/2]) translate([-butterfly_wingmounts_grid()[0][0]*grid_w+grid_w,-butterfly_wingmounts_grid()[0][1]*grid_h+grid_h])
		butterfly_traverse_wingpart(grid_w=grid_w,grid_h=grid_h,start_d=start_d,end_d=end_d,mount_hole_d=mount_hole_d,start_h=start_h,end_h=end_h,dir=-1,mount_index=butterfly_wingmounts_grid_indicies()[0]);
	translate([grid_w/2,-grid_h/2]) rotate(90) translate([-butterfly_wingmounts_grid()[1][0]*grid_w,-butterfly_wingmounts_grid()[1][1]*grid_h])
		butterfly_traverse_wingpart(grid_w=grid_w,grid_h=grid_h,start_d=start_d,end_d=end_d,mount_hole_d=mount_hole_d,start_h=start_h,end_h=end_h,dir=-1,mount_index=butterfly_wingmounts_grid_indicies()[1]);
  }
}

if(render_part=="butterfly_traverse_wingparts") {
  butterfly_traverse_wingparts(mount_hole_d=5.2,start_d=5.2+0.8*3,end_d=2.0);
}

