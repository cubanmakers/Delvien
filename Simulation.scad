include <config.scad>
use <helper.scad>
use <platform.scad>
use <carriage.scad>
use <joint.scad>
use <motor_end.scad>
use <top_end.scad>
use <band_tighter.scad>
use <endstop.scad>
use <distanceholder.scad>
use <fan.scad>

simple=false;

arms=arm_n;
max_angel=joint_open_angel;


v=$t*6;

x1=(v>0 && v<=1)?-100+(v-0)*200:-100;
y1=(v>0 && v<=1)?-100:-100;

x2=(v>1 && v<=2)? 100:x1;
y2=(v>1 && v<=2)?-100+(v-1)*200:y1;

x3=(v>2 && v<=3)? 100-(v-2)*200:x2;
y3=(v>2 && v<=3)? 100:y2;

x4=(v>3 && v<=4)? -100:x3;
y4=(v>3 && v<=4)? 100-(v-3)*200:y3;

x5=(v>4 && v<=5)?-100+(v-4)*200:x4;
y5=(v>4 && v<=5)?-100+(v-4)*200:y4;

x6=(v>5 && v<=6)? 100-(v-5)*200:x5;
y6=(v>5 && v<=6)? 100-(v-5)*200:y5;

ppos=[x6,y6,100];

d=sqrt(200*200*2);
//ppos=[d/2*cos($t*360),d/2*sin($t*360),100];


function get_d(s,e) =[e[0]-s[0],e[1]-s[1],e[2]-s[2]]; 
function get_l(s,e) =sqrt(get_d(s,e)[0]*get_d(s,e)[0]+get_d(s,e)[1]*get_d(s,e)[1]+get_d(s,e)[2]*get_d(s,e)[2]); 
function get_angels(s,e) =[0,acos(get_d(s,e)[2]/get_l(s,e)),get_d(s,e)[0]==0 ? 90 :(get_d(s,e)[0]>0 ? atan(get_d(s,e)[1]/get_d(s,e)[0]): atan(get_d(s,e)[1]/get_d(s,e)[0])+180)];

module line(s, e)
{
	translate(s) rotate(get_angels(s,e)) cylinder(r=0.5,h=get_l(s,e));
}

//Base
{
	color("SkyBlue")
	translate([-100,-100,-1]) cube([200,200,2]);
	% color("SkyBlue",0.3)
	{
		translate([0,0,1]) cylinder(h=1,r=sqrt(200*200*2)/2);	
		translate([-120,-120,1]) cube([240,240,1]);	
	}

	translate([30,0,-19])
	rotate([0,0,-90])
	assign(s=430,d=19,h=950,a=0.5)
	{
		color(wood)
		translate([-s/2,-s/2,0]) 
			cube([s,s,d]);
		if(simple==false)
		{
			%color(wood,a)
			{
				//TOP
				translate([-s/2,-s/2,1000-nema17_od-10-19-20]) 
					cube([s,s,d]);
				//Back
				translate([-s/2,s/2,0]) 
					cube([s,d,h]);
				//Back
				for(dd=[-s/2-d,+s/2])
				translate([dd,-s/2,0]) 
					cube([d,s+d,h]);
			}
			%color("SkyBlue",a*0.5)
			//Front
			translate([-s/2-d,-s/2-4,0]) 
				rotate([0,0,-120])
				cube([s+2*d,2,h]);
		}

		//fans
		assign(h=950-arm_l)
		for(h=[h/3-h/6,2*h/3-h/6,3*h/3-h/6])
		for(i=[0,1])
		rotate([0,0,180+i*90])
		translate([-s/2,-s/2,0])
		{
			fanholder();
				//fan
			rotate([90,0,-45])
			translate([0,0,-61])
				fan(50,15.5,40,4.5);
		}
	}

}




//linear guidance
for(i=[0:arms-1])
{
	rotate([0,0,360/arms*i])
	{
		color(steel)
		for(d=[lg_d/2,-lg_d/2])
		translate([lg_c,d,-nema17_od-10-19]) 
			cylinder(r=ld_rod_d/2,h=1000);

		if(simple==false)
		{
			//Band
			for(d=[band_outer_d/2-band_b/2,-band_outer_d/2+band_b/2])
			color("black")
			translate([lg_c-band_w/2,d-band_b/2,-50])
				cube([band_w,band_b,930]);
			
			//Motor holder
			translate([lg_c,0,-19])
			rotate([180,0,0])
				motor_end(true);
			
			//motor
			translate([lg_c-15,0,-19-nema17_od/2-5])			
			rotate([0,0,-90])
			nema17();

			//pully
			translate([0,0,-19-nema17_od/2-5])			
			rotate([0,90,0])
			translate([0,0,lg_c])			
				narrow_pulley(5, 12, 6.5, 18, 1, 18, 17);

			//Motor holder screws
			color(aluminum)
			for(x=[-25,-55])
			for(y=[-lg_d/2,lg_d/2])
			translate([lg_c+x,y,-19-5-2])
				cylinder(h=19+5+4,r=4/2);
				
			//Band Tighter
			translate([lg_c,0,1000-nema17_od-10-19-20+5-40])
			band_tighter();

			//Top
			translate([lg_c,0,1000-nema17_od-10-19-20])
				top_end();	

			//Band Tighter screws
			color(aluminum)
			for(y=[-15,15])
			translate([lg_c,y,1000-nema17_od-10-19-20+5-40])
				cylinder(h=40,r=4/2);

			//distanceholder
			translate([lg_c,(i==2?-1:1)*lg_d/2,1000-nema17_od-10-19-20-50+5])						
				distanceholder();

			//Endstop
			translate([lg_c,0,1000-nema17_od-10-19-20-50])
				mirror([0,i==2?1:0,0])
				endstop();
	
		}
	}
}


//Platform
translate(ppos)
rotate([0,0,180])	
{
	if(simple)
	difference()
	{
		cylinder(r=platform_outer_r,h=joint_hh,center=true);
		cylinder(h=joint_hh+2,r=platform_inner_r,center=true);
	}
	else
	{
		platform();
		color("black")
		cylinder(h=1,r=0.5);
	}
}


//holders
for(i=[0:arms-1])
assign(a=360/arms*i)
assign(d=[ppos[0]*cos(a)+ppos[1]*sin(a),ppos[1]*cos(a)-ppos[0]*sin(a)])
assign(dist=sqrt(pow(lg_c-lg_holder_d-platform_c-d[0],2)+pow(d[1],2)))
assign(h=ppos[2]+sqrt(arm_l*arm_l-dist*dist))
assign(s=[platform_c+d[0],d[1],ppos[2]])
assign(e=[lg_c-lg_holder_d,0,h])
rotate(a)
{
	if(simple)
	{
		color(abs(atan2(platform_c+d[0]-(lg_c-lg_holder_d),d[1])+90)>max_angel/2?"red":"black")
		{
			line([lg_c-lg_holder_d,-lg_d/2,h],[lg_c-lg_holder_d,lg_d/2,h]);
			for(dd=[-arm_d/2,arm_d/2])
				line([s[0],s[1]+dd,s[2]],[e[0],e[1]+dd,e[2]]);
		}

		color("green")
		for(dd=[-arm_d/2,arm_d/2])
		for(j=[max_angel/2,-max_angel/2])
			line([s[0],s[1]+dd,s[2]],[s[0]+20*cos(j),s[1]+dd+20*sin(j),s[2]]);

	}
	else
	{
		//carriging
		translate([lg_c,0,h])
		rotate([180,0,0])
		mirror([0,i==2?1:0,0])
			carriage();
		
		for(dd=[-arm_d/2,+arm_d/2])
		translate([0,dd,0])
		{
			//joint platform
			assign(a_x=-atan(get_d(s,e)[1]/sqrt(get_d(s,e)[2]*get_d(s,e)[2]+ get_d(s,e)[0]*get_d(s,e)[0])))
			assign(a_y=atan(get_d(s,e)[0]/get_d(s,e)[2]))
			translate(s)
			{
				rotate([0,a_y,0])
					joint_middle(joint_b,joint_l);
				rotate([a_x,a_y,0])
					joint_rod(joint_b,joint_l,joint_w,joint_rh,a=joint_open_angel,rd=arm_rod_d);
			
			}
			//joint carriging
			for(dd=[-arm_d/2,+arm_d/2])
			assign(a_x=atan(get_d(e,s)[1]/sqrt(get_d(e,s)[2]*get_d(e,s)[2]+ get_d(e,s)[0]*get_d(e,s)[0])))
			assign(a_y=-atan(get_d(e,s)[0]/get_d(e,s)[2]))
			translate(e)
			rotate([180,0,0])
			{
				rotate([0,a_y,0])
					joint_middle(joint_b,joint_l);
				rotate([a_x,a_y,0])
					joint_rod(joint_b,joint_l,joint_w,joint_rh,a=joint_open_angel,rd=arm_rod_d);
			
			}
		
			//rod
			color("black")
			translate(s) 
			rotate(get_angels(s,e)) 
			translate([0,0,joint_rh]) cylinder(r=arm_rod_d/2,h=get_l(s,e)-2*joint_rh);
		}

	}
	color("red")
	translate([lg_c-lg_holder_d-platform_c,0,0])
	{
		line([0,0,2],[-lg_c*cos(-max_angel/2),-lg_c*sin(-max_angel/2),2]);
		line([0,0,2],[-lg_c*cos(max_angel/2),-lg_c*sin(max_angel/2),2]);
	}

}
