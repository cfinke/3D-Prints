/**
 * A foot for a small light-up Christmas tree.
 */

$fs = 1;
$fa = 1;

body_length = 104;
body_height_max = 28.7;

edge_width_max = 8.65;
edge_width_min = 4;

border_height = 1.7;
interior_thickness = 1.6;

foot_thickness = 5.2;
foot_offset = 2.25;
foot_depth = 2.1;

toe_width = 5.9;
toe_length = 9;
toe_thickness = 1.7;
toe_vertical_offset = 1.7;

body_flat_length = 26.8;

rounded_corner_radius = 9;
rounded_cutout_radius = 145;

supporting_curve_radius_max = (edge_width_max - interior_thickness) / 2;
supporting_curve_radius_min = (edge_width_min - interior_thickness) / 2;

module foot_profile(length, height, corner_radius, flat_length) {
	difference() {
		hull() {
			square([flat_length, height]);
			translate([length - corner_radius, 0, 0]) intersection() {
				circle(r=corner_radius);
				square(corner_radius);
			}
		}

		translate([body_length, corner_radius + rounded_cutout_radius, 0]) circle(r=rounded_cutout_radius);
	}
}

module foot() {
    // The interior body.
    translate([0, 0, -interior_thickness / 2]) linear_extrude(interior_thickness) {
            foot_profile(body_length, body_height_max, rounded_corner_radius, body_flat_length);
    }

    // The foot.
    translate([0, 0, -foot_thickness / 2]) linear_extrude(foot_thickness) union() {
        square([foot_depth, body_height_max]);
        translate([foot_depth + foot_offset, 0, 0]) square([foot_depth, body_height_max]);
    }
    
    translate([body_length - (toe_length / 3), -toe_vertical_offset, 0]) union() {
        // The "ankle."
        translate([0, 0, -edge_width_min / 2]) linear_extrude(edge_width_min) square([toe_length / 3, toe_vertical_offset]);
        // The "toe."
        translate([(toe_length / 3 / 2), 0, 0]) rotate([90, 0, 0]) linear_extrude(toe_thickness) resize([toe_length, toe_width]) circle(r=toe_length / 2);
    }

    // The flared top edge and curver underside.
    for (i = [0 : 0.5 : supporting_curve_radius_max]) {
        translate([0, -i, 0]) difference() {
                intersection() {
                        translate([0, 0, -edge_width_max / 2]) linear_extrude(edge_width_max) {
                                foot_profile(body_length, body_height_max, rounded_corner_radius, body_flat_length);
                        }

                        assign(profile_max = (supporting_curve_radius_max - (supporting_curve_radius_max * (i / supporting_curve_radius_max))) * 2 + interior_thickness, profile_min = (supporting_curve_radius_min - (supporting_curve_radius_min * (i / supporting_curve_radius_max))) * 2 + interior_thickness) {
                            translate([0, body_height_max, 0]) rotate([90, 0, 0]) linear_extrude(body_height_max) polygon(points=[[foot_depth + foot_offset, profile_max / 2], [body_length, profile_min / 2], [body_length, -profile_min / 2], [foot_depth + foot_offset, -profile_max / 2]]);
                        }
                }

                // Position another extruded profile $border_height below so that the thickness of the top border is always at least $border_height.
                translate([0, -border_height, -edge_width_max / 2]) linear_extrude(edge_width_max) foot_profile(body_length - border_height, body_height_max, rounded_corner_radius, body_flat_length);
        }
    }
    
    // The flared bottom edge.
    translate([0, border_height, 0]) rotate([90, 0, 0]) linear_extrude(border_height) polygon(points=[
            [0, foot_thickness / 2],
            [foot_offset + foot_depth, foot_thickness / 2],
            [body_length, edge_width_min / 2],
            [body_length, -edge_width_min / 2],
            [foot_offset + foot_depth, -foot_thickness / 2],
            [0, -foot_thickness / 2],
            ]);
}

foot();

module printable_foot_base() {
    rotate([90, 0, 0]) intersection() {
        foot();
        translate([0, 0.000001, -body_length * 5]) cube([body_length * 10, body_length * 10, body_length * 10]);
    }
}

module printable_foot_toe() {
    translate([toe_length * 2, 0, toe_vertical_offset + toe_thickness]) rotate([90, 0, 0]) intersection() {
        foot();
        translate([0, -((body_length * 10)+0.01), -body_length * 5]) cube([body_length * 10, body_length * 10, body_length * 10]);
    }
}
