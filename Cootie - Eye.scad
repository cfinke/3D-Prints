$fa = 1;
$fs = 1;

eye_width_widest = 7.6;
eye_thickness = 1.5;
eye_round_radius = 4.3;
eye_length = 9.7;

pupil_offset = 1;
iris_width = 1.25;
iris_radius = 2.5;

peg_base_width = 2.5;
peg_tip_width = 2;
peg_height = 12;

color( "yellow") union() {
	linear_extrude(eye_thickness) union() {
		difference() {
			union() {
				translate([(eye_length-(eye_round_radius * 2))/2,0,0]) resize(newsize=[eye_round_radius * 2, eye_width_widest, 0]) circle(r=100);
				resize(newsize=[eye_length, eye_width_widest, 0]) circle(r=100);
			}
	
			translate([pupil_offset,0,0]) resize(newsize=[iris_radius * 2, iris_radius * 2, 0]) circle(r=100);
		}
	
		translate([pupil_offset, 0, 0]) resize(newsize=[(iris_radius - iris_width) * 2, (iris_radius - iris_width) * 2, 0]) circle(r=100);
		translate([-iris_radius+pupil_offset, -iris_radius, 0]) square([iris_radius,iris_radius * 2]);
	}
	
	translate([1, 0, eye_thickness]) cylinder(r1=peg_base_width / 2, r2=peg_tip_width / 2, h=peg_height, $fn=20);
}