include <config.scad>

module fan(w,h,dw,dd)
color("DimGray")
{
	difference()
	{
		cube([w,w,h],center=true);
		
		for(x=[dw/2,-dw/2])
		for(y=[dw/2,-dw/2])
		translate([x,y,0])
			cylinder(r=dd/2,h=h+2,center=true);
		cylinder(r=(w-5)/2,h=h+2,center=true);

	}

	cylinder(r=h/2,h=h,center=true);

	for(a=[0:180/4:179])
	intersection()
	{
		cylinder(r=(w-10)/2,h=h,center=true);
	
		rotate([20,0,0])
		rotate([0,0,a])
			cube([w-10,2,100],center=true);
	}
}

//fan(50,15.5,40,4.5,1);
//fan(40,10.2,32,4.5,1);


module fanholder()
assign(b=3)
{
		
	assign(l=(40+4+3)/sqrt(2))
	assign(h=(40+4+3))
	translate([0,0,-h/2])
	{
		for(i=[0,1])
		mirror([0,i,0])
		rotate([0,0,-90*i])
		difference()
		{
			cube([b,l,h]);

			assign(m=10)
			for(z=[-h/2-m/2,h/2+m/2])
			translate([-1,-1,z])
				cube([b+2,36/sqrt(2),h]);
			
			translate([0,l,0])
			rotate([0,0,-45])
			translate([-1,0,(h-34)/2])
				cube([2*b,2*b,34]);

			translate([0,20,h/2])
			rotate([0,90,0])
			translate([0,0,-1])
				cylinder(r=3/2,h=b+2);
		}
	}
	
	//Ring
	rotate([90,0,-45])
	translate([0,0,15.5/2-60])
	difference()
	{
		translate([-25,-25,0])
		cube([50,50,1]);

		assign(dw=40)
		for(x=[dw/2,-dw/2])
		for(y=[dw/2,-dw/2])
		translate([x,y,-1])
			cylinder(r=4/2,h=3);
		
		translate([0,0,-1])
			cylinder(r=47/2,h=3);
	}
	
	//holder
	assign(dw=40)
	for(x=[dw/2,-dw/2])
	for(y=[dw/2,-dw/2])
	intersection()
	{
		translate([0,0,-25])
			cube([100,100,50]);

		rotate([90,0,-45])
		translate([x,y,15.5/2-60])
		difference()
		{
				translate([-7/2,-7/2,0])
					cube([7,7,50]);

			translate([0,0,-1])
				cylinder(r=4/2,h=25);
		}
	}

	//support
	for(a=[0,180])
	assign(dw=2*40/4-6)
	for(y=[dw/2,-dw/2])
	intersection()
	{
		translate([0,0,-25])
			cube([100,100,50]);

		rotate([90,0,-45])
		rotate([0,0,a])
		translate([-20,y,15.5/2-60])
		translate([-7/2,-0.7/2,0])
			cube([4.3,0.7,50]);
	}
}

rotate([-45,0,0])
rotate([0,90,0])
{
	fanholder();
	
	//fan
	rotate([90,0,-45])
	translate([0,0,-61])
		% fan(50,15.5,40,4.5);
	
	//wall
	 *% color(wood)
	translate([0,0,-60])
	{
		translate([-19,-19,0])
			cube([19,120,120]);
		translate([-19,-19,0])
			cube([120,19,120]);
	}
}