module air_hockey_puck(diameter=70, height=4.75) {
    difference() {
        cylinder(r=diameter/2, h=height, $fs=1, $fa=1);
        translate([0, 0, height - 1]) cylinder(r=diameter/2*.88, h=1.01, $fs=1, $fa=1);
    }
}


air_hockey_puck(diameter=58);