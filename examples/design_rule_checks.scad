// Identify thinner sections.
test_module="test inner_offset_3d";
test_module="test drc_thinner";

module inner_offset_3d(delta=0.1) {
    intersection_for(i=[0:7]) {
        if(i==0) {
            translate([0,0,-delta]) children();
        } else if(i==1) {
            translate([0,0,delta]) children();
        } else {
            translate(delta*[cos(90*i),sin(90*i),0]) children();
        }
    }
}

if(test_module=="test inner_offset_3d") {
    % cylinder(r1=10,r2=0,h=10);
    inner_offset_3d(delta=0.5) cylinder(r1=10,r2=0,h=10);
}

module drc_thinner(delta=0.1) {
    difference() {
        children();
        intersection() {
            children();
            minkowski() {
                inner_offset_3d(delta=delta) children();
                hull() {
                    cylinder(r1=delta,r2=0,h=delta);
                    rotate([180,0,0]) cylinder(r1=delta,r2=0,h=delta);
                    sphere(r=delta,$fn=8);
                }
            }
        }
    }
}

if(test_module=="test drc_thinner") {
    %cylinder(r1=10,r2=0,h=20);
    translate([0,0,40]) rotate([180,0,0]) %cylinder(r1=10,r2=0,h=20);
    #cylinder(r=8.0,h=1.0);
    drc_thinner(delta=1.0) {
        cylinder(r1=10,r2=0,h=20);
        translate([0,0,40]) rotate([180,0,0]) cylinder(r1=10,r2=0,h=20);
    }
}

