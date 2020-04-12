
module ellipse(width, height, screwholes = false) {
    difference() {
        scale([1, height/width*.9,0]) circle(r=width/2);
        if (screwholes) {
            hole(-width*0.425, 0.75);
            hole(width*0.425, 0.75);
        }
    }
}

module capped_ellipse(width, height) {
    difference() {
        scale([1, height/width*.9,0]) circle(r=width/2);
        #translate([-width*0.425,0.75,height]) dome(d=0.75, h=0.5, hollow=true);
        #translate([width*0.425,0.75,height]) dome(d=0.75, h=0.5, hollow=true);
    }
}

module hole(x, r) {
    translate([x,0,0]) circle(r);
}

$fn = 64;


module hurley(w=30,h=10) {
	top=4;
	bottom=0.5;

	linear_extrude(top) {
		difference() {
			ellipse(w, h);
			#text("HURLEY", 6, halign="center", valign="center", font="Copperplate:style=Bold");
		}
	}

	translate([-w*0.425,0,top]) dome(d=1, h=0.5);
	translate([w*0.425,0,top]) dome(d=1, h=0.5);


	linear_extrude(bottom) {
		translate([0,0,-bottom]) ellipse(w,h);
	}
}

hurley(50,10);

/*
	dome() v1.0.0 by robert@cosmicrealms.com from https://github.com/Sembiance/openscad-modules
	Allows you to create a dome
	
	Usage
	=====
	Prototype: dome(d, h, hollow, wallWidth, $fn)
	Arguments:
		-         d = Diamater of the dome. Default: 5
		-         h = Height of the dome. Default: 2
		-    hollow = Whether or not you want the dome to be hollow. Default: false
		- wallWidth = If the dome is hollow, how wide should the walls be. Default: 0.5
		-       $fn = How smooth you want the dome rounding to be. Default: 128
	Change Log
	==========
	2017-01-04: v1.0.0 - Initial Release
	Thanks to VincentD for the initial code inspiration (http://www.thingiverse.com/thing:277694)
*/

// Example code:
/*
dome(d=10, h=5);
translate([15, 0, 0]) { dome(d=8, h=3, hollow=true); }
*/

module dome(d=5, h=2, hollow=false, wallWidth=0.5, $fn=128)
{
	sphereRadius = (pow(h, 2) + pow((d/2), 2) ) / (2*h);

	translate([0, 0, (sphereRadius-h)*-1])
	{
		difference()
		{
			sphere(sphereRadius);
			translate([0, 0, -h])
			{
				cube([2*sphereRadius, 2*sphereRadius, 2*sphereRadius], center=true);
			}

			if(hollow)
				sphere(sphereRadius-wallWidth);
			
		}
	}
}