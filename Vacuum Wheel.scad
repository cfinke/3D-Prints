/**
 * Replacement wheel for a Kenmore Whispertone 12.0 Vacuum
 */

$fa = 1;

wheel_diameter = 109.7;
wheel_wall_thickness = 3;

wheel_edge_radius = 4;

wheel_outer_height = 16.5;
wheel_inner_height_max = 16.5;//20;
wheel_inner_height_min = 16.5;//18.4;

wheel_outer_width = 10;

wheel_groove_width = 3.7;
wheel_groove_depth = 2.5;

wheel_support_width = 1.3;

wheel_clip_height = 31;
wheel_clip_gap = 3.8;
wheel_clip_width_min = 11;
wheel_clip_width_max = 15.6;
wheel_clip_jut_height = 6.1;
wheel_clip_depth = 8.1;

wheel_underneath_opening_diameter = 42;
wheel_underneath_opening_height_additional = 2;

difference() {
	union() {
		difference() {
			union() {
				// Outer wall.
                                difference() {
                                    cylinder_rounded_on_one_end(h=wheel_outer_height, r=wheel_diameter / 2, edge_radius=wheel_edge_radius);
                                    cylinder(r=(wheel_diameter / 2) - wheel_outer_width - wheel_groove_width, h=wheel_outer_height);
                                }
				
				// Central exterior bump.
				translate([0, 0, wheel_outer_height - wheel_inner_height_min]) difference() {
                                    cylinder(r=(wheel_diameter / 2) - wheel_outer_width - wheel_groove_width, h=wheel_inner_height_min);
                                    translate([0, 0, wheel_support_width]) cylinder(r=(wheel_diameter / 2) - wheel_outer_width - wheel_groove_width - wheel_support_width, h=wheel_inner_height_min - wheel_support_width);
                                }
			}
		
			translate([0, 0, wheel_wall_thickness]) cylinder_rounded_on_one_end(h=wheel_outer_height - wheel_wall_thickness, r=(wheel_diameter - wheel_wall_thickness) / 2, edge_radius=wheel_edge_radius * ( ((wheel_diameter - wheel_wall_thickness) / 2)      / (wheel_diameter / 2)) );
		}
                
                intersection() {
                    solid_wheel();
                    difference() {
                        cylinder(r=(wheel_diameter / 2) - wheel_outer_width + wheel_wall_thickness, h=wheel_groove_depth + wheel_wall_thickness);
                        cylinder(r=(wheel_diameter / 2) - wheel_outer_width - wheel_groove_width - wheel_wall_thickness, h=wheel_groove_depth + wheel_wall_thickness);
                    }
                }
		
		// The inside circle.
		difference() {
			cylinder(r=(wheel_underneath_opening_diameter / 2) + wheel_support_width, h=wheel_outer_height + wheel_underneath_opening_height_additional);
			cylinder(r=(wheel_underneath_opening_diameter / 2), h=wheel_outer_height + wheel_underneath_opening_height_additional);
		}
		
                intersection() {
                    // The supports.
                    for (i = [1 : 12]) {
                            rotate(i * (360 / 12 )) translate([0, wheel_underneath_opening_diameter / 2, -wheel_outer_height/2 ]) cube([wheel_support_width, ((wheel_diameter - wheel_underneath_opening_diameter) / 2) - wheel_support_width, wheel_outer_height * 2]);
                    }
                    
                    solid_wheel();
                }
	}

	// Gap.
	difference() {
		cylinder(r=(wheel_diameter / 2) - wheel_outer_width, h=wheel_groove_depth);
		cylinder(r=(wheel_diameter / 2) - wheel_outer_width - wheel_groove_width, h=wheel_groove_depth);
	}
}

// The clip.
union() {
	intersection() {
		difference() {
			union() {
				cylinder(r=wheel_clip_width_min / 2, h=wheel_clip_height);
				translate([0, 0, wheel_clip_height - wheel_clip_jut_height]) cylinder(r1=wheel_clip_width_max / 2, r2=wheel_clip_width_min / 2, h=wheel_clip_jut_height);

				cylinder(r1=wheel_clip_width_max / 2, r2=wheel_clip_width_min / 2, h=wheel_clip_height - wheel_clip_jut_height);
				//cylinder(r=wheel_clip_width_max / 2, h=wheel_clip_height / 3); // Uncomment this line and comment the previous line for the original clip design.
			}
		
			translate([0, 0, wheel_clip_height]) cube([wheel_clip_gap, wheel_clip_depth, wheel_clip_height], true);
			translate([0, wheel_clip_depth, wheel_clip_height / 2]) cube([wheel_clip_width_max, wheel_clip_depth, wheel_clip_height], true);
			translate([0, -wheel_clip_depth, wheel_clip_height / 2]) cube([wheel_clip_width_max, wheel_clip_depth, wheel_clip_height], true);
		}
	
		union() {
			translate([(wheel_clip_width_max / 2) + (wheel_clip_gap / 2), 0, 0]) cylinder(r=wheel_clip_width_max / 2, h=wheel_clip_height);
			translate([-((wheel_clip_width_max / 2) + (wheel_clip_gap / 2)), 0, 0]) cylinder(r=wheel_clip_width_max / 2, h=wheel_clip_height);
		}
	}
	
	translate([0, 0, wheel_clip_height / 3 / 2]) cube([wheel_clip_width_min, wheel_clip_depth, wheel_clip_height / 3], true);
}

module cylinder_rounded_on_one_end(h, r, edge_radius) {
	intersection() {
		minkowski() {
			translate([0, 0, edge_radius]) cylinder(r=r - edge_radius, h=h - edge_radius);
			sphere(r=edge_radius);
		}

		cylinder(r=r, h=h);
	}
}

module solid_wheel() {
    difference() {
        cylinder_rounded_on_one_end(h=wheel_outer_height, r=wheel_diameter / 2, edge_radius=wheel_edge_radius);
        
        // Gap.
	difference() {
		cylinder(r=(wheel_diameter / 2) - wheel_outer_width, h=wheel_groove_depth);
		cylinder(r=(wheel_diameter / 2) - wheel_outer_width - wheel_groove_width, h=wheel_groove_depth);
	}
    }
}