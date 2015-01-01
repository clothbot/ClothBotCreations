// Lego Compatible Build Modules

test_module="test lcbm_peg";
test_module="test lcbm_socket_hole";
test_module="test lcbm_block_body";
//test_module="test lcbm_letter_peg";

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
            hull() {
                translate([0,0,-socket_base_ext]) cylinder(r1=socket_base_ext+socket_d/2+socket_bevel,r2=socket_d/2,h=socket_base_ext+socket_bevel);
                if(flat_side_w>0.0) {
                    translate([0,0,-socket_base_ext/2]) {
                        cube([flat_side_w,socket_d,socket_base_ext],center=true);
                        cube([socket_d,flat_side_w,socket_base_ext],center=true);
                    }
                }
            }
            hull() {
                cylinder(r=socket_d/2,h=socket_h-socket_bevel);
                if(flat_side_w>0.0) {
                    translate([0,0,socket_h/2-socket_bevel]) {
                        cube([flat_side_w,socket_d,socket_h-2*socket_bevel],center=true);
                        cube([socket_d,flat_side_w,socket_h-2*socket_bevel],center=true);
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
}

if(test_module=="test lcbm_socket_hole") {
    echo("Testing lcbm_socket_hole...");
    lcbm_socket_hole();
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

module lcbm_block_body(unit=[8.0,8.0,10.0/3.0],size=[1,1,1],bevel=0.2,flat=0.0,center=true) {
    offset_x=(center)?-size[0]*unit[0]/2:0.0;
    offset_y=(center)?-size[1]*unit[1]/2:0.0;
    translate([offset_x,offset_y]) hull() {
        translate([bevel,bevel,0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
        translate([unit[0]*size[0]-bevel,bevel,0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
        translate([bevel,unit[1]*size[1],0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
        translate([unit[0]*size[0],unit[1]*size[1],0]) {
            translate([0,0,bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
            translate([0,0,unit[2]*size[2]-bevel]) lcbm_corner_bevel(bevel=bevel,flat=flat);
        }
    }
}

if(test_module=="test lcbm_block_body") {
    echo("Testing lcbm_block_body...");
    lcbm_block_body(size=[1,2,1],center=false);
}

module lcbm_letter_peg(letter="A",letter_h=0.2,letter_size=0.707*4.9,block_h=3.2,block_w=8.0,block_bevel=0.2,peg_h=1.7,min_wall_th=1.0) {
    difference() {
        union() {
            translate([0,0,block_h/2]) minkowski() {
                cube([block_w-2*block_bevel,block_w-2*block_bevel,block_h-2*block_bevel],center=true);
                hull() {
                    sphere(r=block_bevel,$fn=8);
                    cube([2*block_bevel,0.1*block_bevel,0.1*block_bevel],center=true);
                    cube([0.1*block_bevel,2*block_bevel,0.1*block_bevel],center=true);
                    cube([0.1*block_bevel,0.1*block_bevel,2*block_bevel],center=true);
                }
            }
            translate([0,0,block_h]) lcbm_peg(peg_h=peg_h,peg_hole_d=0);
            translate([0,0,block_h+peg_h]) {
                linear_extrude(height=2*letter_h,center=true) text(letter,halign="center",valign="center",size=letter_size);
            }
        }
        lcbm_socket_hole(socket_h=block_h-min_wall_th,socket_hole_h=block_h+peg_h-min_wall_th,socket_hole_bevel=0,flat_side_w=3.0);
    }
}

if(test_module=="test lcbm_letter_peg") {
    echo("Testing lcb_letter_peg...");
    difference() {
        lcbm_letter_peg("B");
        cube([10,10,10]);
    }
}

