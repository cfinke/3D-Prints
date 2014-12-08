max_dimension = 37;

intersection() {
	// Side profile.
	translate([0, 0, -max_dimension]) linear_extrude(max_dimension*2) polygon(points=[
		[0, 0], // Tip of toe.
		[7.9,0], // Back of heel
		[13.15, 27.8], // Under knee
		[18.8, 25.75], // Bottom of post-knee joint
		[25,27.3], // Bottom back of leg.
		[25, 30], // Bottom of beginning of peg
		[33, 30], // Bottom of end of peg.
		[33, 33], // Top of end of peg.
		[25, 33], // Top of beginning of peg.
		[25, 35.8], // Top of back of leg.
		[18.5, 34.35], // Top of post-knee joint.
		[8.1, 37.15], // Top of knee
		[4, 4.3], // Top of ankle
		[.75, 3] // Top of toe
	]);

	// Front profile.
	rotate([0, 90, 0]) linear_extrude(max_dimension*2) polygon(points=[
		[0, 0], // Tip of toe.
		[2.85, 0], // Side of foot.
		[2,4.3], // Back of heel
		[2.9, 27.8], // Under knee
		[2.8, 29], // Under knee
		[2.7, 31], // Under knee
		[2.6, 33], // Under knee
		[2, 35],
		[0, 37.15], // Top of knee
		[-2, 35],
		[-2.6, 33], // Under knee
		[-2.7, 31], // Under knee
		[-2.8, 29], // Under knee
		[-2.9, 27.8], // Under knee
		[-2,4.3], // Back of heel
		[-2.85, 0], // Side of foot.
	]);

	// Top profile.
	translate([0, max_dimension, 0]) rotate([90, 0, 0]) linear_extrude(max_dimension*2) polygon(points=[
		[0, 0], // Tip of toe.
		[1, 2], // Tip of toe.
		[2, 2.8], // Tip of toe.
		[6, 2.8], // Tip of toe.
		[7, 2.78], // Tip of toe.
		[7.9,2.75], // Back of heel
		[13.15, 2.9], // Under knee
		[18.8, 2.9], // Bottom of post-knee joint
		[25,2.9], // Bottom back of leg.
		[25, 1.75], // Bottom of beginning of peg
		[33, 1.75], // Bottom of end of peg.
		[33, 0], // Bottom of end of peg.
		[33, -1.75], // Bottom of end of peg.
		[25, -1.75], // Bottom of beginning of peg
		[25,-2.9], // Bottom back of leg.
		[18.8, -2.9], // Bottom of post-knee joint
		[13.15, -2.9], // Under knee
		[7.9,-2.75], // Back of heel
		[7, -2.78], // Tip of toe.
		[6, -2.8], // Tip of toe.
		[2, -2.8], // Tip of toe.
		[1, -2], // Tip of toe.
	]);
}