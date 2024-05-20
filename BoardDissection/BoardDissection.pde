final int side = 600;

final float[] P = {0,                                           0},
              H = {1/2.0*side,                                  sqrt(6*sqrt(3)-9)/6*side},
              O = {(sqrt(2*sqrt(3)-3)+3)/12*side,               -(sqrt(3)-sqrt(6*sqrt(3)-9))/12*side},
              N = {(1+sqrt(2*sqrt(3)-3))/4*side,                (sqrt(6*sqrt(3)-9)+3*sqrt(7-4*sqrt(3))-6)/12*side},
              F = {P[0],                                        H[0]},
              J = {H[0],                                        H[1]-F[1]},
              K = {H[0],                                        -F[1]},
              G = {H[0],                                        F[1]},
              
              I = {H[0],                                        (3-2*sqrt(6*sqrt(3)-9))/6*side},
              M = {(sqrt(2*sqrt(3))-sqrt(12-6*sqrt(3)))/4*side, (sqrt(4-2*sqrt(3))-sqrt(14*sqrt(3)-24)-2)/4*side},
              
              B = {-H[0],                                       -H[1]},
              Q = {-O[0],                                       -O[1]},
              R = {-N[0],                                       -N[1]},
              L = {-F[0],                                       -F[1]},
              D = {-J[0],                                       -J[1]},
              E = {-K[0],                                       -K[1]},
              A = {-G[0],                                       -G[1]},
              
              C = {-I[0],                                       -I[1]},
              S = {-M[0],                                       -M[1]};

final float[][][] shape = {
  {A, B, Q, P, L},
  {B, D, R, Q},
  {R, F, P, Q},
  {D, E, F},
  {G, H, O, P, F},
  {H, J, N, O},
  {N, L, P, O},
  {J, K, L}
};

final float[][][] bisagras = {
  {A, B, L},
  {B, R, {-H[0], H[1]}, C},
  {R, F},
  {F, E, R, S},
  {G, H, F},
  {H, N, {-B[0], B[1]}, I},
  {N, L},
  {L, K, N, M}
};

PGraphics pg;

void setup() {
  size(600, 600, P2D);
  //fullScreen(P2D);
  pg = createGraphics(side, side, P2D);
  pg.beginDraw();
  pg.noFill();
  pg.stroke(0);
  pg.translate(side/2, side/2);
  for(int i = 0; i < shape.length; i++) {
    float[][] s = shape[i];
    float x_offset = i<shape.length/2? side/2: -side/2;
    polygon(s, x_offset);
  }
  for(int i = 0; i < bisagras.length; i++) {
    float[][] s = bisagras[i];
    float x_offset = i<bisagras.length/2? side/2: -side/2;
    bisagra(s, x_offset);
  }
  //pg.save("dissection.png");
  pg.endDraw();
  noLoop();
}

void draw() {
  scale(1, -1);
  translate(0, -height);
  background(255);
  image(pg, 0, 0);
}

void polygon(float[][] shape, float x_offset) {
  pg.beginShape();
  for(float[] s: shape) {
    pg.vertex(s[0]+x_offset, s[1]);
  }
  pg.endShape(CLOSE);
}

void bisagra(float[][] shape, float x_offset) {
  for(int i = 0; i < shape.length; i++) {
    float[] s = shape[i];
    if(i<2) {
      pg.noFill();
      pg.ellipse(s[0]+x_offset, s[1], side/10, side/10);
    } else {
      pg.fill(0, 0, 255, 50);
      pg.ellipse(s[0]+x_offset, s[1], side/15, side/15);
    }
  }
}
