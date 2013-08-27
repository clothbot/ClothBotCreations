// Branching hull operator
module branch_hull(thispt=undef,points,debug=false) {
  for(i=[0:$children-1]) for(j=[0:len(points)-2]) {
    if(thispt==undef) {
        if(len(points[j+1][0])==undef) {
            if(debug) echo("thispt==undef; branching with ",points[j],[points[j+1]]);
            branch_hull(thispt=points[j],points=[points[j+1]]) child(i);
        } else {
            for(k=[0:len(points[j+1])-1]) {
                if(debug) echo("  thispt==undef; branching with ",points[j],[points[j+1][k]]);
                branch_hull(thispt=points[j],points=[points[j+1][k]]) child(i);
            }
        }
    } else if(len(thispt[0])==undef) {
        if(debug) echo("thispt = ",thispt);
        // Leaf node
        if(len(points[j][0])!=undef) {
            if(debug) echo("    Branching with ",points[j]);
            branch_hull(thispt=thispt,points=[points[j]]) child(i);
        } else {
            if(debug) echo("index ",j);
            if(j<=0) {
                if(debug) echo("    Hull between thispt and points[0]",thispt,points[0]);
                hull() {
                    translate(thispt) child(i);
                    translate(points[0]) child(i);
                }
            } else {
                if(debug) echo("    Hull between points[j] and points[j+1]",points[j],points[j+1]);
                hull() {
                    translate(points[j]) child(i);
                    translate(points[j+1]) child(i);
                }
            }
        }
    } else {
        if(debug) echo("Vector thispt",thispt);
        for(k=[0:len(thispt)-1]) {
            branch_hull(thispt=thispt[k],points=points) child(i);
        }
    }
  }
}

