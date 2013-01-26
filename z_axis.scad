// note: this design needs MCAD library!
// http://reprap.org/wiki/MCAD

fudge=0.1;
include <MCAD/nuts_and_bolts.scad>
include <MCAD/stepper.scad>
include <MCAD/metric_fastners.scad>
include <NEMA17-to-27-adapter.scad>
include <x_montageplt.scad>
include <endstop.scad>

// SIZES: all sizes should be defined here

z_slag = 100;    // de maximale beweging van de as
                // varieer dit om te zien hoe hij beweegt!

// xaxis_plate
xp_l = 154;     // length of the plate
xp_b = 25;      // thickness of the plate
xp_h = 154;     // height of the plate
xp_bh = 14.85;  // height of the edge of the plate
xp_bb = 8.5;    // thickness of the edge of the plate
xp_bbolt = 6;   // size of the bolts in the edge of the plate
xp_bhl = 32;    // distance from side to hole in the edge of the plate

// support beam
sb_l = 40;      // width
sb_b = 15;      // thickness
sb_h = 356;     // height

// z rails, type: damencnc HGR-20-T
zr_l = 20;      // width of the rails 
zr_b = 17.5;    // thickness of the rails
zr_h = sb_h-10;    // length of the rails (depends on construction)
zr_offset = 20; // offset of holes in rails from start
zr_spacing = 60;// spacing of holes in rails
zr_yoffset = 6;// y offset from edge of support beam

// zcart, type damencnc HGH-20CA
zc_l = 44;      // width of the cart
zc_b = 25.4;    // height of the cart
zc_h = 75.6;    // length of the cart
zc_offset = 4.6;// cart offset from rails bottom
zc_pos1 = 10 + z_slag;   // cart positon on rails
zc_pos2 = zc_pos1 + 120; // 2nd cart position on rails

// spindle
sp_l=72;        // spindle width
sp_b=80;        // spindle length
sp_offx=30;     // spindle placement parameter

// top plate
tp_l = xp_l;    // width of the plate
//tp_b = sb_b*2+zr_b;      // length of the plate
tp_b = sp_b;
tp_h=10;        // thickness of top plate

// spacerbus length
spb_l = 50; // spacing tussen stappenmotor en spindle

// spindleconn sizes
sc_l = 60;
sc_b = 60;
sc_h = 10;

// stopblock
st_l = xp_l;
st_b = tp_h;
st_h = tp_h;

module zrailsbolts(h=300, r_offset=40, r_spacing=60, rh=17.5) {
    // boutjes in gaatjes in de beam
    color([0,0.9,0.7])
    for ( x = [ r_offset :r_spacing : h ] ) {
        union() {
            translate([10,rh-10+0.1,x]) rotate([90,0,0]) cap_bolt(M6,15);
        }
    }

}

module zsupport_l() {
    // this part can be made out of staf aluminium
    color ([1,0,0]) 
    union() {
        difference() {
            union() {
                cube([sb_b,sb_l,sb_h]);
                translate([-sb_b,0,xp_l]) cube([sb_b+1,sb_l,sb_h-xp_h]);
            }
            // cut-outs to fit around x_axis-plate
            translate([-1,-1,-1]) cube([xp_bb+1, sb_l+2, xp_bh+1]);
            translate([-1,-1,xp_h-xp_bh]) cube([xp_bb+1, sb_l+2, xp_bh+1]);
            // holes for connection to x_axis-plate
            translate([sb_b+2-xp_bbolt,xp_bhl,xp_bh/2]) rotate([0,-90,0]) boltHole(size=xp_bbolt, length=sb_b+2);
            translate([sb_b+2-xp_bbolt,xp_bhl,xp_h-xp_bh/2])rotate([0,-90,0]) boltHole(size=xp_bbolt, length=sb_b+2);
            // holes for rails
            for ( x = [ zr_offset :zr_spacing : zr_h ] ) {
                translate([4,zr_l/2+zr_yoffset,x+10]) rotate([90,0,90]) boltHole(size=6, length=40);
            }
            // holes to connect the two beams together
            translate([-1-sb_b,sb_l/2,sb_h-15]) rotate([0,90,0]) boltHole(size=4, length=26);
            translate([-1-sb_b,sb_l/2,sb_h-100]) rotate([0,90,0]) boltHole(size=4, length=26);
            translate([-1-sb_b,sb_l/2,sb_h-180]) rotate([0,90,0]) boltHole(size=4, length=26);
            // holes on top to fit topplate
            translate([sb_b/2,sb_l/2,sb_h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            translate([-sb_b/2,sb_l/2,sb_h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
        }
    }
    // show bolts in holes to x_axis-plate
    // color([0,0.9,0.7]) translate([7,th/2,mbw/2]) rotate([0,-90,0]) cap_bolt(M6,15);
    // color([0,0.9,0.7]) translate([7,th/2,mbh-mbw/2]) rotate([0,-90,0]) cap_bolt(M6,15);
    // show bolts to connect the two beams together
    // color([0,0.9,0.7]) translate([-7,th/2,h-20]) rotate([0,90,0]) cap_bolt(M6,20);
    // color([0,0.9,0.7]) translate([-7,th/2,h-80]) rotate([0,90,0]) cap_bolt(M6,20);
}

module zsupport_r() {
    // this part can be made out of staf aluminium
    color ([1,0,0]) 
    union() {
        difference() {
            union() {
                cube([sb_b,sb_l,sb_h]);
                translate([-sb_b,0,xp_l]) cube([sb_b+1,sb_l,sb_h-xp_h]);
            }
            // cut-outs to fit around x_axis-plate
            translate([-1,-1,-1]) cube([xp_bb+1, sb_l+2, xp_bh+1]);
            translate([-1,-1,xp_h-xp_bh]) cube([xp_bb+1, sb_l+2, xp_bh+1]);
            // holes for connection to x_axis-plate
            translate([sb_b+2-xp_bbolt,sb_l-xp_bhl,xp_bh/2]) rotate([0,-90,0]) boltHole(size=xp_bbolt, length=sb_b+2);
            translate([sb_b+2-xp_bbolt,sb_l-xp_bhl,xp_h-xp_bh/2])rotate([0,-90,0]) boltHole(size=xp_bbolt, length=sb_b+2);
            // holes for rails
            for ( x = [ zr_offset :zr_spacing : zr_h ] ) {
                translate([4,sb_l-zr_l/2-zr_yoffset,x+10]) rotate([90,0,90]) boltHole(size=6, length=40);
            }
            // holes to connect the two beams together
            translate([-1-sb_b,sb_l/2,sb_h-15]) rotate([0,90,0]) boltHole(size=4, length=26);
            translate([-1-sb_b,sb_l/2,sb_h-100]) rotate([0,90,0]) boltHole(size=4, length=26);
            translate([-1-sb_b,sb_l/2,sb_h-180]) rotate([0,90,0]) boltHole(size=4, length=26);
            // holes on top to fit topplate
            translate([sb_b/2,sb_l/2,sb_h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            translate([-sb_b/2,sb_l/2,sb_h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
        }
    }
    // show bolts in holes to x_axis-plate
    // color([0,0.9,0.7]) translate([7,th/2,mbw/2]) rotate([0,-90,0]) cap_bolt(M6,15);
    // color([0,0.9,0.7]) translate([7,th/2,mbh-mbw/2]) rotate([0,-90,0]) cap_bolt(M6,15);
    // show bolts to connect the two beams together
    // color([0,0.9,0.7]) translate([-7,th/2,h-20]) rotate([0,90,0]) cap_bolt(M6,20);
    // color([0,0.9,0.7]) translate([-7,th/2,h-80]) rotate([0,90,0]) cap_bolt(M6,20);
}

module topplate() {
    // this part can be made out of 80x105x10mm aluminium 
    color([1,0,0.2])
    difference() {
        translate([-sp_offx,0,0]) cube([tp_b, tp_l, tp_h]);
        // holes to fit on top of zsupport
        translate([sb_b/2,sb_l/2,tp_h+1]) rotate([0,180,0]) boltHole(size=6, length=tp_h+2);
        translate([-sb_b/2,sb_l/2,tp_h+1]) rotate([0,180,0]) boltHole(size=6, length=tp_h+2);
        translate([sb_b/2,tp_l-sb_l/2,tp_h+1]) rotate([0,180,0]) boltHole(size=6, length=tp_h+2);
        translate([-sb_b/2,tp_l-sb_l/2,tp_h+1]) rotate([0,180,0]) boltHole(size=6, length=tp_h+2);
        // uitsnede voor spindel
        translate([19,tp_l/2,-1]) cylinder(r=18,h=12);
        // holes to connect to spindle
        translate([10-sp_offx,xp_l/2-sp_l/2+10,-1]) {
            translate([0,0,0]) boltHole(size=8, length=tp_h+2);
            translate([60,0,0]) boltHole(size=8, length=tp_h+2);
            translate([0,52,0]) boltHole(size=8, length=tp_h+2);
            translate([60,52,0]) boltHole(size=8, length=tp_h+2);
        }       
    }
    $color([0,0.9,0.7]) translate([w/2,th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
    $color([0,0.9,0.7]) translate([-w/2,th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
    $color([0,0.9,0.7]) translate([w/2,wp-th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
    $color([0,0.9,0.7]) translate([-w/2,wp-th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
}

module zrails() {
    // type damencnc HG20R
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
    $zrailsbolts();
}

module zcartholes() {
    translate([26,6,19.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
    translate([26,38,19.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
    translate([26,6,55.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
    translate([26,38,55.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
}

module zcartbolts() {
    color([0,0.9,0.7]) {
        translate([26,6,19.8]) rotate([0,-90,0]) cap_bolt(M6,15);
        translate([26,38,19.8]) rotate([0,-90,0]) cap_bolt(M6,15);
        translate([26,6,55.8]) rotate([0,-90,0]) cap_bolt(M6,15);
        translate([26,38,55.8]) rotate([0,-90,0]) cap_bolt(M6,15);
    }

}

module zcart() {
    // type damencnc HGH-20CA
    difference() {
        cube([zc_b,zc_l,zc_h]);
        zcartholes();
    }
}

module z_spindle(z_slag=0) {
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
    color([0,0.9,0.7]) translate([10,10,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
    color([0,0.9,0.7]) translate([70,10,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
    color([0,0.9,0.7]) translate([70,62,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
    color([0,0.9,0.7]) translate([10,62,-10.1]) rotate([0,0,0]) csk_bolt(M8,20);
}

module spacerbus() {
    rotate([90,0,0])
    difference() {
        cylinder(r=5, h=spb_l);
        translate([0,0,-1]) cylinder(r=2.5, h=spb_l+2);
    }
}

module hfmotorholes() {
    translate([-10.1,102/2-36/2,8.5]) rotate([0,90,0]) boltHole(size=8, length=22);
    translate([-10.1,102/2+36/2,8.5]) rotate([0,90,0]) boltHole(size=8, length=22);
    translate([-10.1,102/2-36/2,8.5+120]) rotate([0,90,0]) boltHole(size=8, length=22);
    translate([-10.1,102/2+36/2,8.5+120]) rotate([0,90,0]) boltHole(size=8, length=22);
}

module hfmotorbolts() {
    color([0,0.9,0.7]) {
    translate([-10.1,102/2-36/2,8.5]) rotate([0,90,0]) cap_bolt(M8,20);
    translate([-10.1,102/2+36/2,8.5]) rotate([0,90,0]) cap_bolt(M8,20);
    translate([-10.1,102/2-36/2,8.5+120]) rotate([0,90,0]) cap_bolt(M8,20);
    translate([-10.1,102/2+36/2,8.5+120]) rotate([0,90,0]) cap_bolt(M8,20);
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
    difference() {
        cube([tp_h ,xp_l+2*zc_offset, zc_pos2+zc_h-zc_pos1]);
        translate([-19,0,0]) zcartholes();
        translate([-19,0,zcoff2-zcoff1]) zcartholes();
        translate([-19,zmpw-cw,0]) zcartholes();
        translate([-19,zmpw-cw,zcoff2-zcoff1]) zcartholes();
        translate([0,16,0.5]) hfmotorholes();
        spindleholes(zmph,zmpw);
    }
    translate([-24,0,0]) zcartbolts();
    translate([-24,0,zcoff2-zcoff1]) zcartbolts();
    translate([-24,zmpw-cw,0]) zcartbolts();
    translate([-24,zmpw-cw,zcoff2-zcoff1]) zcartbolts();
    spindlebolts(zmph,zmpw);
}

module spindleconn() {
    difference() {
        cube([sc_b, sc_l, sc_h]);
        $translate([sch/2+hole_offset,scw/2,-1]) cylinder(r=6,h=sct+2);
        $translate([40.1,10,5]) rotate([0,-90,0]) boltHole(size=5, length=22);
        $translate([40.1,30,5]) rotate([0,-90,0]) boltHole(size=5, length=22);
    }
}

module hfmotor() {
    // http://damencnc.com/en/tools/teknomotor/hf-motor/247
    // model: C51/60-A-SB-P-ER25-3.3KW-18000RPM
    union() {
    difference() {
        cube([119.5, 102, 220]);
        hfmotorholes();
    }        
    translate([119.5,6,100]) cube([30.7,90,80]);
    translate([119.5/2,51,-9]) cylinder(r=50, h=9);
    translate([119.5/2,51,-28.5]) cylinder(r=85/2, h=28);
    translate([119.5/2,51,-56.5]) cylinder(r=15, h=29);
    }
    hfmotorbolts();
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
    cube([st_b,st_l,st_h]);
}

module z_axis() {
    // montageplaat alleen tijdens testen aanzetten!
    translate([xp_bb-xp_b,0,0]) rotate([0,-90,-90]) x_montageplt();
    //
    translate([0,0,0]) zsupport_l();
    translate([0,xp_h-sb_l,0]) zsupport_r();
    translate([sb_b,zr_yoffset,10]) zrails();
    translate([sb_b,xp_l-zr_l-zr_yoffset,10]) zrails();
    translate([sb_b+zc_offset,zr_l/2-zc_l/2+zr_yoffset,zc_pos1]) zcart(cl,cw,ch);
    translate([sb_b+zc_offset,zr_l/2-zc_l/2+zr_yoffset,zc_pos2]) zcart(cl,cw,ch);
    translate([sb_b+zc_offset,xp_l-zc_l+zr_yoffset,zc_pos1]) zcart(cl,cw,ch);
    translate([sb_b+zc_offset,xp_l-zc_l+zr_yoffset,zc_pos2]) zcart(cl,cw,ch);
    
    translate([0,0,sb_h]) topplate();    
    translate([-sp_offx,xp_l/2-sp_l/2,sb_h+tp_h]) {
        z_spindle();
        color([1,0,0]) {
            translate([8,0,14]) spacerbus();
            translate([40,0,14]) spacerbus();
            translate([8,0,46]) spacerbus();
            translate([40,0,46]) spacerbus();
        }
        color([0,0.9,0.7]) {
            translate([8,-52.1,14]) rotate([-90,0,0]) csk_bolt(M5,60);
            translate([40,-52.1,14]) rotate([-90,0,0]) csk_bolt(M5,60);
            translate([8,-52.1,46]) rotate([-90,0,0]) csk_bolt(M5,60);
            translate([40,-52.1,46]) rotate([-90,0,0]) csk_bolt(M5,60);
        }
        translate([24,-spb_l+36 ,30.5]) rotate([90,0,0]) koppeling();
        translate([24,-spb_l,30.5]) rotate([90,0,0]) nema_gasket();
        translate([24,-spb_l-1,30.5]) rotate([90,0,0]) motor(Nema23, NemaMedium, dualAxis=false);
            color([0,0.9,0.7]) {
                translate([0,-56.1,7]) rotate([-90,0,0]) cap_bolt(M5,12);
                translate([48,-56.1,7]) rotate([-90,0,0]) cap_bolt(M5,12);
                translate([0,-56.1,7+48]) rotate([-90,0,0]) cap_bolt(M5,12);
                translate([48,-56.1,7+48]) rotate([-90,0,0]) cap_bolt(M5,12);
                translate([0,-48,7]) rotate([-90,0,0]) flat_nut(M5,12);
                translate([48,-48,7]) rotate([-90,0,0]) flat_nut(M5,12);
                translate([0,-48,7+48]) rotate([-90,0,0]) flat_nut(M5,12);
                translate([48,-48,7+48]) rotate([-90,0,0]) flat_nut(M5,12);
            }
    }
    translate([
        sb_b+zc_offset+zc_b-sc_b,
        -zc_offset-sc_l/2+(xp_l+2*zc_offset)/2,
        zc_pos2+zc_h-sc_h]) 
            spindleconn();
    translate([sb_b+zc_offset+zc_b,-zc_offset,zc_pos1]) z_montageplaat();
    translate([
        sb_b+zc_offset+zc_b+tp_h,
        zc_offset+xp_l/2-51,
        zc_pos1-50]) 
        hfmotor();
    translate([sb_b,0,0])
        stopblock();
    translate([sb_b+st_b+5,148,sb_h+10]) rotate([0,180,-90]) endstop();
}
    
z_axis();
// TODO: boutjes en gaten opnieuw goed zetten
