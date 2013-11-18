include <config.scad>

module joint_middle(b,l) {
	difference()
	{
		//Base
		translate([-l/2,-b/2,-l/2]) cube([l,b,l]);

		//Middle part
		for(i=[0,180])
		rotate([0,i,0])
		{
			//Kugellager
			rotate([0,90,0]) 
			translate([0,0,l/2-kugellager_h]) 
				cylinder(h=kugellager_h+1,r=kugellager_d/2+play/2);
		}
		//Drills
		rotate([0,90,0]) 
		translate([0,0,-l/2-1])
			cylinder(h=l+2,r=3/2);


		//side part
		for(i=[0,180])
		rotate([i,0,0])
		{
			//Kugellager
			rotate([90,0,0]) 
			translate([0,0,b/2-kugellager_h]) 
				cylinder(h=kugellager_h+1,r=kugellager_d/2+play/2);
			//Drills
			rotate([90,0,0]) 
			translate([0,0,kugellager_d/2+1/2]) 
				cylinder(h=b/2,r=3/2);
		}
	}
	
}

module joint_rod(b,l,w,rh,a,rd)
{
	clear=(l/2*(1+1/sin(a/2)))*tan(a/2);
	difference()
	{
		union()
		{
			difference()
			{
				//Base
				translate([-w/2,-l/2,-l/2]) 
					cube([w,l,rh+l/2]);
	
				//Cut
				translate([-l/2-2*play,-l/2-1,-l-1]) 
					cube([l+play*4,l+2,clear+l-1]);
			}

			//Distance holder
			for(i=[0,180])
			rotate([0,0,i])
			translate([-l/2,0,0]) 
			rotate([0,-90,0]) 
				cylinder(h=2*play+1,r=3.5/2);
			
		}
		//holderdrill
		cylinder(h=rh+1,r=(rd+2*play)/2);

		//Drill axe
		translate([-w/2-1,0,0])
			rotate([0,90,0]) 
				cylinder(h=w+2,r=(2+play)/2);

		//Nut cuts
		for(j=[rh-M2_nut_d/2-2,clear+M2_nut_d/2+2])
		translate([0,0,j])
		for(i=[0,180])
		rotate([90,i,i+90])
		{
			translate([0,0,0]) cylinder(h=w/2+1,r=(2+play)/2);
			translate([0,0,w/2-2-M2_nut_h]) cylinder(h=M2_nut_h,r=M2_nut_d/2,$fn=6);
			translate([0,-M2_nut_w/2,w/2-2-M2_nut_h]) cube([l/2+1,M2_nut_w,M2_nut_h]);			
		}

	}
	//screw
	% rotate([0,90,0]) 
	translate([0,0,w/2]) 
		cylinder(h=2,r=4/2);
	% rotate([0,-90,0]) 
	translate([0,0,w/2]) 
		cylinder(h=M2_nut_h,r=M2_nut_d/2,$fn=6);
	
}

module joint_holder(add_remove,b,l,w,hh) {
	if(!add_remove)
	{
		//base
		for(i=[0,180])
		rotate([i,0,0]) 
		{
			translate([-hh/2,b/2+2*play,-hh/2]) 
				cube([hh/2+w/2+1,l/2,hh]);
			rotate([90,0,0])
			translate([0,0,b/2]) 
				cylinder(h=2*play+1,r=3.5/2);
		}
	}
	else
	{	
		//REMOVE
		//Drill
		rotate([90,0,0])
		translate([0,0,-b/2-l/2-1])
			cylinder(h=b+l+2,r=2/2);

		//middle
		cube([w*sqrt(2)+2*play,b,hh+2],center=true);	

		for(i=[-60,60])
		rotate([i,0,0])
		translate([hh/2,-l/2-play,w/2-1]) 
			cube([w/2-hh/2+4*play,l+2*play,l/2+4+2*play]);	
	}
}


t=($t+1/12)%1;
w_x=(t*6*120)%120-60;
w_y=floor(t*6)*18;

rotate([0,-w_y,0])   
	joint_middle(joint_b,joint_l);
rotate([w_x,-w_y,0]) 
	joint_rod(joint_b,joint_l,joint_w,joint_rh,a=joint_open_angel,rd=arm_rod_d);

difference()
{
	union()
	{
		//Base
		translate([joint_w/2,-20,-joint_hh/2]) 
			cube([20,40,joint_hh]);
		joint_holder(false,joint_b,joint_l,joint_w,joint_hh);
	}
	joint_holder(true,joint_b,joint_l,joint_w,joint_hh);
}
