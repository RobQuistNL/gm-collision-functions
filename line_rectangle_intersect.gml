///@param box_x1
///@param box_y1
///@param box_x2
///@param box_y2
///@param line_x1
///@param line_y1
///@param line_x2
///@param line_y2

var xmin = argument0;
var ymin = argument1;
var xmax = argument2;
var ymax = argument3;
var x0 = argument4;
var y0 = argument5;
var x1 = argument6;
var y1 = argument7;

if (xmin > xmax) { show_debug_message("err x1 x2"); }
if (ymin > ymax) { show_debug_message("err x1 y2"); }


// compute outcodes for P0, P1, and whatever point lies outside the clip rectangle
var outcode0 = get_outcode(x0, y0, xmin, xmax, ymin, ymax);
var outcode1 = get_outcode(x1, y1, xmin, xmax, ymin, ymax);
var accept = false;

while (true) {
	if (!(outcode0 | outcode1)) {
		// bitwise OR is 0: both points inside window; trivially accept and exit loop
		accept = true;
		break;
	} else if (outcode0 & outcode1) {
		// bitwise AND is not 0: both points share an outside zone (LEFT, RIGHT, TOP,
		// or BOTTOM), so both must be outside window; exit loop (accept is false)
		break;
	} else {
		// failed both tests, so calculate the line segment to clip
		// from an outside point to an intersection with clip edge
		var __x, __y;

		// At least one endpoint is outside the clip rectangle; pick it.
		var outcodeOut = outcode0 ? outcode0 : outcode1;

		// Now find the intersection point;
		// use formulas:
		//   slope = (y1 - y0) / (x1 - x0)
		//   x = x0 + (1 / slope) * (ym - y0), where ym is ymin or ymax
		//   y = y0 + slope * (xm - x0), where xm is xmin or xmax
		// No need to worry about divide-by-zero because, in each case, the
		// outcode bit being tested guarantees the denominator is non-zero
		if (outcodeOut & _TOP) {           // point is above the clip window
			__x = x0 + (x1 - x0) * (ymax - y0) / (y1 - y0);
			__y = ymax;
		} else if (outcodeOut & _BOTTOM) { // point is below the clip window
			__x = x0 + (x1 - x0) * (ymin - y0) / (y1 - y0);
			__y = ymin;
		} else if (outcodeOut & _RIGHT) {  // point is to the right of clip window
			__y = y0 + (y1 - y0) * (xmax - x0) / (x1 - x0);
			__x = xmax;
		} else if (outcodeOut & _LEFT) {   // point is to the left of clip window
			__y = y0 + (y1 - y0) * (xmin - x0) / (x1 - x0);
			__x = xmin;
		}

		// Now we move outside point to intersection point to clip
		// and get ready for next pass.
		if (outcodeOut == outcode0) {
			x0 = __x;
			y0 = __y;
			outcode0 = get_outcode(x0, y0, xmin, xmax, ymin, ymax);
		} else {
			x1 = __x;
			y1 = __y;
			outcode1 = get_outcode(x1, y1, xmin, xmax, ymin, ymax);
		}
	}
}

return accept;
