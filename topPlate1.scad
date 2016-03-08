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
switchH4Radius=switchH2Radius;
switchH4XShiftB=-2;//hole 2 shift from bottom
switchH4YShiftR=-5;//hole 2 shift from right

switchRadius=16/2+0.2;


cornerRadius=10;

caseIntXDistCorners=178-10*2;
caseIntYDistCorners=249-10*2;

module topPlateNoHoles()
{
    hull()
    {
        cylinder(r=cornerRadius,h=plateThickness,$fn=32);
        translate([0,caseIntYDistCorners,0])
        cylinder(r=cornerRadius,h=plateThickness,$fn=32);
        translate([caseIntXDistCorners,0,0])
        cylinder(r=cornerRadius,h=plateThickness,$fn=32);
        translate([caseIntXDistCorners,caseIntYDistCorners,0])
        cylinder(r=cornerRadius,h=plateThickness,$fn=32);
    }
}

module topPlate()
{
    difference()
    {
        topPlateNoHoles();
        translate([caseIntXDistCorners-20,caseIntYDistCorners-20,-1])
            cylinder(r=switchRadius,h=plateThickness*2);
    }
}

projection()
{
    topPlate();
}

//cube([caseIntX,caseIntY,plateThickness]);



