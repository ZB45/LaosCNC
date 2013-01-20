module hl1(l=1000) {
        union() {
            cube([40,3,l]);
            translate([3,0,0]) rotate([0,0,90]) cube([40,3,l]);
        }
}
module hl2(l=1000, offset=20) {
    for ( x = [ offset :100 : l ] ) {
        translate([13,3,x]) 
            rotate([90,90,0])
            cylinder(h=10, r=3, center=true);
    }
}

module hl(l=1000) {
    difference() {
        hl1(l);
        hl2(l=l, offset=20);
    }
}

module hoeklijn(l=1000) {
    translate([0,0,4]) rotate([180,-90,0]) hl(l);
    translate([l,0,120]) rotate([180,90,0]) hl(l);
}

//hoeklijn();
