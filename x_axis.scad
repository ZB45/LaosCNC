include <MCAD/stepper.scad>

l=1750;
cube([l,20,120]);
cube([l,60,20]);
translate([0,0,100]) cube([l,60,20]);
color([0,0,0]) translate([20,20,20]) cube([30,50,80]);
color([0,0,0]) translate([1580,20,20]) cube([30,50,80]);
color([0,0,0]) translate([750,20,20]) cube([100,50,80]);
color([0.5,0.5,0.5]) {
    translate([730,70,-10]) cube([140,10,140]);
    translate([730,80,-10]) cube([20,10,140]);
    translate([850,80,-10]) cube([20,10,140]);
}
translate([0,45,60]) rotate([0,90,0]) cylinder(h=1700, r=10);

translate([1750,45,60]) rotate([0,90,0]) motor(Nema34, NemaMedium, dualAxis=true);
