// Lego Compatible Build Modules

test_module="test lcbm_peg";
use <lcbm_peg.scad>;
test_module="test lcbm_socket_hole";
use <lcbm_socket_hole.scad>;
use <lcbm_corner_bevel.scad>;
test_module="test lcbm_block_body";
use <lcbm_block_body.scad>;
test_module="test lcbm_letter_peg";
use <lcbm_letter_peg.scad>;
test_module="test lcbm_letter_tile";
use <lcbm_letter_tile.scad>;

if(test_module=="test lcbm_peg") {
    echo("Testing lcbm_peg...");
    lcbm_peg();
}

if(test_module=="test lcbm_socket_hole") {
    echo("Testing lcbm_socket_hole...");
    lcbm_socket_hole(flat_side_w=1.0);
}

if(test_module=="test lcbm_block_body") {
    echo("Testing lcbm_block_body...");
    lcbm_block_body(size=[1,2,1],center=false,shrink=0.25);
    %cube([8,16,10/3],center=false);
}

if(test_module=="test lcbm_letter_peg") {
    echo("Testing lcbm_letter_peg...");
    difference() {
        lcbm_letter_peg("B");
        cube([10,10,10]);
    }
}

if(test_module=="test lcbm_letter_tile") {
    echo("Testing lcbm_letter_tile...");
    lcbm_letter_tile("B",letter_h=0.5,shrink=0.5);
    translate([8.0,0,0]) lcbm_letter_tile("g",letter_h=-0.5,shrink=0.5,size=[2,3,1],valign="bottom");
}
