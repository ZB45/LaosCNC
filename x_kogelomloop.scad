include <MCAD/nuts_and_bolts.scad>

module spindel(l=1600) {
    // stappenmotor.nl: KS1-2x12
    // http://www.stappenmotor.nl/Stappenmotor/kogelomloopspindels/kogelomloopspindels.htm
    rotate([0,90,0]) union() {
        cylinder(h=l, r=6); 
        translate([0,0,60]) cylinder(h=l-100, r=10);
    }
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
    // stappenmotor.nl: KSM1-5x20
    // http://www.stappenmotor.nl/Stappenmotor/kogelomloopspindels/kogelomloopspindels.htm
    rotate([0,-90,0]) difference() {
        union() {
            translate([0,0,1]) cylinder(r=36/2,h=50); //buitenmantel
            cylinder(r=58/2,h=10);                  // brede stuk
        }
        translate([0,0,-1]) cylinder(r=10, h=53);   // binnenmaat
        translate([-29,22,-1]) cube([58,8,12]);    // afvlak brede stuk
        translate([-29,-30,-1]) cube([58,8,12]);   // afvlak brede stuk
        for ( x = [ -45 : 45 : 45 ] ) {
            rotate([0, 0, x])
                translate([47/2, 0, -1])
                    rotate([0, 0, 90])
                    cylinder(r=(6.6/2), h=12);
        }
        for ( x = [ 135 : 45 : 225 ] ) {
            rotate([0, 0, x])
                translate([47/2, 0, -1])
                    rotate([0, 0, 90])
                    cylinder(r=(6.6/2), h=12);
        }
    }
}

module kogelomloopmoerhouder() {
    color([1,0,0])
    difference() {
        cube([22,42,58]);
        union() {
        translate([-1,20,28.5]) rotate([0,90,0]) {
        cylinder(r=18,h=24);
        for ( x = [ -45 : 45 : 45 ] ) {
            rotate([0, 0, x])
                translate([47/2, 0, -1])
                    rotate([0, 0, 90])
                    cylinder(r=6.6/2, h=24);
        }
        for ( x = [ 135 : 45 : 225 ] ) {
            rotate([0, 0, x])
                translate([47/2, 0, -1])
                    rotate([0, 0, 90])
                    cylinder(r=6.6/2, h=24);
        }
        }
        translate([11,-1,5.5]) rotate([-90,0,0]) cylinder(r=2.5, h=34);
        translate([11,-1,5.5+46]) rotate([-90,0,0]) cylinder(r=2.5, h=34);
        }
    }
}

module aandrijving(o=2,l=1600) {
    translate([23,0,0]) losvastlager(); 
    translate([1500,0,0]) losvastlager(); 
    translate([834+o,25,30]) kogelomloopmoer();
    translate([0,25,30]) spindel(l);
    translate([807+o,5,30-58/2]) kogelomloopmoerhouder(); // y=3???
}

//aandrijving();
