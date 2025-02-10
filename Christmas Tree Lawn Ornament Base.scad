$fa = 1;

intersection() {
	translate([0, 0, -500]) cube([1000, 1000, 1000]);
	rotate_extrude() translate([330.5-3.125, 0, 0]) circle(r=3.125);
}

rotate([0, 0, 15]) translate([330.5, 0, 0]) hook();
rotate([0, 0, 45]) translate([330.5, 0, 0]) hook();
rotate([0, 0, 70]) translate([330.5, 0, 0]) hook();

translate([330.5-3.125, 0, -3.125]) end_peg();

rotate([0, 0, 90]) translate([330.5-3.125, 0, -3.125]) end_peg();

module hook() {
	cylinder(r=3.5/2, h=24.25);
	translate([-5, 0, 24.25]) intersection() {
		rotate([90, 0, 0]) rotate_extrude() translate([5, 0, 0]) circle(r=3.5/2);
		translate([0, 0, 50]) cube([100, 100, 100], true);
	}
	translate([-10, 0, 19.25]) cylinder(r=3.5/2, h=5);
}

module end_peg() {
	cylinder(r=3.125, h=30);
}