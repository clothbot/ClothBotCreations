// Minkowski-based offset operator

render_test="test offset_3d_shape";
render_test="test offset_3d positive";
render_test="test offset_3d negative";

module offset_3d_shape(r) {
    intersection() {
        cube([2*r,2*r,2*r],center=true);
        rotate([45,0,0]) intersection() {
            cube([4*r,2*r,4*r],center=true);
            cube([4*r,4*r,2*r],center=true);
        }
        rotate([0,45,0]) intersection() {
            cube([4*r,4*r,2*r],center=true);
            cube([2*r,4*r,4*r],center=true);
        }
        rotate([0,0,45]) intersection() {
            cube([2*r,4*r,4*r],center=true);
            cube([4*r,2*r,4*r],center=true);
        }
    }
}

if(render_test=="test offset_3d_shape") {
    echo("Testing offset_3d_shape()...");
    offset_3d_shape(r=10);
}

module offset_3d(r=0) {
    if(r>0) {
        minkowski() {
            children();
            offset_3d_shape(r=r);
        }
    } else if(r<0) {
        render() difference() {
            union() children() ;
            minkowski() {
                render() difference() {
                    render() minkowski() {
                        children();
                        offset_3d_shape(r=-r);
                    }
                    children();
                }
                offset_3d_shape(r=-r);
            }
        }
    }
}

if(render_test=="test offset_3d positive") {
    echo("Testing offset_3d(r=positive)...");
    difference() {
        offset_3d(r=1.0) {
            cube(10,center=true);
        }
        cube(10,center=false);
    }
    %cube(10,center=true);
}
if(render_test=="test offset_3d negative") {
    echo("Testing offset_3d(r=negative)...");
    difference() {
        offset_3d(r=-1.0) {
            sphere(r=5,center=true);
        }
        cube(10,center=false);
    }
    %sphere(r=5,center=true);
}
