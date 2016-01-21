// Test pointset
cube_size=20;
%cube(cube_size,center=false);
cube_step=1;
pts_xy_bottom=[ for( i=[0:cube_step:cube_size],j=[0:cube_step:cube_size]) [i,j,0] ];
pts_xy_top=[ for( i=[0:cube_step:cube_size],j=[0:cube_step:cube_size]) [i,j,cube_size] ];
pts_xz_bottom=[ for( i=[0:cube_step:cube_size-cube_step],j=[cube_step:cube_step:cube_size-cube_step]) [i,0,j] ];
pts_xz_top=[ for( i=[0:cube_step:cube_size],j=[cube_step:cube_step:cube_size-cube_step]) [i,cube_size,j] ];
pts_yz_bottom=[ for( i=[cube_step:cube_step:cube_size-cube_step],j=[cube_step:cube_step:cube_size]) [0,i,j] ];
pts_yz_top=[ for( i=[cube_step:cube_step:cube_size-cube_step],j=[cube_step:cube_step:cube_size-cube_step]) [cube_size,i,j] ];
pts_spiral_up=[ for(a=[0:10:359],z=[0:1:cube_size/2]) [(z+a/360)*cos(a),(z+a/360)*sin(a),z+a/360] ];
pts_spiral_plane=[ for(a=[0:10:359],z=[1:2:cube_size/2]) [z*cos(a),z*sin(a),cube_size/2+2*cube_step+(cube_size/4-z/4)] ];
//pts=concat( pts_xy_bottom, pts_xy_top, pts_xz_bottom, pts_xz_top);
pts=concat( 
    pts_xy_bottom,
    pts_xz_bottom,
    pts_yz_bottom,
    pts_xy_top,
    pts_xz_top,
    pts_yz_top
    //, pts_spiral
    );

echo(pts_random);
//echo(pts);
pointset(points=pts,angle=45/4,radius=cube_size/2,distance=cube_step/2,neighbors=16
        ,scale_num_points=4,neighbor_radius=(1+sqrt(2))*cube_step,edge_sensitivity=0.75
        ,convexity=5);
for(pt=pts) {
    translate(pt) % cube(size=cube_step/2,center=true);
}

//echo(pts_spiral);
spiral_offset=[-cube_size,0,0];

pts_spiral=concat(pts_spiral_up,pts_spiral_plane);
translate(spiral_offset) pointset(points=pts_spiral,angle=45/4,radius=4*cube_step,distance=cube_step,neighbors=32,scale_num_points=4,edge_sensitivity=0.5,convexity=5);
for(pt=pts_spiral) {
    translate(pt+spiral_offset) % cube(size=cube_step/2,center=true);
}

pts_random = [ for(xrand=rands(0,cube_size,3),yrand=rands(0,cube_size,3,xrand),zcoord=[0,cube_size/4]) [ xrand, yrand, zcoord ] ];
//translate([0,-cube_size,0]) pointset(points=pts_random,angle=45/4,radius=cube_size,distance=cube_size, neighbors=16, scale_num_points=4, edge_sensitivity=0.1,convexity=5);
