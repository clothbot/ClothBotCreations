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

nozzle_separation=32.0;
nozzle_offset=32.0/2;
// Build platform absolute limits: 230x150
wing_front_thickness = 0.8;
wing_back_thickness=0.4;

// Single platform size
wing_span=240;
wing_body_length=30;

wing_rib_angle=atan2(wing_span/2,wing_body_length)/2;
rib_wall_th=1.2;
wing_bone_r=2*wing_front_thickness;
wing_wall_th=1.6;

tail_span=90;
tail_body_length=25;
tail_width=4.0;
vtail_angle=45;
tail_wall_th=1.6;
tail_rib_angle=atan2(tail_span/2,tail_body_length);

tail_front_thickness = 0.6;
tail_back_thickness=0.4;

nose_distance=42;
nose_size=8;

// Single Platform Size
fuselage_length=110;
fuselage_nose_w=4.0;
fuselage_nose_th=2.0;
fuselage_tail_w=10.0;
fuselage_tail_th=1.0;

connector_body_th=2.4;
connector_peg_h=1.8+wing_front_thickness;
connector_peg_d=4.8;
connector_peg_hole_d=1.9;
connector_socket_hole_d=5.5;
connector_socket_hole_h=2.0;

use <../utilities/shell_2d.scad>;

render_part="Wing_2D";
render_part="Tail_2D";
//render_part="Fuselage_Connector";
//render_part="Fuselage_Body";
//render_part="Wing_3D";
render_part="Tail_3D";
render_part="Fuselage_Tail";
render_part="PaperFly";
render_part="PaperFly_Parts_wings";
render_part="PaperFly_Parts_body";
render_part="PaperFly_Parts";
//render_part="PaperFly_Parts_wings45";
render_part="PaperFly_Parts_Large";


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
	, fill_th=0.0
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
	if(fill_th>0) linear_extrude(height=fill_th) Wing_2D(wing_span=wing_span,wing_body_length=wing_body_length,side=side);
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
	, extend=0.1
	, fill_th=0.0
	) {
	intersection() {
		if(side>0) {
			rotate([-(90-vtail_angle),0,0]) rotate([0,0,90]) cube([tail_span,tail_span,tail_span],center=false);
			rotate([0,0,90]) cube([tail_span,tail_span,tail_span],center=false);
		} else {
			rotate([90-vtail_angle,0,0]) rotate([0,0,180]) cube([tail_span,tail_span,tail_span],center=false);
			rotate([0,0,180]) cube([tail_span,tail_span,tail_span],center=false);
		}
		render() difference() {
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
		  % translate([-tail_body_length/2,side*tail_wall_th,(tail_front_thickness+tail_back_thickness)/2]) {
			cube([3*tail_body_length/4+tail_wall_th,tail_wall_th/2,2*extend+tail_front_thickness+tail_back_thickness],center=true);
		  }
		}
		render() linear_extrude(height=2*(tail_front_thickness+tail_back_thickness)) union() {
			shell_2d(th=tail_wall_th,fn=8) Tail_2D(tail_span=tail_span,tail_body_length=tail_body_length,side=side);
			square([2*tail_body_length,4*tail_wall_th],center=true);
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
	if(fill_th>0) linear_extrude(height=fill_th) Tail_2D(tail_span=tail_span,tail_body_length=tail_body_length,side=side);
	translate([-tail_body_length/8,0,0]) hull() {
		translate([-3*tail_body_length/4+tail_wall_th,-side*tail_wall_th,0]) cylinder(r=tail_wall_th,h=tail_front_thickness,center=false);
		translate([-tail_wall_th,-side*tail_wall_th,0]) cylinder(r=tail_wall_th,h=tail_front_thickness,center=false);
		translate([-3*tail_body_length/8,0,tail_front_thickness/2]) cube([3*tail_body_length/4,2*tail_wall_th,tail_front_thickness],center=true);
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
	,shrink=0.4
    ) {
    union() {
        hull() {
            translate([-8*xn/2,0,body_th/2]) cube([8*(xn-1)-shrink,8*yn-shrink,body_th],center=true);
            cylinder(r=8.0*yn/2-shrink/2,h=body_th);
        }
        if(peg_h>0) for(ix=[0:xn-1]) for(iy=[0:yn-1]) translate([-8.0*ix,8.0*(iy-yn/2+0.5),0]) cylinder(r=peg_d/2,h=body_th+peg_h);
    }
}

module Fuselage_Connector_Holes(
    xn=3,yn=2
    ,body_th=connector_body_th
    ,peg_h=connector_peg_h,peg_hole_d=connector_peg_hole_d
    , socket_hole_d=connector_socket_hole_d, socket_hole_h=connector_socket_hole_h
    ,extend=0.1
    ) {
    if(peg_h>0) for(ix=[0:xn-1]) for(iy=[0:yn-1]) translate([-8.0*ix,8.0*(iy-yn/2+0.5),-extend]) cylinder(r=peg_hole_d/2,h=body_th+peg_h+2*extend);
    for(ix=[0:xn-1]) for(iy=[0:yn-1]) translate([-8.0*ix,8.0*(iy-yn/2+0.5),-extend]) {
		cylinder(r=socket_hole_d/2,h=(peg_h>0?1:2)*socket_hole_h+extend);
		if(peg_h>0) translate([0,0,socket_hole_h]) cylinder(r1=socket_hole_d/2,r2=0,h=socket_hole_d/2);
    }
    for(iy=[0:yn-1]) translate([-8.0*(xn-1)/2,8.0*(iy-yn/2+0.5),-extend]) cube([(xn-1)*8.0,socket_hole_d/8,socket_hole_h+extend],center=true);
    if(yn>1) for(ix=[1:xn-1]) translate([-8.0*ix+4.0,0,-0.1]) cylinder(r=peg_hole_d/2,h=body_th+peg_h+2*extend);
    if(yn%2==0) translate([4,0,0]) cylinder(r=4.0/2,h=2*(body_th+peg_h+extend),center=true);
}

if(render_part=="Fuselage_Connector") {
    difference() {
        Fuselage_Connector_Connector();
        Fuselage_Connector_Holes();
    }
}

module Fuselage_Tail_Clip(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length
	, vtail_angle=vtail_angle
	, tail_front_thickness=tail_front_thickness
	, tail_back_thickness=tail_back_thickness
    ,peg_d=connector_peg_d,peg_h=connector_peg_h,peg_hole_d=connector_peg_hole_d
    , socket_hole_d=connector_socket_hole_d, socket_hole_h=connector_socket_hole_h
	) {
  difference() {
	union() {
	  hull() {
		translate([fuselage_tail_w/2,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th,r1=peg_d/2,h=peg_h,center=false);
		}
		translate([tail_body_length+peg_d/2,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th-fuselage_tail_th/4]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th/4,r1=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
		}
	  }
	}
	translate([tail_body_length+peg_d/2,0,0]) cylinder(r=socket_hole_d/2,h=4*(fuselage_tail_th+fuselage_nose_th),center=true);
	translate([tail_body_length+peg_d/2,0,fuselage_nose_th/2]) cylinder(r2=socket_hole_d/2+fuselage_nose_th/2,r1=socket_hole_d/2,h=fuselage_nose_th/2,center=true);
	hull() {
	  translate([tail_body_length+peg_d/2,0,0]) cylinder(r=peg_hole_d/2,h=4*(fuselage_tail_th+fuselage_nose_th),center=true);
	  translate([fuselage_tail_w/2,0,0]) cylinder(r=socket_hole_d/2,h=4*(fuselage_tail_th+fuselage_nose_th),center=true);
	}
  }
}

module Fuselage_Tail(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length
	, vtail_angle=vtail_angle
	, tail_front_thickness=tail_front_thickness
	, tail_back_thickness=tail_back_thickness
    ,peg_d=connector_peg_d,peg_h=connector_peg_h,peg_hole_d=connector_peg_hole_d
    , socket_hole_d=connector_socket_hole_d, socket_hole_h=connector_socket_hole_h
	) {
  difference() {
	union() {
	  hull() {
		translate([fuselage_tail_w/2,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th-fuselage_tail_th/4]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th/4,r1=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
		}
		translate([tail_body_length+fuselage_tail_w/2,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th-fuselage_tail_th/4]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th/4,r1=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
		}
	  }
	  translate([tail_body_length+peg_d/2,0,0]) cylinder(r=peg_d/2,h=fuselage_nose_th+peg_h,center=false);
	  translate([fuselage_tail_w/2,0,0]) cylinder(r=peg_d/2,h=fuselage_nose_th+peg_h,center=false);
	  hull() {
	    translate([tail_body_length+peg_d/2,0,fuselage_tail_th]) cylinder(r1=peg_d/2+(fuselage_nose_th-fuselage_tail_th),r2=peg_d/2,h=fuselage_nose_th-fuselage_tail_th,center=false);
	    translate([fuselage_tail_w/2,0,fuselage_tail_th]) cylinder(r1=peg_d/2+(fuselage_nose_th-fuselage_tail_th),r2=peg_d/2,h=fuselage_nose_th-fuselage_tail_th,center=false);
	  }
	  hull() {
		translate([tail_body_length,0,0]) {
			cylinder(r1=fuselage_tail_w/2-fuselage_tail_th/4,r2=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
			translate([0,0,fuselage_tail_th-fuselage_tail_th/4]) cylinder(r2=fuselage_tail_w/2-fuselage_tail_th/4,r1=fuselage_tail_w/2,h=fuselage_tail_th/4,center=false);
		}
		translate([fuselage_length-wing_body_length+fuselage_nose_w/2,0,0]) {
			cylinder(r1=fuselage_nose_w/2-fuselage_nose_th/4,r2=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
			translate([0,0,fuselage_nose_th-fuselage_nose_th/4]) cylinder(r2=fuselage_nose_w/2-fuselage_nose_th/4,r1=fuselage_nose_w/2,h=fuselage_nose_th/4,center=false);
		}
	  }
    }
	translate([tail_body_length+peg_d/2,0,0]) cylinder(r=peg_hole_d/2,h=4*(fuselage_tail_th+fuselage_nose_th),center=true);
	translate([tail_body_length+peg_d/2,0,0]) cylinder(r=socket_hole_d/2,h=fuselage_tail_th,center=true);
	translate([tail_body_length+peg_d/2,0,fuselage_tail_th/2]) cylinder(r1=socket_hole_d/2,r2=0,h=socket_hole_d/2,center=false);

	translate([fuselage_tail_w/2,0,0]) cylinder(r=peg_hole_d/2,h=4*(fuselage_tail_th+fuselage_nose_th),center=true);
	translate([fuselage_tail_w/2,0,0]) cylinder(r=socket_hole_d/2,h=fuselage_tail_th,center=true);
	translate([fuselage_tail_w/2,0,fuselage_tail_th/2]) cylinder(r1=socket_hole_d/2,r2=0,h=socket_hole_d/2,center=false);

	translate([tail_body_length/2+5*tail_front_thickness,fuselage_tail_w/5,0]) rotate([-90+vtail_angle,0,0]) {
		cube([3*tail_body_length/4+2*tail_front_thickness,2*tail_front_thickness,tail_body_length],center=true);
		// translate([tail_body_length/8,0,0]) cube([3*tail_body_length/4,2*tail_front_thickness,3*tail_front_thickness],center=false);
	}
	//translate([0,fuselage_tail_w/2,0]) cube([2*(tail_body_length-2*tail_front_thickness),fuselage_tail_w/2,tail_body_length],center=true);
	translate([tail_body_length/2+5*tail_front_thickness,-fuselage_tail_w/5,0]) rotate([90-vtail_angle,0,0]) {
		cube([3*tail_body_length/4+2*tail_front_thickness,2*tail_front_thickness,tail_body_length],center=true);
		//translate([tail_body_length/8,0,0]) mirror([0,1,0]) cube([3*tail_body_length/4,2*tail_front_thickness,3*tail_front_thickness],center=false);
	}
	//translate([0,-fuselage_tail_w/2,0]) cube([2*(tail_body_length-2*tail_front_thickness),fuselage_tail_w/2,tail_body_length],center=true);
  }
  //translate([tail_body_length/2,0,tail_front_thickness/2]) cube([3*tail_body_length/4,3*fuselage_tail_w/4,tail_front_thickness],center=true);
}

module Fuselage_Body(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length
	, vtail_angle=vtail_angle
	, tail_front_thickness=tail_front_thickness
	, tail_back_thickness=tail_back_thickness
	) {
  difference() {
	union() {
      Fuselage_Tail(fuselage_length=fuselage_length
            , fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
            , wing_body_length=wing_body_length
            , fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
            , tail_body_length=tail_body_length
            , vtail_angle=vtail_angle
            , tail_front_thickness=tail_front_thickness
            , tail_back_thickness=tail_back_thickness
            );
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
  }
}

if(render_part=="Fuselage_Body") {
	Fuselage_Body();
}

if(render_part=="Fuselage_Tail") {
    difference() {
      union() {
        Fuselage_Tail();
	translate([-fuselage_tail_w,-tail_body_length/2,0]) rotate([0,0,90]) Fuselage_Tail_Clip();
    	translate([tail_body_length,fuselage_tail_w,0]) Tail_3D();
    	translate([tail_body_length,-fuselage_tail_w,0]) Tail_3D(side=-1);
    	translate([tail_body_length+24,0,0]) Fuselage_Connector_Connector();
      }
      translate([tail_body_length+24,0,0]) Fuselage_Connector_Holes();
    }
}

module PaperFly(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length, tail_front_thickness=tail_front_thickness, tail_back_thickness=tail_back_thickness
	) {
  translate([0,-fuselage_length/2,0]) rotate([0,0,90]) difference() {
    union() {
	Fuselage_Body();
	translate([-fuselage_tail_w,-tail_body_length/2,0]) rotate([0,0,90]) Fuselage_Tail_Clip();
	translate([fuselage_length,fuselage_nose_w/2,0]) Wing_3D();
	translate([fuselage_length,-fuselage_nose_w/2,0]) Wing_3D(side=-1);
	translate([tail_body_length,fuselage_tail_w,0]) Tail_3D();
	translate([tail_body_length,-fuselage_tail_w,0]) Tail_3D(side=-1);
	translate([fuselage_length,0,0]) Fuselage_Connector_Connector();
    }
    translate([fuselage_length,0,0]) Fuselage_Connector_Holes();
  }
}

if(render_part=="PaperFly") {
    translate([nozzle_offset,0,0]) PaperFly();
}

module PaperFly_Parts(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
    , wing_front_thickness=wing_front_thickness,wing_back_thickness=wing_back_thickness
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length, tail_front_thickness=tail_front_thickness, tail_back_thickness=tail_back_thickness
	, nozzle_separation=nozzle_separation
    ,peg_d=connector_peg_d,peg_h=connector_peg_h,peg_hole_d=connector_peg_hole_d
    , socket_hole_d=connector_socket_hole_d, socket_hole_h=connector_socket_hole_h
	, parts="wings",body_count=2
	, fill_th=0.0
	) {
  if(parts=="body") translate([0,-fuselage_length/2,0]) for(i=[0:body_count-1]) translate([2*nozzle_separation*i-nozzle_separation,0,0]) {
	translate([nozzle_separation-0.75*nozzle_separation,0,0]) {
	  rotate([0,0,90]) difference() {
		union() {
			Fuselage_Body(wing_body_length=wing_body_length);
			translate([fuselage_length,0,0]) Fuselage_Connector_Connector();
		}
	     translate([fuselage_length,0,0]) Fuselage_Connector_Holes();
	  }
	  translate([1.5*fuselage_tail_w+1.0,3*fuselage_length/4-peg_d,0]) rotate([0,0,90]) Fuselage_Tail_Clip();
	  translate([1.5*fuselage_tail_w+1.0,fuselage_length/2+8,0]) rotate([0,0,90]) difference() {
		Fuselage_Connector_Connector(body_th=wing_front_thickness,peg_h=0);
		Fuselage_Connector_Holes(body_th=wing_front_thickness,peg_h=0);
	  }
	  translate([1.5*fuselage_tail_w+1.0,fuselage_length/2-24,0]) rotate([0,0,90]) difference() {
		hull() {
			Fuselage_Connector_Connector(body_th=2.4,peg_h=1.8);
			translate([-20,-8,0]) cube([8,16,6.4],center=false);
		}
		Fuselage_Connector_Holes(body_th=3.2,peg_h=3.2,socket_hole_h=3.2,peg_hole_d=1.9);
	  }
	}
  }
  if(parts=="wings") translate([0,-wing_span/4,0]) {
	translate([nozzle_separation*(3+(wing_body_length-wing_body_length%nozzle_separation)/nozzle_separation),0,0]) difference() {
	  union() {
         Wing_3D(wing_body_length=wing_body_length,fill_th=fill_th);
         translate([-4,0,0]) Fuselage_Connector_Connector(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
       }
       translate([-4,0,0]) Fuselage_Connector_Holes(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
     }

	translate([nozzle_separation*0,0,0]) rotate([0,0,180]) difference() {
        union() {
          Wing_3D(side=-1,wing_body_length=wing_body_length,fill_th=fill_th);
          translate([-4,0,0]) Fuselage_Connector_Connector(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
        }
        translate([-4,0,0]) Fuselage_Connector_Holes(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
     }
	translate([-2*nozzle_separation+2.0,tail_span/2+(wing_span-tail_span)/16,0]) {
		translate([tail_body_length,(wing_span-tail_span)/8,0]) Tail_3D(fill_th=fill_th);
		// translate([-2,0,0]) Fuselage_Tail_Clip();
		translate([tail_body_length,-fuselage_tail_w,0]) Tail_3D(side=-1,fill_th=fill_th);
	}
  }
	for(i=[-1:2]) translate([2*i*nozzle_separation,0,-wing_front_thickness]) {
		% cube([nozzle_separation,2*nozzle_separation,wing_front_thickness],center=false);
		% rotate([0,0,180]) cube([nozzle_separation,2*nozzle_separation,wing_front_thickness],center=false);
	}
}

if(render_part=="PaperFly_Parts_wings") {
    PaperFly_Parts(parts="wings");
}
if(render_part=="PaperFly_Parts_body") {
    translate([-nozzle_separation*0,0,0]) PaperFly_Parts(parts="body",body_count=2);
}

if(render_part=="PaperFly_Parts") {
    PaperFly_Parts(parts="wings",wing_body_length=55,fill_th=0.0);
    PaperFly_Parts(parts="body",wing_body_length=55,body_count=1);
}
if(render_part=="PaperFly_Parts_wings45") {
    PaperFly_Parts(parts="wings",wing_body_length=45);
}

module PaperFly_Parts_Large(fuselage_length=fuselage_length
	, fuselage_nose_w=fuselage_nose_w,fuselage_nose_th=fuselage_nose_th
    , wing_front_thickness=wing_front_thickness,wing_back_thickness=wing_back_thickness
	, wing_body_length=wing_body_length
	, fuselage_tail_w=fuselage_tail_w,fuselage_tail_th=fuselage_tail_th
	, tail_body_length=tail_body_length, tail_front_thickness=tail_front_thickness, tail_back_thickness=tail_back_thickness
	, nozzle_separation=nozzle_separation
    ,peg_d=connector_peg_d,peg_h=connector_peg_h,peg_hole_d=connector_peg_hole_d
    , socket_hole_d=connector_socket_hole_d, socket_hole_h=connector_socket_hole_h
	, parts="wings",body_count=2
	, fill_th=0.0
	) {
  if(parts=="body") translate([0,-fuselage_length/2,0]) {
	translate([-nozzle_separation/4,0,0]) {
	  rotate([0,0,90]) difference() {
		union() {
			Fuselage_Body(wing_body_length=wing_body_length);
			translate([fuselage_length,0,0]) Fuselage_Connector_Connector();
		}
	     translate([fuselage_length,0,0]) Fuselage_Connector_Holes();
	  }
	  translate([1.5*fuselage_tail_w+1.0,3*fuselage_length/4-peg_d,0]) rotate([0,0,90]) Fuselage_Tail_Clip();
	  translate([1.5*fuselage_tail_w+1.0,fuselage_length/2+8,0]) rotate([0,0,90]) difference() {
		Fuselage_Connector_Connector(body_th=wing_front_thickness,peg_h=0);
		Fuselage_Connector_Holes(body_th=wing_front_thickness,peg_h=0);
	  }
	  translate([1.5*fuselage_tail_w+1.0,fuselage_length/2-24,0]) rotate([0,0,90]) difference() {
		hull() {
			Fuselage_Connector_Connector(body_th=2.4,peg_h=1.8);
			translate([-20,-8,0]) cube([8,16,6.4],center=false);
		}
		Fuselage_Connector_Holes(body_th=3.2,peg_h=3.2,socket_hole_h=3.2,peg_hole_d=1.9);
	  }
	}
  }
  if(parts=="wings") translate([0,0,0]) {
	translate([wing_body_length+nozzle_separation,-wing_span/4,0]) rotate([0,0,0]) difference() {
	  union() {
         Wing_3D(wing_body_length=wing_body_length,fill_th=fill_th,wing_span=wing_span);
         translate([-4,0,0]) Fuselage_Connector_Connector(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
       }
       translate([-4,0,0]) Fuselage_Connector_Holes(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
     }

	translate([-wing_body_length-nozzle_separation,-wing_span/4,0]) rotate([0,0,180]) difference() {
        union() {
          Wing_3D(side=-1,wing_body_length=wing_body_length,fill_th=fill_th,wing_span=wing_span);
          translate([-4,0,0]) Fuselage_Connector_Connector(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
        }
        translate([-4,0,0]) Fuselage_Connector_Holes(yn=1,xn=3,body_th=wing_front_thickness,peg_h=0);
     }
	translate([0,0,0]) {
		translate([wing_body_length,wing_span/8,0]) rotate([0,0,180]) Tail_3D(fill_th=fill_th);
		// translate([-2,0,0]) Fuselage_Tail_Clip();
		translate([-wing_body_length,wing_span/8,0]) Tail_3D(side=-1,fill_th=fill_th);
	}
  }
	for(i=[-1:2]) translate([2*i*nozzle_separation,0,-wing_front_thickness]) {
		% cube([nozzle_separation,2*nozzle_separation,wing_front_thickness],center=false);
		% rotate([0,0,180]) cube([nozzle_separation,2*nozzle_separation,wing_front_thickness],center=false);
	}
}

if(render_part=="PaperFly_Parts_Large") translate([0*nozzle_separation/2,0,0]) {
    % translate([0,0,-1]) cube([230,150,1],center=true);
    PaperFly_Parts_Large(parts="wings",wing_span=270,wing_body_length=75,fill_th=0.0);
    PaperFly_Parts_Large(parts="body",wing_body_length=55,body_count=1);
}
