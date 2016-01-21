a=30;   b=20;   c=10;    //half-axes of ellipse
Step=10;
StartVal_u=0;   EndVal_u=360;    
// 10 seconds, 1224 facets, 614 vertices, 2 volumes StartVal_v=0;   EndVal_v=180;
//StartVal_u=10;   EndVal_u=360;    
// 10 seconds, 1190 facets, 614 vertices, 1 volumes
StartVal_v=0;   EndVal_v=180;


//scale([a,b,c])    sphere(1,$fn=51);       // used in debugging

 function P(u,v)=[a*cos(u)*sin(v),b*sin(u)*sin(v),c*cos(v)];  //point on the surface of an ellipsoid
 function SurfaceElement(u,v,step=Step)=let(Center=P(u,v)
        ,P0=P(u-step/2,v-step/2)
        ,P1=P(u+step/2,v-step/2)
        ,P2=P(u+step/2,v+step/2)
        ,P3=P(u-step/2,v+step/2) )
      (P0 != P1 && P1 != P2 ) ? [P0,P1,P2] : ( ( P0 != P2 && P2 != P3 ) ? [P0,P2,P3]:[P0,P1,P3]);

function SurfaceElements( start_v=StartVal_v, end_v=EndVal_v, start_u=StartVal_u, end_u=EndVal_u, step=Step) = [
    for( v=[start_v+step/2:step:end_v] ) for(u=[start_u+step/2:step:end_u]) SurfaceElement(u,v) ];

points_list=SurfaceElements();
    echo(points_list);

polyhedron(faces=points_list);

if(0) difference() {
  union() for (v=[StartVal_v+Step/2:Step:EndVal_v])   for(u=[StartVal_u+Step/2:Step:EndVal_u])   SurfaceElement(u,v);
   cylinder(r=10,h=100,center=true);
}  


module SurfaceElement_module(u,v)
 { Center=P(u,v);                    // centre vector for SurfaceElement()
   P0=P(u-Step/2,v-Step/2);          // corner vector for SurfaceElement()
   P1=P(u+Step/2,v-Step/2);          // corner vector for SurfaceElement()
   P2=P(u+Step/2,v+Step/2);          // corner vector for SurfaceElement()
   P3=P(u-Step/2,v+Step/2);          // corner vector for SurfaceElement()
//   translate(Center)    color("magenta")   cube([.3,.3,.3], center=true);  
// used in debugging
//    translate(P0)        color("red")       cube([.3,.3,.03],center=true);   // used in debugging
//    translate(P1)        color("white")     cube([.3,.3,.03],center=true);   // used in debugging
//    translate(P2)        color("green")     cube([.3,.3,.03],center=true);   // used in debugging
//    translate(P3)        color("yellow")    cube([.3,.3,.03],center=true);   // used in debugging
//     polygon(P0,P1,P2);   // accepts only 2-vectors
//     polygon(P0,P2,P3);   // accepts only 2-vectors
   if(P0 != P1 && P1 != P2)  color("red")     polyhedron(points=[P0,P1,P2], faces=[[0,1,2]]);
   if(P0 != P2 && P2 != P3)  color("yellow")  polyhedron(points=[P0,P2,P3], faces=[[0,1,2]]);
      // CGAL does'nt like degenerate faces!
//  polyhedron (points=[P0,P1,P2,P3], faces=[[0,1,2,3]]);   // non-planar face, CGAl complains
//   echo(u-Step/2,u+Step/2,v-Step/2,v+Step/2,P0,P1,P2,P3,Center);
 }      

