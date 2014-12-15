include <pins.scad>

// default is 0.3
tolerance = 0.3;

// pinpeg(h=40);
// pin();
// pin(side=true);
// pinhole(t=tolerance);
// pintack(h=10, r=4);
//pins();

// wheel();
// translate([-25/2, 0, 0]) axel_tight();
// translate([-25/2, 0, 0]) axel_loose();
// translate([-25/2, 0, 0]) axel_loose_and_tight();
plate();
//plate_simple();

module pins() {
  translate([-21, 0, 0]) pinpeg(h=20);
  translate([0, 0, 0]) pintack(h=11);
  translate([21, 0, 0]) pintack(h=11);
}

module wheel() {
  difference() {
    union() {
      translate([0, 0, 10]) cylinder(h=5, r1=20/2, r2=17/2);
      translate([0, 0, 5]) cylinder(h=5, r=20/2);
      translate([0, 0, 0]) cylinder(h=5, r1=17/2, r2=20/2);
    }

    translate([0, 0, 11]) cylinder(h=15, r=13/2);    
    pinhole(h=5, t=tolerance);
  }  
}

module axel_tight() {
  difference() {
    union() {
      translate([0, -2.5, 0]) cube([25, 5, 5]);
      cylinder(h=5, r=5*1.75);
      translate([25, 0, 0]) cylinder(h=12, r=5*1.75);
    }
  
    pinhole(h=5, t=tolerance);
    translate([25, 0, 10+2]) rotate([180, 0, 0]) pinhole(h=8, t=tolerance);
  }
}

module axel_loose() {
  difference() {
    union() {
      translate([0, -2.5, 0]) cube([25, 5, 5]);
      cylinder(h=5, r=5*1.75);
      translate([25, 0, 0]) cylinder(h=5, r=5*1.75);
    }
  
    translate([0, 0, 5]) rotate([180, 0, 0]) pinhole(h=5, t=tolerance, tight=false);
    translate([25, 0, 0]) pinhole(h=5, t=tolerance, tight=false);
  }
}

module axel_loose_and_tight() {
  difference() {
    union() {
      translate([0, -2.5, 0]) cube([25, 5, 5]);
      cylinder(h=5, r=5*1.75);
      translate([25, 0, 0]) cylinder(h=5, r=5*1.75);
    }
  
    pinhole(h=10, t=tolerance);
    translate([25, 0, 0]) pinhole(h=10, t=tolerance, tight=false);
  }
}

module plate() {
  %translate([0, 0, -0.5]) cube([100, 100, 1], center=true);
  
  translate([0, 21, 0]) pins();

  translate([-21, 0, 0]) wheel();

  translate([-21, -21, 0]) wheel();

  translate([0, 0, 0]) axel_tight();

  translate([0, -20, 0]) axel_loose();
}

module plate_simple() {
  %translate([0, 0, -0.5]) cube([100, 100, 1], center=true);
  
 translate([-10.5, 10.5, 0]) pintack(h=11);
 translate([10.5, 10.5, 0]) pintack(h=11);
 translate([-25/2, -10.5, 0]) axel_loose_and_tight();
  
}