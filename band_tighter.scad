include <config.scad>


module band_tighter()
{
	d=8;
	w=band_w+4*play+d;
	h=band_b*2+band_bb_od+1;
	difference()
	{
		union()
		{	
			difference()
			{
				//base
				cube([w,30+4+d,h],center=true);
				
				//coutout
				for(a=[-10,0,+10])
				rotate([0,a,0])
				cube([band_w+4*play,band_b*2+band_bb_od+4*play,band_bb_id+d+10],center=true);
			}
			for(a=[-90,90])
			rotate([0,a,0])
			translate([0,0,band_bb_w/2+play])
				cylinder(h=d/2,r=(band_bb_id+2)/2);
		}

		//Holes
		rotate([0,90,0])
			cylinder(h=w+2,r=band_bb_id/2+play,center=true);

		for(dd=[-15,+15])
		translate([0,dd,0])
		{
			cylinder(h=h+2,r=4/2+2*play,center=true);
			cube([w+2,M4_nut_w,M4_nut_h],center=true);
		}
	
	}
}

for(i=[1:arm_n])
translate([(i-2)*(band_w+4*play+20),0,0])
{
	//Band
	for(d=[band_outer_d/2-band_b/2,-band_outer_d/2+band_b/2])
	translate([-band_w/2,d-band_b/2,-20])
		%cube([band_w,band_b,20]);
	
	//ballbearing
	rotate([0,90,0])
		%cylinder(h=band_bb_w,r=band_bb_od/2,center=true);
	
	band_tighter();
}
