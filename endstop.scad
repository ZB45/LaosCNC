module endstop() {
    // http://www.damencnc.com/en/components/electronic-parts/switches---sensors-etc/48
    color([0,0,0]) cube([6,20,10]);
    color("gray") translate([1,2,-4]) cube([4,1,4]);
    color("gray") translate([1,10,-4]) cube([4,1,4]);
    color("gray") translate([1,18,-4]) cube([4,1,4]);
    color("gray") translate([0,2,10]) rotate([-80,0,0]) cube([4,1,18]);
    color("gray") translate([0,19,14]) rotate([0,90,0]) cylinder(r=2, h=4);
}

// endstop();
