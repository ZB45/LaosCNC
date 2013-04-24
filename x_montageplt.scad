$fn=10;
$fs=10;
fudge=0.1;
include <MCAD/nuts_and_bolts.scad>
module montagegat() {
    union() {
        translate([0,27,0]) rotate([90,0,0]) cylinder(r=4.25, h=14);
        translate([0,16.9,0]) rotate([90,0,0]) cylinder(r=2.5, h=12);
    }
}

module middlegates() {
        h=46.5; w=43.2; d=71.2;

        translate([-w/2-d/2,0,-h/2]) montagegat();
        translate([w/2-d/2,0,-h/2]) montagegat();
        translate([w/2-d/2,0,h/2]) montagegat();
        translate([-w/2-d/2,0,h/2]) montagegat();

        translate([-w/2+d/2,0,-h/2]) montagegat();
        translate([w/2+d/2,0,-h/2]) montagegat();
        translate([w/2+d/2,0,h/2]) montagegat();
        translate([-w/2+d/2,0,h/2]) montagegat();
}

module slidergates() {
        translate([-13.25,0,-7.7]) montagegat();
        translate([-13.25,0,7.7]) montagegat();
        translate([13.25,0,-7.7]) montagegat();
        translate([13.25,0,7.7]) montagegat();
}

module boutgat() {
    rotate([-90,0,0]) boltHole(size=6, length=30);
}

module x_montageplt() {
    difference() {
        // blok
        translate([-154/2,0,154/2]) rotate([0,90,0]) difference() {
            cube([154,25,154]);
            // achterzijde
            translate([13.65,-0.1,-0.1]) cube([126.7,5.6,154.2]);
            translate([13.65,4.5,-0.1]) cube([3,2,154.2]);
            translate([137.35,4.5,-0.1]) cube([3,2,154.2]);
            translate([47.8,4.5,-0.1]) cube([58,4,154.2]);
            // voorzijde
            translate([14.85,16.5,-0.1]) cube([124,12,154.2]);
        }
        // gaatjes
        middlegates();
        translate([-47,0,-50.6]) slidergates();
        translate([47,0,-50.6]) slidergates();
        translate([-47,0,50.6]) slidergates();
        translate([47,0,50.6]) slidergates();
        translate([-45.1,4,-70.2]) boutgat();
        translate([-45.1,4,70.2]) boutgat();
        translate([45.1,4,-70.2]) boutgat();
        translate([45.1,4,70.2]) boutgat();
        // sleuven voor zsupport
        translate([-154/2-2,16.5,-100]) cube([42,15,200]);
        translate([154/2+2-40,16.5,-100]) cube([42,15,200]);
    }
}

$cube([71/2-43/2,10,46/2]);

// representation for editing
$x_montageplt();
// 2D representation for lasercutting
$projection( cut=true ) {
    translate([0,0,-12]) rotate([90,0,0]) x_montageplt();
}
