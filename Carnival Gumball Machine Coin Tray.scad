tray_diameter = 152;
tray_height = 30;
wall_thickness = 1.5;

center_diameter = 57;
center_height = 20;
center_gap_width = 10;
gap_width = 40;

$fs = 1;
$fa = 1;

intersection() {
    difference() {
        union() {
            difference() {
                union() {
                    cylinder( d = tray_diameter, h = tray_height );
                }
            
                translate( [0, 0, wall_thickness] ) cylinder( d = tray_diameter - ( 2 * wall_thickness ), h=tray_height );
            }


            translate([0,-(gap_width + (wall_thickness * 2))/2,0]) cube([tray_diameter/2,gap_width + (wall_thickness * 2), tray_height]);

        }
        
        translate([0,-gap_width/2,0]) cube([tray_diameter/2,gap_width, tray_height]);
        cylinder( d = center_diameter, h = tray_height );

    }
    
    cylinder( d = tray_diameter, h = tray_height );
}


difference() {
    cylinder( d = center_diameter + (wall_thickness * 2), h = center_height );
    cylinder( d = center_diameter, h = tray_height );
    translate([0,-center_gap_width/2,0]) cube([tray_diameter/2,center_gap_width, tray_height]);

}





