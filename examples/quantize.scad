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
            translate([2,2,2]) cube(0);
            cube();
        }
    //}
}

module minkowski_null(delta=[1,1,1]) {
    translate(-delta) difference() {
        minkowski() {
            children(0);
            translate(delta) children(1);
        }
        children(0);
    }
}
module quantize_array(dx=1.0,dy=1.0,dz=1.0,minCoord=[-2,-2,-2],maxCoord=[2,2,2],iteration=2,scale=0.5) {
    for(xi=[minCoord[0]:dx:maxCoord[0]]) {
        for(yj=[minCoord[1]:dy:maxCoord[1]]) {
            for(zk=[minCoord[2]:dz:maxCoord[2]]) {
                // echo(str("ca_map: ",xi,",",yj,",",zk,";"));
                intersection() {
                    render() minkowski_null([2*dx,2*dy,2*dz]) {
                        cube([2*dx,2*dy,2*dz],center=true);
                        intersection() {
                            children();
                            translate([xi,yj,zk]) cube([dx,dy,dz],center=true);
                        }
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
    quantize_array(minCoord=[0,0,0],maxCoord=[4,4,4],dx=0.5,dy=0.5,dz=0.5) translate([0.5,0.5,0.5]) cube([2.5,2.5,2.5],center=false);
    translate([0.5,0.5,0.5]) %cube([2.5,2.5,2.5],center=false);
}

if(render_part==3) {
    minkowski() {
        cube_mask(minCoord=[-2,-2,-2],maxCoord=[2,2,2],dz=0.5) sphere(d=2.5,$fn=16);
        cube([0.1,0.1,0.05],center=true);
    }
    translate([5,5,0]) %sphere(d=2.5);
}

if(render_part=="rotated cube") union() {
	quantize_array(minCoord=[0,0,0],maxCoord=[5,5,5],dx=0.2,dy=0.2,dz=0.2,scale=0.707)
		translate([2,2,2]) render() rotate([30,30,30]) difference() {
			cube([2.5,2.5,2.5],center=true);
			cube([2.4,2.4,2.4],center=true);
			cube([2.5,2.5,2.5],center=false);
		}
    translate([2,2,2]) render() rotate([30,30,30]) difference() {
			cube([2.5,2.5,2.5],center=true);
			cube([2.4,2.4,2.4],center=true);
			cube([2.5,2.5,2.5],center=false);
		}
	translate([2,2,2]) rotate([30,30,30]) %cube([2.5,2.5,2.5],center=true);
    %cube([0.5,0.5,0.5],center=true);
}
