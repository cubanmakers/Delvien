include <../config.scad>
include <../helper.scad>
use <gregs-wadebits.scad>

wade_gear_d=14.8888+29.7778;
b=6;
motor_holder_h=10;
h=motor_holder_h+nema17_l;
pully_d=13;
joint_l=30;

module extruder_part(part,showcomp=false)
{
	difference()
	{
		union()
		{
			//Motor holder
			difference()
			{
				translate([0,-motor_holder_h/2,0])
				rotate([0,45,0])
				translate([0,0,(part==0?6/2:0)])
					cube([nema17_od,motor_holder_h,nema17_od+(part==0?6:0)],center=true);	
				
				translate([-nema17_od*sqrt(2)/2,-motor_holder_h-1,-(nema17_od-2*b)/2])
					cube([nema17_od*sqrt(2)/2,motor_holder_h+2,(nema17_od-2*b)]);
			}
			//Base
			translate([-wade_gear_d,-(part==0?10:b),-(B608Z_od+b*2)/2])
				cube([wade_gear_d,(part==0?10:b),B608Z_od+b*2]);
			
			//Barringholder
			translate([-wade_gear_d,0,0])
			rotate([90,0,0])
				cylinder(h=h,r=(B608Z_od+2*b)/2);

			//Tube holder mount
			if(part==0)
			translate([-(8+2*b)/2-wade_gear_d-pully_d/2,-(h+20-1),12/2+1])
			difference()
				cube([8+2*b,h+20-1,15]);

			//joint
			translate([-wade_gear_d+(part==0?0:pully_d),0,(part==0?-joint_l:joint_l)])
			rotate([90,0,0])
			translate([0,0,(part==0?2:1)*M8_nut_h])
			assign(jh=h-(part==0?2:1)*M8_nut_h+(part==0?20-1:0))
			assign(d=(2*b+8))
			assign(l=joint_l)
			{
				cylinder(r=d/2,h=jh);
				translate([-b/2,(part==0?0:-l),0])
				cube([b,l,jh]);
			}

			//joint screw
			if(part==0)
			assign(h_=2*b+4)
			translate([-pully_d-B608Z_od/2-wade_gear_d+3,-h,-h_/2+4/2+8/2+1])
			difference()
				cube([pully_d+B608Z_od/2,h,h_]);

			if(part==1)
			assign(d=4+8+4*play)
			for(d=[d/2,-d/2])
			translate([-wade_gear_d-B608Z_od/2-b-8/2,0,d-4/2-8/2-1])
			rotate([90,0,0])
			translate([0,0,M8_nut_h])
			assign(jh=h-M8_nut_h)
			assign(d=(2*b+8))
			assign(l=B608Z_od/2+5/2+b)
			{
				cylinder(r=d/2,h=jh);
				translate([0,-b/2,0])
					cube([l,b,jh]);
			}

			//Mount
			if(part==0)
			rotate([0,-45,0])
			translate([nema17_od/2+10/2+5,-h/2,0])
				cube([10,h,nema17_od],center=true);
			 
		}

		//Motor cutouts:
		translate([0,-(nema17_l+1)/2-motor_holder_h,0])
		rotate([0,45,0])
			cube([nema17_od+4*play,nema17_l+1,nema17_od+4*play],center=true);	
	  	for (a = [0, 90, 180, 270]) 
		rotate([0, a+45, 0])
		translate([nema17_screw_d/2, 0, nema17_screw_d/2]) 
		rotate([90, 0, 0])
		translate([0, 0,-1]) 
			cylinder(r=3.5/2, h=motor_holder_h+2);
		rotate([90,0,0])
		translate([0, 0,-1]) 
			cylinder(h=motor_holder_h+2,r=(nema17_od-2*b)/2);
		
		//Axe drill
		translate([-wade_gear_d,0,0])
		rotate([90,0,0])
		translate([0,0,-1])
			cylinder(h=h+2,r=B608Z_isd/2);

		//Bearing cuts
		translate([-wade_gear_d,0,0])
		rotate([90,0,0])
		translate([0,0,-1])
			cylinder(r=B608Z_od/2,h=B608Z_h-2+1);
		translate([-wade_gear_d,0,0])
		rotate([90,0,0])
		translate([0,0,h-B608Z_h])
			cylinder(r=B608Z_od/2,h=B608Z_h+20);

		//Tube holder mount drill
		if(part==0)
		translate([-wade_gear_d-pully_d/2,-h-10,0])
			cylinder(h=30,r=9.5/2);

		//joint drill
		translate([-wade_gear_d+(part==0?0:pully_d),0,(part==0?-joint_l:joint_l)])
		rotate([90,0,0])
			cylinder(r=(8+2*play)/2,h=h+20);
		if(part==0)
		translate([-wade_gear_d-pully_d/2,-h-10,-2*joint_l])
			cylinder(h=2*joint_l,r=5/2);
		
		//joint screw drills
		if(part==1)
		assign(d=4+8+4*play)
		for(d=[d/2,-d/2])
		translate([-wade_gear_d-B608Z_od/2-b-8/2,0,d-4/2-8/2-1])
		rotate([90,0,0])
		{
			cylinder(r=8/2,h=h+1);
			translate([0,0,-1])
			cylinder(h=M8_nut_h+1,r=M8_nut_d/2,$fn=6);
		}

		if(part==0)
		translate([0,-h+B608Z_h+4/2,4/2+8/2+1])
		rotate([0,-90,0])
		{
			cylinder(h=100,r=4/2);
			translate([-4/2,-4/2-0.01,-B608Z_od/2+wade_gear_d])
				cube([4,4/2,B608Z_od]);
			translate([0,0,wade_gear_d+B608Z_od/2+1])
			{
				rotate([0,0,90])
				{
					cylinder(h=M4_nut_h,r=M4_nut_d/2,$fn=6);		
					translate([-B608Z_h-M4_nut_d/2-4/2,0,0])
						cylinder(h=M4_nut_h,r=M4_nut_d/2,$fn=6);
				}		
				translate([-M4_nut_w/2,-B608Z_h-M4_nut_d/2-4/2,0]) 
					cube([M4_nut_w,B608Z_h+M4_nut_d/2+4/2,M4_nut_h]);	
			}
		}
		
		

		//Mount drills
		if(part==0)
		assign(h=h-10)
		for(h=[h/4,3*h/4])
		for(b=[nema17_od/4,-nema17_od/4])
		rotate([0,45,0])
		translate([b,-10-h,0])
		translate([0,0,nema17_od/2+5-1])
			cylinder(r=5/2,h=12);

	}


	if(showcomp)
	{
		translate([0,-motor_holder_h,0])
		rotate([0,45,0])
			nema17(motor_holder_h,[true,true,false,true,]);
		
		translate([0,13,0])
		rotate([90,360/20/2,0])
			WadesS();
		
		translate([-wade_gear_d,3,0])
		rotate([270,0,0])
			WadesL();

		//rod
		translate([-wade_gear_d,0,0])
		rotate([90,0,0])
		translate([0,0,-20])
		color(steel)
			cylinder(h=h+38,r=8/2);

		//Pully
		translate([-wade_gear_d,0,0])
		rotate([90,0,0])
		translate([0,0,h+7])
		color(steel)
			cylinder(h=10,r=12/2);		
		
		//joint rod
		if(part==1)
		color(steel)
		assign(d=4+8+4*play)
		for(d=[d/2,-d/2])
		translate([-wade_gear_d-B608Z_od/2-b-8/2,0,d-4/2-8/2-1])
		rotate([90,0,0])
			cylinder(r=8/2,h=h+50+10);

	}
}


module joint_screw()
{
	difference()
	{
		union()
		{

			//joint screw
			assign(d=4+8+4*play)
			for(d=[d/2,-d/2])
			translate([-wade_gear_d-B608Z_od/2-b-8/2,0,d-4/2-8/2-1])
			rotate([90,0,0])
			translate([0,0,h+1])
			assign(jh=50)
			assign(l=B608Z_od/2+5/2+b)
			{
				cylinder(r=(2*b+8)/2,h=jh);
				if(d<0)
				translate([-b-8/2,0,0])
					cube([b,(b+8),jh]);
			}
			
			 
		}

		
		//joint screw drills
		assign(d=4+8+4*play)
		for(d=[d/2,-d/2])
		translate([-wade_gear_d-B608Z_od/2-b-8/2,0,d-4/2-8/2-1])
		rotate([90,0,0])
			cylinder(r=8/2,h=2*h+20);
		
		translate([0,-h-20-B608Z_h-4/2,-4/2-8/2-1])
		rotate([0,-90,0])
		translate([0,0,-1])
			cylinder(h=100,r=6/2);
	}
}

module extruder(showcomp=false,a=0)
rotate([0,(showcomp?45:0),0])
{
	extruder_part(0,showcomp);

	translate([-wade_gear_d,0,-joint_l])
	rotate([0,-a,0])
	translate([wade_gear_d,0,joint_l])
	translate([-pully_d,-(2*h+20),0])
	rotate([180,0,0])
	{
		extruder_part(1,showcomp);
		joint_screw();
	}

	if(showcomp)
	{
		//filament
		color("black")
		translate([-wade_gear_d-pully_d/2,-h-10,-60])
			cylinder(h=120,r=3/2);

		//roadholder
		color("blue",0.4)
		translate([-wade_gear_d-pully_d/2,-h-10,10])
			cylinder(h=50,r=12/2);

		//joint rod
		color(steel)
		translate([-wade_gear_d,0,-joint_l])
		rotate([90,0,0])
			cylinder(r=(8+2*play)/2,h=2*h+20);

		color(steel)
		translate([-wade_gear_d,-h+B608Z_h+4/2,4/2+8/2+1])
		rotate([0,-90,0])
			cylinder(h=50,r=4/2);

		//wall
		% color(wood,0.3)
		rotate([0,-45,0])
		translate([19/2+nema17_od/2+5+10,-50+10,0])
			cube([19,200,200],center=true);
		
	} 
}

extruder(true,0);



