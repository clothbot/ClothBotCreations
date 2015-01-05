// Lego Compatible Build Modules

use <lcbm_corner_bevel.scad>;
test_module="test lcbm_block_body";

module lcbm_block_body(unit=[8.0,8.0,10.0/3.0],size=[1,1,1],bevel=0.2,flat=0.0,center=true,shrink=0.0) {
    offset_x=(center)?-size[0]*unit[0]/2:0.0;
    offset_y=(center)?-size[1]*unit[1]/2:0.0;
    translate([offset_x,offset_y]) hull() {
        translate([bevel+shrink/2,bevel+shrink/2,0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
        translate([unit[0]*size[0]-bevel-shrink/2,bevel+shrink/2,0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
        translate([bevel+shrink/2,unit[1]*size[1]-bevel-shrink/2,0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
        translate([unit[0]*size[0]-bevel-shrink/2,unit[1]*size[1]-bevel-shrink/2,0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
    }
}

if(test_module=="test lcbm_block_body") {
    echo("Testing lcbm_block_body...");
    lcbm_block_body(size=[1,2,1],center=false,shrink=0.25);
    %cube([8,16,10/3],center=false);
}
