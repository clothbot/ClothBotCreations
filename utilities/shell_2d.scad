// 2D Shell Operator
render_part="test_shell_2d";

module shell_2d(th=0.1,n=8) {
    for( i=[0:$children-1]) {
        for(j=[0:n-1]) assign(rot=360*j/n)
            difference() {
                child(i);
                translate([th*cos(rot),th*sin(rot)]) child(i);
            }
    }
}

if(render_part=="test_shell_2d") {
    shell_2d(th=1,n=12) circle(r=10);
}
