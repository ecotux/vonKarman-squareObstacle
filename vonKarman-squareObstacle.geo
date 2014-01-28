
scale = 0.001;

lc1 = 20 ; // mesh at the border of the windtunnel
lc2 = 5 ; // mesh at the border of the internal structure
lc = 2 ; // mesh at the obstacle

diam = 100 ; // width of the obstacle


// Internal Obstacle: square pipe

rad = diam/2;

Point (1) = {-rad * scale, rad * scale, 0 * scale, lc * scale} ;
Point (2) = {rad * scale, rad * scale, 0 * scale, lc * scale} ;
Point (3) = {rad * scale, -rad * scale, 0 * scale, lc * scale} ;
Point (4) = {-rad * scale, -rad * scale, 0 * scale, lc * scale} ;

Line (1) = {1, 2} ;
Line (2) = {2, 3} ;
Line (3) = {3, 4} ;
Line (4) = {4, 1} ;

Line Loop(1) = {2, 3, 4, 1};


// Wind Tunnel

p10 = newp;

H2 = 12 * diam /2;
W1 = 10 * diam /2;
W2 = 60 * diam /2;

Point(p10+1) = {-W1 * scale,  H2 * scale, 0 * scale, lc1 * scale};
Point(p10+2) = { W2 * scale,  H2 * scale, 0 * scale, lc1 * scale};
Point(p10+3) = { W2 * scale, -H2 * scale, 0 * scale, lc1 * scale};
Point(p10+4) = {-W1 * scale, -H2 * scale, 0 * scale, lc1 * scale};

Line(1200) = {p10+1, p10+2};
Line(1201) = {p10+2, p10+3};
Line(1202) = {p10+3, p10+4};
Line(1203) = {p10+4, p10+1};

Line Loop(2) = {1201, 1202, 1203, 1200};


// An internal curve is defined to have a better structured mesh

radint = 4*diam/2;

p11 = newp;

Point (p11+1) = {radint * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (p11+2) = {-radint * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (p11+3) = {3.5*radint * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (p11+4) = {radint * scale, -1.5*radint * scale, 0 * scale, lc * scale} ;
Point (p11+5) = {radint * scale, 1.5*radint * scale, 0 * scale, lc * scale} ;

Ellipse (201) = {p11+3, p11+1, p11+2, p11+5} ;
Ellipse (202) = {p11+5, p11+1, p11+2, p11+2} ;
Ellipse (203) = {p11+2, p11+1, p11+2, p11+4} ;
Ellipse (204) = {p11+4, p11+1, p11+2, p11+3} ;

Line Loop(3) = {204, 201, 202, 203};

// Internal Space is defined

Plane Surface(1204) = {2, 3};
Plane Surface(1205) = {1, 3};

Extrude {0, 0, 1000*scale} {
	Surface{1204};
	Layers{1};
	Recombine;
}
Extrude {0, 0, 1000*scale} {
	Surface{1205};
	Layers{1};
	Recombine;
}

Physical Volume("internal") = {1, 2};

Physical Surface("obstacle") = {1260, 1272, 1268, 1264};
Physical Surface("inlet") = {1226};
Physical Surface("outlet") = {1218};
Physical Surface("upperWall") = {1230};
Physical Surface("lowerWall") = {1222};

