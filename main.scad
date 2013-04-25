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
translate([0,0,719]) {
    rotate ([180,0,0]) color([0.2,0.3,0.3]) rack(l=2900);
    translate([1630,-15,-20]) rotate([0,0,180]) pinion(a=-35,b=-55,l=0, v=0, d=1);
}
translate([0,1612.5,719]) {
    color([0.2,0.3,0.3]) rotate([180,0,0]) rack(l=2900);
    translate([1630,0,-20]) pinion(a=-145,b=55,l=0, v=0, d=-1);
}
translate([1500,0,830]) {
translate([100,0,100]) rotate([0,0,90]) xaxis(l=1600);
//translate([100,20,100]) rotate([0,0,90]) hoeklijn(l=1560);
translate([-50,-20,0])  x_stand(up=150);
translate([170,1620,0]) rotate([0,0,180]) x_stand(up=50);

}
