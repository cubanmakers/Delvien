include <config.scad>
use <helper.scad>


module top_end()
{
	h=20;
	w=lg_d+ld_rod_d+2*3;
	difference()
	{
		union()
		{
			//Base
			translate([-(ld_rod_d+2*play)/2-5,-w/2,0])
				cube([5,w,h]);	
			translate([-ld_rod_d+5-1,-(lg_d-ld_rod_d-2*play)/2,])
				cube([ld_rod_d+1,lg_d-ld_rod_d-2*play,5]);	

			//Holder
			for(i=[0,1])
			translate([0,-lg_d/2+i*lg_d,h/2])
			rotate([180*i,0,0])
			translate([0,0,-h/2])
			{
				rotate([0,0,180])
					clip(h,ld_rod_d+2*play,w=3,c=2,n=1);
			}

			//stabilasation
			for(d=[-lg_d/2,lg_d/2])
			assign(dd=ld_rod_d+2*play+2*3)
			{
				translate([-ld_rod_d-h-2,-dd/2+d,0])		
					cube([h+3,dd,5]);
			
				assign(dd=(dd-3)/2)
				for(d=[d+dd,d-dd])
				translate([0,d,h/2])
				{
					intersection()
					{
						translate([-50-5,0,0])
							cube([100,3,h],center=true);
						translate([-5,0,0])
						rotate([0,-45,0])
							cube([h*3,3,h],center=true);
					}
				}
			}
		}

		//mounting holes
		for(dx=[-25])
		for(dy=[-lg_d/2,lg_d/2])
		translate([dx,dy,-1])
			cylinder(h=7,r=4/2+play);
		for(dx=[0])
		for(dy=[-15,15])
		translate([dx,dy,-1])
			cylinder(h=7,r=4/2+play);
	}


}

top_end();