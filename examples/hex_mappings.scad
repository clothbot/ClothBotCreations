// Hexagonal Distributions
test_module="test square_hex_map";

module square_hex_map(spacing=1.0,grid=[7,7]) {
    for(xi=[0:grid[0]-1], yj=[0:grid[1]-1]) {
        translate([xi*spacing,yj*spacing+0.5*xi*spacing]) {
            children( (xi%7+3*yj%7)%7 );
        }
    }
}

if(test_module == "test square_hex_map") {
    echo("Testing square_hex_map");
    square_hex_map(spacing=1.0,grid=[7,7]) {
        text("1");
        text("2");
        text("3");
        text("4");
        text("5");
        text("6");
        text("7");
    }
}
