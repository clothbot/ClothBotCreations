// RepRap Logo

module reprap_logo_2d(size=10.0) {
  // size=2*(1+sqrt(2))*r, r=0.5*size/(1+sqrt(2))
  r=size/(1+sqrt(2));
  translate([0,r-size/2]) {
    circle($fn=32,r=r);
    rotate(45) square(r,center=false);
  }
}

% circle($fn=32,r=5.0);
reprap_logo_2d(size=10.0);

