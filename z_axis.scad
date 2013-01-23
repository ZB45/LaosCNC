fudge=0.1;
include <x_montageplt.scad>
include <MCAD/nuts_and_bolts.scad>

module zsteun(h=300, w=40, th=15, mbolt=6, mbw=14.85, mbh=154.0, mbc=8.5) {
    color ([1,0,0]) 
    union() {
        difference() {
            cube([w,th,h]);
            // gaatjes voor bevestiging op montageplaat
            translate([w-4.9,th/2,mbw/2]) rotate([0,-90,0]) boltHole(size=mbolt, length=w+1);
            translate([w-4.9,th/2,mbh-mbw/2])rotate([0,-90,0]) boltHole(size=6, length=w+1);
            // uitsnedes voor montageplaat
            translate([-1,-1,-1]) cube([mbc+1, th+2, mbw+1]);
            translate([-1,-1,mbh-mbw]) cube([mbc+1, th+2, mbw]);
            // gaatjes op de top voor zsteunconn
            translate([w/4,th/2,h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            translate([3*w/4,th/2,h+1]) rotate([0,180,0]) boltHole(size=6, length=10);
            // translate([10,-0.1,h-10])rotate([-90,0,0]) boltHole(size=6, length=20.2);
            // translate([xspace-10,-0.1,h-10])rotate([-90,0,0]) boltHole(size=6, length=20.2);
        }
    }
}

module zsteunconn(h=300, w=40, wp=90, wth=5, th=15, rh=17.5) {
    color([1,0,0.2])
    difference() {
        cube([w+rh, wp, wth]);
        translate([w/4,th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=10);
        translate([3*w/4,th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=10);
        translate([3*w/4,wp-th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=10);
        translate([w/4,wp-th/2,wth+1]) rotate([0,180,0]) boltHole(size=6, length=10);
        // uitsnede voor spindel
        translate([-8,wp/2-20,-1]) cube([40,40,7]);
    }
}

module zrailsholes(h=300, r_offset=20, r_spacing=60, rh=17.5) {
    // gaatjes in de beam
    for ( x = [ r_offset :r_spacing : h ] ) {
        union() {
            translate([10,rh-5+0.1,x]) rotate([90,0,0]) boltHole(size=6, length=rh);
        }
    }

}

module zrails(h=300, rh=17.5, rw=20, r_offset=20, r_spacing=60) {
    // type damencnc HG20R
    difference() {
        cube([rw,rh,h]);
        translate([0,rh-1.5,-0.1]) cylinder(r=3, h=h+0.2);
        translate([rw,rh-1.5,-0.1]) cylinder(r=3, h=h+0.2);
        translate([0,rh/2,-0.1]) cylinder(r=3, h=h+0.2);
        translate([rw,rh/2,-0.1]) cylinder(r=3, h=h+0.2);
        zrailsholes(h, r_offset, r_spacing);
    }
}

module zcart(cl=75.6, cw=44, ch=25.4) {
    // ch = 30-4.6
    // type damencnc HGH-20CA
    cube([cw,cl,ch]);
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
        translate([49.5,36,-172.15]) cylinder(r=4,h=10);
    }
    translate([25,96,30]) rotate([90,0,0]) cylinder(r=5, h=120);
    }
}

module z_montageplaat(zmpt=5, zmph=100, zmpw=100) {
    cube([zmpt ,zmpw, zmph]);
}

module spacerbus(th=15) {
    difference() {
        cylinder(r=5, h=th);
        translate([0,0,-1]) cylinder(r=2.5, h=th+2);
    }
}

module hfmotor() {
    // http://damencnc.com/en/tools/teknomotor/hf-motor/247
    // model: C51/60-A-SB-P-ER25-3.3KW-18000RPM
    union() {
    difference() {
        cube([119.5, 102, 220]);
        translate([-0.1,102/2-36/2,8.5]) rotate([0,90,0]) boltHole(size=8, length=12);
        translate([-0.1,102/2+36/2,8.5]) rotate([0,90,0]) boltHole(size=8, length=12);
        translate([-0.1,102/2-36/2,8.5+120]) rotate([0,90,0]) boltHole(size=8, length=12);
        translate([-0.1,102/2+36/2,8.5+120]) rotate([0,90,0]) boltHole(size=8, length=12);
    }        
    translate([119.5,6,100]) cube([30.7,90,80]);
    translate([119.5/2,51,-9]) cylinder(r=50, h=9);
    translate([119.5/2,51,-28.5]) cylinder(r=85/2, h=28);
    translate([119.5/2,51,-56.5]) cylinder(r=15, h=29);
    }
}

module z_axis() {
    h=356; // hoogte van de steun
    w=10; // afstand van de montageplaat tot de rails
    th=15; // dikte vh aluminium van de steun
    wth=5;  // dikte van de top-plaat
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
    r_offset=20; // offset van de rails-gaten
    r_spacing=60; // spacing van de rails-gaten
    spw=72; // spindle width
    sp_offx=w-50; // x spindle offset
    sp_offz=355; // y spindle offset
    cl=75.6; cw=44; ch=25.4; // cart sizes
    coff = 4.6; // cart offset from rails bottom
    zcoff1 =10; zcoff2=zcoff1+120; // cart offsets
    zmph = cl+zcoff2-zcoff1; // heigth of z_montageplaat
    zmpw = mb_h2-mb_h1+cw; //width of z_montageplaat
    zmpt = 5; // dikte van z_montageplaat

    // montageplaat alleen tijdens testen aanzetten!
    translate([-mbd+mbc,0,0]) rotate([0,-90,-90]) x_montageplt();
    //
    translate([0,mb_h1-th/2,0]) zsteun(h, w, th, mbolt, mbw, mbh, mbc);
    translate([0,mb_h2-th/2,0]) zsteun(h, w, th, mbolt, mbw, mbh, mbc);
    //translate([0,mb_h1-th/2,h]) zsteunconn(h, w, wp, wth, th, rh);    
    translate([sp_offx,mbh/2-spw/2,sp_offz]) {
        z_spindle();
        color([1,0,0]) {
            translate([8,0,14]) rotate([90,0,0]) spacerbus(th=25);
            translate([40,0,14]) rotate([90,0,0]) spacerbus(th=25);
            translate([8,0,46]) rotate([90,0,0]) spacerbus(th=25);
            translate([40,0,46]) rotate([90,0,0]) spacerbus(th=25);
            translate([8,72,14]) rotate([-90,0,0]) spacerbus(th=25);
            translate([40,72,14]) rotate([-90,0,0]) spacerbus(th=25);
            translate([8,72,46]) rotate([-90,0,0]) spacerbus(th=25);
            translate([40,72,46]) rotate([-90,0,0]) spacerbus(th=25);
            // TODO: M5/6 gaten voor bout in steun (4 stuks)
        }
    }
    translate([w,mb_h1-rw/2,h]) rotate([0,180,-90]) zrails(h,rh,rw,r_offset,r_spacing);
    translate([w,mb_h2-rw/2,h]) rotate([0,180,-90]) zrails(h,rh,rw,r_offset,r_spacing);
    translate([w+coff,mb_h1-cw/2,zcoff1]) rotate([90,0,90]) zcart(cl,cw,ch);
    translate([w+coff,mb_h2-cw/2,zcoff1]) rotate([90,0,90]) zcart(cl,cw,ch);
    translate([w+coff,mb_h1-cw/2,zcoff2]) rotate([90,0,90]) zcart(cl,cw,ch);
    translate([w+coff,mb_h2-cw/2,zcoff2]) rotate([90,0,90]) zcart(cl,cw,ch);
    translate([w+coff+ch,mb_h1-cw/2,zcoff1]) z_montageplaat(zmpt, zmph, zmpw);
    translate([w+coff+ch+zmpt,mbh/2-102/2,zcoff1+56.5]) hfmotor();
}
    
z_axis();
