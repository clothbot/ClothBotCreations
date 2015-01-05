// Lego Compatible Build Modules

test_module="test lcbm_peg";

module lcbm_peg(peg_d=4.9,peg_h=1.8,peg_bevel=0.2,peg_base_ext=0.1,peg_hole_d=1.8,peg_hole_bevel=0.1,flat_side_w=1.0) {
    $fn=16;
    render() difference() {
        hull() {
            translate([0,0,-peg_base_ext]) cylinder(r=peg_d/2,h=peg_base_ext+peg_h-peg_bevel);
            if(flat_side_w>0.0) {
                translate([0,0,peg_h/2-peg_bevel]) {
                    cube([flat_side_w,peg_d,peg_h-2*peg_bevel],center=true);
                    cube([peg_d,flat_side_w,peg_h-2*peg_bevel],center=true);
                }
            }
            if(peg_bevel>0.0) {
                translate([0,0,peg_h-peg_bevel]) cylinder(r1=peg_d/2,r2=peg_d/2-peg_bevel,h=peg_bevel);
            }
        }
        if(peg_hole_d>0.0) {
            translate([0,0,-peg_base_ext]) {
                cylinder(r=peg_hole_d/2,h=peg_base_ext+peg_h);
            }
            if(peg_hole_bevel>0.0) {
                translate([0,0,-peg_base_ext]) cylinder(r1=peg_hole_d/2+peg_hole_bevel,r2=peg_hole_d/2,h=peg_hole_bevel);
                translate([0,0,peg_h-peg_hole_bevel]) cylinder(r1=peg_hole_d/2,r2=peg_hole_d/2+peg_hole_bevel,h=peg_hole_bevel);
            }
        }
    }
}

if(test_module=="test lcbm_peg") {
    echo("Testing lcbm_peg...");
    lcbm_peg();
}
