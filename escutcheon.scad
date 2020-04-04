// This will produce and escutcheon with french base 
// and ears

$fn=48;

module escutcheon() {
  difference() {
    linear_extrude(height = 6) {
      // scale(2) is about 6cm in height, 4cm in width
      scale(2) import("french-base-eared-top.svg", center=true);
    }
    translate([0, -20, 3]) {
      linear_extrude(height = 3) {
        scale(1.75) import("french-base.svg", center=true);
      }
    }
  }
}


module fesse(x=440,y=150,z=7){
  difference() {
    linear_extrude(z) {
      square([x, y], center = true);
    }
    linear_extrude(z+4) {
      square([x-2, y-2], center = true);
    }    
  }
}

module cross(u=10) {
  #polygon([
      [0,0], [0, 2*u], [-u, 2*u], [-u, 3*u], [0, 3*u], [0, 4*u], [u, 4*u], [u, 3*u], [2*u, 3*u], [2*u, 2*u], [u, 2*u], [u, 0], [0,0]
  ]);
}

module doublecross(u=10) {
  union() {
    cross(u); 
    mirror([0,1,0]) cross(u);
  }
}

module crosscrosslet(u=10) {
  union(){  
    doublecross(u);
    translate([u/2, -u/2, 0]) rotate(90) doublecross(u);
  }
}

// Attrib: https://gist.github.com/anoved/9622826
// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
module star(points, outer, inner) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

			assign(	x_outer = x(outer, increment * p),
					y_outer = y(outer, increment * p),
					x_inner = x(inner, (increment * p) + (increment/2)),
					y_inner = y(inner, (increment * p) + (increment/2)),
					x_next  = x(outer, increment * (p+1)),
					y_next  = y(outer, increment * (p+1))) {
				polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}
		}
	}
}




module hand() {
  rotate(14) {
    linear_extrude(height = 8) {
      scale(0.16) import("mitt.svg", center=true); 
    }
  }
}

union() {
  escutcheon();
  fesse();

  translate([0,0,0]) hand();  
}


  translate([140, 0, 0]) {
    linear_extrude(8) {
      rotate(18) {
        star(5, 54, 27);
      }
    }
  }

  translate([-140, 0, 0]) {
    linear_extrude(8) {
      rotate(18) {
        star(5, 54, 27);
      }
    }
  }

  translate([-110, 160, 0]) {
    linear_extrude(8) {
      crosscrosslet(15);
    }
  }

  translate([110, 160, 0]) {
    linear_extrude(8) {
      crosscrosslet(15);
    }
  }

  translate([-7.5, -160, 0]) {
    linear_extrude(8) {
      crosscrosslet(15);
    }
  }
