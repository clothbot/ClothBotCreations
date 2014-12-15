//Declare the scale that will be used for the model. This scale is used to calculate the pixel to mm scale. EX. scale of 5 means 1pixel on skin = 5mm.

scale=5;

//Create a single standardized handle for tools

module handle(){
difference(){
union(){
cube([2*scale,2*scale,1*scale]);
translate([1*scale,1*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([2*scale,2*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([3*scale,3*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([4*scale,4*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([5*scale,5*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([6*scale,6*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([7*scale,7*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([8*scale,8*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([9*scale,9*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([10*scale,10*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([11*scale,11*scale,0*scale])cube([2*scale,2*scale,1*scale]);
}
translate([2.40*scale,0*scale,0.5*scale])rotate([0,0,45])cube([6.5*scale,2*scale,2*scale],center=true);
translate([0*scale,2.4*scale,0.5*scale])rotate([0,0,45])cube([6.5*scale,2*scale,2*scale],center=true);
}
}

//Create Pickaxe

module pickaxe(){
union(){
handle();
translate([10*scale,10*scale,0*scale])cube([3*scale,1*scale,1*scale]);
translate([10*scale,10*scale,0*scale])cube([1*scale,3*scale,1*scale]);
translate([11*scale,5*scale,0*scale])cube([3*scale,5*scale,1*scale]);
translate([5*scale,11*scale,0*scale])cube([5*scale,3*scale,1*scale]);
translate([12*scale,4*scale,0*scale])cube([1*scale,1*scale,1*scale]);
translate([4*scale,12*scale,0*scale])cube([1*scale,1*scale,1*scale]);
}
}

//Create Axe

module axe(){
union(){
handle();
translate([10*scale,10*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([11*scale,9*scale,0*scale])cube([3*scale,2*scale,1*scale]);
translate([11*scale,8*scale,0*scale])cube([2*scale,3*scale,1*scale]);
translate([6*scale,11*scale,0*scale])cube([5*scale,2*scale,1*scale]);
translate([7*scale,10*scale,0*scale])cube([2*scale,1*scale,1*scale]);
translate([7*scale,13*scale,0*scale])cube([5*scale,1*scale,1*scale]);
translate([8*scale,14*scale,0*scale])cube([4*scale,1*scale,1*scale]);
translate([9*scale,15*scale,0*scale])cube([2*scale,1*scale,1*scale]);
}
}

//Create Sword

module sword(){
difference(){
union(){
cube([2*scale,2*scale,1*scale]);
translate([1*scale,1*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([2*scale,2*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([3*scale,3*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([4*scale,4*scale,0*scale])cube([2*scale,2*scale,1*scale]);
translate([6*scale,5*scale,0*scale])cube([4*scale,1*scale,1*scale]);
translate([7*scale,4*scale,0*scale])cube([4*scale,1*scale,1*scale]);
translate([9*scale,3*scale,0*scale])cube([2*scale,1*scale,1*scale]);
translate([5*scale,6*scale,0*scale])cube([1*scale,4*scale,1*scale]);
translate([4*scale,7*scale,0*scale])cube([1*scale,4*scale,1*scale]);
translate([3*scale,9*scale,0*scale])cube([1*scale,2*scale,1*scale]);
translate([6*scale,6*scale,0*scale])cube([3*scale,1*scale,1*scale]);
translate([6*scale,6*scale,0*scale])cube([1*scale,3*scale,1*scale]);
translate([7*scale,7*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([8*scale,8*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([9*scale,9*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([10*scale,10*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([11*scale,11*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([12*scale,12*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([13*scale,13*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([14*scale,14*scale,0*scale])cube([3*scale,3*scale,1*scale]);
}
translate([2.40*scale,0*scale,0.5*scale])rotate([0,0,45])cube([6.5*scale,2*scale,2*scale],center=true);
translate([0*scale,2.4*scale,0.5*scale])rotate([0,0,45])cube([6.5*scale,2*scale,2*scale],center=true);
}
}

//Create Shovel

module shovel(){
union(){
handle();
translate([9*scale,9*scale,0*scale])cube([4*scale,4*scale,1*scale]);
translate([10*scale,8*scale,0*scale])cube([2*scale,1*scale,1*scale]);
translate([10*scale,7*scale,0*scale])cube([1*scale,1*scale,1*scale]);
translate([8*scale,10*scale,0*scale])cube([1*scale,2*scale,1*scale]);
translate([7*scale,10*scale,0*scale])cube([1*scale,1*scale,1*scale]);
translate([10*scale,13*scale,0*scale])cube([3*scale,1*scale,1*scale]);
translate([13*scale,10*scale,0*scale])cube([1*scale,3*scale,1*scale]);
}
}

//Create Ho

module ho(){
union(){
handle();
translate([10*scale,10*scale,0*scale])cube([3*scale,1*scale,1*scale]);
translate([8*scale,11*scale,0*scale])cube([3*scale,2*scale,1*scale]);
translate([11*scale,9*scale,0*scale])cube([1*scale,1*scale,1*scale]);
translate([6*scale,12*scale,0*scale])cube([3*scale,3*scale,1*scale]);
translate([5*scale,13*scale,0*scale])cube([1*scale,1*scale,1*scale]);
translate([9*scale,13*scale,0*scale])cube([1*scale,1*scale,1*scale]);
}
}

//pickaxe(); //Call to generate the pickaxe
//shovel();   //Call to generate the shovel
//axe();       //Call to generate the axe
//sword();   //Call to generate the sword
//ho();         //Call to generate the ho