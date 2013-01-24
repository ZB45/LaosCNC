// note: this design needs MCAD library!
// http://reprap.org/wiki/MCAD

fudge=0.1;
include <x_montageplt.scad>
include <MCAD/nuts_and_bolts.scad>
include <NEMA17-to-27-adapter.scad>
include <MCAD/stepper.scad>
include <MCAD/metric_fastners.scad>

module zrailsholes(h=300, r_offset=40, r_spacing=60, rh=17.5) {
    // gaatjes in de beam
    for ( x = [ r_offset :r_spacing : h ] ) {
        union() {
            translate([10,rh-5+0.1,x]) rotate([90,0,0]) boltHole(size=6, length=rh);
        }
    }

}

module zsupport(h=356, w=15, th=15, mbolt=6, mbw=14.85, mbh=154.0, mbc=8.5) {
    // this part can be made out of 15x15mm staf aluminium
    color ([1,0,0]) 
    union() {
        difference() {
            union() {
                cube([w,th,h]);
                translate([-w,0,h/2]) cube([w+1,th,h/2]);
            }
            // holes for connection to x_axis-plate
            translate([w-4.9,th/2,mbw/2]) rotate([0,-90,0]) boltHole(size=mbolt, length=w+1);
            translate([w-4.9,th/2,mbh-mbw/2])rotate([0,-90,0]) boltHole(size=6, length=w+1);
            // cut-outs to fit around x_axis-plate
            translate([-1,-1,-1]) cube([mbc+1, th+2, mbw+1]);
            translate([-1,-1,mbh-mbw]) cube([mbc+1, th+2, mbw]);
            // holes on top to fit zsupportconn
            translate([w/2,th/2,h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            translate([-w/2,th/2,h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            translate([w/2,th/2,h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            translate([-w/2,th/2,h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            // holes for rails
            translate([11,17.5,0]) rotate([0,0,-90]) zrailsholes(h=356, rh=10);
            // holes to connect the two beams together
            translate([-w+3,th/2,h-40]) rotate([0,90,0]) boltHole(size=4, length=26);
            translate([-w+3,th/2,h-160]) rotate([0,90,0]) boltHole(size=4, length=26);
            
        }
    }
    // show bolts in holes to x_axis-plate
    color([0,0.9,0.7]) translate([7,th/2,mbw/2]) rotate([0,-90,0]) cap_bolt(M6,15);
    color([0,0.9,0.7]) translate([7,th/2,mbh-mbw/2]) rotate([0,-90,0]) cap_bolt(M6,15);
    // show bolts to connect the two beams together
    color([0,0.9,0.7]) translate([-7,th/2,h-40]) rotate([0,90,0]) cap_bolt(M6,20);
    color([0,0.9,0.7]) translate([-7,th/2,h-160]) rotate([0,90,0]) cap_bolt(M6,20);
}

module zsupportconn(h=356, w=15, wp=90, wth=10, th=15, rh=17.5) {
    // this part can be made out of 80x105x10mm aluminium 
    bof=-20;
    color([1,0,0.2])
    difference() {
        translate([-w-th,0,0]) cube([80, wp, wth]);
        // holes to fit on top of zsupport
        translate([w/2,th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=12);
        translate([-w/2,th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=12);
        translate([w/2,wp-th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=12);
        translate([-w/2,wp-th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=12);
        // uitsnede voor spindel
        // translate([-8,wp/2-20,-1]) cube([40,40,12]);
        translate([19,wp/2,-1]) cylinder(r=18,h=12);
        // holes to connect to spindle
        translate([bof,wp/2-26,-1]) boltHole(size=8, length=wth+2);
        translate([bof+60,wp/2-26,-1]) boltHole(size=8, length=wth+2);
        translate([bof+60,wp/2+26,-1]) boltHole(size=8, length=wth+2);
        translate([bof,wp/2+26,-1]) boltHole(size=8, length=wth+2);
    }
    color([0,0.9,0.7]) translate([w/2,th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
    color([0,0.9,0.7]) translate([-w/2,th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
    color([0,0.9,0.7]) translate([w/2,wp-th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
    color([0,0.9,0.7]) translate([-w/2,wp-th/2,9]) rotate([0,180,0]) cap_bolt(M6,25);
}

module zrails(h=300, rh=17.5, rw=20, r_offset=40, r_spacing=60) {
    // type damencnc HG20R
    difference() {
        cube([rw,rh,h]);
        translate([0,rh-1.5,-0.1]) cylinder(r=3, h=h+0.2);
        translate([rw,rh-1.5,-0.1]) cylinder(r=3, h=h+0.2);
        translate([0,rh/2,-0.1]) cylinder(r=3, h=h+0.2);
        translate([rw,rh/2,-0.1]) cylinder(r=3, h=h+0.2);
        zrailsholes(h, r_offset, r_spacing, rh);
    }
}
module zcartholes() {
    translate([26,6,19.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
    translate([26,38,19.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
    translate([26,6,55.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
    translate([26,38,55.8]) rotate([0,-90,0]) boltHole(size=6, length=12);
}

module zcart(cl=75.6, cw=44, ch=25.4) {
    // ch = 30-4.6
    // type damencnc HGH-20CA
    difference() {
        rotate([90,0,90]) cube([cw,cl,ch]);
        zcartholes();
    }
}

module z_spindle() {
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
    union() {
        translate([49.5,36,-162.15]) cylinder(r=9,h=150);
        translate([49.5,36,-180.15]) cylinder(r=6,h=18);
    }
    translate([25,96,30]) rotate([90,0,0]) cylinder(r=5, h=120); // aandrijfas
    }
    color([0,0.9,0.7]) translate([10,10,-10.1]) rotate([0,0,0]) cap_bolt(M8,20);
    color([0,0.9,0.7]) translate([70,10,-10.1]) rotate([0,0,0]) cap_bolt(M8,20);
    color([0,0.9,0.7]) translate([70,62,-10.1]) rotate([0,0,0]) cap_bolt(M8,20);
    color([0,0.9,0.7]) translate([10,62,-10.1]) rotate([0,0,0]) cap_bolt(M8,20);
}

module spacerbus(th=15) {
    difference() {
        cylinder(r=5, h=th);
        translate([0,0,-1]) cylinder(r=2.5, h=th+2);
    }
}

module hfmotorbolts() {
    translate([-10.9,102/2-36/2,8.5]) rotate([0,90,0]) boltHole(size=8, length=22);
    translate([-10.1,102/2+36/2,8.5]) rotate([0,90,0]) boltHole(size=8, length=22);
    translate([-10.1,102/2-36/2,8.5+120]) rotate([0,90,0]) boltHole(size=8, length=22);
    translate([-10.1,102/2+36/2,8.5+120]) rotate([0,90,0]) boltHole(size=8, length=22);
}

module spindlebolts(zmph,zmpw) {
    translate([6.5,zmpw/2-10,zmph-5]) rotate([0,-90,0]) boltHole(size=5, length=22);
    translate([6.5,zmpw/2+10,zmph-5]) rotate([0,-90,0]) boltHole(size=5, length=22);
}

module z_montageplaat(zmpt=10, zmph=195.5, zmpw=134, zcoff1, zcoff2, cw) {
    difference() {
        cube([zmpt ,zmpw, zmph]);
        translate([-19,0,0]) zcartholes();
        translate([-19,0,zcoff2-zcoff1]) zcartholes();
        translate([-19,zmpw-cw,0]) zcartholes();
        translate([-19,zmpw-cw,zcoff2-zcoff1]) zcartholes();
        translate([0,16,0.5]) hfmotorbolts();
        spindlebolts(zmph,zmpw);
    }
}

module spindleconn(zmpt=5, zmph=100, zmpw=100) {
    sct = 10;
    scw = 40;
    sch = 40;
    hoff = -40;
    hole_offset = -5.5;
    translate ([hoff,zmpw/2-scw/2,zmph-sct])
    difference() {
        cube([sch,scw,sct]);
        translate([sch/2+hole_offset,scw/2,-1]) cylinder(r=6,h=sct+2);
        translate([40.1,10,5]) rotate([0,-90,0]) boltHole(size=5, length=22);
        translate([40.1,30,5]) rotate([0,-90,0]) boltHole(size=5, length=22);
    }
}

module hfmotor() {
    // http://damencnc.com/en/tools/teknomotor/hf-motor/247
    // model: C51/60-A-SB-P-ER25-3.3KW-18000RPM
    union() {
    difference() {
        cube([119.5, 102, 220]);
        hfmotorbolts();
    }        
    translate([119.5,6,100]) cube([30.7,90,80]);
    translate([119.5/2,51,-9]) cylinder(r=50, h=9);
    translate([119.5/2,51,-28.5]) cylinder(r=85/2, h=28);
    translate([119.5/2,51,-56.5]) cylinder(r=15, h=29);
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

module z_axis() {
    z_slag = 80; // de maximale beweging van de as
                // varieer dit om te zien hoe hij beweegt!
    h=356; // hoogte van de steun
    w=15; // afstand van de montageplaat tot de rails
    th=15; // dikte vh aluminium van de steun
    wth=10;  // dikte van de top-plaat
    mbolt=6; // dikte vd bouten in de montageplaat
    mbw=14.85; // breede van de opstaande rand aan de montageplaat
    mbc=8.5; // dikte van de opstaande rand aan de montageplaat
    mbh=154.0; // totale hoogte/breedte van de montageplaat
    mbd = 25.0; // dikte van de montageplaat
    mb_h1=32; // afstand tot 1e gat in opstaande rand
    mb_h2=122; // afstand tot 1e gat in opstaande rand
    wp = mbh-mb_h1-(mbh-mb_h2)+th; // breedte van de top-plaat
    rh=17.5; // hoogte van de rails
    rw=20.0; // breedte van de rails
    r_offset=40; // offset van de rails-gaten
    r_spacing=60; // spacing van de rails-gaten
    spw=72; // spindle width
    sp_offx=w-45; // x spindle offset
    sp_offz=355+10; // y spindle offset
    cl=75.6; cw=44; ch=25.4; // cart sizes
    coff = 4.6; // cart offset from rails bottom
    zcoff1 =10+z_slag; zcoff2=zcoff1+120; // cart offsets
    zmph = cl+zcoff2-zcoff1; // heigth of z_montageplaat
    zmpw = mb_h2-mb_h1+cw; //width of z_montageplaat
    zmpt = 10; // dikte van z_montageplaat
    hfm_offset = 0; //56.5; // ofsset hf_motor op montageplaat
    sb_th = 50; // spacing tussen stappenmotor en spindle

    // montageplaat alleen tijdens testen aanzetten!
    translate([-mbd+mbc,0,0]) rotate([0,-90,-90]) x_montageplt();
    //
    translate([0,mb_h1-th/2,0]) zsupport(h, w, th, mbolt, mbw, mbh, mbc);
   
    translate([0,mb_h2-th/2,0]) zsupport(h, w, th, mbolt, mbw, mbh, mbc);
    translate([0,mb_h1-th/2,h]) zsupportconn(h, w, wp, wth, th, rh);    
    translate([sp_offx,mbh/2-spw/2,sp_offz]) z_spindle();
    translate([sp_offx,mbh/2-spw/2,sp_offz]) color([1,0,0]) {
            translate([8,0,14]) rotate([90,0,0]) spacerbus(th=sb_th);
            translate([40,0,14]) rotate([90,0,0]) spacerbus(th=sb_th);
            translate([8,0,46]) rotate([90,0,0]) spacerbus(th=sb_th);
            translate([40,0,46]) rotate([90,0,0]) spacerbus(th=sb_th);
    }
    translate([sp_offx,mbh/2-spw/2,sp_offz]) color([0,0.9,0.7]) {
            translate([8,-52.1,14]) rotate([-90,0,0]) csk_bolt(M5,60);
            translate([40,-52.1,14]) rotate([-90,0,0]) csk_bolt(M5,60);
            translate([8,-52.1,46]) rotate([-90,0,0]) csk_bolt(M5,60);
            translate([40,-52.1,46]) rotate([-90,0,0]) csk_bolt(M5,60);
    }
    translate([sp_offx,mbh/2-spw/2,sp_offz]) {
            translate([24,-sb_th+36 ,30.5]) rotate([90,0,0]) koppeling();
            translate([24,-sb_th,30.5]) rotate([90,0,0]) nema_gasket();
            translate([24,-sb_th-1,30.5]) rotate([90,0,0]) motor(Nema23, NemaMedium, dualAxis=false);
    }
    translate([w,mb_h1+rw/2,0]) rotate([0,0,-90]) zrails(h,rh,rw,r_offset,r_spacing);
    translate([w,mb_h2+rw/2,0]) rotate([0,0,-90]) zrails(h,rh,rw,r_offset,r_spacing);
    translate([w+coff,mb_h1-cw/2,zcoff1]) zcart(cl,cw,ch);
    translate([w+coff,mb_h2-cw/2,zcoff1]) zcart(cl,cw,ch);
    translate([w+coff,mb_h1-cw/2,zcoff2]) zcart(cl,cw,ch);
    translate([w+coff,mb_h2-cw/2,zcoff2]) zcart(cl,cw,ch);
    translate([w+coff+ch,mb_h1-cw/2,zcoff1]) z_montageplaat(zmpt, zmph, zmpw, zcoff1, zcoff2, cw);
    translate([w+coff+ch,mb_h1-cw/2,zcoff1]) spindleconn(zmpt, zmph, zmpw);
    translate([w+coff+ch+zmpt,mbh/2-102/2,zcoff1+hfm_offset]) hfmotor();
}
    
z_axis();
//TODO: boutjes
