// Watch Strap Modules
// Measurements taken from Kickstarter Pebble Watch
// Curved variant

use <../utilities/circular.scad>;

test_module="test watchstrap_adjustment_band";
test_module="test watchstrap_buckle_band";
test_module="test watchstrap_free_loop";
test_module="test plated";
//test_module="test shapeways";

global_min_wall_th=0.8;
global_min_clearance=0.5;
global_hole_grow=0.05;
global_hole_bevel=0.2;
global_overhang_angle=30.0;
global_debug=true;
global_emboss_delta=0.5;

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

buckle_band_l=74.0;
buckle_band_w=adjustment_band_w;
buckle_band_th=adjustment_band_th;
buckle_band_pin_d=adjustment_band_pin_d;
buckle_band_pin_wall_th=adjustment_band_pin_wall_th;
buckle_tongue_hole_w=3.2;
buckle_tongue_hole_notch=4.5;
buckle_tongue_pin_d=adjustment_band_pin_d;
buckle_tongue_pin_wall_th=1.4;

free_loop_inner_h=5.5;
free_loop_inner_w=22.5;
free_loop_l=10.3;
free_loop_surface_wall_th=1.60;
free_loop_edge_wall_th=2.0;

watch_adjustment_to_band_spacing=44.2+adjustment_band_pin_d/2+buckle_band_pin_d/2;
adjustment_band_bend_r=(adjustment_band_l+buckle_band_l+watch_adjustment_to_band_spacing)/(2*pi());
buckle_band_bend_r=adjustment_band_bend_r-free_loop_inner_h;

module watchstrap_adjustment_band(l=adjustment_band_l
    ,bend_r=adjustment_band_bend_r
    ,band_offset=watch_adjustment_to_band_spacing/2
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
    ,anchor_hole_d=adjustment_band_w/4
) {
    if(debug) {
        echo("watchstrap_adjustment_band:");
        echo(str("            l = ",l));
        echo(str("       bend_r = ",bend_r));
        echo(str("  band_offset = ",band_offset));
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
            hull() {
                translate(circle_point_at_length(bend_r,pin_d/2+pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] )) {
                    cylinder(d=pin_d+2*pin_wall_th+hole_grow,h=w,$fn=16,center=true);
                }
                translate( circle_point_at_length(bend_r,2*hole_offset/8+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
            }
            for(i=[3:8]) {
                hull() {
                    translate( circle_point_at_length(bend_r,(i-1)*hole_offset/8+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
                    translate( circle_point_at_length(bend_r,i*hole_offset/8+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
                }
            }
            for(i=[1:2*hole_count]) {
                hull() {
                    translate( circle_point_at_length(bend_r,hole_offset+(i-1)*hole_spacing/2+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
                    translate( circle_point_at_length(bend_r,hole_offset+i*hole_spacing/2+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
                }
            }
            strap_end=circle_point_at_length(bend_r,l-w/2+band_offset,rotate=-90,offset=[0,bend_r] );
            hull() {
                translate( circle_point_at_length(bend_r,hole_offset+hole_count*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] ) )
                    cylinder(d=th,h=w,center=true,$fn=8);
                translate( strap_end )
                    cylinder(d=th,h=w,center=true,$fn=8);
            }
            strap_end_for_angle=circle_point_at_length(bend_r,l-w/2+band_offset,rotate=-90,offset=[0,0] );
            strap_end_angle=atan2(strap_end_for_angle[1],strap_end_for_angle[0]);
            translate( strap_end ) {
                rotate([0,0,strap_end_angle]) rotate([0,90,0]) # intersection() {
                    cylinder(d=w,h=th,$fn=32,center=true);
                    translate([0,w/2,0]) cube([w,w,th],center=true);
                }
            }
        }
        for(i=[0:hole_count-1]) {
            hole_position=circle_point_at_length(bend_r,hole_offset+i*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] );
            hole_position_for_angle=circle_point_at_length(bend_r,hole_offset+i*hole_spacing+band_offset,rotate=-90,offset=[0,0] );
            hole_angle=atan2(hole_position_for_angle[1],hole_position_for_angle[0]);
            translate( hole_position ) {
                rotate([0,0,hole_angle]) # cube([3*th,hole_l+hole_grow,hole_w+hole_grow],center=true);
            }
        }
        translate(circle_point_at_length(bend_r,pin_d/2+pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] )) union() {
            cylinder(r=pin_d/2+hole_grow/2,h=w,$fn=16,center=true);
            translate([0,0,-w/2]) cylinder(r1=pin_d/2+2*hole_bevel+hole_grow/2,r2=pin_d/2+hole_grow/2,h=2*hole_bevel,center=true,$fn=16);
            translate([0,0,w/2]) cylinder(r2=pin_d/2+2*hole_bevel+hole_grow/2,r1=pin_d/2+hole_grow/2,h=2*hole_bevel,center=true,$fn=16);
        }
        # if(anchor_hole_d>0.0) render() {
            anchor_hole=circle_point_at_length(bend_r,band_offset+w/2,rotate=-90,offset=[0,bend_r]);
            anchor_hole_for_angle=circle_point_at_length(bend_r,band_offset+w/2,rotate=-90,offset=[0,0]);
            anchor_hole_angle=atan2(anchor_hole_for_angle[1],anchor_hole_for_angle[0]);
            translate( anchor_hole ) {
                rotate([0,0,anchor_hole_angle]) rotate([0,90,0]) intersection() {
                    union() {
                        cylinder(d=anchor_hole_d,h=3*th,$fn=16,center=true);
                        rotate([0,0,-45]) translate([0,0,-3*th/2]) cube([anchor_hole_d/2,anchor_hole_d/2,3*th],center=false);
                        rotate([0,0,180-45]) translate([0,0,-3*th/2]) cube([anchor_hole_d/2,anchor_hole_d/2,3*th],center=false);
                    }
                    cube([anchor_hole_d,anchor_hole_d,3*th],center=true);
                }
            }
        }
    }
}

if(test_module=="test watchstrap_adjustment_band") {
    echo("Testing watchstrap_adjustment_band");
    watchstrap_adjustment_band();
}


module watchstrap_buckle_band(l=buckle_band_l
    ,bend_r=buckle_band_bend_r
    ,band_offset=watch_adjustment_to_band_spacing/2
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
    ,anchor_hole_d=buckle_band_w/4
) mirror([1,0]) {
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
            hull() {
                translate(circle_point_at_length(bend_r,pin_d/2+pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] )) {
                    cylinder(d=pin_d+2*pin_wall_th+hole_grow,h=w,$fn=16,center=true);
                }
                translate( circle_point_at_length(bend_r,2*l/16+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
            }
            for(i=[3:15]) {
                hull() {
                    translate( circle_point_at_length(bend_r,(i-1)*l/16+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
                    translate( circle_point_at_length(bend_r,i*l/16+band_offset,rotate=-90,offset=[0,bend_r] ) )
                        cylinder(d=th,h=w,center=true,$fn=8);
                }
            }
            hull() {
                translate( circle_point_at_length(bend_r,15*l/16+band_offset,rotate=-90,offset=[0,bend_r] ) )
                    cylinder(d=th,h=w,center=true,$fn=8);
                translate( circle_point_at_length(bend_r,l-tongue_pin_d/2-tongue_pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] ) )
                    cylinder(d=tongue_pin_d+2*tongue_pin_wall_th+2*hole_grow,h=w,$fn=16,center=true);
            }
        }
        translate(circle_point_at_length(bend_r,pin_d/2+pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] )) union() {
            cylinder(r=pin_d/2+hole_grow/2,h=w,$fn=16,center=true);
            translate([0,0,-w/2]) cylinder(r1=pin_d/2+2*hole_bevel+hole_grow/2,r2=pin_d/2+hole_grow/2,h=2*hole_bevel,center=true,$fn=16);
            translate([0,0,w/2]) cylinder(r2=pin_d/2+2*hole_bevel+hole_grow/2,r1=pin_d/2+hole_grow/2,h=2*hole_bevel,center=true,$fn=16);
        }
        translate( circle_point_at_length(bend_r,l-tongue_pin_d/2-tongue_pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] ) ) union() {
            cylinder(r=pin_d/2+hole_grow/2,h=w,$fn=16,center=true);
            translate([0,0,-w/2]) cylinder(r1=pin_d/2+2*hole_bevel+hole_grow/2,r2=pin_d/2+hole_grow/2,h=2*hole_bevel,center=true,$fn=16);
            translate([0,0,w/2]) cylinder(r2=pin_d/2+2*hole_bevel+hole_grow/2,r1=pin_d/2+hole_grow/2,h=2*hole_bevel,center=true,$fn=16);
        }
        strap_end=circle_point_at_length(bend_r,l-tongue_hole_notch/2+band_offset,rotate=-90,offset=[0,bend_r] );
        strap_end_for_angle=circle_point_at_length(bend_r,l-tongue_hole_notch/2+band_offset,rotate=-90,offset=[0,0] );
        strap_end_angle=atan2(strap_end_for_angle[1],strap_end_for_angle[0]);
        translate(strap_end) rotate([0,0,strap_end_angle+90]) rotate([90,0,0]) # hull() {
            cube([tongue_hole_notch+hole_grow,tongue_hole_w+hole_grow,tongue_pin_d+2*tongue_pin_wall_th+4*hole_grow],center=true);
            if(overhang_angle>0) {
                translate([tongue_hole_notch/2+th/2,0,0]) cube([th,tongue_hole_w+2*hole_grow+2*tan(overhang_angle)*tongue_hole_w,tongue_pin_d+2*tongue_pin_wall_th+4*hole_grow],center=true);
            }
        }
        # if(anchor_hole_d>0.0) render() {
            anchor_hole=circle_point_at_length(bend_r,band_offset+w/2,rotate=-90,offset=[0,bend_r]);
            anchor_hole_for_angle=circle_point_at_length(bend_r,band_offset+w/2,rotate=-90,offset=[0,0]);
            anchor_hole_angle=atan2(anchor_hole_for_angle[1],anchor_hole_for_angle[0]);
            translate( anchor_hole ) {
                rotate([0,0,anchor_hole_angle]) rotate([0,90,0]) intersection() {
                    union() {
                        cylinder(d=anchor_hole_d,h=3*th,$fn=16,center=true);
                        rotate([0,0,-45]) translate([0,0,-3*th/2]) cube([anchor_hole_d/2,anchor_hole_d/2,3*th],center=false);
                        rotate([0,0,180-45]) translate([0,0,-3*th/2]) cube([anchor_hole_d/2,anchor_hole_d/2,3*th],center=false);
                    }
                    cube([anchor_hole_d,anchor_hole_d,3*th],center=true);
                }
            }
        }
    }
}

if(test_module=="test watchstrap_buckle_band") {
    echo("Testing watchstrap_buckle_band");
    watchstrap_buckle_band();
}


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
    spin_offset=$t*(adjustment_band_l+buckle_band_l+watch_adjustment_to_band_spacing);
    echo("Testing plating for printing");
    translate([0*global_min_clearance,0,adjustment_band_w/2]) watchstrap_adjustment_band(anchor_hole_d=0.0,band_offset=spin_offset);
    translate([0*global_min_clearance,adjustment_band_bend_r-buckle_band_bend_r,buckle_band_w/2]) rotate([0,180,0]) watchstrap_buckle_band(anchor_hole_d=0.0,band_offset=-spin_offset);
    translate([free_loop_inner_h/2+free_loop_surface_wall_th,adjustment_band_bend_r,0]) watchstrap_free_loop();
}

if(test_module=="test shapeways") {
    anchor_hole_pos=circle_point_at_length(adjustment_band_bend_r,adjustment_band_w/2,rotate=-90,offset=[0,adjustment_band_bend_r]);
    echo("Testing plating for Shapeways printing");
    translate([global_min_clearance,0,adjustment_band_w/2]) watchstrap_adjustment_band(band_offset=0);
    translate([global_min_clearance,free_loop_inner_h,buckle_band_w/2]) rotate([0,180,0]) watchstrap_buckle_band(band_offset=0,overhang_angle=0);
    translate(anchor_hole_pos) translate([0,2*free_loop_l,free_loop_inner_w/2]) rotate([90,0,0]) watchstrap_free_loop();
    translate(anchor_hole_pos) union() {
        translate([0,-free_loop_inner_h,adjustment_band_w/2]) rotate([0,45,0]) union() {
            cube([free_loop_l,2*global_min_wall_th,2*global_min_wall_th],center=true);
            cube([2*global_min_wall_th,2*global_min_wall_th,free_loop_l],center=true);
        }            
        hull() {
            translate([0,-free_loop_inner_h,adjustment_band_w/2]) cube(2*global_min_wall_th,center=true);
            translate([0,2*free_loop_l+2*global_min_clearance+global_min_wall_th,adjustment_band_w/2]) cube(2*global_min_wall_th,center=true);
        }
        translate([0,2*free_loop_l+2*global_min_clearance+global_min_wall_th,adjustment_band_w/2]) rotate([0,45,0]) union() {
            cube([free_loop_l,2*global_min_wall_th,2*global_min_wall_th],center=true);
            cube([2*global_min_wall_th,2*global_min_wall_th,free_loop_l],center=true);
        }
    }
}
