// test read_xyz() and pointset()

// oni.xyz from CGAL examples/Point_set_processing_3/data/oni.xyz
//  https://github.com/CGAL/cgal/blob/master/Point_set_processing_3/examples/Point_set_processing_3/data/oni.xyz

render_example="read test";
//render_example="read oni";
//render_example="read parameters";
//render_example="oni with points";
//render_example="difference oni";

pointset_xyz=read_xyz("oni.xyz" );

if(render_example=="read test") {
    not_file=read_xyz("invalid.xyz");
    pointset();
    echo(pointset_xyz);
    echo(str("len(pointset_xyz) = ",len(pointset_xyz)));
    echo(str("  len(pointset_xyz[0]) = ",len(pointset_xyz[0])));
    echo(str("  len(pointset_xyz[1]) = ",len(pointset_xyz[1])));
    echo(not_file);
    scale(50) pointset(pointset_xyz,verbose=true);
}

if(render_example=="read oni") scale(50) {
    pointset(points=read_xyz("oni.xyz" ),verbose=true);
}

if(render_example=="read parameters") scale(50) {
    pointset(points=read_xyz("oni.xyz")
        ,jen_k=8
        ,mon_k=8
        ,eaup_scale_num_points=0
        //,eaup_number_of_output_points=3000
        ,eaup_sharpness_angle=7.5
        ,eaup_edge_sensitivity=0.25
        ,eaup_neighbor_radius=0.2
        ,cas_k=6
        ,smdc_angle=15
        ,smdc_radius=1
        ,smdc_distance=0.1
        ,verbose=true);
}

point_dim=0.005;
if(render_example=="oni with points") scale(50) {
        pointset(points=pointset_xyz
            ,neighbors=8
            //,scale_num_points=2
            ,sharpness_angle=7.5
            ,edge_sensitivity=0.25
            ,neighbor_radius=0.02
            ,angle=15
            ,radius=1
            ,distance=0.001
        );
        for(i=[0:len(pointset_xyz[0])-1]) translate(pointset_xyz[0][i]) {
            % color([1,0,1]) hull() {
                cube(point_dim);
                translate(2*point_dim*pointset_xyz[1][i]) cube(0.1*point_dim);
            }
        }
}

if(render_example=="difference oni") scale(50) difference() {
    pointset(points=pointset_xyz[0]);
    cube([0.1,2,2],center=true);
}
//cube();
