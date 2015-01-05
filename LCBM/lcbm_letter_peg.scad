// Lego Compatible Build Modules

use <lcbm_peg.scad>;
use <lcbm_socket_hole.scad>;
//use <lcbm_corner_bevel.scad>;
use <lcbm_block_body.scad>;
test_module="test lcbm_letter_peg";

module lcbm_letter_peg(letter="A",letter_h=0.2,letter_size=0.707*4.9,block_h=3.2,block_w=8.0,block_bevel=0.2,peg_h=1.7,min_wall_th=1.0) {
    difference() {
        union() {
            lcbm_block_body(unit=[block_w,block_w,block_h],bevel=block_bevel,center=true);
            translate([0,0,block_h]) lcbm_peg(peg_h=peg_h,peg_hole_d=0);
            translate([0,0,block_h+peg_h]) {
                linear_extrude(height=2*letter_h,center=true) text(letter,halign="center",valign="center",size=letter_size);
            }
        }
        lcbm_socket_hole(socket_h=block_h-min_wall_th,socket_hole_h=block_h+peg_h-min_wall_th,socket_hole_bevel=0,flat_side_w=3.0);
    }
}

if(test_module=="test lcbm_letter_peg") {
    echo("Testing lcbm_letter_peg...");
    difference() {
        lcbm_letter_peg("B");
        cube([10,10,10]);
    }
}
