include <config.scad>
use <joint.scad>
use <endstop.scad>

module carriage()
{
	difference()
	{		
		union()
		{
			//Base
			translate([-10,-lg_d/2,-joint_hh/2])
				cube([5,lg_d,LMXXUU_l]);
			translate([-(lg_holder_d-joint_w/2),-(arm_d+joint_b+joint_l+4*play)/2,-joint_hh/2])
				cube([lg_holder_d-joint_w/2-5,arm_d+joint_b+joint_l+4*play ,joint_hh]);

			//LMXXUU
			for(d=[-lg_d/2,lg_d/2])
			translate([0,d,-joint_hh/2])
			{
				cylinder(h=LMXXUU_l,r=LMXXUU_d/2+3);
				translate([0,-(ld_rod_d+2*play+8)/2,0])
					cube([LMXXUU_d/2+8,ld_rod_d+2*play+8,LMXXUU_l]);
			}
			
			//Joints
			for(d=[-arm_d/2,arm_d/2])	
			translate([-lg_holder_d,d,0])
			{
				joint_holder(false,joint_b,joint_l,joint_w,joint_hh);
			}
			
			//Band holder
			translate([-LMXXUU_d/2,band_outer_d/2,-joint_hh/2])
				cube([LMXXUU_d,5,LMXXUU_l]);

			//endstop
			translate([0,0,-joint_hh/2])
				endstop_carriage();

		}

		//LMXXUU
		for(d=[-lg_d/2,lg_d/2])
		translate([0,d,-joint_hh/2])
		{
			translate([0,0,-1])
				cylinder(h=LMXXUU_l+2,r=LMXXUU_d/2+2*play);

			translate([0,-(ld_rod_d+2*play)/2,-1])
				cube([LMXXUU_d/2+15,ld_rod_d+2*play,LMXXUU_l+2]);

			for(dd=[-LMXXUU_l/2+6,LMXXUU_l/2-6])
			translate([LMXXUU_d/2+3,0,LMXXUU_l/2+dd])
			rotate([90,0,0])
				cylinder(h=LMXXUU_d+2,r=4/2+play,center=true);
		}

		//Joints
		for(d=[-arm_d/2,arm_d/2])	
		translate([-lg_holder_d,d,0])
		{
			joint_holder(true,joint_b,joint_l,joint_w,joint_hh);
		}

		//Band holder
		for(d=[5,LMXXUU_l-5])
		translate([0,-0.1,d-joint_hh/2])
		{
			translate([LMXXUU_d/2-4,0,0])
			rotate([90,0,0])
			translate([0,0,-band_outer_d/2-5-1])
			{
				cylinder(h=7,r=(3+play)/2);
				cylinder(h=1+2,r=M3_nut_d/2,$fn=6);
			}

			translate([-(LMXXUU_d+3)/2,-(3+2*play)+band_outer_d/2,-(6+2*play)/2])
			for(a=[0,-10])
			rotate([0,0,a])
			translate([])
				cube([LMXXUU_d+3,3+2*play,6+2*play]);			
		}

	}

}

module carriage_band_holder()
{
	translate([0,-LMXXUU_d/2,-joint_hh/2])
	difference()
	{
		cube([6,LMXXUU_d,3]);
		translate([6/2,4,-1])
			cylinder(h=5,r=(3+3*play)/2);

		translate([-1,-band_w/2-play+LMXXUU_d/2,3-band_b/2])
		difference()
		{
			cube([8,band_w+2*play,band_b/2+1]);
			translate([8/2-1/2,-1,-1])
				cube([2.5/2,band_w+2,band_b/2+3]);
		}
	}
}

//Band
for(d=[band_outer_d/2-band_b/2,-band_outer_d/2+band_b/2])
translate([-band_w/2,d-band_b/2,-joint_hh/2-10])
	%cube([band_w,band_b,LMXXUU_l+20]);

carriage();

translate([12,0,0]) 	
	carriage_band_holder();
translate([19,0,0]) 
	carriage_band_holder();





