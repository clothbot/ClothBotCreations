// Lego Compatible Build Modules

//use <lcbm_peg.scad>;
use <lcbm_socket_hole.scad>;
//use <lcbm_corner_bevel.scad>;
use <lcbm_block_body.scad>;
//use <lcbm_letter_peg.scad>;
test_module="test lcbm_letter_tile";

module lcbm_letter_tile(letter="A",letter_h=0.5,size=[1,1,1],unit=[8.0,8.0,10.0/3.0],bevel=0.2,min_wall_th=1.0,shrink=0.0,valign="baseline",halign="center",letter_size=0.0) {
    // letter_size=7.0
    local_letter_size=(letter_size>0.0)?letter_size:0.75*min(size[0],size[1])*min(unit[0],unit[1]);
    socket_h=size[2]*unit[2]-min_wall_th+(letter_h>0.0?0.0:letter_h);
    echo(str("lcbm_letter_tile: socket_h = ",socket_h));
    difference() {
        union() {
            lcbm_block_body(unit=unit,size=size,bevel=bevel,center=false,shrink=shrink);
            if(letter_h>0.0) minkowski() {
                translate([(unit[0]*size[0])/2,(unit[1]*size[1]-local_letter_size)/2,unit[2]*size[2]])
                    linear_extrude(height=2*abs(letter_h)-min_wall_th/2,center=true) text(letter,size=local_letter_size,valign=valign,halign=halign);
                cylinder(r1=min_wall_th/4,r2=0,h=min_wall_th/4,center=false,$fn=4);
            }
        }
        if(letter_h<0.0) {
            echo(str("lcbm_letter_tile: letter_h<0.0 -> ",letter_h));
            translate([(unit[0]*size[0])/2,(unit[1]*size[1]-local_letter_size)/2,unit[2]*size[2]]) {
                linear_extrude(height=2*abs(letter_h),center=true) text(letter,size=local_letter_size,valign=valign,halign=halign);
                # minkowski() {
                    linear_extrude(height=bevel,center=false) text(letter,size=local_letter_size,valign=valign,halign=halign);
                    cylinder(r1=0,r2=2*bevel,h=2*bevel,center=true,$fn=4);
                }
            }
        }
        for(xi=[0:size[0]-1],yj=[0:size[1]-1]) translate([xi*unit[0]+unit[0]/2,yj*unit[1]+unit[1]/2,0]) {
            lcbm_socket_hole(socket_h=socket_h,socket_hole_h=0.0,flat_side_w=1.5,socket_hole_bevel=0);
            if(xi>0 && yj>0) {
                translate([-unit[0]/2,-unit[1]/2,0]) lcbm_socket_hole(socket_h=socket_h,socket_hole_h=0.0,flat_side_w=1.0,socket_hole_bevel=0);
            }
            if(false&&xi>0) {
                translate([-unit[0],-1.0/2,-bevel]) cube([unit[0],1.0,bevel+socket_h],center=false);
            }
            if(false&&yj>0) {
                translate([-1.0/2,-unit[1],-bevel]) cube([1.0,unit[1],bevel+socket_h],center=false);
            }
        }
        if(size[0]>1 || size[1]>1) {
            translate([unit[0]/2-min_wall_th,unit[1]/2-min_wall_th,-bevel]) {
                cube([2*min_wall_th+(size[0]-1)*unit[0],2*min_wall_th+(size[1]-1)*unit[1],bevel+socket_h-2*bevel],center=false);
            }
            # hull() {
                $fn=8;
                translate([unit[0]/2,unit[1]/2,0]) cylinder(r1=min_wall_th+2*bevel,r2=min_wall_th,h=2*bevel,center=true);
                translate([(size[0]-0.5)*unit[0],unit[1]/2,0]) cylinder(r1=min_wall_th+2*bevel,r2=min_wall_th,h=2*bevel,center=true);
                translate([unit[0]/2,(size[1]-0.5)*unit[1],0]) cylinder(r1=min_wall_th+2*bevel,r2=min_wall_th,h=2*bevel,center=true);
                translate([(size[0]-0.5)*unit[0],(size[1]-0.5)*unit[1],0]) cylinder(r1=min_wall_th+2*bevel,r2=min_wall_th,h=2*bevel,center=true);
            }
            # translate([0,0,socket_h-2*bevel]) hull() {
                $fn=8;
                translate([unit[0]/2,unit[1]/2,0]) cylinder(r1=min_wall_th,r2=min_wall_th-bevel,h=bevel,center=false);
                translate([(size[0]-0.5)*unit[0],unit[1]/2,0]) cylinder(r1=min_wall_th,r2=min_wall_th-bevel,h=bevel,center=false);
                translate([unit[0]/2,(size[1]-0.5)*unit[1],0]) cylinder(r1=min_wall_th,r2=min_wall_th-bevel,h=bevel,center=false);
                translate([(size[0]-0.5)*unit[0],(size[1]-0.5)*unit[1],0]) cylinder(r1=min_wall_th,r2=min_wall_th-bevel,h=bevel,center=false);
            }
        }

    }
}

if(test_module=="test lcbm_letter_tile") {
    echo("Testing lcbm_letter_tile...");
    lcbm_letter_tile("B",letter_h=0.5,shrink=0.5);
    translate([8.0,0,0]) lcbm_letter_tile("g",letter_h=-0.5,shrink=0.5,size=[2,3,1],valign="bottom");
}
