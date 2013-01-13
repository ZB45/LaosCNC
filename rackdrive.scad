// Rackdrive
//
// Rack and pinion drive, based on components from damencnc.nl
//
// Peter Brier
//

include <MCAD/stepper.scad>
include <MCAD/gears.scad>
include <MCAD/bearing.scad>

// Motor with gear, axis/flange center at 0,0,0
module gearmotor()
{
  rotate([180,0,0]) motor(Nema34, NemaMedium, dualAxis=true);
  translate([0,0,5]) pulley();
}


// spur gear for rack
module spur()
{
  s_n = 10; // nr of teeth
  s_Dy = 28;  // outer diameter
  s_Do = 24; // contact diameter
  s_Dn = 18; // mount outer radius
  s_d = 10; // mount innner radius
  s_b = 20; // width
  s_a = 35; // total width, including mounting

  difference()
  {
    union()
    {
      cylinder(h=s_a, r=s_Dn/2);
      translate([0,0,s_a-s_b])
        linear_extrude(height = s_b, convexity = 10) 
         gear(number_of_teeth=s_n, circular_pitch=s_Do*180/s_n);
    }
    translate([0,0,-1]) cylinder(h=s_a+2, r=s_d/2);
   }
}

// pulley gear for belt
module pulley(n=12, d=18.9,ND=10,L=20,id=5)
{

    g_n = n; // nr of teeth
    g_Do = d; // contact diameter
    g_b = 14.3; // width
    g_L = L; // total width
    g_d = id; // inner diameter
    g_ND =ND; // outer diameter of mounting

 translate([0,0,g_L,]) rotate([0,180,0]) 
 difference()
  {
    union()
    {
      cylinder(h=g_L, r=g_ND/2);
      translate([0,0,0])
       linear_extrude(height = g_b, convexity = 10) 
       gear(number_of_teeth=g_n, circular_pitch=g_Do*180/g_n);
    }
   translate([0,0,-1]) cylinder(h=g_L+2, r=g_d/2);
  }

}

// Rack
module rack()
{
  translate([-250,-20/2,0]) cube([500,20,20]);
}


///
/// Main assembly
///

//translate([0,0,0]) rack();
translate([-50,0,0]) gearmotor();

dist = 50;

translate([dist,0,0])

// baseplate
translate([0,0,-15/2]) cube([200,70,15], center=true);

// pulley/spur/bearing
translate([0,0,20])
{
  cylinder(r=5,h=60);
  translate([0,0,20]) spur(); 
  translate([0,0,10]) pulley(n=36, d=58.21,id=10,L=25,ND=45);
  translate([0,0,-14]) bearing(model=6203);
}