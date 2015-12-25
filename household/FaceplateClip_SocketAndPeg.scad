// Faceplate Clip - Socket and Peg

$fs=0.1;
$fa=15;

// render_part=1; // Faceplate_Clip_Peg()
//render_part=2; // Faceplate_Clip_Socket()
render_part=3; // Faceplate_Clip_Peg and Faceplate_Clip_Socket

module Faceplate_Clip_Peg_Body(extension=0.1
	, base_width=12.0
	, base_length=60.0
	, base_height=2.0
	, peg_outer_length=22.5
	, peg_width=10.0
	, peg_height=13.0
  ) {
  union() {
    translate([-base_length/2,-base_width/2,0]) cube(size=[base_length,base_width,base_height],center=false);
    translate([-peg_outer_length/2+peg_width/2,-peg_width/2,0])
	cube(size=[peg_outer_length-peg_width,peg_width,peg_height+base_height],center=false);
    translate([-peg_outer_length/2+peg_width/2,0,0])
	cylinder(r=peg_width/2,h=peg_height+base_height,center=false);
    translate([peg_outer_length/2-peg_width/2,0,0])
	cylinder(r=peg_width/2,h=peg_height+base_height,center=false);
  }
}

module Faceplate_Clip_Peg_Holes(extension=0.1
	, base_height=2.0
	, peg_height=13.0
	, base_slot_separation=30.0
	, base_slot_width=25.4/8
	, base_slot_length=11.0
	) {
  union() {
    translate([base_slot_separation/2+base_slot_width/2,-base_slot_width/2,-extension])
      cube(size=[base_slot_length-base_slot_width,base_slot_width,2*extension+base_height],center=false);
    translate([base_slot_separation/2+base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
    translate([base_slot_separation/2+base_slot_length-base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
  }
  union() {
    translate([-base_slot_separation/2-base_slot_length+base_slot_width/2,-base_slot_width/2,-extension])
      cube(size=[base_slot_length-base_slot_width,base_slot_width,2*extension+base_height],center=false);
    translate([-base_slot_separation/2-base_slot_length+base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
    translate([-base_slot_separation/2-base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
  }
  translate([0,0,-extension]) cylinder(r=base_slot_width/2,h=2*extension+base_height+peg_height,center=false);
}

module Faceplate_Clip_Peg() {
  difference() {
    Faceplate_Clip_Peg_Body();
    Faceplate_Clip_Peg_Holes();
  }
}

if(render_part==1) {
  echo("Rendering Faceplate_Clip_Peg()...");
  Faceplate_Clip_Peg();
}

module Faceplate_Clip_Socket_Body(extension=0.1
	, base_width=12.0
	, base_length=60.0
	, base_height=2.0
	, peg_outer_length=22.5
	, peg_width=10.0
	, peg_height=13.0
	, clip_th=3.0
  ) {
  translate([-base_length/2,-base_width/2,0]) union() {
    cube(size=[base_length,base_width+peg_width/2,base_height],center=false);
    translate([base_length/2-peg_outer_length/2-clip_th,0,0]) {
	cube(size=[clip_th,1.5*peg_width,base_height+peg_width+clip_th],center=false);
	translate([clip_th,0,peg_width+clip_th+base_height]) rotate([-90,0,0]) cylinder(r=clip_th,h=1.5*peg_width,center=false);
    }
    translate([base_length/2+peg_outer_length/2,0,0]) {
	cube(size=[clip_th,1.5*peg_width,base_height+peg_width+clip_th],center=false);
	translate([0,0,peg_width+clip_th+base_height]) rotate([-90,0,0]) cylinder(r=clip_th,h=1.5*peg_width,center=false);
    }
  }
}

module Faceplate_Clip_Socket_Holes(extension=0.1
	, base_width=12.0
	, base_length=60.0
	, base_height=2.0
	, peg_width=10.0
	, peg_height=13.0
	, base_slot_separation=30.0
	, base_slot_width=25.4/8
	, base_slot_length=11.0
	, base_slot_y_offset=10.0/5
	) {
  translate([0,peg_width/2,0]) union() {
    translate([base_slot_separation/2+base_slot_width/2,-base_slot_width/2,-extension])
      cube(size=[base_slot_length-base_slot_width,base_slot_width,2*extension+base_height],center=false);
    translate([base_slot_separation/2+base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
    translate([base_slot_separation/2+base_slot_length-base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
  }
  translate([0,peg_width/2,0]) union() {
    translate([-base_slot_separation/2-base_slot_length+base_slot_width/2,-base_slot_width/2,-extension])
      cube(size=[base_slot_length-base_slot_width,base_slot_width,2*extension+base_height],center=false);
    translate([-base_slot_separation/2-base_slot_length+base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
    translate([-base_slot_separation/2-base_slot_width/2,0,-extension])
      cylinder(r=base_slot_width/2,h=2*extension+base_height,center=false);
  }
  translate([0,0,-extension]) cylinder(r=base_slot_width/2,h=2*extension+base_height+peg_height,center=false);
}

module Faceplate_Clip_Socket(extension=0.1
	, base_width=12.0
  ) {
  translate([0,base_width/2,0]) difference() {
    Faceplate_Clip_Socket_Body();
    Faceplate_Clip_Socket_Holes();
  }
}

if(render_part==2) {
  echo("Rendering Faceplate_Clip_Socket()...");
  Faceplate_Clip_Socket();
}

if(render_part==3) {
  echo("Rendering Faceplate_Clip_Peg() and Faceplate_Clip_Socket()...");
  rotate([90,0,180]) Faceplate_Clip_Socket();
  translate([0,-10.0,0]) Faceplate_Clip_Peg();
}

