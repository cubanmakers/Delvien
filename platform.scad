include <config.scad>
use <joint.scad>

module platform()
{
	hl=joint_b+joint_l+4*play;
	difference()
	{
		union()
		{
			//Base
			cylinder(h=joint_hh,r=platform_outer_r,center=true);
			
			//joint holder add
			for(a=[0:arm_n])
			rotate([0,0,360/arm_n*a])
			{
				translate([45,0,0])
					cylinder(r=5,h=joint_hh,center=true);
				for(d=[-arm_d/2,arm_d/2])	
				translate([-platform_c,d,0])
				{
					translate([joint_w/2,-(hl)/2,-joint_hh/2])
						cube([platform_outer_r-platform_inner_r,hl,joint_hh]);
					joint_holder(false,joint_b,joint_l,joint_w,joint_hh);
				}
			}
		}
		//Cutout
		cylinder(h=joint_hh+2,r=platform_inner_r,center=true);

		//joint holder cutout
		for(a=[0:arm_n])
		rotate([0,0,360/arm_n*a])
		{
			translate([45,0,0])
				cylinder(r=(4+2*play)/2,h=joint_hh+2,center=true);
			translate([-(platform_inner_r+platform_outer_r)/2,0,0])
				cylinder(r=(4+2*play)/2,h=joint_hh+2,center=true);
			translate([-platform_c,0,0])
			{
				for(d=[-arm_d/2,arm_d/2])	
				translate([0,d,0])
					joint_holder(true,joint_b,joint_l,joint_w,joint_hh);
			}
		}
	}		
	

}

translate([0,0,joint_hh/2])
platform();
