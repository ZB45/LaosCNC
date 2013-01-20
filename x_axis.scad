include <MCAD/stepper.scad>

module beam(l) {
    translate([0,0,120]) 
        rotate([0,90,0])
            scale([1,1,1]) 
                linear_extrude(file = "x_balk.dxf", height = l, center = false);
}

module xrail(l) {
    translate([0,0,15]) 
        rotate([0,90,0])
            scale([1,1,1]) 
                linear_extrude(file = "x_rails.dxf", height = l, center = false);
    
}

module xrailholes(l=1000, offset=20) {
    for ( x = [ offset :60 : l ] ) {
        union() {
            translate([x,-8,4]) cylinder(h=10, r=3, center=true);
            translate([x,-8,10]) cylinder(h=5, r=4.5, center=true);
        }
    }

}

module xrails(l=1000) {
    color([1,0,0]) difference() {
            xrail(l);
            rotate([-90,0,0]) xrailholes(l, offset=20);
        }
}

module xgliderblock(l=60) {
    color([0,0,0]) 
        rotate([0,90,0])
            linear_extrude(file = "x_gliderblock.dxf", height = l, center = false);
}

module xmontageplaat(l=140) {
    color ([0.5,0.5,0.5])
    rotate([0,90,0])
        linear_extrude(file = "x_montageplt.dxf", height = l, center = false);
}

module bearingblock() {
    color([0,0,0])
        cube([30,50,60]);
}

module driverblock() {
    color([0,0,0])
        cube([50,35,60]);
}

module axis() {
    rotate([0,90,0]) cylinder(h=1700, r=10);
}

module motorplate() {
    cube([5,80,120]);
}

module motorconnector() {
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
    translate([20,16,30]) bearingblock();
    translate([1580,16,30]) bearingblock();
    translate([735,25,30]) driverblock();
    translate([690,52,139]) xmontageplaat();
    translate([0,45,60]) axis();
    //translate([1745,0,0]) motorplate();
    //translate([1695,45,60]) motorconnector();
    //translate([1750,45,60]) rotate([0,90,0]) motor(Nema34, NemaMedium, dualAxis=false);
}

// l = length of beam
// xaxis(l=1745);
