
//chassisInternalX=140;
//chassisInternalY=72;

//radius of generic screw holes
genericHoleRadius=3/2;
//piAX=61.5;
piAX=65; //real value
piBX=85;
piBY=56;
piBZ=1.6;
piBPortsHeight=16;
piBPortsX=22;
piBPortsXShift=2;

piHolesRadius=2.75/2;
piHoleCenterDistFromEdge=3.5;
piDistFrontBackHoles=58;

piHolesZ=20;


piHolesRadius=3/2;
//piHolesRadius=2.75/2;
piHoleCenterDistFromEdge=3.5;
piDistFrontBackHoles=58;




beamsThickness=2.5;
wallsThickness=0.8;


//the rack was too high for the case.
//We squished it by this much to make it fit.
// Set it to 0 if not needed.
chassisYSizeReduction=6;

chassisInternalX=piAX;
chassisInternalY=piBY-chassisYSizeReduction;




padding=0.1;

sideWallsHeight=beamsThickness;
sideWalls2Height=beamsThickness;

chassisX=beamsThickness+chassisInternalX;
chassisY=beamsThickness+chassisInternalY;

screwHolesRadius=2/2;

circuit1X=piBX;
circuit1Y=piBY;
circuit1ScrewsRadius=2/2;
circuit1ScrewsDistFromEdge=piHoleCenterDistFromEdge;
circuit1ScrewPillarsH=6+beamsThickness;



	h1Shift=15;
	h2Shift=30;
	fixationHoles1Radius=3.1/2;
	fixationHoles2Radius=3/2;

h0=6;
screwBlockPadding=1.5;
screwBlockY=5;
screwBlockY2=7;
screwBlockX=fixationHoles1Radius*2+screwBlockPadding*2;

supportBackThickness=2;



zShift01=supportBackThickness+1;


module rpiPlusHoles()
{
	translate([piHoleCenterDistFromEdge,piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piHolesZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge,piBY-piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piHolesZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge+piDistFrontBackHoles,piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piHolesZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge+piDistFrontBackHoles,piBY-piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piHolesZ+padding,$fn=16);
		}
}

module rpiPlusCommonPorts(portsLength01=10)
{
	portsClearance=2;
	usbPortX=7.2;
	usbPortY=6;
	usbPortZ=3.2;
	usbPortXShift=10.6;
	hdmiPortXShift=32;
	hdmiPortX=15;
	hdmiPortY=portsLength01+3;
	hdmiPortZ=6;
	audioPortRadius=6;
	audioPortXShift=53.5;

	translate([usbPortXShift,4,usbPortZ/2])
		rotate([90,90,0])
			color("gray")
				portCutOut(usbPortZ/2, usbPortX/2, usbPortY);

	translate([hdmiPortXShift,11,hdmiPortZ/2])
		rotate([90,90,0])
			color("gray")
				portCutOut(hdmiPortZ/2, hdmiPortX/2, hdmiPortY);

	translate([audioPortXShift,11,hdmiPortZ/2])
		rotate([90,90,0])
			color("gray")
				portCutOut(audioPortRadius/2, 0, hdmiPortY);

}
module portCutOut(radius01, centersDist01, thickness01)
{
	hull()
	{
	translate([0,-centersDist01,0])
		cylinder(r=radius01, thickness01);

	translate([0,centersDist01,0])
		cylinder(r=radius01, thickness01);
	}
}

module rpiBplusPCB() 
{
		difference()
		{
    		cube([piBX, piBY, piBZ], center = false);
			rpiPlusHoles();
		}
}


module rpiBplus() 
{

	color("green")
		{rpiBplusPCB();}
	translate([piBX-piBPortsX+piBPortsXShift,0,piBZ-padding])
	color("gray")
		{cube([piBPortsX,piBY,piBPortsHeight+padding]);}
	translate([0,0,piBZ])
	rpiPlusCommonPorts();

}



module openBasePlate2(nbBeamsX=3,nbBeamsY=2,thickness01=5)
{
	xShift=chassisX/(nbBeamsX+1);
	for (i =[0:nbBeamsX+1])
	{
		translate([xShift*i,0,0])
			cube([beamsThickness,chassisY,thickness01]);
	}

	yShift=chassisY/(nbBeamsY+1);
	for (i =[0:nbBeamsY+1])
	{
		translate([0,yShift*i,0])
			cube([chassisX+beamsThickness,beamsThickness,thickness01]);
	}
}



module circuit1Plate()
{
    //top holes
	translate([circuit1ScrewsDistFromEdge,circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	
	translate([circuit1ScrewsDistFromEdge,circuit1Y-circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	
	screwBeamYShift=0;
	screwBeamYShift=max(chassisYSizeReduction-5,0);


        translate([0,screwBeamYShift,0])
			cube([beamsThickness*2+(circuit1ScrewsDistFromEdge-beamsThickness),chassisY,beamsThickness]);
			
        
        //back holes
	translate([piDistFrontBackHoles+circuit1ScrewsDistFromEdge,circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	translate([piDistFrontBackHoles+circuit1ScrewsDistFromEdge,circuit1Y-circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

        translate([piDistFrontBackHoles+circuit1ScrewsDistFromEdge-beamsThickness,screwBeamYShift,0])
			cube([beamsThickness*2+circuit1ScrewsDistFromEdge-beamsThickness,chassisY,beamsThickness]);		
}


module piSupport1(nbBeamsX=3,nbBeamsY=2,supportThickness=3)
{

  difference()
  {
  union()
  {
	openBasePlate2(nbBeamsX,nbBeamsY,supportThickness);
	translate([beamsThickness,beamsThickness-chassisYSizeReduction/2,0])
	{
		circuit1Plate();
	}


  }
	translate([beamsThickness,beamsThickness-chassisYSizeReduction/2,0.5])
	{
	rpiPlusHoles();
	}
	}

	
}




module piSupport2(nbBeamsX=3,nbBeamsY=2,supportThickness=3)
{


	difference()
	{
		piSupport1(nbBeamsX,nbBeamsY,supportThickness);
		
		translate([0+h1Shift,chassisY,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);

		translate([0+h2Shift,chassisY,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);

		translate([chassisX+beamsThickness-h2Shift,chassisY,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);	

		translate([chassisX+beamsThickness-h1Shift,chassisY,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);



		translate([0+h1Shift,0,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);

		translate([0+h2Shift,0,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);

		translate([chassisX+beamsThickness-h2Shift,0,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);	

		translate([chassisX+beamsThickness-h1Shift,0,supportThickness/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);
	}

}





module fixationSupportNoHoles()
{
color([1,0,1])
{
translate([h1Shift-screwBlockPadding-fixationHoles1Radius,chassisY-screwBlockY,0])
cube([screwBlockX,screwBlockY,h0]);

translate([h2Shift-screwBlockPadding-fixationHoles1Radius,chassisY-screwBlockY,0])
cube([screwBlockX,screwBlockY,h0]);

translate([chassisX+beamsThickness-h1Shift-screwBlockPadding-fixationHoles1Radius,chassisY-screwBlockY,0])
cube([screwBlockX,screwBlockY,h0]);

translate([chassisX+beamsThickness-h2Shift-screwBlockPadding-fixationHoles1Radius,chassisY-screwBlockY,0])
cube([screwBlockX,screwBlockY,h0]);

translate([0,chassisY-screwBlockY,-supportBackThickness])
cube([chassisX,screwBlockY,supportBackThickness]);

translate([0,0,-1*supportBackThickness])
	openBasePlate2(2,2,supportBackThickness);

translate([-1,-supportBackThickness,-supportBackThickness])
cube([chassisX+beamsThickness+2,supportBackThickness,supportBackThickness+h0]);


//BOTTOM FIXATION BLOCKS
translate([-screwBlockX-1,-supportBackThickness,-supportBackThickness])
cube([screwBlockX,screwBlockY2+supportBackThickness,h0+supportBackThickness]);

translate([chassisX+1+beamsThickness,-supportBackThickness,-supportBackThickness])
cube([screwBlockX,screwBlockY2+supportBackThickness,h0+supportBackThickness]);


		translate([0+h1Shift,1,h0/2])
		rotate([-90,0,0])
		cylinder(r1=fixationHoles1Radius,r2=0, h=beamsThickness,$fn=16,center=true);

		translate([0+h2Shift,1,h0/2])
		rotate([-90,0,0])
		cylinder(r1=fixationHoles1Radius,r2=0, h=beamsThickness,$fn=16,center=true);

		translate([chassisX+beamsThickness-h2Shift,1,h0/2])
		rotate([-90,0,0])
		cylinder(r1=fixationHoles1Radius,r2=0, h=beamsThickness,$fn=16,center=true);	

		translate([chassisX+beamsThickness-h1Shift,1,h0/2])
		rotate([-90,0,0])
		cylinder(r1=fixationHoles1Radius,r2=0, h=beamsThickness,$fn=16,center=true);

}

}

module fixationSupport()
{
difference()
{
fixationSupportNoHoles();

		translate([0+h1Shift,chassisY,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles2Radius, h=piBZ+padding,$fn=16,center=true);

		translate([0+h2Shift,chassisY,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles2Radius, h=piBZ+padding,$fn=16,center=true);

		translate([chassisX+beamsThickness-h2Shift,chassisY,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles2Radius, h=piBZ+padding,$fn=16,center=true);	

		translate([chassisX+beamsThickness-h1Shift,chassisY,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles2Radius, h=piBZ+padding,$fn=16,center=true);




		translate([0+h1Shift+(h2Shift-h1Shift)/2,0,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);

		translate([chassisX+beamsThickness-h2Shift+(h2Shift-h1Shift)/2,0,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);	



		translate([-screwBlockX/2-1,0,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);

		translate([chassisX+beamsThickness+screwBlockX/2+1,0,h0/2])
		rotate([90,0,0])
		cylinder(r=fixationHoles1Radius, h=piBZ+padding,$fn=16,center=true);	

}
}



color([1,0.5,0])
piSupport2(1,1,h0);
fixationSupport();


	
	/*translate([beamsThickness+piAX,beamsThickness-chassisYSizeReduction/2+piBY,h0])
		rotate(180,0,0)
		rpiBplus() ;*/
