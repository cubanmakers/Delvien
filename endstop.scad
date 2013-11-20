include <config.scad>
use <helper.scad>
use <top_end.scad>
use <band_tighter.scad>
use <carriage.scad>



module endstop()
{
	translate([0,lg_d/2,0])
	difference()
	{
		union()
		{
			translate([0,0,-5])
				clip(10,ld_rod_d+2*play,w=2,c=1,n=1);

			translate([3,-20-ld_rod_d/2-play-2,-5])
				cube([2,20+1,10]);
		}
		
		//drills:
		assign(d=9.5)
		for(d=[-d/2,d/2])
		translate([0,-10-ld_rod_d/2-play-2+d,0])
		rotate([0,90,0])
		translate([0,0,3-1])
			cylinder(h=2+2,r=2/2+play);

	}

	translate([0,lg_d/2-10-ld_rod_d/2-play-2,0])
	rotate([0,180,-90])
		%mircoswitch();
}

module endstop_carriage()
{
	q=3*2+2;
	translate([0,-lg_d/2+ld_rod_d/2+play+2+10-9.5/2+7.5,0])
	{
		difference()
		{
			translate([-q/2-3,-q/2,0])
				cube([q+3,q,q]);
			//drill
			translate([0,0,-1])
				cylinder(h=q+2,r=2/2+play);
			//Nut
			translate([0,0,q/2])
				cylinder(h=M2_nut_h,r=M2_nut_d/2+play,center=true,$fn=6);
			translate([0,-M2_nut_w/2,q/2-M2_nut_h/2])
				cube([q/2+1,M2_nut_w,M2_nut_h]);
		}
		//screw
		color(steel,1)
		translate([0,0,-5])
			%cylinder(h=16,r=2/2);
	}
}

endstop();

%union()
{
	translate([0,lg_d/2,0])
	color(steel,0.5)
		cylinder(h=150,r=ld_rod_d/2,center=true);

	for(d=[band_outer_d/2-band_b/2,-band_outer_d/2+band_b/2])
	translate([-band_w/2,d-band_b/2,-70])
		cube([band_w,band_b,100]);
	translate([0,0,50])
		top_end();
	translate([0,0,30])
		band_tighter();
	translate([0,0,-16])
	rotate([180,0,0])
		carriage();
}

