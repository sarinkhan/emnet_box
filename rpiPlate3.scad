
//chassisInternalX=140;
//chassisInternalY=72;

//radius of generic screw holes
genericHoleRadius=3/2;
//piAX=61.5;
piAX=65; //real value
piBX=85;
piBY=56;
piBZ=10;


piHolesRadius=3/2;
//piHolesRadius=2.75/2;
piHoleCenterDistFromEdge=3.5;
piDistFrontBackHoles=58;

module rpiPlusHoles()
{
	translate([piHoleCenterDistFromEdge,piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge,piBY-piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge+piDistFrontBackHoles,piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge+piDistFrontBackHoles,piBY-piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}
}
module rpiBplus() 
{
	translate([0,0,plate1DistToPlate2+plateZ+topPlateZ]) 
	{
		difference()
		{
    		cube([piBX, piBY, piBZ], center = false);
			rpiPlusHoles();
		}
	
	}
}
beamsThickness=2.5;
wallsThickness=0.8;

chassisInternalX=piAX;
chassisInternalY=piBY;




padding=0.1;

sideWallsHeight=chassisBattBoxZ+beamsThickness;
sideWalls2Height=beamsThickness;

chassisX=beamsThickness+chassisInternalX;
chassisY=beamsThickness+chassisInternalY;

screwHolesRadius=2/2;

circuit1X=piBX;
circuit1Y=piBY;
circuit1ScrewsRadius=2/2;
circuit1ScrewsDistFromEdge=piHoleCenterDistFromEdge;
circuit1ScrewPillarsH=5+beamsThickness;



//sideBeamY=motorBracketHoleRadius+motorBracketHoleDistFromEdge+beamsThickness;


//motor bracket holes
module motorBracketHole(h0=sideWallsHeight-beamsThickness,shift=beamsThickness,r0=screwHolesRadius) 
{
	translate([0,0,padding+shift]) 
	{
    	cylinder(r=r0, h0+padding, center = false,$fn=32);
	}
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

	//openBasePlate(circuit1X,circuit1Y,0,0);

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
        
        translate([0,0,0])
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

        translate([piDistFrontBackHoles+circuit1ScrewsDistFromEdge-beamsThickness,0,0])
			cube([beamsThickness*2+circuit1ScrewsDistFromEdge-beamsThickness,chassisY,beamsThickness]);		
}


module piSupport1(nbBeamsX=3,nbBeamsY=2,supportThickness=3)
{

  difference()
  {
  union()
  {
	openBasePlate2(nbBeamsX,nbBeamsY,supportThickness);
	translate([beamsThickness,beamsThickness,0])
	{
		circuit1Plate();
	}


  }
	translate([beamsThickness,beamsThickness,0.5])
	{
	rpiPlusHoles();
	}
	}
}

	h1Shift=15;
	h2Shift=30;
	fixationHoles1Radius=3.1/2;
	fixationHoles2Radius=3/2;


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

h0=6;
screwBlockPadding=1.5;
screwBlockY=5;
screwBlockX=fixationHoles1Radius*2+screwBlockPadding*2;

supportBackThickness=2;



zShift01=supportBackThickness+1;



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
cube([screwBlockX,screwBlockY+supportBackThickness,h0+supportBackThickness]);

translate([chassisX+1+beamsThickness,-supportBackThickness,-supportBackThickness])
cube([screwBlockX,screwBlockY+supportBackThickness,h0+supportBackThickness]);


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
//color([1,0.5,0])
//piSupport2(1,1,h0);
fixationSupport();
