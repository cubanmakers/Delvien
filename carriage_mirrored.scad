include <config.scad>
use <joint.scad>
use <endstop.scad>
use <carriage.scad>

//Band
for(d=[band_outer_d/2-band_b/2,-band_outer_d/2+band_b/2])
translate([-band_w/2,d-band_b/2,-joint_hh/2-10])
	%cube([band_w,band_b,LMXXUU_l+20]);

mirror([0,1,0]) 
	carriage();

translate([12,0,0]) 	
	carriage_band_holder();
translate([19,0,0]) 
	carriage_band_holder();