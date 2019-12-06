///@param box_x1
///@param box_y1
///@param box_z1
///@param box_x2
///@param box_y2
///@param box_z2
///@param sphere_x
///@param sphere_y
///@param sphere_z
///@param sphere_r(squared)

var xmin = argument0;
var ymin = argument1;
var zmin = argument2;
var xmax = argument3;
var ymax = argument4;
var zmax = argument5;
var cx = argument6;
var cy = argument7;
var cz = argument8;
var cr = argument9;

if (xmin > xmax) { show_debug_message("err x1 x2"); }
if (ymin > ymax) { show_debug_message("err y1 y2"); }
if (zmin > zmax) { show_debug_message("err z1 z2"); }

var dmin = 0;

if( cx < xmin ) dmin += sqr( cx - xmin ); else if( cx > xmax ) dmin += sqr( cx - xmax );
if( cy < ymin ) dmin += sqr( cy - ymin ); else if( cy > ymax ) dmin += sqr( cy - ymax );
if( cz < zmin ) dmin += sqr( cz - zmin ); else if( cz > zmax ) dmin += sqr( cz - zmax );

return ( dmin <= cr );
