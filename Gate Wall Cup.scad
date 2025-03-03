rod_diameter = 30;

module wall_cup(rod_diameter=0) {
    $fs = 1;
    $fa = 1;
    cup_height = 10;
    
    difference() {
        cylinder(
            r1=( rod_diameter / 2 ) + 10,
            r2=( rod_diameter / 2 ) + 8,
            h = cup_height
        );
        
        translate([0, 0, 5])
            cylinder(
                r1=( rod_diameter / 2 ) + 2,
                r2=( rod_diameter / 2 ) + 5,
                h = cup_height
            );
        
        cylinder(r=3, h=cup_height);
        
        translate([0, 0, 2]) cylinder(r1=3, r2=5, h=3);
    }
}

wall_cup(rod_diameter=rod_diameter);
