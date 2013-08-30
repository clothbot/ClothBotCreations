// Simple Unfolded Cube

use <OpenHardwareLogo.scad>
use <RepRapLogo.scad>

render_part="unfolded_cube_map"; // unfolded_cube_map()
render_part="unfolded_cube_w_led"; // unfolded_cube_w_led()
render_part="unfolded_oshw_cube_w_led"; // unfolded_oshw_cube_w_led()
render_part="unfolded_oshw_reprap_cube_w_led"; // unfolded_oshw_reprap_cube_w_led()
render_part="unfolded_oshw_reprap_cube_w_led_4x"; // unfolded_oshw_reprap_cube_w_led() x 4
render_part="unfolded_oshw_reprap_cube_w_led_large"; // unfolded_oshw_reprap_cube_w_led()


module frame_2d(size,th) {
  difference() {
    square(size,center=true);
    square(size-2*th,center=true);
  }
}

module hinge(size,spacing,wall_h,wall_th) {
  hull() {
    translate([size/2-spacing+wall_th/2,-size/2+spacing-wall_th/2,(1-3/8)*wall_h]) cylinder($fn=8,r=wall_th/2,h=3*wall_h/4,center=true);
    translate([size/2+2*spacing-wall_th/2, size/2-spacing+wall_th/2,(1-3/8)*wall_h]) cylinder($fn=8,r=wall_th/2,h=3*wall_h/4,center=true);
  }
}


module double_hinge(size,spacing,wall_h,wall_th) {
  hull() {
    translate([size/2-spacing+wall_th/2,-size/2+2*spacing-wall_th/2,(1-3/8)*wall_h]) cylinder($fn=8,r=wall_th/2,h=3*wall_h/4,center=true);
    translate([size/2+2*spacing-wall_th/2, -spacing+wall_th/2,(1-3/8)*wall_h]) cylinder($fn=8,r=wall_th/2,h=3*wall_h/4,center=true);
  }
  hull() {
    translate([size/2-spacing+wall_th/2,spacing-wall_th/2,(1-3/8)*wall_h]) cylinder($fn=8,r=wall_th/2,h=3*wall_h/4,center=true);
    translate([size/2+2*spacing-wall_th/2, size/2-2*spacing+wall_th/2,(1-3/8)*wall_h]) cylinder($fn=8,r=wall_th/2,h=3*wall_h/4,center=true);
  }
}


module unfolded_cube_map(size=15.0,spacing=1.0,wall_th=2.0,wall_h=1.0,add_hinges=true) {
  // Top face is center  face 0    
  linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
  if(add_hinges) for(i=[0:3]) rotate([0,0,360*i/4]) hinge(size,spacing,wall_h,wall_th);
  if($children>0) child(0);
  // CCW from X+
  // face 1
  translate([size+spacing,0,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>1) child(1);
  }
  // face 2
  translate([0,size+spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>2) child(2);
  }
  // face 3
  translate([-size-spacing,0,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>3) child(3);
  }
  // face 4
  translate([0,-size-spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>4) child(4);
  }
  // Bottom face 5
  translate([0,-2*(size+spacing),0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    rotate([0,0,90]) hinge(size,spacing,wall_h,wall_th);
    if($children==1) child(0);
    if($children>5) child(5);
  }
}

if(render_part=="unfolded_cube_map") {
  echo("Rendering unfolded_cube_map()...");
  unfolded_cube_map();
}

module led_holder(size,spacing,inner_h,wall_h,wall_th,led_d) {
  intersection() {
    hull() {
      translate([0,0,wall_h/2]) cube([size-spacing,size-spacing,wall_h],center=true);
      translate([0,0,inner_h-wall_h/2]) cube([size-2*inner_h-spacing,size-2*inner_h-spacing,wall_h],center=true);
    }
    union() {
      difference() {
	  cylinder(r=led_d/2+wall_th,h=2*inner_h,center=true);
	  cylinder(r=led_d/2,h=2*inner_h+wall_h,center=true);
	}
	for(i=[0:3]) rotate([0,0,360*i/4+45]) translate([led_d/2+wall_th/2,-wall_th/2,wall_h/2]) cube([size,wall_th,wall_h],center=false);
    }
  }
}

module unfolded_cube_w_led(size=20.0, spacing=1.0, inner_h=5.0, wall_h=0.5,wall_th=2.0, led_d=5.2) {
  $fn=16;
  unfolded_cube_map(size=size,wall_th=wall_th,wall_h=wall_h,spacing=spacing) led_holder(size,spacing,inner_h,wall_h,wall_th,led_d);
}

if(render_part=="unfolded_cube_w_led") {
  echo("Rendering unfolded_cube_w_led()...");
  unfolded_cube_w_led(wall_h=0.5,led_d=5.6,inner_h=1.25);
}

module unfolded_oshw_cube_w_led(size=30.0, spacing=2.0, inner_h=5.0, wall_h=0.5,wall_th=2.0, led_d=5.2) {
  $fn=16;
  unfolded_cube_map(size=size,wall_th=wall_th,wall_h=wall_h,spacing=spacing) {
    led_holder(size,spacing,inner_h,wall_h,wall_th,led_d); // Top face object

    linear_extrude(height=inner_h) rotate(90) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) oshw_logo_2d(scale=(size-wall_th/2)/200);
    linear_extrude(height=inner_h) rotate(180) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) oshw_logo_2d(scale=(size-wall_th/2)/200);
    linear_extrude(height=inner_h) rotate(-90) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) oshw_logo_2d(scale=(size-wall_th/2)/200);
    linear_extrude(height=inner_h) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) oshw_logo_2d(scale=(size-wall_th/2)/200);
    led_holder(size,spacing,inner_h,wall_h,wall_th,led_d); // Bottom face object

  }
}

if(render_part=="unfolded_oshw_cube_w_led") {
  echo("Rendering unfolded_oshw_cube_w_led()...");
  rotate([0,0,-90]) unfolded_oshw_cube_w_led(wall_h=0.50,wall_th=1.0,led_d=5.6,inner_h=1.5);
}

module unfolded_tab(size=15.0,spacing=1.0,wall_th=2.0,wall_h=1.0) {
  tab_w=size-spacing-8*wall_th;
  tab_h=2*wall_h+1.2*wall_th;
  translate([0,(size-spacing)/2,wall_h/2]) difference() {
    translate([0,tab_h/2,0]) cube([tab_w,tab_h,wall_h],center=true);
    translate([0,tab_h/2,0]) cube([tab_w-2*wall_th,1.2*wall_h,2*wall_h],center=true);
  }
} 

module unfolded_slot(size=15.0,spacing=1.0,wall_th=2.0,wall_h=1.0) {
  slot_w=size-spacing-2*wall_th;
  slot_h=2*wall_h+1.5*wall_th;
  translate([0,(size-spacing)/2,wall_h/2]) difference() {
    translate([0,slot_h/2-wall_th,0]) cube([slot_w,slot_h,wall_h],center=true);
    translate([0,slot_h/2-wall_th,0]) cube([slot_w-2*wall_th,1.5*wall_h,2*wall_h],center=true);
  }
} 


module unfolded_cube_map_s(size=15.0,spacing=1.0,wall_th=2.0,wall_h=1.0,add_hinges=true,add_tabs=true) {
  // Top face is center  face 0    
  linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
  if(add_hinges) double_hinge(size,spacing,wall_h,wall_th);
  if(add_hinges) rotate(-90) double_hinge(size,spacing,wall_h,wall_th);
  if(add_tabs) unfolded_tab(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
  if(add_tabs) rotate(90) unfolded_tab(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
  if($children>0) child(0);
  // CCW from X+
  // face 1
  translate([size+spacing,0,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if(add_tabs) rotate(-90) unfolded_slot(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_tabs) rotate(180) unfolded_slot(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_hinges) rotate(90) double_hinge(size,spacing,wall_h,wall_th);
    if($children==1) child(0);
    if($children>1) child(1);
  }
  // face 2
  translate([size+spacing,size+spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if(add_tabs) rotate(-90) unfolded_slot(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_tabs) rotate(90) unfolded_slot(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_tabs) unfolded_tab(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if($children==1) child(0);
    if($children>2) child(2);
  }
  // face 3
  translate([-size-spacing,-size-spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if(add_tabs) unfolded_slot(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_tabs) rotate(90) unfolded_slot(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_hinges) double_hinge(size,spacing,wall_h,wall_th);
    if($children==1) child(0);
    if($children>3) child(3);
  }
  // face 4
  translate([0,-size-spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if(add_tabs) rotate(-90) unfolded_tab(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_tabs) rotate(180) unfolded_slot(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if($children==1) child(0);
    if($children>4) child(4);
  }
  // Bottom face 5
  translate([-size-spacing,-2*(size+spacing),0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if(add_tabs) rotate(90) unfolded_tab(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_tabs) rotate(-90) unfolded_tab(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    if(add_tabs) rotate(180) unfolded_tab(size=size,spacing=spacing,wall_th=wall_th,wall_h=wall_h);
    rotate([0,0,90]) double_hinge(size,spacing,wall_h,wall_th);
    if($children==1) child(0);
    if($children>5) child(5);
  }
}


module unfolded_oshw_reprap_cube_w_led(size=30.0, spacing=2.0, inner_h=5.0, wall_h=0.5,wall_th=2.0, led_d=5.2) {
  $fn=16;
  unfolded_cube_map_s(size=size,wall_th=wall_th,wall_h=wall_h,spacing=spacing) {
    led_holder(size,spacing,inner_h,wall_h,wall_th,led_d); // Top face object
    render() intersection() {
      hull() {
        translate([0,0,wall_h/2]) cube([size-spacing,size-spacing,wall_h],center=true);
        translate([0,0,inner_h-wall_h/2]) cube([size-2*inner_h-spacing,size-2*inner_h-spacing,wall_h],center=true);
      }
      linear_extrude(height=inner_h) rotate(90) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) oshw_logo_2d(scale=(size+spacing)/200);
    }
    rotate(-90) render() intersection() {
      hull() {
        translate([0,0,wall_h/2]) cube([size-spacing,size-spacing,wall_h],center=true);
        translate([0,0,inner_h-wall_h/2]) cube([size-2*inner_h-spacing,size-2*inner_h-spacing,wall_h],center=true);
      }
      linear_extrude(height=inner_h) rotate(180) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) reprap_logo_2d(size=(size-spacing-wall_th));
    }
    render() intersection() {
      hull() {
        translate([0,0,wall_h/2]) cube([size-spacing,size-spacing,wall_h],center=true);
        translate([0,0,inner_h-wall_h/2]) cube([size-2*inner_h-spacing,size-2*inner_h-spacing,wall_h],center=true);
      }
      linear_extrude(height=inner_h) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) render() oshw_logo_2d(scale=(size+spacing)/200);
    }
    render() intersection() {
      hull() {
        translate([0,0,wall_h/2]) cube([size-spacing,size-spacing,wall_h],center=true);
        translate([0,0,inner_h-wall_h/2]) cube([size-2*inner_h-spacing,size-2*inner_h-spacing,wall_h],center=true);
      }
      linear_extrude(height=inner_h) shell_2d(width=wall_th,steps=8,scale_x=1.0,scale_y=1.0) reprap_logo_2d(size=(size-spacing-wall_th));
   } 
   led_holder(size,spacing,inner_h,wall_h,wall_th,led_d); // Bottom face object

  }
}

uorcwl_size=20.0;
uorcwl_spacing=2.0;
if(render_part=="unfolded_oshw_reprap_cube_w_led") {
  echo("Rendering unfolded_oshw_reprap_cube_w_led()...");
  rotate(45) translate([0,(uorcwl_size+uorcwl_spacing)/2,0]) unfolded_oshw_reprap_cube_w_led(size=uorcwl_size,spacing=uorcwl_spacing,wall_h=0.75,wall_th=0.8,led_d=5.6,inner_h=1.5);
}

uorcwl_count=4;
if(render_part=="unfolded_oshw_reprap_cube_w_led_4x") {
  echo("Rendering unfolded_oshw_reprap_cube_w_led() x 4...");
  for(i=[0:uorcwl_count-1]) translate([(i-(uorcwl_count-1)/2)*sqrt(2)*uorcwl_size,0,0])
  rotate(45) translate([0,(uorcwl_size+uorcwl_spacing)/2,0]) unfolded_oshw_reprap_cube_w_led(size=uorcwl_size,spacing=uorcwl_spacing,wall_h=0.75,wall_th=0.8,led_d=5.6,inner_h=1.5);
}

uorcwl_size_large=40.0;
if(render_part=="unfolded_oshw_reprap_cube_w_led_large") {
  echo("Rendering large unfolded_oshw_reprap_cube_w_led()...");
  rotate(90+45) 
   translate([0,(uorcwl_size_large+uorcwl_spacing)/2,0])
	unfolded_oshw_reprap_cube_w_led(size=uorcwl_size_large,spacing=uorcwl_spacing,wall_h=0.75,wall_th=0.8,led_d=5.6,inner_h=1.5);
}
