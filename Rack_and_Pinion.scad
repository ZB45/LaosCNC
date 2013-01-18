module tooth(h,b,th) {
polygon([
    [b,h*(1-th)],[b/2,h],[0,h*(1-th)]
    ]);
}

module rack() {
b=1/3; h=1; th=1/4; l=3000; offs=1/20;
translate([0,0.5,0]) rotate([90,0,0])
union() {
square([l*b,h*(1-th)]);
for(x=[0:l-1]) {
    translate([x*b,-h*offs,0]) tooth(h,b,th);
}
}
}

rack();
