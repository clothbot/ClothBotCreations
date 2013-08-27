// hex walk

module hex_walk(dist=10.0,depth=4,dir=60) {
    if(depth>0) rotate(dir) translate([dist,0]) hex_walk(dist=dist,depth=depth-1,dir=-1*dir) child(0);
    child(0);
}

