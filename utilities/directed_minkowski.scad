// Directed Minkowski Modules

render_test="test bulge_cube";
//render_test="test bulge_cone";
render_test="test text projection";

module bulge_cube(h,scale_xy=0.1,theta=0,phi=0,dr=0) {
    intersection() {
        for(i=[0:1],j=[0:1]) {
            minkowski() {
                children();
                rotate([0,0,theta]) rotate([0,phi,0]) translate([0,0,dr])
                    mirror([i,j]) scale([scale_xy,scale_xy,h]) cube(1,center=false);
            }
        }
    }
}

if(render_test=="test bulge_cube") {
    %sphere(10);
    difference() {
        bulge_cube(2,0.001,theta=360*$t,phi=360*$t,dr=20*$t) sphere(10);
        sphere(10);
        cube(20,center=false);
    }
}

module bulge_cone(h,scale_xy=0.1,theta=0,phi=0,dr=0) {
    intersection() {
        minkowski() {
            children();
            rotate([0,0,theta]) rotate([0,phi,0]) translate([0,0,dr])  scale([scale_xy,scale_xy,h]) render()
                cylinder(r2=1,r1=0,h=1,center=false,$fn=16);
        }
    }
}

if(render_test=="test bulge_cone") {
    %sphere(10);
    difference() {
        bulge_cone(25*4*($t+0.01)*(1-$t-0.01),35*($t+0.01)*(1-$t-0.01),theta=360*$t,phi=360*$t,dr=15*4*$t*(1-$t)) sphere(10);
        sphere(10);
        cube(20,center=false);
    }
}

module bulge_cube_mask(h,scale_xy=0.1,theta=0,phi=0,dr=0) {
    difference() {
        bulge_cube(h=h,scale_xy=scale_xy,theta=theta,phi=phi,dr=dr) children();
        children();
    }
}

if(render_test=="test text projection") {
    %sphere(10);
    intersection() {
            translate([0,0,5]) linear_extrude(height=10) resize([15,0,0],auto=true) text("OpenSCAD",valign="center",halign="center");
            bulge_cube_mask(h=0.25,scale_xy=0.1,theta=0,phi=0,dr=0) sphere(10);
    }
}

