// Lego Compatible Build Modules

test_module="test lcbm_peg";
test_module="test lcbm_socket_hole";
test_module="test lcbm_block_body";
//test_module="test lcbm_letter_peg";
test_module="test lcbm_letter_tile";

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

module lcbm_socket_hole(socket_d=4.9, socket_h=2.0, socket_bevel=0.2, socket_base_ext=0.1, socket_hole_d=1.8, socket_hole_h=3.3,socket_hole_bevel=0.1,flat_side_w=1.5) {
    $fn=16;
        render() {
            union() {
                translate([0,0,-socket_base_ext]) cylinder(r1=socket_base_ext+socket_d/2+socket_bevel,r2=socket_d/2,h=socket_base_ext+socket_bevel);
                if(flat_side_w>0.0) {
                    hull() translate([0,0,-socket_base_ext/2]) {
                        cube([flat_side_w,socket_d,socket_base_ext],center=true);
                        cube([socket_d,flat_side_w,socket_base_ext],center=true);
                    }
                }
            }
            hull() {
                cylinder(r=socket_d/2,h=socket_h-socket_bevel);
                if(flat_side_w>0.0) {
                    translate([0,0,socket_h/2-socket_bevel/2]) {
                        cube([flat_side_w,socket_d,socket_h-socket_bevel],center=true);
                        cube([socket_d,flat_side_w,socket_h-socket_bevel],center=true);
                    }
                }
                if(socket_bevel>0.0) {
                    translate([0,0,socket_h-socket_bevel]) cylinder(r1=socket_d/2,r2=socket_d/2-socket_bevel,h=socket_bevel);
                }
            }
            if(socket_hole_d>0.0) {
                cylinder(r=socket_hole_d/2,h=socket_hole_h);
                translate([0,0,socket_h]) cylinder(r1=socket_hole_d/2+2*socket_hole_bevel,r2=socket_hole_d/2,h=2*socket_hole_bevel,center=true);
                if(socket_hole_bevel>0.0) {
                    translate([0,0,socket_hole_h-socket_hole_bevel]) cylinder(r1=socket_hole_d/2,r2=socket_hole_d/2+socket_hole_bevel,h=socket_hole_bevel,center=false);
                }
            }
        }
}

if(test_module=="test lcbm_socket_hole") {
    echo("Testing lcbm_socket_hole...");
    lcbm_socket_hole(flat_side_w=1.0);
}

module lcbm_corner_bevel(bevel=0.2,flat=0.0) {
    local_flat=(flat>0.0&&flat<=bevel)?flat:0.1*bevel;
    hull() {
        sphere(r=bevel,$fn=8);
        cube([2*bevel,local_flat,local_flat],center=true);
        cube([local_flat,2*bevel,local_flat],center=true);
        cube([local_flat,local_flat,2*bevel],center=true);
    }
}

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

module lcbm_letter_tile(letter="A",letter_h=0.5,size=[1,1,1],unit=[8.0,8.0,10.0/3.0],bevel=0.2,min_wall_th=1.0,shrink=0.0,valign="baseline",halign="center",letter_size=0.0) {
    // letter_size=7.0
    local_letter_size=(letter_size>0.0)?letter_size:0.75*min(size[0],size[1])*min(unit[0],unit[1]);
    socket_h=size[2]*unit[2]-min_wall_th+(letter_h>0.0?0.0:letter_h);
    echo(str("lcbm_letter_tile: socket_h = ",socket_h));
    difference() {
        union() {
            lcbm_block_body(unit=unit,size=size,bevel=bevel,center=false,shrink=shrink);
            if(letter_h>0.0) {
                translate([(unit[0]*size[0])/2,(unit[1]*size[1]-local_letter_size)/2,unit[2]*size[2]])
                    linear_extrude(height=2*abs(letter_h),center=true) text(letter,size=local_letter_size,valign=valign,halign=halign);
            }
        }
        for(xi=[0:size[0]-1],yj=[0:size[1]-1]) translate([xi*unit[0]+unit[0]/2,yj*unit[1]+unit[1]/2,0]) {
            lcbm_socket_hole(socket_h=socket_h,socket_hole_h=0.0,flat_side_w=1.5,socket_hole_bevel=0);
            if(xi>0 && yj>0) {
                translate([-unit[0]/2,-unit[1]/2,0]) lcbm_socket_hole(socket_h=socket_h,socket_hole_h=0.0,flat_side_w=1.0,socket_hole_bevel=0);
            }
            if(xi>0) {
                translate([-unit[0],-1.0/2,-bevel]) cube([unit[0],1.0,bevel+socket_h],center=false);
            }
            if(yj>0) {
                translate([-1.0/2,-unit[1],-bevel]) cube([1.0,unit[1],bevel+socket_h],center=false);
            }
        }
        if(letter_h<0.0) {
            echo(str("lcbm_letter_tile: letter_h<0.0 -> ",letter_h));
            translate([(unit[0]*size[0])/2,(unit[1]*size[1]-local_letter_size)/2,unit[2]*size[2]])
                linear_extrude(height=2*abs(letter_h),center=true) text(letter,size=local_letter_size,valign=valign,halign=halign);
        }
    }
}

if(test_module=="test lcbm_letter_tile") {
    echo("Testing lcbm_letter_tile...");
    lcbm_letter_tile("B",letter_h=0.5,shrink=0.5);
    translate([8.0,0,0]) lcbm_letter_tile("g",letter_h=-0.5,shrink=0.5,size=[2,2,1],valign="bottom");
}
