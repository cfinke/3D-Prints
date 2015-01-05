/**
 * Original script from http://www.thingiverse.com/thing:28882
 */

// Text for the cutter.
cutter_text = "J";

// Height of the cutter in mm.
cutter_size = 64;

// Font to use for the cutter, in the style "<Font Name>:style=<Font Style>". See http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Text#Using_fonts
cutter_font = "Arial Black:style=Bold";

// Thickness of the cutter in mm.
cutter_thickness = 1.75;

// Height of the flange in mm.
flange_height = 2;

// Height of the cutter in mm, in addition to the flange height.
cutter_height = 10;

// Width of the flange in mm.
flange_width = 6;

cutterMinimum = 1;

mirror([1, 0, 0]) {
    minkowski() {
            outline();
            cylinder(r1 = cutter_thickness / 3, r2 = cutterMinimum / 3, h = cutter_height);
    };
    
    flange();
};

module flange() {
	difference() {
		minkowski() {
			baseShape(h=flange_height / 3);
			cylinder(r = flange_width, h = flange_height / 3);
		};

		translate([0, 0, -0.01]) baseShape(h=flange_height * 1.1);
	};
}

module outline() {
	difference() {
		minkowski() {
			baseShape(h=flange_height / 3);
			cylinder(r = cutterMinimum / 3, h=flange_height / 3);
		}

		translate([0, 0, -0.01]) baseShape(h=flange_height * 1.1);
	};
};

module baseShape(h) {
	linear_extrude(height=h) text(text=cutter_text, size=cutter_size, font=cutter_font);
}
