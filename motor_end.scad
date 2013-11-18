include <config.scad>
use <helper.scad>

module motor_end()
{
	h=nema17_od+10;
	w=lg_d+ld_rod_d+2*play+2*3;
	translate([0,0,h/2])
	difference()
	{
		union()
		{
			//Base
			translate([-15,-w/2,-h/2])
				cube([5,w,h]);	

			//Holder
			for(i=[0,1])
			translate([0,-lg_d/2+i*lg_d,0])
			rotate([180*i,0,0])
			translate([0,0,-h/2])
			{
				rotate([0,0,180])
					clip(h,ld_rod_d+2*play,w=3,c=2);
				translate([-15,-(ld_rod_d+2*play+2*3)/2,0])
					cube([15-ld_rod_d/2+play-1,ld_rod_d+2*play+2*3,h]);
			}

			//stabilasation
			for(d=[-lg_d/2,lg_d/2])
			assign(dd=ld_rod_d+2*play+2*3)
			{
				translate([-15-h,-dd/2+d,-h/2])		
					cube([h+1,dd,5]);
			
				assign(dd=(dd-3)/2)
				for(d=[d+dd,d-dd])
				translate([0,d,0])
				{
					intersection()
					{
						translate([-50-10,0,0])
							cube([100,3,h],center=true);
						rotate([0,-45,0])
							cube([200,3,h+2],center=true);
					}
				}
			}
		}

		//Nema17
		rotate([0,-90,0])
		translate([0,0,15-6])
		{
			cylinder(h=5+2,r=nema17_id/2);	
			for(i=[-nema17_screw_d/2,nema17_screw_d/2])
			for(j=[-nema17_screw_d/2,nema17_screw_d/2])
			translate([i,j,0])
			cylinder(h=5+2,r=(3+play)/2);	
		}

		//mounting holes
		for(dx=[-25,-55])
		for(dy=[-lg_d/2,lg_d/2])
		translate([dx,dy,-h/2-1])
			cylinder(h=7,r=4/2+play);
	}

}


//Band
for(d=[band_outer_d/2-band_b/2,-band_outer_d/2+band_b/2])
translate([-band_w/2,d-band_b/2,(nema17_od+10)/2])
	%cube([band_w,band_b,50]);

motor_end();