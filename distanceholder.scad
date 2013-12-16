include <config.scad>

module distanceholder(h=26)
{
	difference()
	{
		cylinder(r=(ld_rod_d+2*play+5)/2,h=h);
		
		translate([0,0,-1])
			cylinder(r=(ld_rod_d+2*play)/2,h=h+2);
	}

}

distanceholder();