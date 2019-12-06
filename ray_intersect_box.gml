var rayOrigin = argument0; //[x, y, z]
var rayDirection = argument1; //[x, y, z] (not normlized, just the endpoint of the ray. Should be called "rayTarget")
var boxMin = argument2; //[x, y, z] min of AABB
var boxMax = argument3; //[x, y, z] max of AABB

var rox = rayOrigin[0];
var roy = rayOrigin[1];
var roz = rayOrigin[2];

var rdx = rayDirection[0] - rox;
var rdy = rayDirection[1] - roy;
var rdz = rayDirection[2] - roz;

// r.dir is unit direction vector of ray
var dirfracx = 1/rdx;
var dirfracy = 1/rdy;
var dirfracz = 1/rdz;

// lb is the corner of AABB with minimal coordinates - left bottom, rt is maximal corner
// r.org is origin of ray
var t1 = (boxMin[0] - rox)*dirfracx;
var t2 = (boxMax[0] - rox)*dirfracx;
var t3 = (boxMin[1] - roy)*dirfracy;
var t4 = (boxMax[1] - roy)*dirfracy;
var t5 = (boxMin[2] - roz)*dirfracz;
var t6 = (boxMax[2] - roz)*dirfracz;

var tmin = max(max(min(t1, t2), min(t3, t4)), min(t5, t6));
var tmax = min(min(max(t1, t2), max(t3, t4)), max(t5, t6));

// if tmax < 0, ray (line) is intersecting AABB, but the whole AABB is behind us
if (tmax < 0) {
    return false;
}

// if tmin > tmax, ray doesn't intersect AABB
if (tmin > tmax) {
    return false;
}

return point_distance_3d(rox, roy, rayOrigin[2], rox+rdx*tmin, roy+rdy*tmin, roz+rdz*tmin); // Returns distance from origin to intersection point
