include <config.scad>
use <platform.scad>

module indicator()
{
	color("LightGrey")
	cylinder(r=8/2,h=88);

	color("Black")
	translate([0,0,-15])
		cylinder(r=4.5/2,h=15);
	
	color("RoyalBlue")
	translate([0,3,55/2+21.5])
	rotate([90,0,0])
	difference()
	{
		cylinder(r=55/2,h=25,center=true);
		translate([0,0,-25/2-3+2])
			cylinder(r=50/2,h=3);
	}

} 

module adapter_indicator()
{
	difference()
	{
		union()
		{
			cylinder(r=20/2,h=10);

			for(a=[0:arm_n])
			rotate([0,0,180+360/arm_n*a])
			translate([0,-4,0])
				cube([25,8,4]);
			
		}
		
		translate([0,0,2])
			platform_holes(2,6);		
		
		translate([0,0,-1])
			cylinder(r=(8+4*play)/2,h=12);

		for(a=[0:arm_n])
		rotate([0,0,360/arm_n*a])
		translate([0,0,5])
		rotate([0,90,0])
			cylinder(r=3.5/2,h=11);

	}
}

adapter_indicator();


% translate([0,0,-joint_hh/2])
{
	indicator();
	platform();
}