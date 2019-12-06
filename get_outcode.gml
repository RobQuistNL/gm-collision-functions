///@param x
///@param y

///@param xmin
///@param xmax
///@param ymin
///@param ymax

#macro _LEFT 1   // 0001
#macro _RIGHT 2  // 0010
#macro _BOTTOM 4 // 0100
#macro _TOP 8    // 1000

var code = 0; // 0000

var xmin = argument2;
var xmax = argument3;
var ymin = argument4;
var ymax = argument5;

if (argument0 < xmin)           // to the left of clip window
	code |= _LEFT;
else if (argument0 > xmax)      // to the right of clip window
	code |= _RIGHT;
if (argument1 < ymin)           // below the clip window
	code |= _BOTTOM;
else if (argument1 > ymax)      // above the clip window
	code |= _TOP;
	
return code;
