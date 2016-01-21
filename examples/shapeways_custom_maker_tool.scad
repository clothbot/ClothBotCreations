// Shapeways CustomMaker Test

render_part="render picture_frame";

// Material: Frosted Ultra Detail Plastic
function min_bbox_check(x,y,z) = (x+y+z>=12.0)? true:false;
function max_bbox_check(x,y,z) = (x<284 && y<184 && z<203)? true:false;
min_sup_wall_th=0.3;
min_unsup_wall_th=0.6;
min_sup_wire_th=0.6;
min_unsup_wire_th=0.8;

min_emb_h=0.1;
min_eng_depth=0.1;

min_esc_hole_single_d=4.0;
min_esc_hole_multi_d=2.0;

min_clearance=0.05;

interlocking=true;

sw_cm_min_eng_depth=0.1;
sw_cm_min_emb_h=0.1;

function in2mm(l)=25.4*l;

picture_sizes=[
    ["wallet"
        ,[ in2mm(2.0),in2mm(3.0) ] 
        ,[600,900]
    ]
,   ["2R"
        ,[ in2mm(2.5),in2mm(3.5) ]
        ,[750,1050]
    ]
,   ["standard"
        ,[ in2mm(4.0),in2mm(6.0) ]
        ,[1200,1800]
    ]
,   ["3R"
        ,[ in2mm(3.5),in2mm(5.0) ]
        ,[1050,1500]
    ]
,   ["4R"
        ,[ in2mm(4.0),in2mm(6.0) ]
        ,[1200,1800]
    ]
,   ["4D"
        ,[ in2mm(4.5),in2mm(6.0) ]
        ,[ 1350,1800 ]
    ]
];

module picture_frame(size_name
        ,picture_sizes=picture_sizes
        ,wall_th=min_unsup_wall_th
        ,pillar_d=min_unsup_wire_th,pillar_spacing=min_esc_hole_single_d
        ,pillar_h=min_esc_hole_multi_d
    ) {
    picture_size=get_picture_size(size_name,picture_sizes);
    echo(str("  picture_size = ",picture_size));
    size_mm2=picture_size[1];
    echo(str("  size_mm2 = ",size_mm2));
    size_pixels=picture_size[2];
    pillar_count=[ round((size_mm2[0]+pillar_d)/(pillar_d+pillar_spacing))
        , round((size_mm2[1]+pillar_d)/(pillar_d+pillar_spacing)) ];
    echo(str("  pillar_count = ",pillar_count));
    minkowski() {
        translate([0,0,-wall_th]) linear_extrude(height=wall_th/2) {
            square([size_mm2[0],size_mm2[1]],center=true);
        }
        hull() {
            cylinder(r1=wall_th/2,r2=0,h=wall_th/2,center=false,$fn=8);
            translate([0,0,-wall_th/4]) {
                cube([wall_th/8,wall_th,wall_th/2],center=true);
                cube([wall_th,wall_th/8,wall_th/2],center=true);
            }
        }
    }
    for(i=[1:pillar_count[0]-1]) {
        color([1,0,0]) translate([(pillar_d+pillar_spacing)*(i-pillar_count[0]/2),size_mm2[1]/2+pillar_d/2,-4*wall_th/2]) hull() {
            cylinder(r1=pillar_d/2-wall_th/2,r2=pillar_d/2,h=wall_th/2,center=false,$fn=8);
            translate([0,0,4*wall_th/2+pillar_h]) sphere(r=pillar_d/2,$fn=27);
        }
        color([1,0,0]) translate([(pillar_d+pillar_spacing)*(i-pillar_count[0]/2),-size_mm2[1]/2-pillar_d/2,-4*wall_th/2]) hull() {
            cylinder(r1=pillar_d/2-wall_th/2,r2=pillar_d/2,h=wall_th/2,center=false,$fn=8);
            translate([0,0,4*wall_th/2+pillar_h]) sphere(r=pillar_d/2,$fn=27);
        }
    }
    for(i=[1:pillar_count[1]-1]) {
        color([1,0,0]) translate([size_mm2[0]/2+pillar_d/2,(pillar_d+pillar_spacing)*(i-pillar_count[1]/2),-4*wall_th/2]) hull() {
            cylinder(r1=pillar_d/2-wall_th/2,r2=pillar_d/2,h=wall_th/2,center=false,$fn=8);
            translate([0,0,4*wall_th/2+pillar_h]) sphere(r=pillar_d/2,$fn=27);
        }
        color([1,0,0]) translate([-size_mm2[0]/2-pillar_d/2,(pillar_d+pillar_spacing)*(i-pillar_count[1]/2),-4*wall_th/2]) hull() {
            cylinder(r1=pillar_d/2-wall_th/2,r2=pillar_d/2,h=wall_th/2,center=false,$fn=8);
            translate([0,0,4*wall_th/2+pillar_h]) sphere(r=pillar_d/2,$fn=27);
        }
    }
}

if(render_part=="render picture_frame") {
    picture_frame("wallet");
}
