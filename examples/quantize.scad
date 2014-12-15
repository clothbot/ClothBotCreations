// Cellular Automata
render_part="quantize cube";
//render_part="null space";
render_part="quantize array";
render_part="rotated cube";

//dt=$t;
dt=0.8;

module quantize_cube(dx=1.0,dy=1.0,dz=1.0) {
//    for(i=[0:$children-1]) {
        intersection() {
            minkowski() {
                children(0);
                cube([dx,dy,dz],center=true);
            }
            # cube([dx,dy,dz],center=true);
        }
}

if(render_part=="quantize cube") {
    echo("Test quantize_cube.");
    quantize_cube(dx=1,dy=1,dz=1) {
        intersection() {
            # translate([(dt-0.5)*2,0,0]) sphere(r=0.25,$fn=8);
            cube([0.5,0.5,0.5],center=true);
        }
    }
}

module nullspace() {
    intersection() {
        translate([-2,0,0]) cube(1);
        translate([2,0,0]) cube(1);
    }
}

if(0) intersection() {
    minkowski() {
        nullspace();
        cube();
    }
    cube();
}

if(render_part=="null space") {
    echo("Minkowski on null-space test.");
    //intersection() {
        //# scale(1.5) cube();
        # minkowski() {
            intersection() {
                translate([-0.75*dt,0,0]) # cube();
                translate([0.75*dt,0,0]) # cube();
            }
            cube();
        }
    //}
}

module quantize_array(dx=1.0,dy=1.0,dz=1.0,minCoord=[-2,-2,-2],maxCoord=[2,2,2],iteration=2,scale=0.5) {
    for(xi=[minCoord[0]:dx:maxCoord[0]]) {
        for(yj=[minCoord[1]:dy:maxCoord[1]]) {
            for(zk=[minCoord[2]:dz:maxCoord[2]]) {
                // echo(str("ca_map: ",xi,",",yj,",",zk,";"));
                intersection() {
                    minkowski() {
                        intersection() {
                            children();
                            translate([xi,yj,zk]) cube([dx,dy,dz],center=true);
                        }
                        cube([2*dx,2*dy,2*dz],center=true);
                    }
                    translate([xi,yj,zk]) cube(scale*[dx,dy,dz],center=true);
                }
            }
        }
    }
}

module cube_mask(dx=1.0,dy=1.0,dz=1.0,minCoord=[-2,-2,-2],maxCoord=[2,2,2],scale=0.5) {
    for(xi=[minCoord[0]:dx:maxCoord[0]]) {
        for(yj=[minCoord[1]:dy:maxCoord[1]]) {
            for(zk=[minCoord[2]:dz:maxCoord[2]]) {
                // echo(str("ca_map: ",xi,",",yj,",",zk,";"));
                translate([xi,yj,zk]) scale(scale) translate([-xi,-yj,-zk]) intersection() {
                    translate([xi,yj,zk]) cube([dx,dy,dz],center=true);
                    children();
                }
            }
        }
    }
}

//
if(render_part=="quantize array") {
    quantize_array(minCoord=[-2,-2,-2],maxCoord=[2,2,2],dx=0.5,dy=0.5,dz=0.5) cube([2.5,2.5,2.5],center=true);
    %cube([2.5,2.5,2.5],center=true);
}

if(render_part==3) {
    minkowski() {
        cube_mask(minCoord=[-2,-2,-2],maxCoord=[2,2,2],dz=0.5) sphere(d=2.5,$fn=16);
        cube([0.1,0.1,0.05],center=true);
    }
    translate([5,5,0]) %sphere(d=2.5);
}

if(render_part=="rotated cube") {
	quantize_array(minCoord=[-2,-2,-2],maxCoord=[2,2,2],dx=0.25,dy=0.25,dz=0.25,scale=0.707)
		render() rotate([30,30,30]) difference() {
			cube([2.5,2.5,2.5],center=true);
			cube([2.0,2.0,2.0],center=true);
			cube([2.5,2.5,2.5],center=false);
		}
	rotate([30,30,30]) %cube([2.5,2.5,2.5],center=true);
}
