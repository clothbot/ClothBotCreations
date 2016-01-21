// Replace arms for glasses
// Make: MOREL
// Model: LIGHTEC 6810L
// Parameters: 52[]17  140 GB 205

render_part="glasses_arm_mount_slot_cutout";
render_part="glasses_arm";
//render_part="glasses_arms";
//render_part="glasses_ear";
//render_part="glasses_arm_pair";

min_space=2.0;
layer_th=0.2;
nozzle_d=0.4;
grow_hole_abs=nozzle_d/2;

function quicksort_x(arr) = !(len(arr)>0 && len(arr[0])>1) ? [] : let(
    pivot   = arr[floor(len(arr)/2)][0],
    lesser  = [ for (vec = arr) if (vec[0]  < pivot) vec ],
    equal   = [ for (vec = arr) if (vec[0] == pivot) vec ],
    greater = [ for (vec = arr) if (vec[0]  > pivot) vec ]
        ) concat(
            quicksort_x(lesser), equal, quicksort_x(greater)
    );

function quicksort_y(arr) = !(len(arr)>0 && len(arr[0])>1) ? [] : let(
    pivot   = arr[floor(len(arr)/2)][1],
    lesser  = [ for (vec = arr) if (vec[1]  < pivot) vec ],
    equal   = [ for (vec = arr) if (vec[1] == pivot) vec ],
    greater = [ for (vec = arr) if (vec[1]  > pivot) vec ]
        ) concat(
            quicksort_y(lesser), equal, quicksort_y(greater)
    );

glasses_arm_outline_start_pt=[0,0];
glasses_arm_outline_end_pt=[3.0,10.37];
glasses_arm_outline=[glasses_arm_outline_start_pt
    ,[83.0,0],[80.0,5.0]
    ,[55.86,5.0],[48.81,10.37]
    ,glasses_arm_outline_end_pt];
echo(str("quicksort_x(quicksort_y(glasses_arm_outline)) = ",quicksort_x(quicksort_y(glasses_arm_outline))));
echo(str("quicksort_y(quicksort_x(glasses_arm_outline)) = ",quicksort_y(quicksort_x(glasses_arm_outline))));
glasses_arm_outline_bbox=[
    [ quicksort_x(glasses_arm_outline)[0][0]
        , quicksort_y(glasses_arm_outline)[0][1] ]
    ,[ quicksort_x(glasses_arm_outline)[len(glasses_arm_outline)-1][0]
        , quicksort_y(glasses_arm_outline)[len(glasses_arm_outline)-1][1] ]
    ];
echo(str("glasses_arm_outline_bbox = ",glasses_arm_outline_bbox));
glasses_arm_inline=[glasses_arm_outline_start_pt
    ,[83.0,0],[83.0-(3.1*(83.0-80.0)/5.00),3.1]
    ,[34.30,3.1],[26.81,10.37]
    ,glasses_arm_outline_end_pt];
glasses_arm_inline_bbox=[
    [ quicksort_x(glasses_arm_inline)[0][0]
        , quicksort_y(glasses_arm_inline)[0][1] ]
    ,[ quicksort_x(glasses_arm_inline)[len(glasses_arm_inline)-1][0]
        , quicksort_y(glasses_arm_inline)[len(glasses_arm_inline)-1][1] ]
    ];
echo(str("glasses_arm_inline_bbox = ",glasses_arm_inline_bbox));
glasses_arm_mount_hole_w=0.9+2*grow_hole_abs;
glasses_arm_mount_hole_l=3.82+0.5*grow_hole_abs;
glasses_arm_mount_hole_offset=(glasses_arm_outline_end_pt-glasses_arm_outline_start_pt)/2+[2.27,0];
glasses_arm_mount_hole=[
    glasses_arm_mount_hole_offset+[0,-glasses_arm_mount_hole_w/2]
    ,glasses_arm_mount_hole_offset+[0,glasses_arm_mount_hole_w/2]
    ,glasses_arm_mount_hole_offset+[glasses_arm_mount_hole_l,glasses_arm_mount_hole_w/2]
    ,glasses_arm_mount_hole_offset+[glasses_arm_mount_hole_l,-glasses_arm_mount_hole_w/2]
];
glasses_arm_mount_slot_th=0.84;
//glasses_arm_mount_slot_w=4.82;
glasses_arm_mount_slot_w=4.0+grow_hole_abs;
glasses_arm_mount_slot_l=13.64+5*glasses_arm_mount_slot_th;
// glasses_arm_mount_slot_l=20;
glasses_arm_mount_slot_dy=[0,1]*glasses_arm_mount_hole_offset;
glasses_arm_mount_slot=[
    [0,glasses_arm_mount_slot_dy-glasses_arm_mount_slot_w/2]
    ,[glasses_arm_mount_slot_l,glasses_arm_mount_slot_dy-glasses_arm_mount_slot_w/2]
//    ,[glasses_arm_mount_hole_offset[0]+glasses_arm_mount_hole_l/2,glasses_arm_mount_slot_dy-glasses_arm_mount_slot_w/2]
    ,[glasses_arm_mount_slot_l,glasses_arm_mount_slot_dy+glasses_arm_mount_slot_w/2]
//    ,[glasses_arm_mount_hole_offset[0]+glasses_arm_mount_hole_l/2,glasses_arm_mount_slot_dy+glasses_arm_mount_slot_w/2]
    ,[0,glasses_arm_mount_slot_dy+glasses_arm_mount_slot_w/2]
];
glasses_arm_mount_slot_h=5.67-0.7-1.45-glasses_arm_mount_slot_th/2-1*layer_th;
echo(str("glasses_arm_mount_slot_h = ",glasses_arm_mount_slot_h));

glasses_arm_outline_th=2.10-3*layer_th;
glasses_arm_inline_th=2.60-1*layer_th;
glasses_arm_inner_th=1.60-layer_th;

glasses_ear_outline_extend=[3.0,0];
glasses_ear_outline_start_pt=[83.0,0];
glasses_ear_outline_outer_elbow_pt=[134.0-32*3/4,0];
glasses_ear_outline_inner_elbow_pt=[130-30.0*3/4,5.0];
glasses_ear_outline_end_pt=[80.0,5.0];
glasses_ear_outline=[glasses_ear_outline_start_pt-glasses_ear_outline_extend
    ,glasses_ear_outline_outer_elbow_pt
    ,[134.0,32.0],[130,35.0]
    ,glasses_ear_outline_inner_elbow_pt
    ,glasses_ear_outline_end_pt-glasses_ear_outline_extend];
glasses_ear_outline_bbox=[
    [ quicksort_x(glasses_ear_outline)[0][0]
        , quicksort_y(glasses_ear_outline)[0][1] ]
    ,[ quicksort_x(glasses_ear_outline)[len(glasses_ear_outline)-1][0]
        , quicksort_y(glasses_ear_outline)[len(glasses_ear_outline)-1][1] ]
    ];
echo(str("glasses_ear_outline_bbox = ",glasses_ear_outline_bbox));
glasses_ear_inline_inset=[1.0,0];
glasses_ear_inline=[[83.0,0]+glasses_ear_inline_inset
    ,glasses_ear_outline_outer_elbow_pt
    ,[134.0-(32-24)*3/4,24.0],[130-(32-24)*3/4,24.0]
//    ,[130-24.0*3/4-5*3/4,3.0]
    ,glasses_ear_outline_outer_elbow_pt-(glasses_ear_outline_outer_elbow_pt-glasses_ear_outline_inner_elbow_pt)*3/5
//    ,[83.0-3*3/5,3.0]
    ,glasses_ear_outline_start_pt-(glasses_ear_outline_start_pt-glasses_ear_outline_end_pt)*3/5+glasses_ear_inline_inset
    ];
glasses_ear_inline_bbox=[
    [ quicksort_x(glasses_ear_inline)[0][0]
        , quicksort_y(glasses_ear_inline)[0][1] ]
    ,[ quicksort_x(glasses_ear_inline)[len(glasses_ear_inline)-1][0]
        , quicksort_y(glasses_ear_inline)[len(glasses_ear_inline)-1][1] ]
    ];
echo(str("glasses_ear_inline_bbox = ",glasses_ear_inline_bbox));
glasses_ear_outline_th=2.00-3*layer_th;
glasses_ear_inline_th=2.50-3*layer_th;

module glasses_arm_mount_slot_cutout() {
    // top of tongue
    hull() {
        translate([0,0,4*layer_th])
            linear_extrude(layer_th) intersection() {
                offset(glasses_arm_mount_slot_th/4) polygon(glasses_arm_mount_slot,convexity=10);
                offset(-3.5*glasses_arm_mount_slot_th) polygon(glasses_arm_outline,convexity=10);
            }
        translate([0,0,glasses_arm_inline_th/2]) linear_extrude(glasses_arm_inline_th/4-layer_th,center=false) offset(-glasses_arm_mount_slot_th) intersection() {
            polygon(glasses_arm_mount_slot,convexity=10);
            offset(-3.5*glasses_arm_mount_slot_th) polygon(glasses_arm_outline,convexity=10);
        }
    }
    // sides of tongue
    translate([0,0,-layer_th]) linear_extrude(4*layer_th+layer_th,center=false) intersection() {
        difference() {
            polygon(glasses_arm_mount_slot,convexity=10);
            translate([glasses_arm_mount_slot_th,0]) offset(-glasses_arm_mount_slot_th) polygon(glasses_arm_mount_slot,convexity=10);
        }
        offset(-3.5*glasses_arm_mount_slot_th) polygon(glasses_arm_outline,convexity=10);
    }
    // end slot
    % translate([0,0,3*layer_th]) linear_extrude(glasses_arm_mount_slot_th+layer_th) intersection() {
        offset(glasses_arm_mount_slot_th/4) polygon(glasses_arm_mount_slot,convexity=10);
        difference() {
            offset(grow_hole_abs) polygon(glasses_arm_outline,convexity=10);
            offset(-1.5*glasses_arm_mount_slot_th) polygon(glasses_arm_outline,convexity=10);
        }
    }
    // upper cavity
    hull() {
        translate([0,0,glasses_arm_mount_slot_h-glasses_arm_inline_th/2]) linear_extrude(glasses_arm_inline_th/2-2*layer_th,center=false) polygon(glasses_arm_mount_hole,convexity=10);
        translate([0.0*glasses_arm_mount_hole_w,0,glasses_arm_inline_th/2]) linear_extrude(2*layer_th,center=false) offset(1*glasses_arm_mount_hole_w) polygon(glasses_arm_mount_hole,convexity=10);
    }
    translate(glasses_arm_mount_hole_offset+[glasses_arm_mount_hole_l/2-0.5*glasses_arm_mount_slot_th,-glasses_arm_mount_slot_w/2]) {
        translate([0,0,-layer_th]) {
            linear_extrude(layer_th+4*layer_th) {
                square([1.5*glasses_arm_mount_slot_th,glasses_arm_mount_slot_w],center=false);
            }
            linear_extrude(layer_th+7*layer_th) {
                translate([-1.8*glasses_arm_mount_slot_th/2,glasses_arm_mount_slot_w/2]) square([1.8*glasses_arm_mount_slot_th,0.9*glasses_arm_mount_slot_w],center=true);
            }
        }
    }
    translate(glasses_arm_mount_hole_offset) translate([1.5*glasses_arm_mount_hole_l+2*nozzle_d,0,glasses_arm_mount_slot_h-glasses_arm_inline_th/2])  {
        cube([glasses_arm_mount_hole_l,glasses_arm_mount_slot_w,0.5*glasses_arm_inline_th+1*layer_th],center=true);
    }
}

if(render_part=="glasses_arm_mount_slot_cutout") {
    echo("Rendering glasses_arm_mount_slot_cutout()");
    glasses_arm_mount_slot_cutout();
}

module glasses_arm() {
    difference() {
        difference() {
            union() {
                render() minkowski() {
                    linear_extrude(glasses_arm_outline_th-0*glasses_arm_mount_slot_th-4*layer_th) 
                        offset(-layer_th) polygon(glasses_arm_outline,convexity=10);
                    hull() {
                        cylinder(r1=0,r2=2*layer_th,h=2*layer_th,center=false,$fn=8);
                        translate([0,0,2*layer_th]) cylinder(r1=2*layer_th,r2=0,h=2*layer_th,center=false,$fn=8);
                    }
                }
                render() minkowski() {
                    linear_extrude(glasses_arm_inline_th-4*layer_th) offset(-2*layer_th) polygon(glasses_arm_inline,convexity=10);
                    hull() {
                        cylinder(r1=0,r2=2*layer_th,h=2*layer_th,center=false,$fn=8);
                        translate([0,0,2*layer_th]) cylinder(r1=2*layer_th,r2=0,h=2*layer_th,center=false,$fn=8);
                    }
                }
                render() minkowski() {
                    linear_extrude(glasses_arm_mount_slot_h-2*layer_th) offset(-glasses_arm_mount_slot_th-2*layer_th) polygon(glasses_arm_inline,convexity=10);
                    cylinder(r1=2*layer_th,r2=0,h=2*layer_th,center=false,$fn=8);
                }
            }
            glasses_arm_mount_slot_cutout();
            
        }
        linear_extrude(4*glasses_arm_inline_th,center=true) polygon(glasses_arm_mount_hole,convexity=10);
    }
}

module glasses_arm_inset() {
    translate([0,0,glasses_arm_mount_slot_h-2*layer_th]) linear_extrude(3*layer_th)
        offset(-glasses_arm_mount_slot_th-2*layer_th-2*nozzle_d) polygon(glasses_arm_inline,convexity=10);
}

if(render_part=="glasses_arm") {
    echo("Rendering glasses_arm()");
    difference() {
       glasses_arm();
        %glasses_arm_inset();
    }
}

if(render_part=="glasses_arms") {
    echo("Rendering pair glasses_arm()");
    translate([0,1,0]) glasses_arm();
    translate([0,-1,0]) mirror([0,1,0]) glasses_arm();
}

module glasses_ear() {
    render() minkowski() {
        linear_extrude(glasses_ear_outline_th-4*layer_th) offset(-2*layer_th) polygon(glasses_ear_outline,convexity=10);
        hull() {
            cylinder(r1=0,r2=2*layer_th,h=2*layer_th,center=false,$fn=8);
            translate([0,0,2*layer_th]) cylinder(r1=2*layer_th,r2=0,h=2*layer_th,center=false,$fn=8);
        }
    }
    render() minkowski() {
        linear_extrude(glasses_ear_inline_th-4*layer_th) offset(-2*layer_th) polygon(glasses_ear_inline,convexity=10);
        hull() {
            cylinder(r1=0,r2=2*layer_th,h=2*layer_th,center=false,$fn=8);
            translate([0,0,2*layer_th]) cylinder(r1=2*layer_th,r2=0,h=2*layer_th,center=false,$fn=8);
        }
    }
}

if(render_part=="glasses_ear") {
    echo("Rendering glasses_ear()");
    glasses_ear();
}

module glasses_arm_pair() {
    color([0,0.8,0]) translate(glasses_arm_outline_end_pt+[-glasses_arm_outline_bbox[1][0]/2,min_space]) union() {
        glasses_arm();
        glasses_ear();
    }
    color([0.8,0,0]) translate([glasses_arm_outline_bbox[1][0]/2,0]) mirror([1,0,0]) {
        union() {
            glasses_arm();
            glasses_ear();
        }
    }
}

if(render_part=="glasses_arm_pair") {
    echo("Rendering glasses_arm_pair()");
    glasses_arm_pair();
}

