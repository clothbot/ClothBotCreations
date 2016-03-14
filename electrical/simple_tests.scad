// Simple Conductivity Tests.

render_part="resistance test";

in2mm=25.4;

layer_th=0.2;
nozzle_d=0.4;

probe_d=1.0;

module probe(id=probe_d,od=probe_d+4*nozzle_d,h=layer_th,flat_w=2*nozzle_d) {
    difference() {
        hull() {
            cylinder(r=od/2,h=h,center=false,$fn=16);
            translate([0,0,h/2]) cube([flat_w,od,h],center=true);
            translate([0,0,h/2]) cube([od,flat_w,h],center=true);
        }
        cylinder(r=id/2,h=3*h,center=true,$fn=16);
    }
}

module resistance_test(th=layer_th,w=2*nozzle_d,l=10.0,nozzle_d=nozzle_d,probe_d=probe_d,layer_th=layer_th) {
    probe_h=th+2*layer_th;
    translate([-2*nozzle_d-probe_d/2,0,0]) {
        probe(id=probe_d,od=probe_d+4*nozzle_d,h=probe_h,flat_w=w);
    }
    translate([-nozzle_d,-w/2,0]) {
        cube([2*nozzle_d+l,w,th],center=false);
    }
    translate([l+2*nozzle_d+probe_d/2,0,0]) {
        probe(id=probe_d,od=probe_d+4*nozzle_d,h=probe_h,flat_w=w);
    }
}

if(render_part=="resistance test") {
    echo("Resistance test part");
    for(i=[0:4]) translate([0,i*(probe_d+5*nozzle_d),0]) {
        resistance_test(th=layer_th+i*layer_th);
    }
}

