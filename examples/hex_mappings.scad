// Hexagonal Distributions
test_module="test square_hex_map";
test_module="test hex_map";

module square_hex_map(spacing=1.0,grid=[7,7]) {
    for(xi=[0:grid[0]-1], yj=[0:grid[1]-1]) {
        translate([xi*spacing,yj*spacing+0.5*xi*spacing]) {
            children( (xi%7+3*yj%7)%7 );
        }
    }
}

module circle_text(string="test",d=1.0) {
    difference() {
        circle($fn=32,d=d);
        resize([0.5*d,0.5*d]) text(string,valign="center",halign="center");
    }
}

if(test_module == "test square_hex_map") {
    echo("Testing square_hex_map");
    square_hex_map(spacing=1.0,grid=[3,3]) {
        circle_text("1",d=0.90);
        circle_text("2",d=0.90);
        circle_text("3",d=0.90);
        circle_text("4",d=0.90);
        circle_text("5",d=0.90);
        circle_text("6",d=0.90);
        circle_text("7",d=0.90);
    }
}

module hex_text(string="test",id=1.0) {
    difference() {
        intersection_for(i=[0:2]) {
            rotate(120*i+90) square([id,3*id],center=true);
        }
        resize([0.5*id,0.5*id]) text(string,valign="center",halign="center");
    }
}

module hex_map(spacing=1.0,grid=[7,7]) {
    for(xi=[0:grid[0]-1], yj=[0:grid[1]-1]) {
        translate([xi*spacing*cos(30),yj*spacing+xi*spacing*sin(30)]) {
            children( (xi%7+3*yj%7)%7 );
        }
    }
}

if(test_module == "test hex_map") {
    echo("Testing hex_map");
    hex_map(spacing=1.0,grid=[7,7]) {
        hex_text("1",id=0.95);
        hex_text("2",id=0.95);
        hex_text("3",id=0.95);
        hex_text("4",id=0.95);
        hex_text("5",id=0.95);
        hex_text("6",id=0.95);
        hex_text("7",id=0.95);
    }
}
