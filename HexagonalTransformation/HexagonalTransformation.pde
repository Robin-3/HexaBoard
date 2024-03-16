final float area = 1.0;

final float sq_b = sqrt(area);
final float hx_b = sqrt(sqrt(12) * area)/3.0;

class Point {
  float x, y;
  Point(float _x, float _y) {
    this.x = _x;
    this.y = _y;
  }
}

Point[] points, points_sq, points_hx;
boolean is_sq = true;
boolean is_sq_grid = true;

void setup() {
  size(480,480);
  println(sq_b, hx_b);
  // noLoop();

  points = new Point[24];
  points_sq = new Point[points.length];
  points_hx = new Point[points.length];
  for(int i = 0; i < points.length; i++) {
    points[i] = new Point(0, 0);
    points_sq[i] = new Point(0, 0);
    points_hx[i] = new Point(0, 0);
  }

  // sq
  points_sq[0].x = sq_b/2.0;
  points_sq[0].y = 0; // 0.0*sq_b/6.0
  points_sq[1].x = sq_b/2.0;
  points_sq[1].y = sq_b/6.0; // 1.0*sq_b/6.0
  points_sq[2].x = sq_b/2.0;
  points_sq[2].y = sq_b/3.0; // 2.0*sq_b/6.0
  points_sq[3].x = sq_b/2.0;
  points_sq[3].y = sq_b/2.0; // 3.0*sq_b/6.0
  points_sq[4].x = sq_b/3.0;
  points_sq[4].y = sq_b/2.0;
  points_sq[5].x = sq_b/6.0;
  points_sq[5].y = sq_b/2.0;

  points_sq[6].x = 0;
  points_sq[6].y = sq_b/2.0;
  points_sq[7].x = -sq_b/6.0;
  points_sq[7].y = sq_b/2.0;
  points_sq[8].x = -sq_b/3.0;
  points_sq[8].y = sq_b/2.0;
  points_sq[9].x = -sq_b/2.0;
  points_sq[9].y = sq_b/2.0;
  points_sq[10].x = -sq_b/2.0;
  points_sq[10].y = sq_b/3.0;
  points_sq[11].x = -sq_b/2.0;
  points_sq[11].y = sq_b/6.0;

  points_sq[12].x = -sq_b/2.0;
  points_sq[12].y = 0;
  points_sq[13].x = -sq_b/2.0;
  points_sq[13].y = -sq_b/6.0;
  points_sq[14].x = -sq_b/2.0;
  points_sq[14].y = -sq_b/3.0;
  points_sq[15].x = -sq_b/2.0;
  points_sq[15].y = -sq_b/2.0;
  points_sq[16].x = -sq_b/3.0;
  points_sq[16].y = -sq_b/2.0;
  points_sq[17].x = -sq_b/6.0;
  points_sq[17].y = -sq_b/2.0;

  points_sq[18].x = 0;
  points_sq[18].y = -sq_b/2.0;
  points_sq[19].x = sq_b/6.0;
  points_sq[19].y = -sq_b/2.0;
  points_sq[20].x = sq_b/3.0;
  points_sq[20].y = -sq_b/2.0;
  points_sq[21].x = sq_b/2.0;
  points_sq[21].y = -sq_b/2.0;
  points_sq[22].x = sq_b/2.0;
  points_sq[22].y = -sq_b/3.0;
  points_sq[23].x = sq_b/2.0;
  points_sq[23].y = -sq_b/6.0;

  // hx
  points_hx[0].x = sqrt(3)*hx_b/2.0;
  points_hx[0].y = 0; // 0.0*hx_b/4.0
  points_hx[1].x = sqrt(3)*hx_b/2.0;
  points_hx[1].y = hx_b/4.0; // 1.0*hx_b/4.0
  points_hx[2].x = sqrt(3)*hx_b/2.0;
  points_hx[2].y = hx_b/2.0; // 2.0*hx_b/4.0
  points_hx[3].x = 3.0*sqrt(3)*hx_b/8.0; // 3.0*sqrt(3)*hx_b/8.0
  points_hx[3].y = 5.0*hx_b/8.0; // 5.0*hx_b/8.0
  points_hx[4].x = sqrt(3)*hx_b/4.0; // 2.0*sqrt(3)*hx_b/8.0
  points_hx[4].y = 3.0*hx_b/4.0; // 6.0*hx_b/8.0
  points_hx[5].x = sqrt(3)*hx_b/8.0; // 1.0*sqrt(3)*hx_b/8.0
  points_hx[5].y = 7.0*hx_b/8.0; // 7.0*hx_b/8.0

  points_hx[6].x = 0; // 1.0*sqrt(3)*hx_b/8.0
  points_hx[6].y = hx_b; // 8.0*hx_b/8.0
  points_hx[7].x = -sqrt(3)*hx_b/8.0;
  points_hx[7].y = 7.0*hx_b/8.0;
  points_hx[8].x = -sqrt(3)*hx_b/4.0;
  points_hx[8].y = 3.0*hx_b/4.0;
  points_hx[9].x = -3.0*sqrt(3)*hx_b/8.0;
  points_hx[9].y = 5.0*hx_b/8.0;
  points_hx[10].x = -sqrt(3)*hx_b/2.0;
  points_hx[10].y = hx_b/2.0;
  points_hx[11].x = -sqrt(3)*hx_b/2.0;
  points_hx[11].y = hx_b/4.0;

  points_hx[12].x = -sqrt(3)*hx_b/2.0;
  points_hx[12].y = 0;
  points_hx[13].x = -sqrt(3)*hx_b/2.0;
  points_hx[13].y = -hx_b/4.0;
  points_hx[14].x = -sqrt(3)*hx_b/2.0;
  points_hx[14].y = -hx_b/2.0;
  points_hx[15].x = -3.0*sqrt(3)*hx_b/8.0;
  points_hx[15].y = -5.0*hx_b/8.0;
  points_hx[16].x = -sqrt(3)*hx_b/4.0;
  points_hx[16].y = -3.0*hx_b/4.0;
  points_hx[17].x = -sqrt(3)*hx_b/8.0;
  points_hx[17].y = -7.0*hx_b/8.0;

  points_hx[18].x = 0; // 1.0*sqrt(3)*hx_b/8.0
  points_hx[18].y = -hx_b; // 8.0*hx_b/8.0
  points_hx[19].x = sqrt(3)*hx_b/8.0;
  points_hx[19].y = -7.0*hx_b/8.0;
  points_hx[20].x = sqrt(3)*hx_b/4.0;
  points_hx[20].y = -3.0*hx_b/4.0;
  points_hx[21].x = 3.0*sqrt(3)*hx_b/8.0;
  points_hx[21].y = -5.0*hx_b/8.0;
  points_hx[22].x = sqrt(3)*hx_b/2.0;
  points_hx[22].y = -hx_b/2.0;
  points_hx[23].x = sqrt(3)*hx_b/2.0;
  points_hx[23].y = -hx_b/4.0;

  for(int i = 0; i < points.length; i++) {
    points[i].x = points_sq[i].x;
    points[i].y = points_sq[i].y;
  }
}

void draw() {
  // reset y-axis
  scale(1, -1);
  translate(0, -height);
  
  float center_x = width/2.0;
  float center_y = height/2.0;
  float zoom = 75.0;

  background(0);
  noStroke();

  int size = 3;
  
  for(int _y = -(size-1); _y < size; _y++) {
    float center_offset_y = is_sq? sq_b: 3.0*hx_b/2.0;
    center_offset_y *= _y;

    for(int _x = -(size-1); _x < size; _x++) {
      if(!is_sq_grid && -_x-_y >= size) continue;
      if(!is_sq_grid && _x+_y >= size) continue;

      float center_offset_x = is_sq? sq_b: sqrt(3.0)*hx_b;
      center_offset_x *= _x;

      if(!is_sq)
        center_offset_x += _y*sqrt(3.0)*hx_b/2.0;

      beginShape(TRIANGLE_FAN);
      vertex((0.0+center_offset_x)*zoom+center_x, (0.0+center_offset_y)*zoom+center_y);

      for(int i = 0; i < points.length; i++) {
        if(i%4 == 0 || i%4 == 1)
          fill(255, 0, 255, 255/2.0);
        else
          fill(0, 255, 255, 255/2.0);

        Point pa = points[i];
        vertex((pa.x+center_offset_x)*zoom+center_x, (pa.y+center_offset_y)*zoom+center_y);
        if(i+1 < points.length) {
          Point pn = points[i+1];
          vertex((pn.x+center_offset_x)*zoom+center_x, (pn.y+center_offset_y)*zoom+center_y);
        }
      }

      vertex((points[0].x+center_offset_x)*zoom+center_x, (points[0].y+center_offset_y)*zoom+center_y);
      endShape();
    }
  }
}

void mousePressed() {
  if(mouseButton == LEFT) {
    is_sq = !is_sq;
  
    for(int i = 0; i < points.length; i++) {
      Point p_p = is_sq? points_sq[i]: points_hx[i];
      Point p = points[i];
  
      p.x = p_p.x;
      p.y = p_p.y;
    }
  }

  if(mouseButton == RIGHT)
    is_sq_grid = !is_sq_grid;
}
