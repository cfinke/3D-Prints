/**
 * A square funnel, originally for a bird feeder shaped like a barn where you added birdseed through the chimney.
 */

// I took measurements in inches, so the 25.4 is for converting to mm.

bottom_height = 1.5 * 25.4;
bottom_width = 1.375 * 25.4;
bottom_depth = 1.375 * 25.4;

top_height = 3 * 25.4;
top_width = 5 * 25.4;

funnel_thickness = 2;
corner_radius = 2;

difference() {
	minkowski() {
		union() {
			linear_extrude( bottom_height ) {
				square( [ bottom_width - ( funnel_thickness * 2 ), bottom_depth - ( funnel_thickness * 2 ) ], center = true );
			}

			translate( [ 0, 0, bottom_height ] ) {
				pyramid( base_width = top_width - ( funnel_thickness * 2 ), top_width = bottom_width - ( funnel_thickness * 2 ), height = top_height );
			}
		}

		sphere( r = corner_radius ); // This makes the funnel corner_radius mm thicker everywhere.
	}

	// Remove the inside of the bottom portion.
	linear_extrude( bottom_height ) {
		square(
			[ bottom_width - ( funnel_thickness - corner_radius ) * 2 - ( funnel_thickness * 2 ), bottom_depth - ( funnel_thickness - corner_radius ) * 2 - ( funnel_thickness * 2 ) ], center = true );
	}

	// Remove the inside of the top portion.
	translate( [ 0, 0, bottom_height ] ) {
		pyramid( base_width = top_width - ( 2 * ( funnel_thickness - corner_radius ) ) - ( funnel_thickness * 2 ), top_width = bottom_width - ( 2 * ( funnel_thickness - corner_radius ) ) - ( funnel_thickness * 2 ), height = top_height );
	}

	// Cut off the bottom.
	translate( [ 0, 0, -100 ] ) linear_extrude( 100 ) {
		square( [ bottom_width * 2, bottom_width * 2 ], center = true );
	}

	// Cut off the top.
	translate( [ 0, 0, bottom_height + top_height ] ) linear_extrude( 100 ) {
		square( [ top_width * 2, top_width * 2 ], center = true );
	}
}

module pyramid( base_width, top_width, height ) {
	polyhedron(
		points = [
			[ top_width / 2, top_width / 2, 0 ],
			[ -top_width / 2, top_width / 2, 0 ],
			[ -top_width / 2, -top_width / 2, 0 ],
			[ top_width / 2, -top_width / 2, 0 ],

			[ base_width / 2, base_width / 2, height ],
			[ -base_width / 2, base_width / 2, height ],
			[ -base_width / 2, -base_width / 2, height ],
			[ base_width / 2, -base_width / 2, height ],
		],
		faces = [
			[ 0, 4, 5, 1 ],
			[ 1, 5, 6, 2 ],
			[ 2, 6, 7, 3 ],
			[ 3, 7, 4, 0 ],

			[ 7, 6, 5, 4 ],
			[ 0, 1, 2, 3 ],
		]
	);
}