module R30rail(l=1000) {
    translate([0,-15,0]) 
        rotate([90,0,90])
            scale([1,1,1]) 
                linear_extrude(file = "R30.dxf", height = l, center = false);
}

module R30holes(l=1000, offset=20) {
    for ( x = [ offset : 80 : l ] ) {
        union() {
            translate([x,0,13]) cylinder(h=27, r=4.5, center=true);
            translate([x,0,19]) cylinder(h=15, r=7, center=true);
        }
    }

}

module R30(l=10, offset=20) {
    difference() {
        R30rail(l);
        R30holes(l, offset);
    }
}

// R30(l=200);
