include <config.scad>

module clip(h,d,w=3,c=1,n=2)
{
	difference()
	{
		//Base
		translate([-2*w-3-d/2,-(d+2*w)/2,0])
			cube([d+3*w+3,d+2*w,h]);

		//Hole
		translate([0,0,-1])
			cylinder(h=h+2,r=d/2);

		//cutout
		translate([-(d/2+3+2*w+1),-c/2,-1])
			cube([d/2+3+2*w+1,c,h+2]);

		//screws
		for(i=[1:n])
			translate([-d/2-w-(3+play)/2,0,-w/2 + (h+w)/(n+1)*i])
			rotate([90,0,0])
			{
				cylinder(h=2*w+d+2,r=(3+play)/2,center=true);
				translate([0,0,d/2+w-M3_nut_h])
					cylinder(h=M3_nut_h+1,r=M3_nut_d/2,$fn=6);
			}
	}


}

module nema17(screw_l=5,screws=[true,true,true,true]) {
  color([0.4, 0.4, 0.4]) 
  {
  translate([0, -nema17_l/2, 0])
  intersection() {
      cube([nema17_od, nema17_l, nema17_od], center=true);
      rotate([0, 45, 0]) cube([nema17_od*sqrt(2)-5, nema17_l, nema17_od*sqrt(2)-5], center=true);
  }
  translate([0, 2, 0]) rotate([90, 0, 0])
      cylinder(r=nema17_id/2, h=2+1);
  }
  color(steel)
  translate([0, -nema17_l/2+10, 0]) rotate([90, 0, 0])
    cylinder(r=2.5, h=nema17_l+21, center=true);
  translate([0,screw_l+4,0])
  for (a = [0, 90, 180, 270]) 
  	if(screws[a/90])
	rotate([0, a, 0]) {
    color([0.2, 0.2, 0.2]) translate([nema17_screw_d/2, 0, nema17_screw_d/2])
      rotate([90, 0, 0]) {
      translate([0, 0, 0]) cylinder(r=2.5, h=4);
      translate([0, 0, 0]) cylinder(r=1.5, h=screw_l+10);
    }
    color(steel) translate([nema17_screw_d/2, -3.5, nema17_screw_d/2])
      rotate([90, 0, 0]) cylinder(r=5, h=0.5);
  }
}


module narrow_pulley(bore_diameter, outside_diameter, width,
           flange_diameter, flange_width,
           hub_diameter, hub_width) {
  color(aluminum)
  difference() {
    union() {
      cylinder(r=outside_diameter/2, h=width+2*flange_width,
           center=true);
      // Flanges
      translate([0, 0, (width+flange_width)/2])
        cylinder(r=flange_diameter/2, h=flange_width, center=true);
      translate([0, 0, -(width+flange_width)/2])
        cylinder(r=flange_diameter/2, h=flange_width, center=true);
      translate([0, 0, 0.75*flange_width-hub_width/2])
        cylinder(r=hub_diameter/2,
             h=hub_width-width-1.5*flange_width,
             center=true);
    }
    // Bore
    cylinder(r=bore_diameter/2, h=2*hub_width, center=true);
  }
}

module mircoswitch(a=1)
{
	l=20;
	w=6;
	h=10;
	holes_h=2.9;
	holes_d=9.5;
	holes_c=5.3+holes_d/2;
	holes_r=2.5/2;

	f1=-holes_c+1.7;
	f2=f1+8.8;
	f3=f2+7.7;
	fd=0.6;
	fw=3.2;
	fh=6.4;

	trigger_h=1;
	trigger_l=2;
	trigger_w=4;
	trigger_ofc=7.5-holes_d/2;

	difference()
	{
		union()
		{
			//Base
			color("black",a)
			translate([-holes_c,-w/2,-holes_h])
				cube([l,w,h]);

			//feets
			color(steel,a)
			for(d=[f1,f2,f3])
			translate([-fd/2+d,-fw/2,-fh])
				cube([fd,fw,fh]);

			//trigger
			color("white",a)
			translate([-trigger_l/2-trigger_ofc,-trigger_w/2,h-holes_h])
				cube([trigger_l,trigger_w,trigger_h]);
		}
		//drills
		for(d=[-holes_d/2,holes_d/2])
		translate([d,0,0])
		rotate([90,0,0])
			cylinder(h=w+2,r=holes_r,center=true);
	}

}
