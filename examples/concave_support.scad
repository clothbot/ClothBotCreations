// concave support generator example
// - Assumes children() to be concave geometries.

render_part="test concave_support";

nozzle_d=0.4;
layer_th=0.2;

module concave_support(outline_shrink=nozzle_d/2,support_offset=layer_th) {
    render() difference() {
        union() for(i=[0:$children-1]) {
            hull() {
                linear_extrude(height=support_offset) 
                    offset(-outline_shrink) projection(cut=false) children(i);
                children(i);
            }
        }
        for(i=[0:$children-1]) minkowski() {
            children(i);
            cylinder(r=support_offset,h=2*support_offset,center=true,$fn=8);
        }
    }
}

module test_cube1() {
    translate([0,0,5*sqrt(2)]) rotate([30,30,45]) cube(10);
}

module test_cylinder1() {
    translate([0,0,20]) rotate([-30,-30,-30]) cylinder(r=5,h=10,center=true);
}

module test_sphere1() {
    translate([10,10,22.5]) sphere(r=5);
}

module test_axle1() {
    translate([0,0,17.5]) rotate([0,90,45]) cylinder(r=2.5,h=20,center=false);
}

if( render_part=="test concave_support" ) {
    echo("Test concave_support...");
    color([1,0,0]) test_cube1();
    color([0,1,0]) test_cylinder1();
    color([0,0,1]) test_sphere1();
    color([0,0,0]) test_axle1();
    # concave_support() {
        test_cube1();
        test_cylinder1();
        test_sphere1();
        test_axle1();
    }
}
