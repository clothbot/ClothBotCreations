// truncated circle
module circle_trunc(r,angle=0) {
    render() union() {
        circle(r=r);
        rotate(angle) intersection() {
            square([2*r,2*r],center=true);
            rotate(45) square([r,r],center=false);
        }
    }
}   

