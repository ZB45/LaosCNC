include <MCAD/stepper.scad>
include <MCAD/gears.scad>
include <MCAD/bearing.scad>

module tooth(h,b,th) {
polygon([
    [b,h*(1-th)],[b/2,h],[0,h*(1-th)]
    ]);
}

module rack(l=1000) {
    l=l/10;
    b=1/3; 
    h=1; 
    th=1/4; 
    offs=1/20;
    scale([12.5,12.5,12.5]) 
        translate([0,0.5,0]) 
            rotate([90,0,0])
                union() {
                    square([l*b*3*4/5,h*(1-th)]);
                    for(x=[0:(l*3*4/5)-1]) {
                        translate([x*b,-h*offs,0]) 
                            tooth(h,b,th);
                    }
                }
}

module band() {
    color([.4,.4,.4]) 
    difference() {
    hull() {
        translate([0,18,0]) rotate ([90,0,0]) cylinder(r=52, h=15);
        translate([76,18,0]) rotate ([90,0,0]) cylinder(r=17, h=15);
    }
    hull() {
        translate([0,19,0]) rotate ([90,0,0]) cylinder(r=51, h=22);
        translate([76,19,0]) rotate ([90,0,0]) cylinder(r=16, h=22);
    }
    }
}

module pinionframe() {
    color([.7,.9,.8]) hull() {
        translate([177,34,0]) rotate ([90,0,0]) cylinder(r=13, h=18);
        translate([0,15,-50]) cube([140,18,100]);
        translate([-20,15,-20]) cube([30,18,40]);

    }
}

module tensionholder(l=0,v=0) {
    difference() {
        union() {
            translate([-6.5,0,-6.5]) cube([34,1.5,13]);
            translate([13.5,0,-6.5]) cube([1.5,20,13]);
            translate([7.5,12.5,0]) rotate([0,90,0]) cylinder(r=6.5, h=5);
            translate([-10-l,0,-6.5]) {
                translate([14,12.5,6.5]) rotate([0,90,0]) cylinder(r=4, h=107);
                translate([78,-19+v,-6]) {
                    cube([2,50,24]);
                    difference() {
                        translate([-16,0,0]) cube([40,2,24]);
                        translate([16,4,12.5]) rotate([90,0,0]) cylinder(r=4,h=5);
                    }
                }
                translate([80,12.5,6.5]) rotate([0,90,0]) cylinder(r=8, h=1.7);
                color([1,0,0]) translate([81.7,12.5,6.5]) rotate([0,90,0]) cylinder(r=7, h=32);
                translate([114,12.5,6.5]) rotate([0,90,0]) cylinder(r=8, h=1.7);
                translate([116,12.5,6.5]) rotate([0,90,0]) cylinder(r=6.6, h=5);
            }
        }
        translate([0,-26,0]) rotate ([-90,0,0]) cylinder(r=4, h=30);
    }
}

module pinion(a=-30,b=-60,l=0, v=0, d=1) {
    rotate([0,a,0]) {
    translate([0,8,0]) 
    difference() {
    union() {
        band();
        translate([0,20,0]) rotate ([90,0,0]) cylinder(r=51, h=20);
        translate([76,20,0]) rotate ([90,0,0]) cylinder(r=16, h=20);
        translate([0,0,0]) rotate ([90,0,0]) cylinder(r=11, h=20);
        translate([177,36,0]) rotate ([90,0,0]) cylinder(r=4.7, h=38);
        translate([177,56,0]) rotate ([90,0,0]) cylinder(r=14.4, h=22);
        pinionframe();
        translate([76,34,0]) rotate([0,90,90]) motor(Nema34, NemaMedium, dualAxis=false);
    }
    translate([-5,35,20]) rotate ([90,0,0]) cylinder(r=4, h=30);
    translate([0,35,0]) rotate ([90,0,0]) cylinder(r=5, h=30);
    translate([-5,35,-20]) rotate ([90,0,0]) cylinder(r=4, h=30);
    }
    translate([-5,40,d*20]) {
    color([0,0,0]) translate([0,-25,0]) rotate ([-90,0,0]) cylinder(r=4, h=30);
    rotate([0,b,0]) tensionholder(l=0,v=0);
    }
    }
}
//tensionholder();
//pinion();
// rotate([0,-30,0]) pinion();
//color([0,0,0]) translate([-500,0,20]) rotate([180,0,0]) rack();
