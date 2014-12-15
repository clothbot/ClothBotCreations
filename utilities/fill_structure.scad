// Fill Structures

module top_surfaces(layer_th=3*0.2,wall_th=4*0.4,n=8) {
  for(i=[0:$children-1]) {
	  difference() {
		children(i);
		translate([0,0,-layer_th]) children(i);
		for(j=[0:n-1]) assign(dx=wall_th*cos(360*j/n),dy=wall_th*sin(360*j/n)) {
			translate([dx,dy,-2*layer_th]) children(i);
		}
	  }
  }
}

module skin_sides(wall_th=4*0.4,n=8) {
  intersection_for(i=[0:n-1]) assign(dx=wall_th*cos(360*i/n)/2,dy=wall_th*sin(360*i/n)/2) {
	echo(i,dx,dy);
	translate([dx,dy,0]) children();
  }
}

module this() {
  render() import("/Volumes/CaseSensitive/ClothBotDesigns/Projects/things/OpenSourceActionFigure_thing_116571/Head_Parts_scale_3x/Head_Bottom_repaired.stl");
}
//%this();

//intersection() {
  //top_surfaces() sphere(50,center=true); // this();
  if(true)  top_surfaces(layer_th=4*0.2,wall_th=4*0.4) {
	render() union() import("/Volumes/CaseSensitive/ClothBotDesigns/Projects/things/OpenSourceActionFigure_thing_116571/Head_Parts_scale_3x/Head_Bottom_repaired.stl");
  }
  if(false) skin_sides(wall_th=8*0.4,n=8) {
	import("/Volumes/CaseSensitive/ClothBotDesigns/Projects/things/OpenSourceActionFigure_thing_116571/Head_Parts_scale_3x/Head_Bottom_repaired.stl");
  }
//}
