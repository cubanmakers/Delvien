include <config.scad>
use <joint.scad>

for(d=[-10,10])
translate([d,0,joint_l/2])
{
	rotate([90,0,0])
		joint_rod(joint_b,joint_l,joint_w,joint_rh,a=joint_open_angel,rd=arm_rod_d);

	translate([0,10,0])
	rotate([0,0,90])
		joint_middle(joint_b,joint_l);
}
