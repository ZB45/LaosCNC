include <MCAD/nuts_and_bolts.scad>

module spindel(l=1600) {
    // stappenmotor.nl: KS1-2x12
    // http://www.stappenmotor.nl/Stappenmotor/kogelomloopspindels/kogelomloopspindels.htm
    rotate([0,90,0]) cylinder(h=l, r=6); 
}

module losvastlager() {
    // stappenmotor.nl: FL1-12 en LL1-12
    // http://www.stappenmotor.nl/Stappenmotor/vast%20en%20los%20lagers/vast%20en%20los%20lagers%20voor%20cnc%20spindels.html
    color([0,0,0])
        difference() {
            cube([25,43,60]);
            union() {
                translate([-1,38,-1]) cube([27,6,13]);
                translate([-1,38,48]) cube([27,6,13]);
                translate([12.5,-1.9,6]) rotate([-90,0,0]) boltHole(size=6, length=40);
                translate([12.5,-1.9,54]) rotate([-90,0,0]) boltHole(size=6, length=40);
                translate([-1,25,30]) rotate([0,90,0]) cylinder(r=6, h=27);
                translate([-0.5,25,30]) rotate([0,90,0]) cylinder(r=10, h=2);
                translate([23.5,25,30]) rotate([0,90,0]) cylinder(r=10, h=2);
            }
        }
    color([0,1,0]) {
        difference() {
            union() {
                translate([0,25,30]) rotate([0,90,0]) cylinder(r=10, h=1.5);
                translate([23.5,25,30]) rotate([0,90,0]) cylinder(r=10, h=1.5);
            }
            translate([-0.5,25,30]) rotate([0,90,0]) cylinder(r=6, h=27);
        }
    }
}

module kogelomloopmoer() {
    // stappenmotor.nl: KSM1-2x12
    // http://www.stappenmotor.nl/Stappenmotor/kogelomloopspindels/kogelomloopspindels.htm
    rotate([0,-90,0]) difference() {
        union() {
            translate([0,0,1]) cylinder(r=12,h=27);
            cylinder(r=37/2,h=5);
        }
        translate([0,0,-1]) cylinder(r=6, h=30);
        translate([-21,14,-1]) cube([42,12,7]);
        translate([-21,-26,-1]) cube([42,12,7]);
        for ( x = [ -45 : 45 : 45 ] ) {
            rotate([0, 0, x])
                translate([14.5, 0, 0])
                    rotate([0, 0, 90])
                    cylinder(r=4.5/2, h=7);
        }
        for ( x = [ 135 : 45 : 225 ] ) {
            rotate([0, 0, x])
                translate([14.5, 0, 0])
                    rotate([0, 0, 90])
                    cylinder(r=4.5/2, h=7);
        }
    }
}

module kogelomloopmoerhouder() {
    color([1,0,0])
    difference() {
        cube([22,32,57]);
        union() {
        translate([-1,14,28.5]) rotate([0,90,0]) {
        cylinder(r=12,h=24);
        for ( x = [ -45 : 45 : 45 ] ) {
            rotate([0, 0, x])
                translate([14.5, 0, 0])
                    rotate([0, 0, 90])
                    cylinder(r=4.5/2, h=24);
        }
        for ( x = [ 135 : 45 : 225 ] ) {
            rotate([0, 0, x])
                translate([14.5, 0, 0])
                    rotate([0, 0, 90])
                    cylinder(r=4.5/2, h=24);
        }
        }
        translate([11,-1,5.5]) rotate([-90,0,0]) cylinder(r=2.5, h=34);
        translate([11,-1,5.5+46]) rotate([-90,0,0]) cylinder(r=2.5, h=34);
        }
    }
}

module aandrijving(o=2,l=1600) {
    translate([53,0,0]) losvastlager(); 
    translate([1530,0,0]) losvastlager(); 
    translate([834+o,25,30]) kogelomloopmoer();
    translate([0,25,30]) spindel(l);
    translate([807+o,11,30-57/2]) kogelomloopmoerhouder();
}

//aandrijving();
