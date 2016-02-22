base_length = 19;
base_height = 13;
base_width = 19;

insert_thickness = 1.7;

module game_piece_base(
    base_length=0,
    base_height=0,
    base_width=0,
    insert_thickness=0
    ) {
        $fs = 1;
        edge_thickness = 1.2;
        
        linear_extrude(height=base_length) difference() {
            union() {
                square([edge_thickness, base_length]);
                
                rotate([0, 0, 90]) square([edge_thickness, base_height * .3]);
                translate([0, base_length - edge_thickness, 0])
                    rotate([0, 0, 90]) square([edge_thickness, base_height * .3]);
               
                translate([-base_height * .3, 0, 0]) rotate([0, 0, 45]) square([edge_thickness, sqrt( pow(base_height * .7, 2) * 2)]);

                translate([-base_height * .3, base_length, 0]) rotate([0, 0, -45]) translate([0, -sqrt( pow(base_height * .7, 2) * 2), 0]) square([edge_thickness, sqrt( pow(base_height * .7, 2) * 2)]);
                
                translate([-base_height, (base_width - ((insert_thickness * .85) + (2 * edge_thickness)))/ 2, 0]) square([base_height * .666, (insert_thickness * .85) + (2 * edge_thickness)]); 
                
                translate([0, edge_thickness, 0]) circle(r=edge_thickness);
                translate([0, base_width - edge_thickness, 0]) circle(r=edge_thickness);
                translate([-base_height * .333, (base_width / 2)-edge_thickness-(insert_thickness*.85/2), 0]) circle(r=edge_thickness);
                translate([-base_height * .333, (base_width / 2)+edge_thickness+(insert_thickness*.85/2), 0]) circle(r=edge_thickness);

                translate([-base_height + 3 * edge_thickness, (base_width / 2)-edge_thickness-(insert_thickness*.85/2), 0]) circle(r=edge_thickness);
                translate([-base_height + 3 * edge_thickness, (base_width / 2)+edge_thickness+(insert_thickness*.85/2), 0]) circle(r=edge_thickness);
            }
            
            translate([0, (base_width - (insert_thickness * .85)) / 2, 0]) rotate([0, 0, 90]) square([insert_thickness * .85, base_length]);
            
            diamond_cutout_hypotenuse = (edge_thickness * 2) + (insert_thickness * .85);
            diamond_cutout_side_length = sqrt( pow( diamond_cutout_hypotenuse, 2) / 2 );
            
            translate([-base_height, base_width / 2 - (diamond_cutout_hypotenuse/2), 0]) rotate([0, 0, 45]) square([diamond_cutout_side_length, diamond_cutout_side_length]);
        }
}

game_piece_base(
    base_length=base_length,
    base_height=base_height,
    base_width=base_width,
    insert_thickness=insert_thickness
);