// Directed Minkowski Modules

render_test="test bulge_cube";
render_test="test bulge_cone";

module bulge_cube(h,scale_xy=0.1,theta=0,phi=0) {
    intersection() {
        for(i=[0:1],j=[0:1]) {
            minkowski() {
                children();
                rotate([0,0,theta]) rotate([0,phi,0]) 
                    mirror([i,j]) scale([scale_xy,scale_xy,h]) cube(1,center=false);
            }
        }
    }
}

if(render_test=="test bulge_cube") {
    %sphere(10);
    difference() {
        bulge_cube(2,0.001,360*$t,360*$t) sphere(10);
        sphere(10);
        cube(20,center=false);
    }
}

module bulge_cone(h,scale_xy=0.1,theta=0,phi=0) {
    intersection() {
        minkowski() {
            children();
            rotate([0,0,theta]) rotate([0,phi,0]) scale([scale_xy,scale_xy,h]) render()
                cylinder(r2=1,r1=0,h=1,center=false,$fn=16);
        }
    }
}

if(render_test=="test bulge_cone") {
    %sphere(10);
    difference() {
        bulge_cone(1,0.001,360*$t,360*$t) sphere(10);
        sphere(10);
        cube(20,center=false);
    }
}

