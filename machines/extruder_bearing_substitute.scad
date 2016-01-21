// Extruder bearing substitute.

render_part="bearing 623";
render_part="bearing 693";
render_part="drive gear";
render_part="drive gear mask";
render_part="idler pad";

nozzle_d=0.4;
layer_th=0.2;

// 623zz dim
function bearing_623(pname)=let(params=[["id",3.0],["od",10.0],["th",4.0]]) params[search([pname],params,1,0)[0]][1];
echo(str("bearing 623: id=",bearing_623("id")," od=",bearing_623("od")," th=",bearing_623("th")));

module bearing_623(center=false,delta=0.0) {
    linear_extrude(height=bearing_623("th"),convexity=3,center=center) difference() {
        circle(d=bearing_623("od"));
        circle(d=bearing_623("id")+delta);
    }
}

if(render_part=="bearing 623") {
    echo("Rendering bearing 623");
    bearing_623($fn=32,center=true);
}

// 693zz dim
function bearing_693(pname)=let(params=[["id",3.0],["od",8.0],["th",4.0]]) params[search([pname],params,1,0)[0]][1];
echo(str("bearing 693: id=",bearing_693("id")," od=",bearing_693("od")," th=",bearing_693("th")));

module bearing_693(center=false,delta=0.0) {
    linear_extrude(height=bearing_693("th"),convexity=3,center=center) difference() {
        circle(d=bearing_693("od"));
        circle(d=bearing_693("id")+delta);
    }
}

if(render_part=="bearing 693") {
    echo("Rendering bearing 693");
    bearing_693($fn=32,center=true);
}

// drive_gear dim
function drive_gear(pname)=let(params=[["id",2*2.5],["od",2*6.3],["th",11.0],["channel_offset_h",7.7],["channel_offset_r",5+2.5],["channel_r",2]])
    params[search([pname],params,1,0)[0]][1];
echo(str("drive gear: id=",drive_gear("id")," od=",drive_gear("od")," th=",drive_gear("th")," channel_offset_h=",drive_gear("channel_offset_h")," channel_offset_r=",drive_gear("channel_offset_r")," channel_r=",drive_gear("channel_r")));

module drive_gear_2d() {
    difference() {
        translate([drive_gear("id")/2,0]) square([drive_gear("od")/2-drive_gear("id")/2,drive_gear("th")]);
        translate([drive_gear("channel_offset_r"),drive_gear("channel_offset_h")]) circle(r=drive_gear("channel_r"));
    }
}

module drive_gear(center=false) {
    translate([0,0,center?-drive_gear("channel_offset_h"):0]) {
        rotate_extrude(convexity=3) drive_gear_2d();
    }
}
if(render_part=="drive gear") {
    echo("Rendering drive gear");
    drive_gear(center=true,$fn=32);
}

module drive_gear_mask() {
    rotate_extrude(convexity=3) intersection() {
        drive_gear_2d($fn=32);
        translate([0,drive_gear("th")]) mirror([0,1]) drive_gear_2d($fn=32);
    }
}

if(render_part=="drive gear mask") {
    echo("Rendering drive gear bidirectional mask");
    drive_gear_mask();
}

module idler_pad(delta=0.0,center=false) {
    contact_r=(bearing_623("od")-bearing_623("id"))/4+drive_gear("od")-(2*drive_gear("channel_offset_r")-2*drive_gear("channel_r"));
    translate([0,0,(center?-bearing_623("th")/2:0.0)]) difference() {
        bearing_623(delta=delta);
        for(i=[0:2]) rotate([0,0,120*i]) {
            translate([bearing_623("od")/2+drive_gear("channel_offset_r")-drive_gear("channel_r")-(bearing_623("od")-bearing_623("id"))/4,0,bearing_623("th")/2]) drive_gear(center=true);
        }
        for(i=[0:3]) rotate([0,0,120*i]) {
            #translate([contact_r+drive_gear("channel_r"),0,bearing_623("th")/2]) rotate([90,0,0]) cylinder(r=drive_gear("channel_r"),h=bearing_623("od"),center=true);
            rotate([0,0,7.5]) #translate([contact_r+drive_gear("channel_r"),0,bearing_623("th")/2]) rotate([90,0,0]) cylinder(r=drive_gear("channel_r"),h=bearing_623("od"),center=true);
            rotate([0,0,-7.5]) #translate([contact_r+drive_gear("channel_r"),0,bearing_623("th")/2]) rotate([90,0,0]) cylinder(r=drive_gear("channel_r"),h=bearing_623("od"),center=true);
        }
        if(delta>0) for(i=[0:3]) rotate(45*i) {
            cube([bearing_623("id")+2*delta,delta,2*bearing_623("th")+2*delta],center=true);
        }
    }
}

if(render_part=="idler pad") {
    echo("Rendering idler pad");
    for(i=[-1:1]) translate([0,i*bearing_623("od"),0]) rotate(30) idler_pad(delta=0.4,$fn=32);
}

filament_max_d=2.0;
filament_min_d=1.5;
