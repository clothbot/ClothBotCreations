// arc functions
test_module="test circle_point_at_length";


function pi()=3.14159265358979323846;

function circle_circumference(r)=2*pi()*r;

// angle=360*l/circle_circumference(r)
// r*[cos(angle),sin(angle)]
function circle_point_at_length(r,l,offset=[0,0],rotate=0)=(r==0.0)?[0,l]
    :[r*cos(rotate+360*l/circle_circumference(r)), r*sin(rotate+360*l/circle_circumference(r)) ]+offset;

subdivisions=10;
path_length=128;
if(test_module=="test circle_point_at_length") {
    for(i=[0:subdivisions],bend_r=[30:20:200]) translate([0,0,bend_r]) union() {
        translate( circle_point_at_length(bend_r,i*path_length/subdivisions,rotate=-90,offset=[0,bend_r] ) ) {
            color([i/subdivisions,i/subdivisions,i/subdivisions]) cylinder(r1=2,r2=0,h=4);
        }
        if(i>0) hull() {
            translate( circle_point_at_length(bend_r,(i-1)*path_length/subdivisions,rotate=-90,offset=[0,bend_r] ) ) {
                cube();
            }
            translate( circle_point_at_length(bend_r,i*path_length/subdivisions,rotate=-90,offset=[0,bend_r] ) ) {
                cube();
            }
        }
    }
}
