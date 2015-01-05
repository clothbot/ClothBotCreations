// Lego Compatible Build Modules

module lcbm_corner_bevel(bevel=0.2,flat=0.0) {
    local_flat=(flat>0.0&&flat<=bevel)?flat:0.1*bevel;
    hull() {
        sphere(r=bevel,$fn=8);
        cube([2*bevel,local_flat,local_flat],center=true);
        cube([local_flat,2*bevel,local_flat],center=true);
        cube([local_flat,local_flat,2*bevel],center=true);
    }
}
