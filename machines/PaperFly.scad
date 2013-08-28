// Updated V-Tail Paper Fly
/*

Dervived from the Bukobot Fly by Diego Porqueras - Deezmaker (http://deezmaker.com)
  See http://www.thingiverse.com/thing:22268

This adaptation is for printing a PLA skeleton directly on paper for a hybrid flier.

This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

$fn=60; // Smoothness setting

wing_front_thickness = 0.8;
wing_back_thickness=0.2;
wing_span=150;
wing_body_length=50;
wing_rib_angle=atan2(wing_span/2,wing_body_length)/2;
rib_wall_th=0.8;
wing_bone_r=2*wing_front_thickness;
wing_wall_th=1.6;

tail_span=80;
tail_body_length=40;
tail_width=4.0;
vtail_angle=30;
tail_wall_th=1.6;
tail_rib_angle=atan2(tail_span/2,tail_body_length);

tail_front_thickness = 0.3;
tail_back_thickness=0.2;

nose_distance=42;
nose_size=8;

fuselage_length=100;
fuselage_nose_w=4.0;
fuselage_nose_th=2.0;
fuselage_tail_w=8.0;
fuselage_tail_th=1.0;

connector_body_th=3.2;
connector_peg_h=1.8;
connector_peg_d=4.9;
connector_peg_hole_d=1.8;
connector_socket_hole_d=4.9;
connector_socket_hole_h=2.0;

use <../utilities/shell_2d.scad>;

render_part="Wing_2D";
render_part="Tail_2D";
//render_part="Fuselage_Connector";
//render_part="Fuselage_Body";
//render_part="Wing_3D";
render_part="Tail_3D";
render_part="PaperFly";

module Wing_2D(wing_span=wing_span
    , wing_body_length=wing_body_length
    , side=1
    ) {
    hull() {
        translate([-1,0]) circle(r=1,center=false);
        translate([-wing_body_length+10,side*(wing_span/2-wing_body_length/2)]) scale([0.5,1]) circle(r=wing_body_length/2,center=false);
        translate([-wing_body_length+1,0]) circle(r=1,center=false);
    }
}

if(render_part=="Wing_2D") {
  echo("Rendering Wing_2D()...");
  % translate([-wing_body_length/2,0]) square([wing_body_length,wing_span],center=true);
  Wing_2D();
}

module Wing_3D(wing_span=wing_span
	, wing_body_length=wing_body_length
	, side=1
	, wing_front_thickness=wing_front_thickness
	, wing_back_thickness=wing_back_thickness
	, wing_wall_th=wing_wall_th
	, rib_wall_th=rib_wall_th
	, tip_angle=wing_rib_angle
	) {
	intersection() {
		render() hull() {
			linear_extrude(height=wing_front_thickness) difference() {
				Wing_2D(wing_span=wing_span,wing_body_length=wing_body_length,side=side);
				translate([-wing_wall_th,0]) Wing_2D(wing_span=wing_span,wing_body_length=wing_body_length,side=side);
			}
			linear_extrude(height=wing_back_thickness) difference() {
				Wing_2D(wing_span=wing_span,wing_body_length=wing_body_length,side=side);
				translate([wing_wall_th,0]) Wing_2D(wing_span=wing_span,wing_body_length=wing_body_length,side=side);
			}
		}
		render() linear_extrude(height=2*(wing_front_thickness+wing_back_thickness)) union() {
			shell_2d(th=wing_wall_th,fn=8) Wing_2D(wing_span=wing_span,wing_body_length=wing_body_length,side=side);
			translate([-wing_body_length/2,side*(wing_span/2)/8]) square([2*wing_body_length,rib_wall_th],center=true);
			translate([-(1/16)*wing_body_length,side*((wing_span/2)/8+rib_wall_th/2)]) rotate(side*(-tip_angle/3+180)) {
				translate([0,-rib_wall_th/2]) square([wing_body_length,rib_wall_th],center=false);
				circle(r=rib_wall_th/2,$fn=8);
			}
			translate([-wing_body_length/2,side*3*(wing_span/2)/8]) square([2*wing_body_length,rib_wall_th],center=true);
			translate([-(3/16)*wing_body_length,side*(3*(wing_span/2)/8+rib_wall_th/2)]) rotate(side*(-2*tip_angle/3+180)) {
				translate([0,-rib_wall_th/2]) square([wing_body_length,rib_wall_th],center=false);
				circle(r=rib_wall_th/2,$fn=8);
			}
			translate([-wing_body_length/2,side*5*(wing_span/2)/8]) square([2*wing_body_length,rib_wall_th],center=true);
			translate([-(5/16)*wing_body_length,side*(5*(wing_span/2)/8+rib_wall_th/2)]) rotate(side*(-tip_angle+180)) {
				translate([0,-rib_wall_th/2]) square([wing_body_length,rib_wall_th],center=false);
				circle(r=rib_wall_th/2,$fn=8);
			}
		}
	}
}

if(render_part=="Wing_3D") {
  echo("Rendering Wing_3D()...");
  Wing_3D();
}


module Tail_2D(tail_span=tail_span
    , tail_body_length=tail_body_length
    , side=1
    ) {
    hull() {
        translate([-2,side*2]) circle(r=2,center=false);
        translate([-tail_body_length+tail_body_length/4,side*(tail_span/2-tail_body_length/4)]) circle(r=tail_body_length/4,center=false);
        translate([-tail_body_length+1,side*1]) circle(r=1,center=false);
    }
}

if(render_part=="Tail_2D") {
    echo("Rendering Tail_2D()...");
    %translate([-tail_body_length/2,0]) square([tail_body_length,tail_span],center=true);
    Tail_2D(side=-1);
}

module Tail_3D(tail_span=tail_span
	, tail_body_length=tail_body_length
	, side=1
	, tail_front_thickness=tail_front_thickness
	, tail_back_thickness=tail_back_thickness
	, tail_wall_th=tail_wall_th
	, rib_wall_th=rib_wall_th
	, tip_angle=tail_rib_angle
	, vtail_angle=vtail_angle
	, fuselage_tail_th=fuselage_tail_th
	) {
	intersection() {
		if(side>0) {
			rotate([-vtail_angle,0,0]) rotate([0,0,90]) cube([tail_span,tail_span,tail_span],center=false);
			rotate([0,0,90]) cube([tail_span,tail_span,tail_span],center=false);
		} else {
			rotate([vtail_angle,0,0]) rotate([0,0,180]) cube([tail_span,tail_span,tail_span],center=false);
			rotate([0,0,180]) cube([tail_span,tail_span,tail_span],center=false);
		}
		render() union() {
		  hull() {
			linear_extrude(height=tail_front_thickness) difference() {
				Tail_2D(tail_span=tail_span,tail_body_length=tail_body_length,side=side);
				translate([-tail_wall_th,0]) Tail_2D(tail_span=tail_span,tail_body_length=tail_body_length,side=side);
			}
			linear_extrude(height=tail_back_thickness) difference() {
				Tail_2D(tail_span=tail_span,tail_body_length=tail_body_length,side=side);
				translate([tail_wall_th,0]) Tail_2D(tail_span=tail_span,tail_body_length=tail_body_length,side=side);
			}
		  }
		  rotate([-side*vtail_angle,0,0]) rotate([0,0,side*90]) hull() {
			translate([tail_wall_th/2,side*tail_wall_th,0]) cylinder(r=tail_wall_th/2,h=fuselage_tail_th,center=false);
			translate([tail_wall_th/2,side*(tail_body_length-tail_wall_th),0]) cylinder(r=tail_wall_th/2,h=fuselage_tail_th,center=false);
		  }
		}
		render() linear_extrude(height=2*(tail_front_thickness+tail_back_thickness)) union() {
			shell_2d(th=tail_wall_th,fn=8) Tail_2D(tail_span=tail_span,tail_body_length=tail_body_length,side=side);
			square([2*tail_body_length,3*tail_wall_th],center=true);
			translate([0,side*rib_wall_th/2]) rotate(side*(-tip_angle/3+180)) {
				translate([0,-rib_wall_th/2]) square([tail_span,rib_wall_th],center=false);
				circle(r=rib_wall_th/2,$fn=8);
			}
			translate([0,side*rib_wall_th/2]) rotate(side*(-(2/3)*tip_angle+180)) {
				translate([0,-rib_wall_th/2]) square([tail_span,rib_wall_th],center=false);
				circle(r=rib_wall_th/2,$fn=8);
			}
			translate([0,side*rib_wall_th/2]) rotate(side*(-tip_angle+180)) {
				translate([0,-rib_wall_th/2]) square([tail_span,rib_wall_th],center=false);
				circle(r=rib_wall_th/2,$fn=8);
			}
		}
	}
}

if(render_part=="Tail_3D") {
  echo("Rendering Tail_3D()...");
  Tail_3D(side=-1);
}


module Fuselage_Connector_Connector(
    xn=3,yn=2
    ,body_th=connector_body_th
    ,peg_d=connector_peg_d,peg_h=connector_peg_h
    ) {
    union() {
        hull() {
            translate([-8*xn/2,0,body_th/2]) cube([8*(xn-1),8*yn,body_th],center=true);
            cylinder(r=8.0*(yn-1),h=body_th);
        }
        for(ix=[0:xn-1]) for(iy=[0:yn-1]) translate([-8.0*ix,8.0*(iy-yn/2+0.5),0]) cylinder(r=peg_d/2,h=body_th+peg_h);
    }
}

module Fuselage_Connector_Holes(
    xn=3,yn=2
    ,body_th=connector_body_th
    ,peg_h=connector_peg_h,peg_hole_d=connector_peg_hole_d
    , socket_hole_d=connector_socket_hole_d, socket_hole_h=connector_socket_hole_h
    ,extend=0.1
    ) {
    for(ix=[0:xn-1]) for(iy=[0:yn-1]) translate([-8.0*ix,8.0*(iy-yn/2+0.5),-extend]) cylinder(r=peg_hole_d/2,h=body_th+peg_h+2*extend);
    for(ix=[0:xn-1]) for(iy=[0:yn-1]) translate([-8.0*ix,8.0*(iy-yn/2+0.5),-extend]) cylinder(r=socket_hole_d/2,h=socket_hole_h+extend);
    for(ix=[1:xn-1]) translate([-8.0*ix+4.0,0,-0.1]) cylinder(r=peg_hole_d/2,h=body_th+peg_h+2*extend);
    translate([4,0,0]) cylinder(r=(socket_hole_d-peg_hole_d)/4,h=2*(body_th+peg_h+extend),center=true);
}

if(render_part=="Fuselage_Connector") {
    difference() {
        Fuselage_Connector_Connector();
        Fuselage_Connector_Holes();
    }
}

module Fuselage_Body(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length
	) {
	hull() {
		translate([fuselage_tail_w/2,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th-fuselage_tail_th/4]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th/4,r1=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
		}
		translate([tail_body_length-fuselage_tail_w/2,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th-fuselage_tail_th/4]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th/4,r1=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
		}
	}
	hull() {
		translate([tail_body_length-fuselage_tail_w/2,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th-fuselage_tail_th/4]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th/4,r1=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
		}
		translate([fuselage_length-wing_body_length+fuselage_nose_w/2,0,0]) {
			cylinder(r1=fuselage_nose_w/2-fuselage_nose_th/4,r2=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
			translate([0,0,fuselage_nose_th-fuselage_nose_th/4]) cylinder(r2=fuselage_nose_w/2-fuselage_nose_th/4,r1=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
		}
	}
	hull() {
		translate([fuselage_length-wing_body_length+fuselage_nose_w/2,0,0]) {
			cylinder(r1=fuselage_nose_w/2-fuselage_nose_th/4,r2=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
			translate([0,0,fuselage_nose_th-fuselage_nose_th/4]) cylinder(r2=fuselage_nose_w/2-fuselage_nose_th/4,r1=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
		}
		translate([fuselage_length-fuselage_nose_w/2,0,0]) {
			cylinder(r1=fuselage_nose_w/2-fuselage_nose_th/4,r2=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
			translate([0,0,fuselage_nose_th-fuselage_nose_th/4]) cylinder(r2=fuselage_nose_w/2-fuselage_nose_th/4,r1=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
		}
	}
}

if(render_part=="Fuselage_Body") {
	Fuselage_Body();
}

module PaperFly(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length
	) {
	Fuselage_Body();
	translate([fuselage_length,fuselage_nose_w/2,0]) Wing_3D();
	translate([fuselage_length,-fuselage_nose_w/2,0]) Wing_3D(side=-1);
	translate([tail_body_length,fuselage_tail_w/2,0]) Tail_3D();
	translate([tail_body_length,-fuselage_tail_w/2,0]) Tail_3D(side=-1);
	translate([fuselage_length,0,0]) difference() {
        Fuselage_Connector_Connector();
        Fuselage_Connector_Holes();
    }
}

if(render_part=="PaperFly") {
    PaperFly();
}

