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

module zrailsholes(l=300, offset=20, spacing=60) {
    // gaatjes in de beam
    for ( x = [ offset :spacing : l ] ) {
        union() {
            translate([10,4,x]) rotate([90,0,0]) cylinder(h=10, r=3, center=true);
        }
    }

}

module zrails(l=300) {
    // type damencnc HGR-20-T
    difference() {
        cube([20,17.5,l]);
        translate([0,16,-0.1]) cylinder(r=3, h=l+0.2);
        translate([20,16,-0.1]) cylinder(r=3, h=l+0.2);
        translate([0,8,-0.1]) cylinder(r=3, h=l+0.2);
        translate([20,8,-0.1]) cylinder(r=3, h=l+0.2);
        zrailsholes(l=l,offset=20, spacing=60);
    }
    zrailsholes();
}

module zcart() {
    // type damencnc HGH-20CA
    difference() {
        cube([44,75.6,30-4.6]);
        translate([44/2-10, 75.9, -4.6]) rotate([90,0,0]) zrails(l=76);
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
        translate([49.5,36,-172.15]) cylinder(r=4,h=10);
    }
    translate([25,96,30]) rotate([90,0,0]) cylinder(r=5, h=120);
    }
}

module z_axis() {
    h=300; // hoogte van de steun
    w=40; // afstand van de montageplaat tot de rails
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
    xspace=40; //oud!

    // montageplaat alleen tijdens testen aanzetten!
    translate([-mbd+mbc,0,0]) rotate([0,-90,-90]) x_montageplt();
    //
    translate([0,mb_h1-th/2,0]) zsteun(h, w, th, mbolt, mbw, mbh, mbc);
    translate([0,mb_h2-th/2,0]) zsteun(h, w, th, mbolt, mbw, mbh, mbc);
    translate([0,mb_h1-th/2,h]) zsteunconn(h, w, wp, wth, th, rh);    
    translate([xspace, 41.9, 0]) rotate([0,0,-90]) zrails(h);
    translate([xspace, 132, 0]) rotate([0,0,-90]) zrails(h);
    translate([xspace+4.6,10,10]) rotate([90,0,90]) zcart();
    translate([xspace+4.6,100,10]) rotate([90,0,90]) zcart();
    translate([xspace+4.6,10,110]) rotate([90,0,90]) zcart();
    translate([xspace+4.6,100,110]) rotate([90,0,90]) zcart();
    translate([-38,41.9,175]) z_spindle();
}
    
z_axis();
