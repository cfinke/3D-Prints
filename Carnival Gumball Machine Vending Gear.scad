// Thickness of the gear teeth. Factory default is 4.5.
tooth_thickness = 6;

// Length of the shaft, not including the part that runs through the teeth. Default 5.
shaft_height = 7.5;

// Outer diameter of the shaft.
shaft_diameter = 16;

// Inner diameter of the shaft (or diameter of the screw).
screw_diameter = 4.5;

// The length of the screw (ignoring the head) that can be inside the gear.
screw_length = 8; 

// Diameter of the countersink for the screw head.
screw_countersink_diameter = 11;

tooth_count = 9;
tooth_width = 4.5;
tooth_length = 9.4;
teeth_diameter = 37;
screw_countersink_depth = tooth_thickness + shaft_height - screw_length;

round_inner_tooth_part_diameter = 19.3;

knob_round_diameter = 12;
knob_round_penetration = 3;

knob_square_width = 8;
knob_square_penetration = 4;

$fs = .5;
$fa = .5;

rotate([180,0,0]) difference() {
    union() {
        // The gear shaft.
        cylinder( d=shaft_diameter, h=tooth_thickness + shaft_height );
        
        
        translate( [0, 0, shaft_height] ) {
            cylinder( d = round_inner_tooth_part_diameter, h=tooth_thickness );
        
            for ( i = [0:9]) {
                rotate([0, 0, 360 / tooth_count * i]) translate([0, -tooth_width / 2, 0]) {
                    cube([teeth_diameter / 2 - ( tooth_width / 2 ), tooth_width, tooth_thickness]);
                    translate([teeth_diameter / 2 - tooth_width / 2,tooth_width / 2,0]) cylinder( d=tooth_width, h=tooth_thickness);
                }
            }
        }
    }
    
    // The hole for the screw.
    cylinder( d=screw_diameter, h=tooth_thickness + shaft_height );
    
    // The countersink for the screw head.
    translate([0, 0, screw_length]) cylinder( d=screw_countersink_diameter, h=screw_countersink_depth );
    
    // The inset for the round part of the knob.
    cylinder( d = knob_round_diameter, h = knob_round_penetration );
    
    translate([0,0,(knob_round_penetration + knob_square_penetration)/2]) cube([knob_square_width, knob_square_width, knob_round_penetration + knob_square_penetration ], true);
}
    




