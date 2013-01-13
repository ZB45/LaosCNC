include <tafel.scad>
include <R30.scad>
tafel(l=290,b=160,h=70,hs=30,hp=20);
color([1,0,0]) {
    translate([0,2.5,80]) R30(l=290);
    translate([0,157.5,80]) R30(l=290);
}
