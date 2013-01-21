fudge = 0.01; 

include <tafel.scad>
include <R30.scad>
include <Rack_and_Pinion.scad>
include <x_axis.scad>
include <hoeklijn.scad>
tafel(l=2900,b=1600,h=700,hs=300,hp=200);
color([1,0,0]) {
   translate([0,25,800]) R30(l=2900, offset=30);
   translate([0,1575,800]) R30(l=2900, offset=30);
}
translate([1600,0,900]) rotate([0,0,90]) xaxis(l=1600);
translate([1600,0,900]) rotate([0,0,90]) hoeklijn(l=1600);
