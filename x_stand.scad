fudge = 0.1;

module x_stand(mw = 20, up=50, sw=70) {
    union() {
        translate([50,0,80+mw]) cube([120,mw,120]);
        cube([220,sw,mw]);
        translate([0,0,-80+mw]) cube([220,mw,80]);
        translate([0,0,mw])
            polyhedron(
                points = [[0,0,0], [220,0,0], [220,mw,0], [0,mw,0],
                    [50,0,80], [170,0,80], [170,mw,80],[50,mw,80]],
                triangles=[ [0,1,2],[0,2,3],[4,5,6],[4,6,7],
                    [1,2,5],[5,2,6],[0,4,7],[0,7,3],
                    [2,6,7],[2,3,7],[0,1,5],[5,4,0] ]
            );
        translate([up,mw,mw]) cube([mw,sw-mw,200]);
//translate([100,mw,0]) polyhedron(
//    points = [[0,0,0], [mw,0,0], [mw,100,0], [0,100,0],
//            [0,0,80], [mw,0,80] ],
//    triangles = [ [0,1,2],[0,2,3],[1,4,5],[0,1,4],
//            [2,5,4],[2,4,3],[1,2,5],[0,3,4] ]
//);
        } //union()
} // module x_stand

//x_stand(sw=50);
