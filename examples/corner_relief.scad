// corner relief
in2mm=25.4;
test_render="test corner_relief";
test_render="test complex corner_relief";
test_render="test acute corner_relief";


test_frame_size=in2mm*[10,10];
test_frame_wall_th=1.0*in2mm;
test_tool_d=1/16*in2mm;

module frame(size=[20,10],wall_th=2.0) {
    difference() {
        square(size,center=true);
        square([size[0]-2*wall_th,size[1]-2*wall_th],center=true);
    }
}

//%frame(size=[100,100]);
module corner_relief(d=1/16,delta=0.1,mode="miter",compensate=0.0) {
    %children();
    minkowski() {
        difference() {
            if(mode=="round") {
                offset(join_type="round",delta=-delta,$fn=16) offset(join_type="miter",delta=compensate) children();
            }
            offset(join_type="bevel",delta=-delta,$fn=16) offset(join_type="miter",delta=compensate) children();
            if(mode=="miter") {
                offset(join_type="miter",delta=-delta,$fn=16) offset(join_type="miter",delta=compensate) children();
            }
        }
        circle(d=d-delta,$fn=16);
    }
}

if(0) {
    difference() {
        offset(join_type="round",delta=-1/16) frame(size=[10,10]);
        offset(join_type="bevel",delta=-1/16) frame(size=[10,10]);
    }
}


if(test_render=="test corner_relief") {
    echo("Testing corner_relief.");
    for(xi=[-1,1],yj=[-1,1]) {
        translate([xi*(test_frame_size[0]/2-test_frame_wall_th-test_tool_d),yj*(test_frame_size[1]/2-test_frame_wall_th-test_tool_d)]) % circle(d=test_tool_d,$fn=16);
    }
    difference() {
        frame(size=test_frame_size,wall_th=test_frame_wall_th);
        corner_relief(d=test_tool_d,delta=0.1) {
            frame(size=test_frame_size,wall_th=test_frame_wall_th);
        }
    }        
}

module complex_frame(size=[20,10],wall_th=2.0) {
    difference() {
        union() {
            square(size,center=true);
            rotate(45) square(size,center=true);
        }
        square([size[0]-2*wall_th,size[1]-2*wall_th],center=true);
        rotate(45) square([size[0]-2*wall_th,size[1]-2*wall_th],center=true);
    }
}

if(test_render=="test complex corner_relief") {
    echo("Testing corner_relief.");
    for(xi=[-1,1],yj=[-1,1]) {
        translate([xi*(test_frame_size[0]/2-test_frame_wall_th-test_tool_d),yj*(test_frame_size[1]/2-test_frame_wall_th-test_tool_d)]) % circle(d=test_tool_d,$fn=16);
    }
    difference() {
        complex_frame(size=test_frame_size,wall_th=test_frame_wall_th);
        corner_relief(d=test_tool_d,delta=0.1) {
            complex_frame(size=test_frame_size,wall_th=test_frame_wall_th);
        }
    }        
}

module acute_frame(size=[20,10],wall_th=2.0) {
    difference() {
        union() {
            square(size,center=true);
            rotate(45) square(size,center=true);
        }
        circle(d=sqrt(pow(size[0],2)+pow(size[1],2))/2,$fn=3);
    }
}

if(test_render=="test acute corner_relief") {
    echo("Testing acute corner_relief.");
    for(xi=[-1,1],yj=[-1,1]) {
        translate([xi*(test_frame_size[0]/2-test_frame_wall_th-test_tool_d),yj*(test_frame_size[1]/2-test_frame_wall_th-test_tool_d)]) % circle(d=test_tool_d,$fn=16);
    }
    difference() {
        acute_frame(size=test_frame_size,wall_th=test_frame_wall_th);
        # corner_relief(d=test_tool_d,delta=0.1,mode="round",compensate=0.05) {
            acute_frame(size=test_frame_size,wall_th=test_frame_wall_th);
        }
    }        
}