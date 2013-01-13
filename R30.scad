module R30(l=10, offset=2) {
    difference() {
        rotate([90,0,90])
            scale([0.1,0.1,1]) 
                linear_extrude(file = "R30.dxf", height = l, center = false);
        for ( x = [ offset : 8 : l ] ) {
            translate([x,1.4,1.4]) cylinder(h=3, r=0.45, center=true);
            translate([x,1.4,2.4]) cylinder(h=2, r=0.7, center=true);
        }
    }
}

