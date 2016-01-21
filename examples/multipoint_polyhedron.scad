// Join Points.

Show_Rendering_Error=true;

module join_points(points,faces,r=0.1,debug=false) {
    if(debug) {
        echo("join_points:");
        echo(str("  points: ",points));
        echo(str("   faces: ",faces));
    }
    for(i=[0:len(faces)-1]) {
        face=faces[i];
            if(debug) {
                echo("  face ",i,": ",face);
            }
            for(j=[0:len(face)-2]) {
                color([j/len(face),j/len(face),j/len(face)]) hull() {
                    translate(points[face[j]]) sphere(r=r);
                    translate(points[face[j+1]]) sphere(r=r);
                }
            }
            color([1,1,1]) hull() {
                translate(points[face[len(face)-1]]) sphere(r=r);
                translate(points[face[0]]) sphere(r=r);
            }
    }
}

// If set to false, draws 1 polyhedron, renders OK, imports to MeshLab OK.
// If set to true, draws 2 identical polyhedra, on render:
//     "WARNING: Object may not be a valid 2-manifold and may need repair!"
Show_Rendering_Error=true;

p=[[0,-10,-5],[2,-10,-5],[8,-10,-5],[8,10,-5],[2,10,-5],[0,10,-5],[2,0,-5],
  [0,-10,5], [2,-10,5], [8,-10,5], [8,10,5], [2,10,5], [0,10,5], [2,0,5]];

/* f=[[8,7,13],[13,12,11],[9,8,10],[8,11,10],
  [6,0,1],[4,5,6],[3,1,2],[3,4,1],
  [7,8,1],[8,9,2],[9,10,3],[10,11,4],[11,12,5],[12,13,6],[13,7,0],
  [1,0,7],[2,1,8],[3,2,9],[4,3,10],[5,4,11],[6,5,12],[0,6,13]];
*/
f=[ [0,1,2,3,4,5,6]
    ,[13,12,11,10,9,8,7]
    ,[7,8,9,2,1,0]
    ,[10,11,12,5,4,3]
    //,[12,13,6,5]
    //,[13,7,0,6]
    ,[12,13,7,0,6,5]
    ,[9,10,3,2]
];

//polyhedron(points=p,faces=f);
//if (Show_Rendering_Error) translate([15,0,0]) polyhedron(points=p,faces=f);
join_points(points=p,faces=f,r=0.1,debug=true);
polyhedron(points=p,faces=f);

if (Show_Rendering_Error) translate([15,0,0]) polyhedron(points=p,faces=f);
