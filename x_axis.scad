include <MCAD/stepper.scad>
include <MCAD/nuts_and_bolts.scad>
include <MCAD/metric_fastners.scad>
include <x_montageplt.scad>
include <x_kogelomloop.scad>
include <Rack_and_Pinion.scad>

module beam(l) {
    // dit is de beam van Peter / Michael maxlen = 218cm
    translate([0,0,120]) 
        rotate([0,90,0])
            scale([1,1,1]) 
                linear_extrude(file = "x_balk.dxf", height = l, center = false);
}

module xrail(l) {
    // dit is de rails die al op de beam zit
    translate([0,0,15]) 
        rotate([0,90,0])
            scale([1,1,1]) 
                linear_extrude(file = "x_rails.dxf", height = l, center = false);
    
}

module xrailholes(l=1000, offset=20) {
    // gaatjes in de beam
    for ( x = [ offset :60 : l ] ) {
        union() {
            translate([x,-8,4]) cylinder(h=10, r=3, center=true);
            translate([x,-8,10]) cylinder(h=5, r=4.5, center=true);
        }
    }

}

module xrails(l=1000) {
    // rails met gaatjes
    color([1,0,0]) difference() {
            xrail(l);
            rotate([-90,0,0]) xrailholes(l, offset=20);
        }
}

module xgliderblock(l=60) {
    // lagers op huidige rails
    color([0,0,0]) 
        rotate([0,90,0])
            linear_extrude(file = "x_gliderblock.dxf", height = l, center = false);
}

module xmontageplaat(l=140) {
    // montageplaat op huidige rails
    color ([0.5,0.5,0.5])
    rotate([0,90,0])
        x_montageplt();
}

module motorplate() {
    // deze plaat moeten we zelf maken!
    color("red", 0.8) difference() {
        cube([10,90,117]);
        // motor attachment holes
        translate([-15,77,25]) rotate([0,90,0]) cylinder(h=35, r=3);
        translate([-15,77,95]) rotate([0,90,0]) cylinder(h=35, r=3);
        //translate([-15,7,25]) rotate([0,90,0]) cylinder(h=35, r=3);
        //translate([-15,7,95]) rotate([0,90,0]) cylinder(h=35, r=3);
        // motor middle hole
        translate([-15,42,60]) rotate([0,90,0]) cylinder(h=30, r=30);
        // beam attachment holes
        //translate([7,10,26]) rotate([0,-90,0]) boltHole(size=4, length=30);
        translate([7,28.5,22]) rotate([0,-90,0]) boltHole(size=4, length=30);
        //translate([7,10,92]) rotate([0,-90,0]) boltHole(size=4, length=30);
        translate([7,28.5,96]) rotate([0,-90,0]) boltHole(size=4, length=30);
        // alternative beam attachment holes
        translate([17,7,25]) rotate([0,-90,0]) bolt(len=40, dia=6);
        translate([17,7,95]) rotate([0,-90,0]) bolt(len=40, dia=6);
    }
}

module motorconnector() {
    // stappenmotor.nl: KKK1-12x12
    // http://www.stappenmotor.nl/Stappenmotor/flexibele%20askoppelingen/klauw%20koppelingen/klauwkoppelingen/klauw%20koppelingen.htm
    color([1,0,0]) 
        rotate([0,90,0]) cylinder(h=30, r=12);
}

module xaxis(l) {
    beam(l);
    translate([0,37,99.5]) xrails(l);
    translate([l,37,25.5]) rotate([180,0,180]) xrails(l);
    translate([690,40,124]) xgliderblock();
    translate([770,40,124]) xgliderblock();
    translate([750,40,1]) rotate([180,0,180]) xgliderblock();
    translate([830,40,1]) rotate([180,0,180]) xgliderblock();
    translate([750,51,62]) rotate([0,90,0]) xmontageplaat();

    // not in use: spindle drive
    //translate([0,16,32]) aandrijving(o=5, l=l-30);
    //translate([1600,0,3]) motorplate();
    //translate([1520,41,62]) motorconnector();
    //translate([1585,41,62]) rotate([0,90,0]) motor(Nema34, NemaMedium, dualAxis=false);

    // rack & pinion drive
    color([0.3,0.5,0.5]) translate([0,0,100]) rotate([180,0,0]) rack(l=l);
    
}

// l = length of beam
//xaxis(l=1600);
