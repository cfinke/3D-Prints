$fs = .5;
$fa = 0.05;

clip_z = 6;

round_clip_radius_outer = 6.6;
round_clip_radius_inner = 4;

round_clip_opening_angle = 66;
round_clip_pins_x = 10;
round_clip_pins_y = 2;

long_clip_offset_x = 3;
long_clip_offset_y = 2.4 + round_clip_radius_outer;

long_clip_radius_outer = 5.5;
long_clip_radius_inner = 2.25;

long_clip_pins_x = 11.5;
long_clip_pins_y = 3;
long_clip_pins_gap = 3.1;

module pie_slice(r=3.0, a=30) {
	intersection() {
		circle(r=r);
		square(r);
		rotate(a-90) square(r);
	}
}

linear_extrude(clip_z) {
	difference() {
		union() {
			difference() {
				union() {
					circle(r=round_clip_radius_outer);
					translate([0, round_clip_pins_x/2, 0]) square([round_clip_pins_x,round_clip_pins_y], true);
				}

				circle(r=round_clip_radius_inner);
				rotate([0, 0, (90-(round_clip_opening_angle/2))]) pie_slice(r=round_clip_radius_outer + round_clip_pins_y, a=round_clip_opening_angle);
			};

			translate([long_clip_offset_x, -long_clip_offset_y, 0]) {
				difference() {
					union() {
						difference() {
							circle(r=long_clip_radius_outer);
							translate([-long_clip_radius_outer/2, 0, 0]) square([long_clip_radius_outer, long_clip_pins_gap], true);
						}
				
						translate([-11/2, 0, 0] ) {
							translate([0, -4.55+(long_clip_pins_y/2), 0]) square([long_clip_pins_x,long_clip_pins_y], true);
							translate([0, 4.55-(long_clip_pins_y/2), 0]) square([long_clip_pins_x,long_clip_pins_y], true);
							translate([-5, -4.55, 0]) rotate([0, 0, 90]) polygon(points=[ [0, 0], [3.9, 0], [3.3, 2.9], [0, 2.9] ]);
							mirror([0, 1, 0]) translate([-5, -4.55, 0]) rotate([0, 0, 90]) polygon(points=[ [0, 0], [3.9, 0], [3.3, 2.9], [0, 2.9] ]);
						}

					}

					circle(r=long_clip_radius_inner);

				}

				translate([1.5, 1.25+(2.3/2), 0]) square([2.5, 2.5], true);
				translate([1.5, -(1.25+(2.3/2)), 0]) square([2.5, 2.5], true);
			}
		}

		circle(r=3.75);
	}

}