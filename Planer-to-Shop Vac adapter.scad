use <module-funnel.scad>;

// The inner diameter of the large end of the adapter. This is the outer diameter of the larger of the two hoses you're connecting.
param_from = 102.75;

// The inner diameter of the small end of the adapter. This is the outer diameter of the smaller of the two hoses you're connecting.
param_to = 30.75;

// The total height of the adapter.
param_height = 60;

// The thickness of the adapter walls.
param_wall_thickness = 2;

// The height of each of the top and bottom vertical bands of the adapter.
param_band_height = 10;

$fa = 1;
$fs = 1;

funnel(from=param_from, to=param_to, height=param_height, wall_thickness=param_wall_thickness, band_height=param_band_height);