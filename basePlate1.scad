//internal dimensions
caseIntX=175;
caseIntY=245;
caseBottomIntZ=65;

plateThickness=5;




switchX=168;
switchY=105;

switchPCBX=149;
switchPCBY=95;

switchXShift=(caseIntX-switchX)/2;
switchYShift=5;

//definitions for hole 2 (top right)
switch2HRadius=5;
switchH2XShiftT=2;//hole 2 shift from top
switchH2YShiftR=-5;//hole 2 shift from right

//definitions for hole 2 (bottom right)
switch4HRadius=switch2HRadius;
switchH4XShiftB=-2;//hole 2 shift from bottom
switchH4YShiftR=-5;//hole 2 shift from right

cube([caseIntX,caseIntY,plateThickness]);

translate([switchXShift,switchYShift,plateThickness])
color([0.8,0.8,0.8])
{
	cube([switchX,switchY,plateThickness]);
}

