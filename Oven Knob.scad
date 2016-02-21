// The total height of the knob.
knob_height = 15;

// The outer diameter of the knob.
knob_diameter = 24;

// The height of the part of the knob base that is totally vertical.
knob_base_cylinder_height = 3;

// If you want the inside of the bottom of the knob to be a hollowed out cone, you can set the height of the hollow.
knob_base_inset_height = 3;

// The height of the rounded top of the knob base.
knob_base_rounded_height = 2;

// The width of the knob handle.
knob_handle_thickness = 4;

// The width of the pin at its widest point.
pin_diameter = 6.5;

// The width of the pin, perpendicular from the flat side(s)
pin_diameter_flat = 5.3;

// The height of the pin.
pin_height = 8;

// The knob is parallel with the flat side of the pin by default, but you can specify an arbitrary rotation.
knob_handle_rotation = 0;

// Does the pin have two flat sides?
pin_double_sided = "no"; // [yes:Yes, no:No]

// Depending on your printer and your filament, the plastic may shrink after printing. Use this variable to increase the size of the peg hole radius in case it shrinks more than a tolerable amount.
shrinkage_allowance = 0.25;

module knob(
    knob_height=0, 
    knob_diameter=0,
    knob_base_cylinder_height=0,
    knob_base_rounded_height=0,
    knob_handle_thickness=0,
    pin_diameter=0,
    pin_diameter_flat=0,
    pin_height=0,
    knob_handle_rotation=0,
    pin_double_sided="no",
    knob_base_inset_height=0,
    shrinkage_allowance=0) {

    real_knob_handle_thickness = max(knob_handle_thickness, pin_diameter + 1.5);
    real_pin_double_sided = (pin_double_sided == "yes" ? true : false);
    real_knob_base_inset_height = min( knob_base_inset_height, knob_base_cylinder_height + knob_base_rounded_height - 1 );
    // https://en.wikipedia.org/wiki/Spherical_cap
    sphere_radius = ( pow( knob_diameter / 2, 2 ) + pow( knob_base_rounded_height, 2 ) ) / ( 2 * knob_base_rounded_height );

    $fs = .5;
    $fa = .5;

    difference() {
        union() {
            // The base of the knob.
            cylinder(r=knob_diameter / 2, h=knob_base_cylinder_height);

            // The rounded top of the base of the knob.
            intersection() {
                translate([0, 0, -sphere_radius + knob_base_rounded_height + knob_base_cylinder_height])
                    sphere(r=sphere_radius, $fa = 1);
                translate([0, 0, knob_base_cylinder_height])
                    cylinder(r=knob_diameter / 2, h=knob_base_rounded_height);
            }
            
            // The handle.
            intersection() {
                rotate([0, 0, knob_handle_rotation]) translate([-real_knob_handle_thickness / 2, 0, 0]) rotate([0, 90, 0]) minkowski() {
                    cylinder(r=knob_height, h=real_knob_handle_thickness);
                    sphere(r=1);
                   }
                translate([0, 0, (knob_height+1)/2]) cube([knob_diameter, knob_diameter, knob_height+1], true);
               cylinder(r=knob_diameter / 2, h=knob_height+10);
            }
            
        }
        
        // The pin hole.
        translate([0, 0, real_knob_base_inset_height]) intersection() {
            cylinder(r=(pin_diameter / 2) + shrinkage_allowance, h=pin_height, $fs = .5);
            
            translate([0, 0, pin_height / 2]) {
                if (real_pin_double_sided) {
                    cube([pin_diameter_flat + (2 * shrinkage_allowance), (pin_diameter + (2 * shrinkage_allowance)), pin_height], true);
                }
                else {
                    translate([(pin_diameter - pin_diameter_flat) / 2, 0, 0])
                    cube([pin_diameter_flat + (2 * shrinkage_allowance), (pin_diameter + (2 * shrinkage_allowance)), pin_height], true);
                }
            }
        }
        
        cylinder(r1=knob_diameter/2-1, r2=pin_diameter/2+shrinkage_allowance, h=real_knob_base_inset_height);
    }
}

knob(
    knob_height=knob_height, 
    knob_diameter=knob_diameter,
    knob_base_cylinder_height=knob_base_cylinder_height,
    knob_base_rounded_height=knob_base_rounded_height,
    knob_handle_thickness=knob_handle_thickness,
    pin_diameter=pin_diameter,
    pin_diameter_flat=pin_diameter_flat,
    pin_height=pin_height,
    knob_handle_rotation=knob_handle_rotation,
    pin_double_sided=pin_double_sided,
    knob_base_inset_height=knob_base_inset_height,
    shrinkage_allowance=shrinkage_allowance
);