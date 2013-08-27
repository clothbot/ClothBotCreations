// Chain Hull
module chain_hull(points) {
  for(i=[0:$children-1]) for(j=[0:len(points)-2]) render() hull() {
    translate(points[j]) child(i);
    translate(points[j+1]) child(i);
  }
}


