float size;
final float sq3 = sqrt(3),
            y = sq3/2*sqrt(2*sq3-3);
final float[] M = {0,        0},
              G = {sq3,      0},
              B = {-sq3,     0},
              N = {-sq3/2,   0.5},
              L = {sq3/2,    -0.5},
              O = {N[0]+0,   N[1]+1},
              K = {L[0]-0,   L[1]-1},
              E = {y,        1.5},
              J = {-y,       -1.5},
              C = {E[0]-sq3, E[1]+0},
              H = {J[0]+sq3, J[1]+0},
              D = {E[0]-1.5, E[1]+y},
              I = {J[0]+1.5, J[1]-y},
              F = {E[0]+1.5, E[1]-y},
              A = {J[0]-1.5, J[1]+y};
final float[][][] shape = {
    {A, B, N, M, J},
    {B, C, O, N},
    {O, E, M, N},
    {C, D, E},
    {F, G, L, M, E},
    {G, H, K, L},
    {K, J, M, L},
    {H, I, J}
  };

PGraphics pg;

void setup() {
  size(400, 400, P2D);
  //fullScreen(P2D);
  size = height*.825;
  pg = createGraphics(width, height, P2D);
  pg.beginDraw();
  pg.noFill();
  pg.stroke(0);
  for(float[][] s: shape) {
    polygon(s, size/(2*sq3));
  }
  //pg.save("dissection.png");
  pg.endDraw();
  noLoop();
}

void draw() {
  background(255);
  image(pg, 0, 0);
}

void polygon(float[][] shape, float size) {
  pg.beginShape();
  for(float[] s: shape) {
    pg.vertex(s[0]*size+width/2, s[1]*size+height/2);
  }
  pg.endShape(CLOSE);
}
