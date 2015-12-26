// Derived from Thingiverse Thing 28241
//  http://www.thingiverse.com/thing:28241/

filament_d = 1.75;
spring_d = 8;

//render_part="plate";
render_part="idler";
//render_part="base";
//render_part="assembly";

if(render_part=="plate") plate();

if(render_part=="idler") {
    % translate([0,0,-1.0]) cube([32.0,60.0,2.0],center=true);
    translate([-10,15,0]) rotate([0,0,90+30]) idler();
}


if(render_part=="base") base();

if(render_part=="assembly") assembly();

module plate(){
translate([30,15,0])idler();
base();
}

module assembly(){
union(){
translate([0, 15.5, 0]) base();
translate([15.5, 15.5, 0]) {
	%translate([-15.5, -15.5, 0]) translate([10.56 / 2 + 4 + filament_d, 0, 7.7]) linear_extrude(height = 4, convexity = 5) difference() {// 693 bearing
		circle(4);
		circle(1.5, $fn = 6);
	}

	translate([0, 0, 5]) rotate(-9) idler();
}
%translate([-15.5+9,20.5,0])cube([30,5,15]);
%translate([0, 0, 2]) difference() {// drive gear
	linear_extrude(height = 11, convexity = 5) difference() {
		circle(6.3);
		circle(2.5);
	}
	translate([0, 0, 7.7]) rotate_extrude(convexity = 5, $fs = 0.5) translate([5 + 2.5, 0, 0]) circle(r = 2);
}}}

module idler(idler_h=10,filament_h=4.6) difference() {
	linear_extrude(height = idler_h, convexity = 5) difference() {
		union() {
			circle(5);
			translate([0, -18.5, 0]) circle(5);
			rotate(180) translate([-5, 0, 0]) square([10, 18.5]);
			rotate(104){
				square([5, 25]);
				translate([0,22.5])square([15.8,4]);
			}
			rotate(77)translate([0,27.2])square([4,18]);
			rotate(50) translate([-8, -2, 0]) square([5, 10]);
		}
		circle(3 * 7/12, $fn = 6);
		rotate(9) translate([-15.5 + 10.56 / 2 + 4 + filament_d, -15.5, 0]) circle(2.5* 7/12, $fn = 6);
	}
	translate([0, 0, idler_h/2]) {
		#rotate(9) translate([-15.5 + 10.56 / 2 + 4 + filament_d, -15.5, 0]) linear_extrude(height = idler_h-filament_h, convexity = 5, center = true) difference() {
			circle(6);
			circle(2, $fn = 6);
		}
		#translate([10.56 / 2 + 1.5, 0, 0]) {
            hull() {
                translate([0,0,-(idler_h-2*filament_h)/2]) rotate([-90,0,9]) translate([-15.5, 0, -15.5]) cylinder(r = 2, h = 50, $fn = 6);
                translate([0,0,(idler_h-2*filament_h)/2]) rotate([-90,0,9]) translate([-15.5, 0, -15.5]) cylinder(r = 2, h = 50, $fn = 6);
            }
            hull() {
                translate([0,0,-(idler_h-2*filament_h)/2]) rotate([-90, 0, 0]) translate([-15.5, 0, -15.5]) rotate([0, 0, 0]) cylinder(r = 2, h = 100, center = true, $fn = 6);
                translate([0,0,(idler_h-2*filament_h)/2]) rotate([-90, 0, 0]) translate([-15.5, 0, -15.5]) rotate([0, 0, 0]) cylinder(r = 2, h = 100, center = true, $fn = 6);
            }
        }
	}
	translate([0, 0, idler_h - 4]) cylinder(r1 = 0, r2 = 8, h = 8, $fn = 6);
	translate([0, 0, -4]) cylinder(r2 = 0, r1 = 8, h = 8, $fn = 6);
	translate([0, 0, idler_h / 2]) rotate([90, 0, -13]) translate([-24-15.5, 0, -2]) cylinder(r = spring_d * 7/12, h = idler_h, $fn = 6);
}

module base() difference() {
	linear_extrude(height = 15, convexity = 5) difference() {
		union() {
			translate([-7,0,0])square([45, 10], center = true);
			translate([15.5, 0, 0]) circle(5);
		}
		for (side = [1, -1]) translate([side * 15.5, 0, 0]) circle(3 * 7/12, $fn = 6);
		translate([0, -15.5, 0]) circle(12);
	}
	rotate([0,0,14])translate([-12, -10, 5]) linear_extrude(height = 15, convexity = 5)square(100);
	translate([-39,0,5])cube(20);
	translate([-15.5, 0, 15 - 4]) cylinder(r1 = 0, r2 = 8, h = 8, $fn = 6);
	translate([-24, 7, 10]) rotate([90,0,0])cylinder(r = spring_d * 7/12,h=10, $fn = 6);
}