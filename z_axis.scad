fudge=0.1;
include <x_montageplt.scad>
include <MCAD/nuts_and_bolts.scad>

module zsteun(h=300, xspace=40) {
color ([1,0,0]) union() {
    difference() {
        cube([xspace,20,h]);
        translate([xspace-4.9,10,14.85/2])rotate([0,-90,0]) boltHole(size=6, length=xspace+0.2);
        translate([xspace-4.9,10,154-14.85/2])rotate([0,-90,0]) boltHole(size=6, length=xspace+0.2);
        translate([10,-0.1,h-10])rotate([-90,0,0]) boltHole(size=6, length=20.2);
        translate([xspace-10,-0.1,h-10])rotate([-90,0,0]) boltHole(size=6, length=20.2);
    }
    translate([-8.5,0,14.85]) cube([20,20,124.3]);
}
}

module zsteunconn(h=300, xspace=40) {
    color([1,0,0.2])
    difference() {
        cube([xspace, 70, 20]);
        translate([10,70.1,10])rotate([90,0,0]) boltHole(size=6, length=10);
        translate([xspace-10,70.1,10])rotate([90,0,0]) boltHole(size=6, length=10);
        translate([10,-0.1,10])rotate([-90,0,0]) boltHole(size=6, length=10);
        translate([xspace-10,-0.1,10])rotate([-90,0,0]) boltHole(size=6, length=10);
    }
}

module zrailsholes(l=300, offset=20, spacing=60) {
    // gaatjes in de beam
    for ( x = [ offset :spacing : l ] ) {
        union() {
            translate([10,4,x]) rotate([90,0,0]) cylinder(h=10, r=3, center=true);
        }
    }

}

module zrails(l=300) {
    // type damencnc HGR-20-T
    difference() {
        cube([20,17.5,l]);
        translate([0,16,-0.1]) cylinder(r=3, h=l+0.2);
        translate([20,16,-0.1]) cylinder(r=3, h=l+0.2);
        translate([0,8,-0.1]) cylinder(r=3, h=l+0.2);
        translate([20,8,-0.1]) cylinder(r=3, h=l+0.2);
        zrailsholes(l=l,offset=20, spacing=60);
    }
    zrailsholes();
}

module zcart() {
    // type damencnc HGH-20CA
    difference() {
        cube([44,75.6,30-4.6]);
        translate([44/2-10, 75.9, -4.6]) rotate([90,0,0]) zrails(l=76);
    }
}

module z_axis() {
    xspace=40;
    h=300;
    translate([0,22,0]) zsteun(h, xspace);
    translate([0,154-42,0]) zsteun(h, xspace);
    translate([0,42,20]) zsteunconn(h, xspace);
    translate([0,42,h-20]) zsteunconn(h, xspace);    
    translate([xspace, 42, 0]) rotate([0,0,-90]) zrails(h);
    translate([xspace, 132, 0]) rotate([0,0,-90]) zrails(h);
    translate([xspace+4.6,10,10]) rotate([90,0,90]) zcart();
    translate([xspace+4.6,100,10]) rotate([90,0,90]) zcart();
    translate([xspace+4.6,10,110]) rotate([90,0,90]) zcart();
    translate([xspace+4.6,100,110]) rotate([90,0,90]) zcart();
}
    
translate([-25,0,0]) rotate([0,-90,-90]) x_montageplt();
z_axis();
//zsteunconn(xspace=40, h=300);
//zsteun(h=300, xspace=40);
