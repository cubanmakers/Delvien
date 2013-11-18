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
//clip(20,10);

module nema17(screw_l=5) {
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
  for (a = [0, 90, 180, 270]) rotate([0, a, 0]) {
    color([0.2, 0.2, 0.2]) translate([nema17_screw_d/2, 0, nema17_screw_d/2])
      rotate([90, 0, 0]) {
      translate([0, 0, 0]) cylinder(r=2.5, h=4);
      translate([0, 0, 0]) cylinder(r=1.5, h=12);
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

