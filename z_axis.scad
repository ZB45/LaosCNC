// note: this design needs MCAD library!
// http://reprap.org/wiki/MCAD

fudge=0.1;
//$fn=100;
//$fs=100;

include <MCAD/nuts_and_bolts.scad>
include <MCAD/stepper.scad>
include <MCAD/metric_fastners.scad>
include <NEMA17-to-27-adapter.scad>
include <x_montageplt.scad>
include <endstop.scad>

module zsupport_l() {
    // this part can be made out of staf aluminium
    h=356;
    color ([1,0,0]) 
        difference() {
            cube([40,15,h]);
                // holes for connection to x_axis-plate
                translate([40-(154/2-45.1),0,154/2-70.1]) rotate([-90,0,0]) boltHole(size=6, length=20);
                translate([40-(154/2-45.1),0,154/2+70.1]) rotate([-90,0,0]) boltHole(size=6, length=20);
                translate([20,15.1,154/2-23]) rotate([90,0,0]) bolt(M5,35);
                translate([20,15.1,154/2+23]) rotate([90,0,0]) bolt(M5,35);
              
                // holes for rails
                for ( x = [ 28 :60 : h ] ) {
                    translate([22,4.5,x]) rotate([-90,0,0]) boltHole(size=6, length=20);
                }
                // holes to connect the two beams together
                translate([7.5,11,h-15]) rotate([0,90,-90]) boltHole(size=6, length=70);
                translate([7.5,11,h-100]) rotate([0,90,-90]) boltHole(size=6, length=70);
                translate([7.5,11,h-180]) rotate([0,90,-90]) boltHole(size=6, length=70);
                // holes on top to fit topplate
                translate([20,7.5,h+1]) rotate([0,180,0]) boltHole(size=6, length=20);
                // hole for stopblock();
                translate([30,16,7.5]) rotate([90,0,0]) boltHole(size=4, length=30);
        }
}

module zsupport_r() {
    // this part can be made out of staf aluminium
    h=356;
    color ([1,0,0]) 
        difference() {
            cube([40,15,h]);
                // holes for connection to x_axis-plate
                translate([(154/2-45.1),0,154/2-70.1]) rotate([-90,0,0]) boltHole(size=6, length=20);
                translate([(154/2-45.1),0,154/2+70.1]) rotate([-90,0,0]) boltHole(size=6, length=20);
                translate([20,0,154/2-23]) rotate([-90,0,0]) boltHole(size=5, length=20);
                translate([20,0,154/2+23]) rotate([-90,0,0]) boltHole(size=5, length=20);
             
                // holes for rails
                for ( x = [ 28 :60 : h ] ) {
                    translate([18,4.5,x]) rotate([-90,0,0]) boltHole(size=6, length=20);
                }
                // holes to connect the two beams together
                translate([40-7.5,11,h-15]) rotate([0,90,-90]) boltHole(size=6, length=70);
                translate([40-7.5,11,h-100]) rotate([0,90,-90]) boltHole(size=6, length=70);
                translate([40-7.5,11,h-180]) rotate([0,90,-90]) boltHole(size=6, length=70);
                // holes on top to fit topplate
                translate([20,7.5,h+1]) rotate([0,180,0]) boltHole(size=6, length=20);
                // hole for stopblock();
                translate([10,16,7.5]) rotate([90,0,0]) boltHole(size=4, length=30);
        }
}

module zsupport2() {
    // this part can be made out of staf aluminium
    h=356-154;
    color ([1,0,0]) 
    difference() {
            cube([15,40,h]);
            // holes to connect the two beams together
            translate([7.5,-3,h-15]) rotate([0,90,90]) boltHole(size=6, length=70);
            translate([7.5,-3,h-100]) rotate([0,90,90]) boltHole(size=6, length=70);
            translate([7.5,-3,h-180]) rotate([0,90,90]) boltHole(size=6, length=70);
            translate([7.5,20,h+1]) rotate([0,180,0]) boltHole(size=6, length=11);

    }   
}

module topplate() {
    $fn=50;
    color([1,0,0.2])
    difference() {
    rotate([0,0,90]) translate([0,-154/2,0]) 
    difference() {
        translate([-30,0,0]) cube([80, 154, 10]);
        // uitsnede voor spindel
        translate([19,154/2,-1]) cylinder(r=18,h=12);
        // holes to connect to spindle
        translate([10-30,154/2-72/2+10,-1]) {
            translate([0,0,0]) boltHole(size=8, length=10+2);
            translate([60,0,0]) boltHole(size=8, length=10+2);
            translate([0,52,0]) boltHole(size=8, length=10+2);
            translate([60,52,0]) boltHole(size=8, length=10+2);
        }       
    }
    // holes to fit on top of zsupport
    translate([154/2-20,16.5+7.5,-1]) cylinder(r=3, h=12);
    translate([-154/2+20,16.5+7.5,-1]) cylinder(r=3, h=12);
    translate([154/2-40+7.5,-20+16.5,-1]) cylinder(r=3, h=12);
    translate([-154/2+25+7.5,20-40+16.5,-1]) cylinder(r=3, h=12);
    }
}

module zrails() {
    // z rails, type: damencnc HGR-20-T
    zr_l = 20;      // width of the rails 
    zr_b = 17.5;    // thickness of the rails
    zr_h = 356;    // length of the rails (depends on construction)
    zr_offset = 28-15; // offset of holes in rails from start
    zr_spacing = 60;// spacing of holes in rails
    zr_yoffset = 6;// y offset from edge of support beam
    // type damencnc HG20R
    translate([10,0,0]) rotate([0,0,90]) 
    difference() {
        cube([zr_b,zr_l,zr_h]);
        translate([zr_b/2,0,-1]) cylinder(r=3, h=zr_h+2);
        translate([zr_b/2,zr_l,-1]) cylinder(r=3, h=zr_h+2);
        translate([zr_b,0,-1]) cylinder(r=3, h=zr_h+2);
        translate([zr_b,zr_l,-1]) cylinder(r=3, h=zr_h+2);
        // gaatjes in de beam
        for ( x = [ zr_offset :zr_spacing : zr_h ] ) {
            union() {
                translate([-1,zr_l/2,x]) rotate([0,90,0]) boltHole(size=6, length=10);
            }
        }
    }
}

module zcartholes() {
    translate([6,26,19.8]) rotate([90,0,0]) boltHole(size=6, length=12);
    translate([6,26,55.8]) rotate([90,0,0]) boltHole(size=6, length=12);
    translate([38,26,19.8]) rotate([90,0,0]) boltHole(size=6, length=12);
    translate([38,26,55.8]) rotate([90,0,0]) boltHole(size=6, length=12);
}

module zcartbolts() {
    color([0,0.9,0.7]) {
        translate([6,26,19.8]) rotate([90,0,0]) csk_bolt(M6,15);
        translate([6,26,55.8]) rotate([90,0,0]) csk_bolt(M6,15);
        translate([38,26,19.8]) rotate([90,0,0]) csk_bolt(M6,15);
        translate([38,26,55.8]) rotate([90,0,0]) csk_bolt(M6,15);
    }

}

module zcart() {
    // type damencnc HGH-20CA
    difference() {
        cube([44,25.5,75.5]);
        zcartholes();
    }
}

module z_spindle(z_slag) {
    translate([36,0,0]) rotate([0,0,90]) {
    color([1,1,0])
    union() {
        difference() {
            cube([80,72,68]);
            // holes bottom
            translate([10,10,-.1]) boltHole(size=8, length=18);
            translate([70,10,-.1]) boltHole(size=8, length=18);
            translate([70,62,-.1]) boltHole(size=8, length=18);
            translate([10,62,-.1]) boltHole(size=8, length=18);
            // holes around axis left
            translate([8,-.1,14]) rotate([-90,0,0]) boltHole(size=4.5, length=8);
            translate([40,-.1,14]) rotate([-90,0,0]) boltHole(size=4.5, length=8);
            translate([8,-.1,46]) rotate([-90,0,0]) boltHole(size=4.5, length=8);
            translate([40,-.1,46]) rotate([-90,0,0]) boltHole(size=4.5, length=8);
            // holes around axis right
            translate([8,72.1,14]) rotate([90,0,0]) boltHole(size=4.5, length=8);
            translate([40,72.1,14]) rotate([90,0,0]) boltHole(size=4.5, length=8);
            translate([8,72.1,46]) rotate([90,0,0]) boltHole(size=4.5, length=8);
            translate([40,72.1,46]) rotate([90,0,0]) boltHole(size=4.5, length=8);
        }
        translate([32,18,66]) cube([35,35,200]);
        translate([49.5,36,-12.15]) cylinder(r=15,h=13);
    }
    color([0,0,0]) {
    translate([0,0,z_slag+4]) union() {
        translate([49.5,36,-162.15]) cylinder(r=9,h=150);
        translate([49.5,36,-180.15]) cylinder(r=6,h=18);
    }
    translate([25,96,30]) rotate([90,0,0]) cylinder(r=5, h=120); // aandrijfas
    }
    $color([0,0.9,0.7]) translate([10,10,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
    $color([0,0.9,0.7]) translate([70,10,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
    $color([0,0.9,0.7]) translate([70,62,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
    $color([0,0.9,0.7]) translate([10,62,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
    }
}

module spacerbus() {
    rotate([90,0,0])
    difference() {
        cylinder(r=5, h=40);
        translate([0,0,-1]) cylinder(r=2.5, h=50+2);
    }
}

module hfmotorholes() {
    translate([0,0,14.75]) {
    translate([-15,0,0]) rotate([-90,0,0]) boltHole(size=6, length=22);
    translate([15,0,0]) rotate([-90,0,0]) boltHole(size=6, length=22);
    translate([-15,0,110]) rotate([-90,0,0]) boltHole(size=6, length=22);
    translate([15,0,110]) rotate([-90,0,0]) boltHole(size=6, length=22);
    }
}

module hfmotorbolts() {
    color([0,0.9,0.7]) translate([0,0,14.75]) {
    translate([-15,0,0]) rotate([-90,0,0]) cap_bolt(M6,20);
    translate([15,0,0]) rotate([-90,0,0]) cap_bolt(M6,20);
    translate([-15,0,110.5]) rotate([-90,0,0]) cap_bolt(M6,20);
    translate([15,0,110.5]) rotate([-90,0,0]) cap_bolt(M6,20);
    }
}

module spindleholes(zmph,zmpw) {
    translate([6.5,zmpw/2-10,zmph-5]) rotate([0,-90,0]) boltHole(size=5, length=22);
    translate([6.5,zmpw/2+10,zmph-5]) rotate([0,-90,0]) boltHole(size=5, length=22);
}

module spindlebolts(zmph,zmpw) {
    color([0,0.9,0.7]) {
    translate([2.5,zmpw/2-10,zmph-5]) rotate([0,-90,0]) cap_bolt(M5,22);
    translate([2.5,zmpw/2+10,zmph-5]) rotate([0,-90,0]) cap_bolt(M5,22);
    }
}

module z_montageplaat() {
    translate([-154/2,0,0]) difference() {
        translate([0,0,-85]) cube([154,10,280]);
        translate([0,-18,0]) zcartholes();
        translate([0,-18,120]) zcartholes();
        translate([154-44,-18,0]) zcartholes();
        translate([154-44,-18,120]) zcartholes();
        for ( z = [ 0: 25 : 90 ] ) 
            translate([154/2,-1,-z]) hfmotorholes();
        // spindle connection holes
        translate([154/2+15,7,195-23]) rotate([90,0,0]) boltHole(size=5, length=22);
        translate([154/2-15,7,195-23]) rotate([90,0,0]) boltHole(size=5, length=22);
        translate([154/2+15,7,195-53]) rotate([90,0,0]) boltHole(size=5, length=22);
        translate([154/2-15,7,195-53]) rotate([90,0,0]) boltHole(size=5, length=22);
    }
}

module washernut_m5() {
    $fs=100;
    $fn=100;
    rotate([-90,0,0]) {
        flat_nut(M5);
        translate([0,0,4.5]) washer(M5);
    }
}

module spindleconn() {
    h=60;
    difference() {
        union() {
            translate([-30,0,54]) cube([60,60,6]);
            translate([-30,54,0]) cube([60,6,60]);
            translate([-30,0,0]) 
                polyhedron ( points = [[0, 54, 54], [6, 54, 54], [0, 54, 0], 
                [6, 54, 0], [0, 0, 54], [6, 0, 54]], 
                triangles = [[0,1,2], [3,2,1],  [0,5,1], [0,4,5], 
                [4,5,2], [3,2,5],  [0,2,4], [1,3,5] ]);
            translate([24,0,0]) 
                polyhedron ( points = [[0, 54, 54], [6, 54, 54], [0, 54, 0], 
                [6, 54, 0], [0, 0, 54], [6, 0, 54]], 
                triangles = [[0,1,2], [3,2,1],  [0,5,1], [0,4,5], 
                [4,5,2], [3,2,5],  [0,2,4], [1,3,5] ]);
        }
        translate([-20,-1,-1]) cube([40,41,h-14]);
        translate([0,30,-1]) cylinder(r=6,h=h+2);
        translate([15,53,40]) rotate([-90,0,0]) boltHole(size=5, length=8);
        translate([-15,53,40]) rotate([-90,0,0]) boltHole(size=5, length=8);
        translate([15,53,10]) rotate([-90,0,0]) boltHole(size=5, length=8);
        translate([-15,53,10]) rotate([-90,0,0]) boltHole(size=5, length=8);
    }
}

module hfmotor() {
    // http://damencnc.com/en/tools/teknomotor/hf-motor/247
    // model: C51/60-A-SB-P-ER25-3.3KW-18000RPM
    difference() {
    translate([-51,0,0]) union() {
        cube([102,119.5, 220]);
        translate([6,119.5,100]) cube([90,30.7,80]);
        translate([51,119.5/2,-9]) cylinder(r=50, h=9);
        translate([51,119.5/2,-28.5]) cylinder(r=85/2, h=28);
        translate([51,119.5/2,-56.5]) cylinder(r=15, h=29);
        $translate([51,119.5/2,-136.5]) cylinder(r=4, h=80);
    }
    hfmotorholes();
    }
}

module koppeling() {
    // damencnc
    // http://www.damencnc.com/en/components/mechanical-parts/shaft-couplers/145
    // HUB ShaftCoupler DCNC-D32-L32_B6.35
    // SPIDER DCNC-D32-L32 (B-green)
    // HUB ShaftCoupler DCNC-D32-L32_B10.00
    color([0,1,0]) {
        cylinder(r=16, h=32);
    }
}

module stopblock() {
    difference() {
        cube([154,10,15]);
        translate([10,7.1,7.5]) rotate([90,0,0]) boltHole(size=4, length=20);
        translate([144,7.1,7.5]) rotate([90,0,0]) boltHole(size=4, length=20);
    }
}

module static() {
    //x_montageplt();
    translate([154/2-40,16.5,-154/2]) {
        zsupport_l();
        translate([20,7.5,356+12]) rotate([0,180,0]) cap_bolt(M6,30);
    }
    translate([-154/2,16.5,-154/2]) {
        zsupport_r();
        translate([20,7.5,356+12]) rotate([0,180,0]) cap_bolt(M6,30);
    }
    translate([154/2-15,-40+16.5,154/2]) {
        zsupport2();
        translate([7.5,20,356-154+12]) rotate([0,180,0]) cap_bolt(M6,30);
    }
    translate([-154/2,-40+16.5,154/2]) {
        zsupport2();
        translate([7.5,20,356-154+12]) rotate([0,180,0]) cap_bolt(M6,30);
    }
    //translate([-154/2,16.5+15,-154/2]) stopblock();
    translate([154/2-40+22,16.5+15,-154/2]) zrails(); 
    translate([-154/2+40-22,16.5+15,-154/2]) zrails(); 
    translate([0,0,356-154/2]) topplate();
    translate([0,-30,289]) z_spindle(z_slag);
    rotate([0,0,90]) 
    translate([-30,-72/2,356-154/2+10]) {
        color([1,0,0]) {
            translate([2,-4,14]) spacerbus();
            translate([46,-4,14]) spacerbus();
            translate([2,-4,52]) spacerbus();
            translate([46,-4,52]) spacerbus();
        }
        translate([24,-42+36 ,30.5]) rotate([90,0,0]) koppeling();
        translate([24,-2,30.5]) rotate([90,0,0]) nema_gasket();
        translate([24,-40-1,30.5]) rotate([90,0,0]) motor(Nema23, NemaLong, dualAxis=false);
    }
    translate([-154/2,50,356-154/2+12]) rotate([0,180,-90]) endstop();
}

module moving() {
    translate([-154/2,-25.5,0]) zcart();
    translate([154/2-44,-25.5,0]) zcart();
    translate([-154/2,-25.5,195-75.5]) zcart();
    translate([154/2-44,-25.5,195-75.5]) zcart();
    z_montageplaat();
    translate([0,0,-75]) {
        translate([0,10,0]) hfmotor();
        hfmotorbolts();
    }
    translate([0,-60,132]) {
        spindleconn();
        translate([-15,49,10]) washernut_m5();
        translate([15,49,10]) washernut_m5();
        translate([-15,49,40]) washernut_m5();
        translate([15,49,40]) washernut_m5();
    }
}

module flatprojection() {
	// flat for lasercutting
	$fn=20;
	$fs=20;
	projection(cut=true) {
	translate([154/2,154/2,-12]) rotate([90,0,0]) x_montageplt();
	translate([154/2,354,-5]) rotate([90,0,0]) z_montageplaat();
	translate([160,0,7.5]) rotate([-90,0,0]) zsupport_l();
	translate([210,0,7.5]) rotate([-90,0,0]) zsupport_r();
	translate([160,360,20]) rotate([-90,0,0]) zsupport2();
	translate([180,360,20]) rotate([-90,0,0]) zsupport2();
	translate([0,445,5]) rotate([-90,0,0]) stopblock();
	translate([154/2,495,-5]) topplate();
	translate([225,390,0]) nema_gasket();
	translate([225,450,0]) nema_gasket();
	}
}

z_slag = 100;    // de maximale beweging van de as
                // varieer dit om te zien hoe hij beweegt!
                // 0...146
static();
translate([0,60,z_slag-62]) moving();


// TODO:
// * nameten hoe veel de lagers over de rails vallen
// * nameten/bereken of z-spindle wel in het midden hangt en op de juiste
//   hoogte is getekend
// * MAL maken voor topplate();
// * SPINDLEconn maken

// SVG:
// topplate
// z_montageplaat (nieuwe versie)


