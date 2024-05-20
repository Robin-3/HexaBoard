// ========== EXECUTION ==========
s = 1.15;
r = 0.12;
h = .5;
mid = 0.4;
pin = 0.6;
size = 100;
i = 8;

// ========== SETUP ==========
// Set up variables
side = sqrt(6*sqrt(3));
// Set up vertices
P = [0,0];
H = [1/2*side, sqrt(6*sqrt(3)-9)/6*side];
O = [(sqrt(2*sqrt(3)-3)+3)/12*side, -(sqrt(3)-sqrt(6*sqrt(3)-9))/12*side];
N = [(1+sqrt(2*sqrt(3)-3))/4*side, (sqrt(6*sqrt(3)-9)+3*sqrt(7-4*sqrt(3))-6)/12*side];
F = [P[0], H[0]];
J = [H[0], H[1]-F[1]];
K = [H[0], -F[1]];
G = [H[0], F[1]];
I = [H[0], (3-2*sqrt(6*sqrt(3)-9))/6*side];
M = [(sqrt(2*sqrt(3))-sqrt(12-6*sqrt(3)))/4*side, (sqrt(4-2*sqrt(3))-sqrt(14*sqrt(3)-24)-2)/4*side];
B = -H;
Q = -O;
R = -N;
L = -F;
D = -J;
E = -K;
A = -G;
C = -I;
S = -M;

// Set up shapes
shape = [
    [ [A,B,Q,P,L], [A,B,L] ],
    [ [B,D,R,Q],   [B,R,[-H[0],H[1]],C] ],
    [ [R,F,P,Q],   [R,F] ],
    [ [D,E,F],     [F,E,R,S] ],
    [ [G,H,O,P,F], [G,H,F] ],
    [ [H,J,N,O],   [H,N,[-B[0],B[1]],I] ],
    [ [N,L,P,O],   [N,L] ],
    [ [J,K,L],     [L,K,N,M] ]
];


// ========== MODULES ==========
// Makes a polygon of the specified shape
module mypoly(i, h) {
  linear_extrude(height=h, center=true)
    polygon(shape[i][0]);
}

// Makes a cylinder at the specified vertex of a shape
module mycylinder(i, v, h, r, s=1, c=true) {
  translate(shape[i][1][v])
    scale([s, s, s])
        cylinder(h=h, r=r, center=c, $fn=100);
}

// Makes the specified shape, with correct hinges/etc.
module myshape(i) {
  difference() {
    union() {
      mypoly(i, h); // Base shape
      mycylinder(i, 0, h, r); // + 100% main in-hinge
      mycylinder(i, 1, h, r); // + 100% main out-hinge
    }

    // - 105% top/bottom in-hinge
    translate([0, 0, h*mid/2])
      mycylinder(i, 0, h, r, s, false);
    translate([0, 0, -h*s-h*mid/2])
      mycylinder(i, 0, h, r, s, false);

    mycylinder(i, 1, h*mid, r, s); // - 105% middle out-hinge
    mycylinder(i, 1, h, r*pin, s); // - 105% pin out-hinge

    // Remove neighbour vertices
    if(len(shape[i][1]) > 2 ) {
      for(j=[2:len(shape[i][1])-1])
        mycylinder(i, j, h, r, s);
    }
  }

  mycylinder(i, 0, h, r*pin); // + 100% pin in-hinge
}

// Make all shapes
module makeAll(size) {
    scale([size, size, size])
        translate([0, 0, h/2]) {
            translate([side/2,0,0]) {
                myshape(0);
                myshape(1);
                myshape(2);
                myshape(3);
            }
            translate([-side/2,0,0]) {
                myshape(4);
                myshape(5);
                myshape(6);
                myshape(7);
            }
        }
}

// Make specified shape
module make(i, size) {
    scale([size, size, size])
        translate([0, 0, h/2])
            myshape(i);
}


// ========== EXECUTION ==========
if(i >= 0 && i <= 7)
    make(i, size);
else
    makeAll(size);
