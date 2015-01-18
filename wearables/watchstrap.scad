// Watch Strap Modules
// Measurements taken from Kickstarter Pebble Watch

use <../utilities/circular.scad>;

test_module="test watchstrap_adjustment_band";
test_module="test watchstrap_buckle_band";
test_module="test watchstrap_free_loop";
test_module="test plated";

global_min_wall_th=0.8;
global_min_clearance=0.5;
global_hole_grow=0.05;
global_hole_bevel=0.1;
global_overhang_angle=30.0;
global_debug=true;

adjustment_band_l=128.0;
adjustment_band_w=22.0;
adjustment_band_th=2.5;
adjustment_band_pin_d=1.8;
adjustment_band_pin_wall_th=1.0;
adjustment_band_hole_l=4.2;
adjustment_band_hole_w=3.6;
adjustment_band_hole_offset=37.10+adjustment_band_hole_l/2;
adjustment_band_hole_spacing=12.35-adjustment_band_hole_l;
adjustment_band_hole_count=9;

module watchstrap_adjustment_band(l=adjustment_band_l
    ,w=adjustment_band_w
    ,th=adjustment_band_th
    ,pin_d=adjustment_band_pin_d
    ,pin_wall_th=adjustment_band_pin_wall_th
    ,hole_l=adjustment_band_hole_l
    ,hole_w=adjustment_band_hole_w
    ,hole_offset=adjustment_band_hole_offset
    ,hole_spacing=adjustment_band_hole_spacing
    ,hole_count=adjustment_band_hole_count
    ,hole_bevel=global_hole_bevel
    ,hole_grow=global_hole_grow
    ,min_wall_th=global_min_wall_th
    ,debug=global_debug
) {
    if(debug) {
        echo("watchstrap_adjustment_band:");
        echo(str("            l = ",l));
        echo(str("            w = ",w));
        echo(str("           th = ",th));
        echo(str("        pin_d = ",pin_d));
        echo(str("  pin_wall_th = ",pin_wall_th));
        echo(str("       hole_l = ",hole_l));
        echo(str("       hole_w = ",hole_w));
        echo(str("  hole_offset = ",hole_offset));
        echo(str(" hole_spacing = ",hole_spacing));
        echo(str("   hole_count = ",hole_count));
        echo(str("   hole_bevel = ",hole_bevel));
        echo(str("    hole_grow = ",hole_grow));
        echo(str("  min_wall_th = ",min_wall_th));
    }
    difference() {
        union() {
            translate([pin_wall_th+pin_d/2,0,pin_wall_th+pin_d/2+hole_grow]) rotate([-90,0,0]) hull() {
                cylinder(d=2*pin_wall_th+pin_d+2*hole_grow,h=w,$fn=16,center=false);
                # cube([w/4,pin_d/2+pin_wall_th+hole_grow,w],center=false);
            }
            hull() {
                translate([pin_d/2+pin_wall_th,0]) cube([th,w,th],center=false);
                translate([l-w/2,w/2,0]) cylinder(d=w,h=th,$fn=32,center=false);
            }
        }
        translate([pin_wall_th+pin_d/2,0,pin_wall_th+pin_d/2+hole_grow]) rotate([-90,0,0]) {
            minkowski() {
                cylinder(d=pin_d,h=w,$fn=16,center=false);
                sphere(r=hole_grow/2);
            }
            cylinder(r1=pin_d/2+2*hole_bevel,r2=pin_d/2,h=2*hole_bevel,center=true,$fn=16);
            translate([0,0,w]) cylinder(r2=pin_d/2+2*hole_bevel,r1=pin_d/2,h=2*hole_bevel,center=true,$fn=16);
        }
        translate([hole_offset,w/2,0]) for(i=[0:hole_count-1]) minkowski() {
            translate([i*hole_spacing,0,th/2]) cube([hole_l,hole_w,2*th],center=true);
            sphere(r=hole_grow/2);
        }
    }
}

if(test_module=="test watchstrap_adjustment_band") {
    echo("Testing watchstrap_adjustment_band");
    watchstrap_adjustment_band();
}

buckle_band_l=74.0;
buckle_band_w=adjustment_band_w;
buckle_band_th=adjustment_band_th;
buckle_band_pin_d=adjustment_band_pin_d;
buckle_band_pin_wall_th=adjustment_band_pin_wall_th;
buckle_tongue_hole_w=3.2;
buckle_tongue_hole_notch=4.5;
buckle_tongue_pin_d=adjustment_band_pin_d;
buckle_tongue_pin_wall_th=1.4;

module watchstrap_buckle_band(l=buckle_band_l
    ,w=buckle_band_w
    ,th=buckle_band_th
    ,pin_d=buckle_band_pin_d
    ,pin_wall_th=buckle_band_pin_wall_th
    ,tongue_hole_w=buckle_tongue_hole_w
    ,tongue_hole_notch=buckle_tongue_hole_notch
    ,tongue_pin_d=buckle_tongue_pin_d
    ,tongue_pin_wall_th=buckle_tongue_pin_wall_th
    ,hole_bevel=global_hole_bevel
    ,hole_grow=global_hole_grow
    ,overhang_angle=global_overhang_angle
    ,min_wall_th=global_min_wall_th
    ,debug=global_debug
) {
    if(debug) {
        echo("watchstrap_buckle_band:");
        echo(str(" l = ",l));
        echo(str(" w = ",w));
        echo(str(" th = ",th));
        echo(str(" pin_d = ",pin_d));
        echo(str(" pin_wall_th = ",pin_wall_th));
        echo(str(" tongue_hole_w = ",tongue_hole_w));
        echo(str(" tongue_hole_notch = ",tongue_hole_notch));
        
    }
    difference() {
        union() {
            translate([pin_wall_th+pin_d/2,0,pin_wall_th+pin_d/2+hole_grow]) rotate([-90,0,0]) hull() {
                cylinder(d=2*pin_wall_th+pin_d+2*hole_grow,h=w,$fn=16,center=false);
                # cube([w/4,pin_d/2+pin_wall_th+hole_grow,w],center=false);
            }
            translate([pin_d/2+pin_wall_th,0]) cube([l-pin_d/2-pin_wall_th-tongue_pin_d/2-tongue_pin_wall_th,w,th],center=false);
            translate([l-tongue_pin_d/2-tongue_pin_wall_th-hole_grow,0,th/2]) hull() {
                rotate([-90,0,0]) cylinder(d=tongue_pin_d+2*tongue_pin_wall_th+2*hole_grow,h=w,$fn=16,center=false);
                #translate([-tongue_hole_notch+th,w/2,0]) cube([th/2,w,th],center=true);
            }
        }
        translate([pin_wall_th+pin_d/2,0,pin_wall_th+pin_d/2+hole_grow]) rotate([-90,0,0]) {
            minkowski() {
                cylinder(d=pin_d,h=w,$fn=16,center=false);
                sphere(r=hole_grow/2);
            }
            cylinder(r1=pin_d/2+2*hole_bevel,r2=pin_d/2,h=2*hole_bevel,center=true,$fn=16);
            translate([0,0,w]) cylinder(r2=pin_d/2+2*hole_bevel,r1=pin_d/2,h=2*hole_bevel,center=true,$fn=16);
        }
        translate([l-tongue_pin_d/2-tongue_pin_wall_th-hole_grow,0,th/2]) rotate([-90,0,0]) {
            minkowski() {
                cylinder(d=tongue_pin_d,h=w,$fn=16,center=false);
                sphere(r=hole_grow/2);
            }
            cylinder(r1=tongue_pin_d/2+2*hole_bevel,r2=tongue_pin_d/2,h=2*hole_bevel,center=true,$fn=16);
            translate([0,0,w]) cylinder(r2=tongue_pin_d/2+2*hole_bevel,r1=tongue_pin_d/2,h=2*hole_bevel,center=true,$fn=16);
        }
        # translate([l-tongue_hole_notch/2,w/2,th/2]) hull() {
            cube([tongue_hole_notch+hole_grow,tongue_hole_w+hole_grow,tongue_pin_d+2*tongue_pin_wall_th+4*hole_grow],center=true);
            if(overhang_angle>0) {
                translate([tongue_hole_notch/2+th/2,0,0]) cube([th,tongue_hole_w+2*hole_grow+2*tan(overhang_angle)*tongue_hole_w,tongue_pin_d+2*tongue_pin_wall_th+4*hole_grow],center=true);
            }
        }
    }
}

if(test_module=="test watchstrap_buckle_band") {
    echo("Testing watchstrap_buckle_band");
    watchstrap_buckle_band();
}

free_loop_inner_h=5.5;
free_loop_inner_w=22.5;
free_loop_l=10.3;
free_loop_surface_wall_th=1.60;
free_loop_edge_wall_th=2.0;

module watchstrap_free_loop(inner_h=free_loop_inner_h
    ,inner_w=free_loop_inner_w
    ,l=free_loop_l
    ,surface_wall_th=free_loop_surface_wall_th
    ,edge_wall_th=free_loop_edge_wall_th
    ,hole_bevel=global_hole_bevel
    ,hole_grow=global_hole_grow
    ,min_wall_th=global_min_wall_th
) {
    difference() {
        hull() {
            translate([inner_h/2,inner_w/2,0]) scale([surface_wall_th+hole_grow,edge_wall_th+hole_grow,1.0]) cylinder(r=1.0,h=l,$fn=16,center=false);
            translate([inner_h/2,-inner_w/2,0]) scale([surface_wall_th+hole_grow,edge_wall_th+hole_grow,1.0]) cylinder(r=1.0,h=l,$fn=16,center=false);
            translate([-inner_h/2,-inner_w/2,0]) scale([surface_wall_th+hole_grow,edge_wall_th+hole_grow,1.0]) cylinder(r=1.0,h=l,$fn=16,center=false);
            translate([-inner_h/2,inner_w/2,0]) scale([surface_wall_th+hole_grow,edge_wall_th+hole_grow,1.0]) cylinder(r=1.0,h=l,$fn=16,center=false);
        }
        minkowski() {
            translate([0,0,l/2]) cube([inner_h,inner_w,l],center=true);
            sphere(r=hole_grow,$fn=8);
        }
    }
}

if(test_module=="test watchstrap_free_loop") {
    echo("Testing watchstrap_free_loop");
    watchstrap_free_loop();
}

if(test_module=="test plated") {
    echo("Testing plating for printing");
    translate([global_min_clearance,global_min_clearance,adjustment_band_w]) rotate([-90,0,0]) watchstrap_adjustment_band();
    translate([global_min_clearance,-global_min_clearance-(buckle_tongue_pin_d/2+buckle_tongue_pin_wall_th/2),0]) rotate([90,0,0]) watchstrap_buckle_band();
    translate([-global_min_clearance-(free_loop_inner_h/2+free_loop_surface_wall_th),0,0]) watchstrap_free_loop();
}
