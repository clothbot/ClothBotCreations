// Directed Minkowski Modules

render_test="test bulge_cube";
render_test="test bulge_cone";

module bulge_cube(h,scale_xy=0.1) {
    intersection() {
        for(i=[0:1],j=[0:1]) {
            minkowski() {
                children();
                mirror([i,j]) scale([scale_xy,scale_xy,h]) cube(1,center=false);
            }
        }
    }
}

if(render_test=="test bulge_cube") {
    %sphere(10);
    difference() {
        bulge_cube(2) sphere(10);
        sphere(10);
        cube(20,center=false);
    }
}

module bulge_cone(h,scale_xy=0.1) {
    intersection() {
        for(i=[0:1],j=[0:1]) {
            minkowski() {
                children();
                mirror([i,j]) scale([scale_xy,scale_xy,h]) render() intersection() {
                    cube(1,center=false);
                    cylinder(r1=1,r2=0,h=1,center=false,$fn=16);
                }
            }
        }
    }
}

if(render_test=="test bulge_cone") {
    %sphere(10);
    difference() {
        bulge_cone(2) sphere(10);
        sphere(10);
        cube(20,center=false);
    }
}