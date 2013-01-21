fudge=0.1;
include <MCAD/nuts_and_bolts.scad>
module montagegat() {
    union() {
        translate([0,27,0]) rotate([90,0,0]) cylinder(r=4.25, h=14);
        translate([0,16.9,0]) rotate([90,0,0]) cylinder(r=2.5, h=12);
    }
}

module middlegates() {
        translate([0,0,0]) montagegat();
        translate([46,0,0]) montagegat();
        translate([0,0,42.9]) montagegat();
        translate([46,0,42.9]) montagegat();
}

module slidergates() {
        translate([0,0,0]) montagegat();
        translate([15.4,0,0]) montagegat();
        translate([0,0,26.5]) montagegat();
        translate([15.4,0,26.5]) montagegat();
}

module boutgat() {
    translate([0,-1,0]) rotate([-90,0,0]) boltHole(size=6, length=30);
}

module x_montageplt() {
    difference() {
        cube([154,25,154]);
        union() {
        translate([13.65,-0.1,-0.1]) cube([126.7,5.6,154.2]);
        translate([13.65,4.5,-0.1]) cube([3,2,154.2]);
        translate([137.35,4.5,-0.1]) cube([3,2,154.2]);
        translate([47.8,4.5,-0.1]) cube([58,4,154.2]);
        translate([14.85,16,-0.1]) cube([124.3,9.1,154.2]);
        translate([54,0,19.6]) middlegates();
        translate([54,0,90.8]) middlegates();
        translate([18.6,0,16.4]) slidergates();
        translate([18.6,0,110.6]) slidergates();
        translate([120.3,0,16.4]) slidergates();
        translate([120.3,0,110.6]) slidergates();
        translate([7.45,0,32]) boutgat();
        translate([7.45,0,122]) boutgat();
        translate([146.55,0,32]) boutgat();
        translate([146.55,0,122]) boutgat();
        }
    }

}

// x_montageplt();
