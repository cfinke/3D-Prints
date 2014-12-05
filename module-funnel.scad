module funnel(from, to, height, wall_thickness, band_height) {
	// Bottom band.
	difference() {
		cylinder(r=(from/2)+wall_thickness, h=band_height);
		cylinder(r=(from/2), h=band_height);
	}

	// Funnel.
	translate([0, 0, band_height]) difference() {
		cylinder(r1=(from/2)+wall_thickness, r2=(to/2)+wall_thickness, h=height-(2*band_height));
		cylinder(r1=(from/2), r2=(to/2), h=height-(2*band_height));
	}

	// Top band.
	translate([0, 0, height-band_height]) difference() {
		cylinder(r=(to/2)+wall_thickness, h=band_height);
		cylinder(r=(to/2), h=band_height);
	}
}