// test skin_surface

//render_example="skin_surface test";
//render_example="four points";
//render_example="spiral points";
//render_example="random points";
//render_example="sphere points";
render_example="oni points";

if(render_example=="skin_surface test") scale(10) {
    skin_surface();
    grow_balls=true;
    scale_point_weight=(1+2*$t)*(grow_balls?1/4:1/2);
    % cube([2,1,2],center=true);
    skin_surface(points=[ [[-1,0,0],[1,0,0]],[scale_point_weight,scale_point_weight]]
        ,subdivisions=3
        ,shrink_factor=1/scale_point_weight
        ,grow_balls=grow_balls
        );
}

if(render_example=="four points") scale(4) {
    position_4pts=[
        [1,-1,-1]
        ,[1,1,1]
        ,[-1,1,-1]
        ,[-1,-1,1]
        ];
    weights_4pts=[ 1.25,4,3,1.25 ];
    weighted_4pts=[ position_4pts, weights_4pts ];
    skin_surface(points=1.5*position_4pts,weights=weights_4pts);
}

if(render_example=="spiral points") scale(4) translate([0,0,-3]) {
    pts_spiral_up=[ for(a=[0:10:359],z=[1:1:4]) [(z+a/360)*cos(a),(z+a/360)*sin(a),z+a/360] ];
    weights_spiral_up=[ for(a=[0:10:359],z=[1:1:4]) (z+a/360)/5 ];
    skin_surface(points=pts_spiral_up,weights=weights_spiral_up);
}

if(render_example=="random points") scale(20) translate([-0.5,-0.5,-0.5]) {
    nrand=pow(5,3);
    rand_nums=rands(0,1,3*nrand,0);
    pts_random = [ for(i=[0:3:3*(nrand-1)]) [ rand_nums[i],rand_nums[i+1],rand_nums[i+2] ] ];
    pts_corners = [ for(x=[0,1],y=[0,1],z=[0,1]) [x,y,z] ];
    skin_surface(points=concat(pts_random,pts_corners),weight=(0.5+4*$t*(1-$t))/nrand,subdivisions=0,grow_balls=true);
}

function pi()=3.14159265358979323846;
function pointOnSphere(radius=1.0,k,N) =
    [ radius*cos(360*k*pi()*(3-sqrt(5))/(2*pi()))*sqrt(1-(k*(2/N)-1+((2/N)/2))*(k*(2/N)-1+((2/N)/2)))
    , radius*(k*(2/N)-1+((2/N)/2))
    , radius*sin(360*k*pi()*(3-sqrt(5))/(2*pi()))*sqrt(1-(k*(2/N)-1+((2/N)/2))*(k*(2/N)-1+((2/N)/2)))
    ];
function sphere_surface_area(r)=4*pi()*pow(r,2);
function sphere_volume(r)=4*pi()*pow(r,3)/3;
function sphere_points(r,N) = [for (k=[0:N-1]) pointOnSphere(r,k,N) ];

if(render_example=="sphere points") {
    num_sphere_pts=pow(6,3);
    sphere_r=20;
    sphere_pts=sphere_points(sphere_r,num_sphere_pts);
    skin_surface(points=sphere_pts,weight=pow(0.55,3)*sphere_surface_area(sphere_r)/num_sphere_pts);
}

if(render_example=="oni points") scale(40) {
    pointset_xyz=read_xyz("oni.xyz");
    skin_surface(points=pointset_xyz[0],weight=0.0005,grow_balls=false,verbose=true);
}
