module tp10(l) {
    scale([2.5,2.5,1]) {
        linear_extrude(file = "extrusie-doorsnee.dxf", height = l, center = false);
    }
}

module edge45() {
    //translate([0,0,10]) rotate([0,90,0]) 
    translate([10.1,10.1,-0.1]) rotate([0,0,180])
    polyhedron ( points = [[0, 0, 0], [10.2, 0, 0], [0, 10.2, 0], 
             [10.2, 10.2, 0], [0, 0, 10.2], [10.2, 0, 10.2]], 
              triangles = [[0,1,2], [3,2,1],  [0,5,1], [0,4,5], 
              [4,5,2], [3,2,5],  [0,2,4], [1,3,5] ]);
}

module tp10c(l) {
    difference() {
        tp10(l,$fn=100);
        %edge45($fn=100);
        %translate([10,0,l]) rotate([0,180,0]) edge45();
    }
}

module vlak(l,b) {
	    translate([0,0,10]) rotate([90,90,90]) tp10c(l);
	    translate([0,b,0]) rotate([90,-90,90]) tp10c(l);
	    translate([0,0,0]) rotate([0,-90,-90]) tp10c(b);
	    translate([l,0,10]) rotate([180,90,-90]) tp10c(b);
}

module poten(h) {
    translate([0,0,0]) tp10(h);
    translate([280,0,0]) tp10(h);
    translate([0,150,0]) tp10(h);
    translate([280,150,0]) tp10(h);
}

module steunliggers(l,hs) {
    translate([0,0,hs]) {
	    translate ([10,0,0]) rotate([90,0,90]) tp10(l-20);
	    translate([10,150,0]) rotate([90,0,90]) tp10(l-20);
    }
}

module zijplaten(l, b, hp) {
    translate([-1,0,hp]) cube([1,b,30]);
    translate([l,0,hp]) cube([1,b,30]);
}

module imperial() {
	// zijkanten
	translate([0,0,-.5]) cube([250,2.5,3.5]);
	translate([0,137.5,-.5]) cube([250,2.5,3.5]);
	// dunnetjes
	translate([51,0,0]) cube([2.5,140,2.5]);
	translate([81,0,0]) cube([2.5,140,2.5]);
	translate([142,0,0]) cube([2.5,140,2.5]);
	translate([173,0,0]) cube([2.5,140,2.5]);
	translate([225,0,0]) cube([2.5,140,2.5]);
	// dikkertjes
	translate([20,0,-1]) cube([3.5,140,3.5]);
	translate([110,0,-1]) cube([3.5,140,3.5]);
	translate([203,0,-1]) cube([3.5,140,3.5]);
	// einden
	translate([1,0,-.5]) cube([3.5,140,2.5]);
	translate([245.5,0,-.5]) cube([3.5,140,2.5]);
}

module tafel(l,b,h,hs,hp) {
    poten(h);
    translate([0,0,h]) vlak(l,b);
    steunliggers(l,hs);
    color([0,1,0]) zijplaten(l, b,hp);
    color([0,0,0]) translate([20,10,75]) imperial();
}

// tafel(l=290,b=160,h=70,hs=30,hp=20);
