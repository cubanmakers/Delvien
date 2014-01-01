//General Settings
play=0.2; //to make fittings (add to some holes if nessesary)
//circle resolution 
$fa = 3;
$fs = 0.1;

aluminum = [0.9, 0.9, 0.9];
steel = [0.8, 0.8, 0.9];
wood="BurlyWood";

//Linear Guidance Settings
lg_d=70;//70  //distance      
lg_c=200;//200;  //away form center   
lg_holder_d=23;//15 //distace from holder to the mount joint  
ld_rod_d=10;

//Arms Settings
arm_n=3;
arm_d=50;//50  //distance
arm_l=300;//300; //length
arm_rod_d=5;//5  //rod diameter

//Joint Settings
joint_open_angel=120;
joint_b=16; 
joint_l=8;
joint_w=14;
joint_rh=30;
joint_hh=joint_l/sqrt(2);

//Platform
platform_c=33;//25 //mount away from center
platform_inner_r=15;
platform_outer_r=25;


//ISO/DIN Parts 
//Kugellager
kugellager_d=5+play;
kugellager_h=2.5+play;

//Mutter M2
M2_nut_d=4.38+2*play;
M2_nut_w=4+2*play;
M2_nut_h=1.6+2*play;

//Mutter M3
M3_nut_d=6.01+2*play;
M3_nut_w=5.5+2*play;
M3_nut_h=2.4+2*play;

//Mutter M4
M4_nut_d=7.66+2*play;
M4_nut_w=7+2*play;
M4_nut_h=3.2+2*play;

//Mutter M8
M8_nut_d=14.38+2*play;
M8_nut_w=13+2*play;
M8_nut_h=6.8+2*play;

//LMXXUU Linear Ball Bearing
LMXXUU_d=19;
LMXXUU_l=29;

//Pully 2.5
band_w=5;
band_b=2;
band_outer_d=13;
//Ballbearing opposit for pully
band_bb_id=5;
band_bb_od=11;
band_bb_w=4;

//Bearing
B608Z_od=22+2*play;
B608Z_id=8+2*play;
B608Z_isd=13;
B608Z_h=7;




//Nema17
nema17_od=42.3;
nema17_id=22+2*play;
nema17_screw_d=31;
nema17_l=48;


