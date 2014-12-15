//Declare the scale that will be used for the model. This scale is used to calculate the pixel to mm scale. EX. scale of 5 means 1pixel on skin = 5mm. 

scale=5;

//Create the head of guy

module head() 
{
difference() 
{
cube(size = scale * 8, center=true);
translate([0,0,scale*4])cylinder(r=scale*1,h=8, center=true,$fn=100);
}
}

//create the connector hole for use to connect the leg to body with a piece of filament 

module leg_connector()
{
translate([scale*2,scale*1,0])cylinder(r=1.5,h=scale*2, center=true,$fn=100); 
translate([scale*2,scale*2,0])cylinder(r=1.5,h=scale*2, center=true,$fn=100);
}

//Create the body of guy

module body() 
{
difference()
{
union()
{
translate([0,0,scale*10])cube([scale*8,scale*4,scale*12], center=true);
translate([0,0,scale*4])cylinder(r=scale*1-0.25,h=8, center=true,$fn=100);
}
translate([0,scale*-1.5,scale*16])leg_connector();
translate([scale*-4,scale*-1.5,scale*16])leg_connector();
translate([scale*4,0,scale*6])rotate(a=[90,0,90])cylinder(r=1.5,h=scale*2, center=true,$fn=100);
translate([scale*-4,0,scale*6])rotate(a=[90,0,90])cylinder(r=1.5,h=scale*2, center=true,$fn=100);
}
}

//Create the legs of the guy

module legs()
{
difference()
{
union()
{
translate([scale*2.015,0,scale*22])cube([scale*3.97,scale*4,scale*12], center=true);
translate([scale*-2.015,0,scale*22])cube([scale*3.97,scale*4,scale*12], center=true);
}
translate([0,scale*-1.5,scale*16])leg_connector();
translate([scale*-4,scale*-1.5,scale*16])leg_connector();
}
}

//Create the tools arm of guy

module toolarm()
{
difference()
{
translate([-6*scale,4*scale,6*scale])rotate([90,0,0])cube([4*scale,4*scale,12*scale],center=true);
translate([-6*scale,8.5*scale,6*scale])rotate([0,90,0])cube([5*scale+0.5,1.4*scale+0.5,1*scale+0.5],center=true);
translate([scale*-4,0,scale*6])rotate(a=[90,0,90])cylinder(r=scale*0.2,h=scale*2, center=true,$fn=100);
}
}

//Create the normal arm of guy

module freearm()
{
difference()
{
translate([6*scale,4*scale,6*scale])rotate([90,0,0])cube([4*scale,4*scale,12*scale],center=true);
translate([scale*4,0,scale*6])rotate(a=[90,0,90])cylinder(r=scale*0.2,h=scale*2, center=true,$fn=100);
}
}

//head();       //Call to generate the guy's head
//body();       //Call to generate the guy's body
legs();         //Call to generate the guy's legs
//toolarm();   //Call to generate the guy's tool arm
freearm();  //Call to generate the guy's free arm