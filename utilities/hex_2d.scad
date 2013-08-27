// hex_2d

module hex_2d(flat_d=10.0,angle=0.0) {
    render() rotate(angle) intersection() {
        square([flat_d,2*flat_d],center=true);
        rotate(60) square([flat_d,2*flat_d],center=true);
        rotate(-60) square([flat_d,2*flat_d],center=true);
    }
}

