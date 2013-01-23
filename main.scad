fudge = 0.01; 

include <tafel.scad>
include <R30.scad>
include <Rack_and_Pinion.scad>
include <x_axis.scad>
include <hoeklijn.scad>
include <x_stand.scad>
tafel(l=2900,b=1600,h=700,hs=300,hp=200);
color([1,0,0]) {
   translate([0,25,800]) R30(l=2900, offset=30);
   translate([0,1575,800]) R30(l=2900, offset=30);
}
translate([1500,0,830]) {
translate([100,20,100]) rotate([0,0,90]) xaxis(l=1560);
//translate([100,20,100]) rotate([0,0,90]) hoeklijn(l=1560);
translate([-50,0,0]) rotate([0,0,0]) x_stand(up=150);
translate([170,1600,0]) rotate([0,0,180]) x_stand(up=50);
}
