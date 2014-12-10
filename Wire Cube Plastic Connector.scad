width = 39;
height = 26;
wall_width = 2.9;
horizontal_wall_width = 2.2;
base_height = 2.9;
shelf_gap = 5.1;
shelf_ridge_gap = 4;
center_support_width = 9.5;
base_bulge_radius = 4 * height;
ridge_radius = (shelf_gap - shelf_ridge_gap) / 2;
ridge_count = 11;
ridge_offset = 2.5; // Distance from top that ridges start.
$fa = 1;
$fs = 1;

module wire_cube_plastic_connector()  {
	intersection() {
		translate([0, 0, -height]) cylinder(r=width/2, h=2*height);
		union() {
			difference() {
				union() {
					translate([0, 0, height / 2]) cube([shelf_gap + (2*wall_width), width, height], true);
					translate([0, 0, height / 2]) cube([width, shelf_gap + (2*wall_width), height], true);
					cylinder(r=width/2, h=base_height);
	
					translate([0, 0, base_height + shelf_gap]) cylinder(r=width / 2, h=horizontal_wall_width);
	
					// The ridges on either side of the base shelf openings.
					intersection() {
						cylinder(r=width/2 - ridge_offset, h=height);
						translate([0, 0, base_height]) rotate([90, 0, 0]) ridges();
					};
	
					intersection() {
						cylinder(r=width/2 - ridge_offset, h=height);
						mirror([0, 1, 0]) translate([0, 0, base_height]) rotate([90, 0, 0]) ridges();
					}
			
					intersection() {
						cylinder(r=width/2 - ridge_offset, h=height);
						translate([0, 0, shelf_gap]) translate([0, 0, base_height]) rotate([90, 0, 0]) ridges();
					}
	
					intersection() {
						cylinder(r=width/2 - ridge_offset, h=height);
						translate([0, 0, shelf_gap]) mirror([0, 1, 0]) translate([0, 0, base_height]) rotate([90, 0, 0]) ridges();
					}
				}
				union() {
					translate([0, 0, (height / 2)+base_height+shelf_gap]) cube([shelf_gap, width, height], true);
					translate([0, 0, (height / 2)+base_height+shelf_gap]) cube([width, shelf_gap, height], true);
				}
			}
	
			translate([0, shelf_gap / 2, 0]) ridges();
			mirror([0, 1, 0]) translate([0, shelf_gap / 2, 0]) ridges();
	
			rotate([0, 0, 90]) translate([0, shelf_gap / 2, 0]) ridges();
			rotate([0, 0, 90]) mirror([0, 1, 0]) translate([0, shelf_gap / 2, 0]) ridges();
	
			difference() {
				translate([0, 0, (height / 2)]) cube([center_support_width, center_support_width, height], true);
				translate([0, 0, base_height]) cylinder(r=center_support_width / 4, h=height);
			}
	
			// Bottom bump radius.
			// Uncomment to add a 2mm rounded bottom. Not functionally necessary, and a pain to print.
			/*
			intersection() {
				translate([0, 0, -2]) cylinder(r=width/2, h=2);
				translate([0, 0, base_bulge_radius-2]) sphere(r=base_bulge_radius, $fn = 300);
			}
			*/
		};
	}
}

module ridges() {
	translate([-width / 2, 0, 0]) for (column = [1 : ridge_count]) {
			translate([(column - 0.5) * (width / ridge_count), 0, 0]) cylinder(r=ridge_radius,h=height - ridge_offset, $fn=20);
		}
}

wire_cube_plastic_connector();