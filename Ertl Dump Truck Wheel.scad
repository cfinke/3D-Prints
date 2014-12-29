$fa = .5;
$fs = .1;

axle_pocket_diameter = 5.1;
hubcap_diameter = 9.6;
wheel_diameter = 13.8;
spoke_diameter = 15.5;

spoke_width = 4.55;

central_height = 5.15;
middle_height = 7.8;
total_height = 8.2;

wall_thickness = 1;
axle_wall_thickness = 1.55;

axle_ridge_width = .4;
axle_ridge_height = .5;
axle_ridge_count = 5;

hubcap_ridge_thickness = .66;

difference() {
    union() {
        difference() {
            union() {
                // The main outside wheel part.
                cup(r=wheel_diameter/2, h=central_height, t=wall_thickness);
                
                // The spokes sticking out at 90º angles.
                difference() {
                    cup(r=spoke_diameter/2, h=central_height, t=(spoke_diameter - wheel_diameter)/2);
                    translate([spoke_width/2, spoke_width/2, 0]) cube([(spoke_diameter/2)-(spoke_width/2),(spoke_diameter/2)-(spoke_width/2), central_height]);
                    mirror([1,0,0]) translate([spoke_width/2, spoke_width/2, 0]) cube([(spoke_diameter/2)-(spoke_width/2),(spoke_diameter/2)-(spoke_width/2), central_height]);
                    mirror([0,1,0]) translate([spoke_width/2, spoke_width/2, 0]) cube([(spoke_diameter/2)-(spoke_width/2),(spoke_diameter/2)-(spoke_width/2), central_height]);
                    mirror([0,1,0]) mirror([1,0,0]) translate([spoke_width/2, spoke_width/2, 0]) cube([(spoke_diameter/2)-(spoke_width/2),(spoke_diameter/2)-(spoke_width/2), central_height]);
                }
            }
            
            // Remove the area that the hubcap cylinder will occupy to avoid a hollow void inside the wheel.
            cylinder(r=hubcap_diameter/2, h=middle_height);
        }
        
        // The bulk of the hubcap.
        translate([0, 0, (central_height - middle_height) / 2]) cup(r=hubcap_diameter/2, h=middle_height, t=wall_thickness);
        // The axle pocket.
        // The z-translate is not a typo; the central cylinder is even with the hubcap on one end.
        translate([0, 0, (central_height - middle_height) / 2]) cup(r=axle_pocket_diameter/2, h=total_height, t=axle_wall_thickness);
        
        // The axle ridges.
        for (ridge = [1 : axle_ridge_count] ) {
            translate([0, 0, (total_height - ((middle_height - central_height) / 2)) - (ridge * axle_ridge_height * 2)]) washer(r=(axle_pocket_diameter/2) - axle_wall_thickness, h=axle_ridge_height, t=axle_ridge_width);
        }
    }
    
    // Hubcap detail.
    translate([0, 0, (central_height - middle_height) / 2]) washer(r=(hubcap_diameter/2)-hubcap_ridge_thickness,h=wall_thickness/3, t=hubcap_ridge_thickness);
    translate([0, 0, (central_height - middle_height) / 2]) washer(r=(hubcap_diameter/2)-(3*hubcap_ridge_thickness),h=wall_thickness/3, t=hubcap_ridge_thickness);
    translate([0, 0, (central_height - middle_height) / 2]) washer(r=(hubcap_diameter/2)-(5*hubcap_ridge_thickness),h=wall_thickness/3, t=hubcap_ridge_thickness);
    
    // translate([0, 0, -50]) cube([100, 100, 100]); // Uncomment to see inner geometry.
}


module cup(r, h, t) {
    difference() {
        cylinder(r=r, h=h);
        translate([0, 0, t]) cylinder(r=r-t,h=h-t);
    }
}

module washer(r, h, t) {
    difference() {
        cylinder(r=r, h=h);
        cylinder(r=r-t,h=h);
    }
}