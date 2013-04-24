module tp10(l) {
    scale([25,25,1]) {
        linear_extrude(file = "extrusie-doorsnee.dxf", height = l, center = false);
    }
}

module edge45() {
    translate([100,100,0]) rotate([0,0,180])
    polyhedron ( points = [[0, 0, 0], [102, 0, 0], [0, 102, 0], 
             [102, 102, 0], [0, 0, 102], [102, 0, 102]], 
              triangles = [[0,1,2], [3,2,1],  [0,5,1], [0,4,5], 
              [4,5,2], [3,2,5],  [0,2,4], [1,3,5] ]);
}

module tp10c(l) {
    difference() {
        tp10(l,$fn=100);
        %edge45($fn=100);
        %translate([100,0,l]) rotate([0,180,0]) edge45();
    }
}

module vlak(l,b) {
	    translate([0,0,100]) rotate([90,90,90]) tp10c(l);
	    translate([0,b,0]) rotate([90,-90,90]) tp10c(l);
	    translate([0,0,0]) rotate([0,-90,-90]) tp10c(b);
	    translate([l,0,100]) rotate([180,90,-90]) tp10c(b);
}

module poten(h) {
    translate([0,0,0]) tp10(h);
    translate([2800,0,0]) tp10(h);
    translate([0,1500,0]) tp10(h);
    translate([2800,1500,0]) tp10(h);
}

module steunliggers(l,hs) {
    translate([0,0,hs]) {
	    translate ([100,0,0]) rotate([90,0,90]) tp10(l-200);
	    translate([100,1500,0]) rotate([90,0,90]) tp10(l-200);
    }
}

module zijplaten(l, b, hp) {
    translate([-10,0,hp]) cube([1,b,300]);
    translate([l,0,hp]) cube([1,b,300]);
}

module imperial() {
	// zijkanten
	translate([0,0,-5]) cube([2500,25,35]);
	translate([0,1375,-5]) cube([2500,25,35]);
	// dunnetjes
	translate([510,0,0]) cube([25,1400,25]);
	translate([810,0,0]) cube([25,1400,25]);
	translate([1420,0,0]) cube([25,1400,25]);
	translate([1730,0,0]) cube([25,1400,25]);
	translate([2250,0,0]) cube([25,1400,25]);
	// dikkertjes
	translate([200,0,-1]) cube([35,1400,35]);
	translate([1100,0,-1]) cube([35,1400,35]);
	translate([2030,0,-1]) cube([35,1400,35]);
	// einden
	translate([10,0,-5]) cube([35,1400,25]);
	translate([2455,0,-5]) cube([35,1400,25]);
}

module tafel(l,b,h,hs,hp) {
    poten(h);
    translate([0,0,h]) vlak(l,b);
    steunliggers(l,hs);
    color([0,1,0]) zijplaten(l, b,hp);
    color([0,0,0]) translate([200,100,750]) imperial();
}

//tafel(l=2900,b=1600,h=700,hs=300,hp=200);
