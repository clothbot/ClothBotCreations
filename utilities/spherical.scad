// Spherical Functions

test_module="test sphere_points";
test_module="test sphere_poly";

function pi()=3.14159265358979323846;

function pointOnSphere(radius=1.0,k,N) =
  [ radius*cos(360*k*pi()*(3-sqrt(5))/(2*pi()))*sqrt(1-(k*(2/N)-1+((2/N)/2))*(k*(2/N)-1+((2/N)/2)))
   , radius*(k*(2/N)-1+((2/N)/2))
   , radius*sin(360*k*pi()*(3-sqrt(5))/(2*pi()))*sqrt(1-(k*(2/N)-1+((2/N)/2))*(k*(2/N)-1+((2/N)/2)))
  ];

// Cartesian to Spherical coordinate mapping.
function cart2sphere(x,y,z) = [ // returns [r, inclination, azimuth]
  sqrt( x*x+y*y+z*z )
  , acos(z/sqrt(x*x+y*y+z*z))
  , atan2(y,x)
  ];

// Spherical to Cartesian coordinate mapping.
function sphere2cart(r,inc,azi) = [ // returns [x, y, z]
  r*sin(inc)*cos(azi)
  , r*sin(inc)*sin(azi)
  , r*cos(inc)
  ];

function sphere_surface_area(r)=4*pi()*pow(r,2);
function sphere_volume(r)=4*pi()*pow(r,3)/3;

function sphere_points(r,N) = [for (k=[0:N-1]) pointOnSphere(r,k,N) ];

test_sphere_r=100;
test_sphere_N=100;

if(test_module=="test sphere_points") {
    echo("Testing sphere_points function...");
    coords=sphere_points(test_sphere_r,test_sphere_N);
    for(i=[0:len(coords)-1]) {
        echo(str("Sphere Coordinate: ",coords[i]));
        translate(coords[i]) color([0.5*(coords[i][0]+test_sphere_r)/test_sphere_r,0.5*(coords[i][1]+test_sphere_r)/test_sphere_r,0.5*(coords[i][2]+test_sphere_r)/test_sphere_r]) union() {
            cylinder(r1=10,r2=0,h=10,center=false);
            cube(10);
        }
    }
}

module sphere_translate2Point(radius=1.0,k,N,align=false) {
  // Cartesian Coordinate Translate
  for( i=[0:$children-1] ) assign(cc=pointOnSphere(radius=radius,k=k,N=N),cc0=pointOnSphere(radius=radius,k=0,N=N))
	 {
    if(align==false) {
      translate( cc ) child(i);
    } else assign(cs=cart2sphere(cc[0],cc[1],cc[2]),cs0=cart2sphere(cc0[0],cc0[1],cc0[2]) ) {
      translate( sphere2cart(cs[0],cs[1]-cs0[1]+90,cs[2]-cs0[2]) ) child(i);
    }
  }
}

module sphere_radial2Point(radius=1.0,k,N,align=false,hemisphere=false) {
  // Spherical Coordinate Mapping
  for( i=[0:$children-1] ) assign(cc=pointOnSphere(radius=radius,k=k,N=N),cc0=pointOnSphere(radius=radius,k=0,N=N)) 
    assign(rx=0
	,ry=cart2sphere(cc[0],cc[1],cc[2])[1]-((align==true) ? cart2sphere(cc0[0],cc0[1],cc0[2])[1]:90)
	,rz=cart2sphere(cc[0],cc[1],cc[2])[2]-((align==true) ? cart2sphere(cc0[0],cc0[1],cc0[2])[2]:0)
	) {
    rotate([rx,ry,rz]) if(hemisphere==false || ry>0.0) 
      translate([cart2sphere(cc[0],cc[1],cc[2])[0],0,0])
	rotate([0,90,0]) child(i);
  }
}

module sphere_map2Points(radius=1.0,N=3) assign(
  inc= pi()*(3-sqrt(5))
  , off=2/N) {
  for(k=[0:N-1]) assign(
    y = k*off-1+(off/2)
    , r = sqrt(1-(k*off-1+(off/2))*(k*off-1+(off/2)))
    , phi=k*inc ) {
	translate([radius*cos(360*phi/(2*pi()))*r,radius*y,radius*sin(360*phi/(2*pi()))*r]) child(0);
  }
}

function closest_back(start,next,coords,curr,delta=0.1)=
    ( ( norm(coords[start]-coords[curr]) < (1+delta)*norm(coords[start]-coords[next]) )
    &&( norm(coords[next]-coords[curr]) < (1+delta)*norm(coords[start]-coords[next]) )||curr==0)?curr:
        closest_back(start,next,coords,curr-1,delta=delta);

test_sphere_r2=100;
test_sphere_N2=20;

if(test_module=="test sphere_poly") {
    echo("Testing sphere_poly...");
    coords=sphere_points(test_sphere_r2,test_sphere_N2);
    translate(coords[0]) color([1,1,1]) sphere(2);
    for(i=[1:len(coords)-2]) {
        pt1=coords[i];
        pt2=coords[i+1];
        cb=closest_back(i,i+1,coords,i-1);
        echo(str("i:",i," pt1:",pt1," pt2:",pt2," cb:",cb));
        echo(str("  norm(pt1-pt2): ",norm(pt1-pt2)));
        color([1,0,0]) hull() {
            translate(pt1) cube();
            translate(pt2) cube();
        }
        color([0,1,0]) hull() {
            translate(pt1) sphere();
            translate(coords[cb]) sphere();
        }
        color([0,0,1]) hull() {
            translate(pt1) cylinder();
            translate(coords[cb]) cylinder();
        }
    }
}

