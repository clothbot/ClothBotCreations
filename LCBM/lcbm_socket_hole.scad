// Lego Compatible Build Modules

test_module="test lcbm_socket_hole";

module lcbm_socket_hole(socket_d=4.9, socket_h=2.0, socket_bevel=0.2, socket_base_ext=0.1, socket_hole_d=1.8, socket_hole_h=3.3,socket_hole_bevel=0.1,flat_side_w=1.5) {
    $fn=16;
        render() {
            union() {
                translate([0,0,-socket_base_ext]) cylinder(r1=socket_base_ext+socket_d/2+socket_bevel,r2=socket_d/2,h=socket_base_ext+socket_bevel);
                if(flat_side_w>0.0) {
                    hull() translate([0,0,-socket_base_ext/2]) {
                        cube([flat_side_w,socket_d,socket_base_ext],center=true);
                        cube([socket_d,flat_side_w,socket_base_ext],center=true);
                    }
                }
            }
            hull() {
                cylinder(r=socket_d/2,h=socket_h-socket_bevel);
                if(flat_side_w>0.0) {
                    translate([0,0,socket_h/2-socket_bevel/2]) {
                        cube([flat_side_w,socket_d,socket_h-socket_bevel],center=true);
                        cube([socket_d,flat_side_w,socket_h-socket_bevel],center=true);
                    }
                }
                if(socket_bevel>0.0) {
                    translate([0,0,socket_h-socket_bevel]) cylinder(r1=socket_d/2,r2=socket_d/2-socket_bevel,h=socket_bevel);
                }
            }
            if(socket_hole_d>0.0) {
                cylinder(r=socket_hole_d/2,h=socket_hole_h);
                translate([0,0,socket_h]) cylinder(r1=socket_hole_d/2+2*socket_hole_bevel,r2=socket_hole_d/2,h=2*socket_hole_bevel,center=true);
                if(socket_hole_bevel>0.0) {
                    translate([0,0,socket_hole_h-socket_hole_bevel]) cylinder(r1=socket_hole_d/2,r2=socket_hole_d/2+socket_hole_bevel,h=socket_hole_bevel,center=false);
                }
            }
        }
}

if(test_module=="test lcbm_socket_hole") {
    echo("Testing lcbm_socket_hole...");
    lcbm_socket_hole(flat_side_w=1.0);
}
