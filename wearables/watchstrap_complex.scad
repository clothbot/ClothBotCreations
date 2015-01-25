// Watch Strap Modules
// Measurements taken from Kickstarter Pebble Watch
// Curved variant

use <../utilities/circular.scad>;

test_module="test watchstrap_link";
//test_module="test watchstrap_adjustment_band";
//test_module="test watchstrap_buckle_band";
//test_module="test watchstrap_free_loop";
//test_module="test plated";
test_module="test shapeways";

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

module watchstrap_link( link_start_pt=[0,0], link_end_pt=[adjustment_band_hole_spacing/sqrt(2),adjustment_band_hole_spacing/sqrt(2)]
    , w=adjustment_band_w
    , th=adjustment_band_th
    , hole_l=adjustment_band_hole_l
    , hole_w=adjustment_band_hole_w
    , hole_bevel=global_hole_bevel
    , hole_grow=global_hole_grow
    , min_wall_th=global_min_wall_th
    , text=""
    , debug=global_debug
    , invert=false
    , min_clearance=global_min_clearance
    , fill_hole=false
) {
    link_mid_pt=link_start_pt+(link_end_pt-link_start_pt)/2;
    link_l=norm(link_end_pt-link_start_pt);
    link_dir=(link_l>0.0)?(link_end_pt-link_start_pt)/link_l:[0,1];
    link_angle=atan2(link_dir[1],link_dir[0]);
    if(debug) {
        echo("watchstrap_link:");
        echo(str("    link_start_pt = ",link_start_pt));
        echo(str("    link_end_pt = ",link_end_pt));
        echo(str("    w = ",w));
        echo(str("    th = ",th));
        echo(str("    hole_l = ",hole_l));
        echo(str("    hole_w = ",hole_w));
        echo(str("    hole_bevel = ",hole_bevel));
        echo(str("    hole_grow = ",hole_grow));
        echo(str("    min_wall_th = ",min_wall_th));
        echo(str("  Calculated:"));
        echo(str("    link_mid_pt = ",link_mid_pt));
        echo(str("    link_l = ",link_l));
        echo(str("    link_dir = ",link_dir));
        echo(str("    link_angle = ",link_angle));
    }
    translate(link_mid_pt) rotate([0,(invert)?180:0,link_angle]) {
        translate([0,0,-w/2+2*min_wall_th+min_clearance]) difference() {
            hull() {
                translate([-link_l/2,0]) {
                    cylinder(r1=th/2+min_clearance+min_wall_th-hole_bevel,r2=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                    translate([0,0,2*min_wall_th-hole_bevel]) 
                        cylinder(r2=th/2+min_clearance+min_wall_th-hole_bevel,r1=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                }
                translate([0,0]) {
                    cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,2*min_wall_th-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                }
            }
            if(!fill_hole) translate([-link_l/2,0,-min_clearance]) {
                cylinder(r=th/2+min_clearance,h=2*min_wall_th+2*min_clearance,center=false,$fn=16);
            }
        }
        translate([0,0,-w/2+2*min_wall_th+min_clearance]) {
            translate([link_l/2,0]) hull() {
                translate([0,0,-2*min_wall_th-min_clearance]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                translate([0,0,4*min_wall_th+min_clearance-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
            }
            translate([link_l/2,0,-2*min_wall_th-min_clearance]) hull() {
                scale([1,0.5,1]) cylinder(r1=th/2+min_clearance+min_wall_th-hole_bevel,r2=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                translate([0,0,2*min_wall_th-hole_bevel]) 
                    scale([1,0.5,1]) cylinder(r2=th/2+min_clearance+min_wall_th-hole_bevel,r1=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                translate([0,0,2*min_wall_th+min_clearance-hole_bevel])
                    cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
            }
            translate([0,0,2*min_wall_th+min_clearance]) hull() {
                translate([0,0,link_l/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                translate([0,0,2*min_wall_th-hole_bevel+link_l/2]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                translate([link_l/2,0]) {
                    cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,2*min_wall_th-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                }
            }
            hull() {
                cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                translate([0,0,4*min_wall_th+min_clearance-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
            }
        }
        translate([0,0,w/2-2*min_wall_th-min_clearance]) rotate([180,0,0]) difference() {
            hull() {
                translate([-link_l/2,0]) {
                    cylinder(r1=th/2+min_clearance+min_wall_th-hole_bevel,r2=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                    translate([0,0,2*min_wall_th-hole_bevel]) 
                        cylinder(r2=th/2+min_clearance+min_wall_th-hole_bevel,r1=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                }
                translate([0,0]) {
                    cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,2*min_wall_th-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                }
            }
            if(!fill_hole) translate([-link_l/2,0,-min_clearance]) {
                cylinder(r=th/2+min_clearance,h=2*min_wall_th+2*min_clearance,center=false,$fn=16);
            }
        }
        translate([0,0,w/2-2*min_wall_th-min_clearance]) rotate([180,0,0]) {
            translate([link_l/2,0]) hull() {
                translate([0,0,-2*min_wall_th-min_clearance])cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                translate([0,0,4*min_wall_th+min_clearance-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
            }
            translate([link_l/2,0,-2*min_wall_th-min_clearance]) hull() {
                scale([1,0.5,1]) cylinder(r1=th/2+min_clearance+min_wall_th-hole_bevel,r2=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                translate([0,0,2*min_wall_th-hole_bevel]) 
                    scale([1,0.5,1]) cylinder(r2=th/2+min_clearance+min_wall_th-hole_bevel,r1=th/2+min_clearance+min_wall_th,h=hole_bevel,$fn=16,center=false);
                translate([0,0,2*min_wall_th+min_clearance-hole_bevel])
                    cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
            }
            translate([0,0,2*min_wall_th+min_clearance]) hull() {
                translate([0,0,link_l/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                translate([0,0,2*min_wall_th-hole_bevel+link_l/2]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                translate([link_l/2,0]) {
                    cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,2*min_wall_th-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                }
            }
            hull() {
                cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                translate([0,0,4*min_wall_th+min_clearance-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
            }
        }
        hull() {
            translate([0,-(th-min_wall_th)/2,0]) cube([hole_l+4*min_wall_th,min_wall_th,hole_l+2*min_wall_th],center=true);
            translate([0,0,-w/2+4*min_wall_th+2*min_clearance]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
            translate([0,0,w/2-4*min_wall_th-2*min_clearance-hole_bevel]) cylinder(r2=th/2-hole_bevel,r1=th/2,h=hole_bevel,$fn=8,center=false);
        }
        if(text!="") translate([0,-th/2,0]) rotate([90,0,0]) minkowski() {
            render() linear_extrude(height=min_wall_th/2,center=true) {
                text(text=text,size=link_l/2,halign="center",valign="center");
            }
            cylinder(r1=min_wall_th/2,r2=0,h=min_wall_th/2,$fn=8,center=true);
        }
    }
}

if(test_module=="test watchstrap_link") {
    echo("Testing watchstrap_link");
    watchstrap_link(text="A");
}

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
    ,word="CBD"
) {
    lead_in_l=hole_offset%hole_spacing;
    pre_offset_hole_count=(hole_offset-lead_in_l)/hole_spacing;
    post_offset_hole_count=floor((l-w/2-hole_offset)/hole_spacing);
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
        echo(str(" Calculated:"));
        echo(str("                lead_in_l = ",lead_in_l));
        echo(str("    pre_offset_hole_count = ",pre_offset_hole_count));
        echo(str("   post_offset_hole_count = ",post_offset_hole_count));
    }
    difference() {
        union() {
            color([1,0,0]) hull() {
                translate(circle_point_at_length(bend_r,pin_d/2+pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] )) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=(pin_d+2*pin_wall_th+hole_grow)/2,r2=(pin_d+2*pin_wall_th+hole_grow)/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=(pin_d+2*pin_wall_th+hole_grow)/2-hole_bevel,r2=(pin_d+2*pin_wall_th+hole_grow)/2,h=hole_bevel,$fn=8,center=false);
                }
                translate( circle_point_at_length(bend_r,lead_in_l+band_offset,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
            }
            color([1,0.5,0]) hull() {
                translate( circle_point_at_length(bend_r,lead_in_l+band_offset,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
                translate( circle_point_at_length(bend_r,lead_in_l+band_offset+hole_spacing/2,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
            }
            color([0,1,0]) for(i=[1:pre_offset_hole_count-1]) {
                watchstrap_link( link_start_pt=circle_point_at_length(bend_r,(i-0.5)*hole_spacing+band_offset+lead_in_l,rotate=-90,offset=[0,bend_r] )
                    , link_end_pt=circle_point_at_length(bend_r,(i+0.5)*hole_spacing+band_offset+lead_in_l,rotate=-90,offset=[0,bend_r] )
                    ,w=w,th=th,hole_l=hole_l,hole_w=hole_w,hole_bevel=hole_bevel,hole_grow=hole_grow,min_wall_th=min_wall_th
                    , debug=debug,text=word[i-1],fill_hole=(i==1));
            }
            color([0,0,1]) for(i=[0:hole_count-1]) {
                watchstrap_link( link_start_pt=circle_point_at_length(bend_r,hole_offset+(i-0.5)*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] )
                    , link_end_pt=circle_point_at_length(bend_r,hole_offset+(i+0.5)*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] )
                    ,w=w,th=th,hole_l=hole_l,hole_w=hole_w,hole_bevel=hole_bevel,hole_grow=hole_grow,min_wall_th=min_wall_th, debug=debug);
            }
            if(post_offset_hole_count>=hole_count) color([1,0,1]) for(i=[0:post_offset_hole_count-hole_count]) {
                watchstrap_link( link_start_pt=circle_point_at_length(bend_r,hole_offset+(hole_count+i-0.5)*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] )
                    , link_end_pt=circle_point_at_length(bend_r,hole_offset+(hole_count+i+0.5)*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] )
                    ,w=w,th=th,hole_l=hole_l,hole_w=hole_w,hole_bevel=hole_bevel,hole_grow=hole_grow,min_wall_th=min_wall_th, debug=debug);
            }
            strap_end=circle_point_at_length(bend_r,l-w/2+band_offset,rotate=-90,offset=[0,bend_r] );
            color([1,1,0]) hull() {
                translate( circle_point_at_length(bend_r,hole_offset+(post_offset_hole_count+0.5)*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
                translate( strap_end ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
            }
            strap_end_for_angle=circle_point_at_length(bend_r,l-w/2+band_offset,rotate=-90,offset=[0,0] );
            strap_end_angle=(bend_r==0.0)?0.0:atan2(strap_end_for_angle[1],strap_end_for_angle[0]);
            translate( strap_end ) {
                rotate([0,0,strap_end_angle]) rotate([0,90,0]) # intersection() {
                    render() hull() {
                        translate([0,0,th/2-hole_bevel]) cylinder(r1=w/2,r2=w/2-hole_bevel,h=hole_bevel,center=false,$fn=32);
                        translate([0,0,-th/2]) cylinder(r2=w/2,r1=w/2-hole_bevel,h=hole_bevel,center=false,$fn=32);
                    }
                    translate([0,w/2,0]) cube([w,w,th],center=true);
                }
            }
        }
        for(i=[0:hole_count-1]) {
            hole_position=circle_point_at_length(bend_r,hole_offset+i*hole_spacing+band_offset,rotate=-90,offset=[0,bend_r] );
            hole_position_for_angle=circle_point_at_length(bend_r,hole_offset+i*hole_spacing+band_offset,rotate=-90,offset=[0,0] );
            hole_angle=(bend_r==0.0)?0.0:atan2(hole_position_for_angle[1],hole_position_for_angle[0]);
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
            anchor_hole=circle_point_at_length(bend_r,band_offset+w/2-hole_spacing/2,rotate=-90,offset=[0,bend_r]);
            anchor_hole_for_angle=circle_point_at_length(bend_r,band_offset+w/2-hole_spacing/2,rotate=-90,offset=[0,0]);
            anchor_hole_angle=(bend_r==0.0)?0.0:atan2(anchor_hole_for_angle[1],anchor_hole_for_angle[0]);
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
    watchstrap_adjustment_band(bend_r=0,band_offset=0.0);
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
    ,hole_spacing=adjustment_band_hole_spacing
    ,hole_l=adjustment_band_hole_l
    ,hole_w=adjustment_band_hole_w
    ,overhang_angle=global_overhang_angle
    ,min_wall_th=global_min_wall_th
    ,debug=global_debug
    ,anchor_hole_d=buckle_band_w/4
    ,word="Pebble"
) {
    band_center=l/2;
    lead_in_l=band_center%(hole_spacing/2);
    holes_count=(l-2*lead_in_l)/hole_spacing;
    holes_to_center=(band_center-lead_in_l)/hole_spacing;
    if(debug) {
        echo("watchstrap_buckle_band:");
        echo(str(" l = ",l));
        echo(str(" w = ",w));
        echo(str(" th = ",th));
        echo(str(" pin_d = ",pin_d));
        echo(str(" pin_wall_th = ",pin_wall_th));
        echo(str(" tongue_hole_w = ",tongue_hole_w));
        echo(str(" tongue_hole_notch = ",tongue_hole_notch));
        echo(str(" Calculated:"));
        echo(str("    band_center = ",band_center));
        echo(str("    lead_in_l = ",lead_in_l));
        echo(str("    holes_to_center = ",holes_to_center));
        echo(str("    holes_count = ",holes_count));
    }
    difference() {
        union() {
            color([1,0,0]) hull() {
                translate(circle_point_at_length(bend_r,pin_d/2+pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] )) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=(pin_d+2*pin_wall_th+hole_grow)/2,r2=(pin_d+2*pin_wall_th+hole_grow)/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=(pin_d+2*pin_wall_th+hole_grow)/2-hole_bevel,r2=(pin_d+2*pin_wall_th+hole_grow)/2,h=hole_bevel,$fn=8,center=false);
                }
                translate( circle_point_at_length(bend_r,lead_in_l+band_offset+hole_spacing/2,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
            }
            color([0,1,0]) for(i=[1:holes_count-1]) {
                letter_pos=len(word)-i;
                letter=(anchor_hole_d>0.0)?
                    (i==1)?"":word[letter_pos+1]
                    :word[letter_pos];
                watchstrap_link( link_start_pt=circle_point_at_length(bend_r,(i-0.5)*hole_spacing+band_offset+lead_in_l,rotate=-90,offset=[0,bend_r] )
                    , link_end_pt=circle_point_at_length(bend_r,(i+0.5)*hole_spacing+band_offset+lead_in_l,rotate=-90,offset=[0,bend_r] )
                    ,w=w,th=th,hole_l=hole_l,hole_w=hole_w,hole_bevel=hole_bevel,hole_grow=hole_grow,min_wall_th=min_wall_th, debug=false
                    ,text=letter
                    ,invert=true
                    ,fill_hole=(i==holes_count-1));
            }
            color([1,1,0]) hull() {
                translate( circle_point_at_length(bend_r,l-lead_in_l-hole_spacing/2+band_offset,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
                translate( circle_point_at_length(bend_r,l-lead_in_l-tongue_pin_d/2-tongue_pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
            }
            color([1,0,1]) hull() {
                translate( circle_point_at_length(bend_r,l-lead_in_l-tongue_pin_d/2-tongue_pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=th/2,r2=th/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=th/2-hole_bevel,r2=th/2,h=hole_bevel,$fn=8,center=false);
                }
                translate( circle_point_at_length(bend_r,l-tongue_pin_d/2-tongue_pin_wall_th+band_offset,rotate=-90,offset=[0,bend_r] ) ) {
                    translate([0,0,w/2-hole_bevel]) cylinder(r1=(tongue_pin_d+2*tongue_pin_wall_th+2*hole_grow)/2,r2=(tongue_pin_d+2*tongue_pin_wall_th+2*hole_grow)/2-hole_bevel,h=hole_bevel,$fn=8,center=false);
                    translate([0,0,-w/2]) cylinder(r1=(tongue_pin_d+2*tongue_pin_wall_th+2*hole_grow)/2-hole_bevel,r2=(tongue_pin_d+2*tongue_pin_wall_th+2*hole_grow)/2,h=hole_bevel,$fn=8,center=false);
                }
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
        strap_end_angle=(bend_r==0)?0.0:atan2(strap_end_for_angle[1],strap_end_for_angle[0]);
        translate(strap_end) rotate([0,0,strap_end_angle+90]) rotate([90,0,0]) # hull() {
            cube([tongue_hole_notch+hole_grow,tongue_hole_w+hole_grow,tongue_pin_d+2*tongue_pin_wall_th+4*hole_grow],center=true);
            if(overhang_angle>0) {
                translate([tongue_hole_notch/2+th/2,0,0]) cube([th,tongue_hole_w+2*hole_grow+2*tan(overhang_angle)*tongue_hole_w,tongue_pin_d+2*tongue_pin_wall_th+4*hole_grow],center=true);
            }
        }
        # if(anchor_hole_d>0.0) render() {
            anchor_hole=circle_point_at_length(bend_r,lead_in_l+band_offset+hole_spacing,rotate=-90,offset=[0,bend_r]);
            anchor_hole_for_angle=circle_point_at_length(bend_r,lead_in_l+band_offset+hole_spacing,rotate=-90,offset=[0,0]);
            anchor_hole_angle=(bend_r==0.0)?0.0:atan2(anchor_hole_for_angle[1],anchor_hole_for_angle[0]);
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
    watchstrap_buckle_band(bend_r=0,anchor_hole_d=0,word="ClothBot",band_offset=0.0);
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
    //anchor_hole_pos=circle_point_at_length(adjustment_band_bend_r,adjustment_band_w/2,rotate=-90,offset=[0,adjustment_band_bend_r]);
    anchor_hole_pos=[0,0];
    adjustment_band_anchor_hole_offset=adjustment_band_w/2-adjustment_band_hole_spacing/2;
    buckle_band_center=buckle_band_l/2;
    buckle_band_lead_in_l=buckle_band_center%(adjustment_band_hole_spacing/2);
    //buckle_band_lead_in_l=adjustment_band_hole_offset%adjustment_band_hole_spacing;
    buckle_band_anchor_hole_offset=buckle_band_lead_in_l+adjustment_band_hole_spacing;
    echo("Testing plating for Shapeways printing");
    translate([global_min_clearance,0,adjustment_band_w/2]) watchstrap_adjustment_band(band_offset=-adjustment_band_anchor_hole_offset);
    translate([global_min_clearance,free_loop_inner_h,buckle_band_w/2]) watchstrap_buckle_band(band_offset=-buckle_band_anchor_hole_offset,overhang_angle=0);
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
