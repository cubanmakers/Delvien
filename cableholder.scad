include <config.scad>

module cableholder(bwall=3,bflax=0.32*4,h=10,l=15,a=45)
{
	for(i=[0,1])
	{
		translate([i*(bwall+1),0,0])
		intersection()
		{
			cube([100,100,h]);
			rotate([0,0,-a*i])
			difference()
			{
				cube([bwall,l,h]);
				
				translate([0,l-4,h/2])
				rotate([0,90,0])
				translate([0,0,-1])
					cylinder(r=4/2,h=bwall+2);
			}
		}
	}
	
	cube([2*bwall+1,bflax,h]);
}

cableholder();