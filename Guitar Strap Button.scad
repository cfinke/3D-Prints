/**
 * Strap button for a child's guitar. 13mm tall, ~15mm wide at the widest.
 */

$fa = 1;
$fs = 1;

module strap_button() {
	current_height = 0;

	difference() {
		union() {
			// Bottom ridge
			translate([0, 0, current_height]) cylinder(r=5.4, h=1.8);
		
			assign(current_height = current_height + 1.8) {
			
				// Thin part.
				translate([0, 0, current_height]) cylinder(r=3.75, h=5.5);
				assign(current_height = current_height + 5.5) {
					translate([0, 0, current_height]) cylinder(r1=3.75, r2=7.4, h=2.9);
					assign(current_height = current_height + 2.9) {
						translate([0, 0, current_height]) difference() {
							scale([1, 1, .23]) sphere(r=7.4);
							translate([0, 0, -7.4]) cube([14.8, 14.8, 14.8], true);
						};
					};
					
				};
			};
		}

		cylinder(r=2.05, h=13);
		translate([0, 0, 9.1]) cylinder(r=3.45, h=3);
	};
}

strap_button();