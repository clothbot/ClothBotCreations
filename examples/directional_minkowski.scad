// directional minkwoski

module myShape() {
    difference() {
        scale([1,4]) circle(10);
        circle(5);
    }
}

%myShape();

module extend_yp(d=1.0,overlap=0.1,angle=0,scale_d=0.001) {
    intersection() {
        minkowski() {
            rotate(angle) translate([-overlap,0]) square([scale_d*d+overlap,d],center=false);
            children();
        }
        minkowski() {
            rotate(angle) translate([overlap,0]) mirror([1,0]) square([scale_d*d+overlap,d],center=false);
            children();
        }
    }
}

difference() {
    extend_yp(4,0,360*$t) myShape();
    myShape();
}

