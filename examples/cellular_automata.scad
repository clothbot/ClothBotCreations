// Cellular Automata
test_module="test ca_2x2_match";
test_module="test ca_2x2_map";
test_module="test ca_2x2_grid_match_simple";
test_module="test ca_2x2_grid_match_2x2";
test_module="test ca_2x2_grid_4x4_match";
test_module="test ca_2x2_grid_4x4_map";
test_module="test union ca_2x2_grid_4x4_map";

test_pattern=[[1,0],[1,1]];
test_match=[[1,0],[1,1]];
test_map=[[0,1],[1,0]];

test_match_any_list=[
	 [[1,0],[1,1]]
        ,[[0,1],[1,1]]
        ,[[1,1],[0,1]]
        ,[[1,1],[1,0]]
        ];
        

module ca_2x2_match(pattern=[[1,0],[1,1]]) {
    scale([2,2]) difference() {
        intersection_for(xi=[0:1],yj=[0:1]) if(round(pattern[xi][yj])==1) {
            echo(str("ca_2x2_match: intersection_for match at xi=",xi,", yj=",yj));
                intersection() {
                    translate([-xi,-yj]) offset(delta=1.0) intersection() {
                        union() children();
                        translate([xi,yj]) square([1,1],center=false);
                    }
                    square([1,1],center=false);
                }
        }
        for(xi=[0:1],yj=[0:1]) if(round(pattern[xi][yj])==0) {
            echo(str("ca_2x2_match: difference match at xi=",xi,", yj=",yj));
            intersection() {
                translate([-xi,-yj]) offset(delta=1.0) intersection()  {
                    union() children();
                    translate([xi,yj]) square([1,1],center=false);
                }
                square([1,1],center=false);
            }
        }
    }
}

module ca_2x2_match_pos(pattern=[[1,0],[1,1]]) {
    scale([2,2]) {
        intersection_for(xi=[0:1],yj=[0:1]) if(round(pattern[xi][yj])==1) {
            //echo(str("ca_2x2_match_pos: intersection_for match at xi=",xi,", yj=",yj));
                intersection() {
                    translate([-xi,-yj]) offset(delta=1.0) intersection() {
                        union() children();
                        translate([xi,yj]) square([1,1],center=false);
                    }
                    square([1,1],center=false);
                }
        }
    }
}

module ca_2x2_match_neg(pattern=[[1,0],[1,1]]) {
    scale([2,2]) {
        for(xi=[0:1],yj=[0:1]) if(round(pattern[xi][yj])==0) {
            //echo(str("ca_2x2_match_neg: difference match at xi=",xi,", yj=",yj));
            intersection() {
                translate([-xi,-yj]) offset(delta=1.0) intersection()  {
                    union() children();
                    translate([xi,yj]) square([1,1],center=false);
                }
                square([1,1],center=false);
            }
        }
    }
}

module pattern_2x2(pattern=[[1,0],[1,1]],delta=0) {
    union() for(xi=[0:1]) for(yj=[0:1]) if(round(pattern[xi][yj])==1) {
        translate([xi,yj]) {
            if(delta!=0) {
                offset(delta=delta) square([1,1],center=false);
            } else {
                square([1,1],center=false);
            }
        }
    }
}

if(test_module=="test ca_2x2_match") {
    ca_2x2_match(pattern=test_match) {
        pattern_2x2(pattern=test_pattern);
    }
    %translate([0,0,3]) pattern_2x2(pattern=test_pattern);
    %translate([0,0,1.5]) pattern_2x2(pattern=test_match);
}

module ca_2x2_map(from=[[1,0],[1,1]],to=[[0,1],[1,0]],delta=0.0) {
    echo(str("ca_2x2_map: len(from)=",len(from)));
    intersection() {
        ca_2x2_match(pattern=from) children();
        pattern_2x2(pattern=to,delta=delta);
    }
}
//#square(1,center=false);
if(test_module=="test ca_2x2_map") {
    ca_2x2_map(from=test_match,to=test_map) {
        pattern_2x2(pattern=test_pattern);
    }
    %translate([0,0,3]) pattern_2x2(pattern=test_pattern);
    %translate([0,0,1.5]) pattern_2x2(pattern=test_match);
    %translate([0,0,-1.5]) pattern_2x2(pattern=test_map);
}

module test_2x2_grid_4x4(delta=0.0) {
    for(gx0=[0:1],gx1=[0:1],gy0=[0:1],gy1=[0:1]) translate(2*[gx0+2*gx1,gy0+2*gy1])
        pattern_2x2(pattern=[[gx0,gy0],[gx1,gy1]],delta=delta);
}

module test_2x2_grid_rotate_pattern(pattern=[[1,0],[1,1]],delta=0.0) {
    translate([2,2,]) for(i=[0:3]) rotate(90*i) {
        pattern_2x2(pattern=pattern,delta=delta);
    }
}

module ca_2x2_grid_match_simple(pattern=[[1,0],[1,1]],grid_size=[10,10]) {
    echo(str("ca_2x2_grid_match_simple: $children = ",$children));
    for(gxi=[0:grid_size[0]],gyj=[0:grid_size[1]]) translate([2*gxi,2*gyj]) {
        //ca_2x2_match(pattern=pattern) translate([-2*gxi,-2*gyj]) children();
        difference() {
            ca_2x2_match_pos(pattern=pattern) translate([-2*gxi,-2*gyj]) children();
            ca_2x2_match_neg(pattern=pattern) translate([-2*gxi,-2*gyj]) children();
        }
    }
}

if(test_module=="test ca_2x2_grid_match_simple") {
    ca_2x2_grid_match_simple(pattern=test_match,grid_size=[2,2])
        test_2x2_grid_rotate_pattern(pattern=test_pattern,delta=-0.4);
    %translate([0,0,3]) test_2x2_grid_rotate_pattern(pattern=test_pattern,delta=-0.4);
    %translate([0,0,1.5]) pattern_2x2(pattern=test_match);
}

module ca_gen_grid_mask(pattern=[[1,0],[0,0]],grid_size=[10,10],cell_size=[1,1]) {
    echo(str("ca_gen_grid_mask: $children = ",$children));
    for(gxi=[0:grid_size[0]],gyj=[0:grid_size[1]]) translate([2*gxi,2*gyj]) {
        for(xi=[0:1],yj=[0:1]) if(round(pattern[xi][yj])==1) {
            translate([xi,yj]) square(cell_size,center=false);
        }
    }
}

module ca_2x2_grid_match(pattern=[[1,0],[1,1]],grid_size=[10,10]) {
    difference() {
        intersection_for(xi=[0:1],yj=[0:1]) if(round(pattern[xi][yj])==1) {
            echo(str("ca_2x2_match: intersection_for match at xi=",xi,", yj=",yj));
                translate([0.5,0.5]) offset(delta=0.5) intersection() {
                    translate([-xi,-yj]) offset(delta=1.0) intersection() {
                        union() children();
                        translate([xi,yj]) ca_gen_grid_mask(pattern=[[1,0],[0,0]],grid_size=grid_size);
                    }
                    ca_gen_grid_mask(pattern=[[1,0],[0,0]],grid_size=grid_size,cell_size=[1,1]);
                }
        }
        for(xi=[0:1],yj=[0:1]) if(round(pattern[xi][yj])==0) {
            echo(str("ca_2x2_match: difference match at xi=",xi,", yj=",yj));
            translate([0.5,0.5]) offset(delta=0.5) intersection() {
                translate([-xi,-yj]) offset(delta=1.0) intersection()  {
                    union() children();
                    translate([xi,yj]) ca_gen_grid_mask(pattern=[[1,0],[0,0]],grid_size=grid_size);
                }
                ca_gen_grid_mask(pattern=[[1,0],[0,0]],grid_size=grid_size,cell_size=[1,1]);
            }
        }
    }
}

if(test_module=="test ca_2x2_grid_match_2x2") {
    ca_2x2_grid_match(pattern=test_match,grid_size=[2,2])
        test_2x2_grid_rotate_pattern(pattern=test_pattern,delta=-0.4);
    %translate([0,0,3]) test_2x2_grid_rotate_pattern(pattern=test_pattern,delta=-0.4);
    %translate([0,0,1.5]) pattern_2x2(pattern=test_match);
}

if(test_module=="test ca_2x2_grid_4x4_match") {
    difference() {
        ca_2x2_grid_match(pattern=test_match,grid_size=[4,4])
            test_2x2_grid_4x4(delta=-0.4);
        test_2x2_grid_4x4(delta=-0.2);
    }
    %translate([0,0,-1]) ca_gen_grid_mask(pattern=[[1,0],[0,0]],grid_size=[4,4]);
    //%translate([0,0,3]) test_2x2_grid_4x4(delta=-0.4);
    //%translate([0,0,1.5]) pattern_2x2(pattern=test_match);
    test_2x2_grid_4x4(delta=-0.3);
    translate([-2,-2]) {
        difference() {
            pattern_2x2(pattern=[[1,1],[1,1]],delta=-0.05);
            pattern_2x2(pattern=[[1,1],[1,1]],delta=-0.1);
        }
        pattern_2x2(pattern=test_match,delta=-0.2);
    }
}

module ca_2x2_grid_map(from=[[1,0],[1,1]],to=[[0,1],[1,0]],delta=0.0,grid_size=[10,10]) {
    echo(str("ca_2x2_grid_map: len(from)=",len(from)));
    intersection() {
        ca_2x2_grid_match(pattern=from) children();
        ca_gen_grid_mask(pattern=to,grid_size=grid_size,cell_size=[1,1]);
    }
}

if(test_module=="test ca_2x2_grid_4x4_map") {
    difference() {
        ca_2x2_grid_map(from=test_match,to=test_map,grid_size=[4,4]) {
            test_2x2_grid_4x4(delta=-0.4);
        }
        test_2x2_grid_4x4(delta=-0.2);
    }
    %translate([0,0,1.5]) ca_gen_grid_mask(pattern=test_match,grid_size=[4,4]);
    %translate([0,0,-1.0]) ca_gen_grid_mask(pattern=test_map,grid_size=[4,4]);
    //%translate([0,0,3]) test_2x2_grid_4x4(delta=-0.4);
    //%translate([0,0,1.5]) pattern_2x2(pattern=test_match);
    test_2x2_grid_4x4(delta=-0.3);
    translate([-2,-2]) {
        difference() {
            pattern_2x2(pattern=[[1,1],[1,1]],delta=-0.05);
            pattern_2x2(pattern=[[1,1],[1,1]],delta=-0.1);
        }
        pattern_2x2(pattern=test_match,delta=-0.2);
    }
}

if(test_module=="test union ca_2x2_grid_4x4_map") {
    difference() {
        union() for(this_match=test_match_any_list) {
            ca_2x2_grid_map(from=this_match,to=test_map,grid_size=[4,4])
                test_2x2_grid_4x4(delta=-0.4);
        }
        test_2x2_grid_4x4(delta=-0.2);
    }
    %translate([0,0,1.5]) ca_gen_grid_mask(pattern=test_match,grid_size=[4,4]);
    %translate([0,0,-1.0]) ca_gen_grid_mask(pattern=test_map,grid_size=[4,4]);
    //%translate([0,0,3]) test_2x2_grid_4x4(delta=-0.4);
    //%translate([0,0,1.5]) pattern_2x2(pattern=test_match);
    test_2x2_grid_4x4(delta=-0.3);
    translate([-2,-2]) {
        difference() {
            pattern_2x2(pattern=[[1,1],[1,1]],delta=-0.05);
            pattern_2x2(pattern=[[1,1],[1,1]],delta=-0.1);
        }
        pattern_2x2(pattern=test_match,delta=-0.2);
    }
}
