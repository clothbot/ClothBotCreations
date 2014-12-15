// Incremental positions
function segment_pos(l,a,i) = 0;
l=1.0;
a=10;
M=[
	[ cos(a),-sin(a),0,l]
	,[sin(a),cos(a),0,0]
	,[0,0,1,0]
	,[0,0,0,1]
];
function powm(M,i) = i>1?M*powm(M,i-1):M;
M2=powm(M,2);
echo(str("M:",M));
echo(str("M2:",M2));
cube();
for(i=[1:32]) assign(MP=powm(M,i)) multmatrix(m=MP) {
  echo(str("M^",i,": ",MP));
  rotate([0,90,0]) cylinder(r1=1,r2=0,h=1);
}
