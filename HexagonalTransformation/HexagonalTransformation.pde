final float area = 5000.0;

final float sq_b = sqrt(area);
final float hx_b = sqrt(sqrt(12) * area)/3.0;

boolean is_sq = true;
boolean is_sq_grid = true;

void setup() {
  size(480,480);
  println(sq_b, hx_b);
  // noLoop();
  
}

void draw() {
  // reset y-axis
  scale(1, -1);
  translate(width/2.0, -height/2.0);

  background(0);
  noStroke();
  
  fill(255, 0, 255, 255/2.0);
  // Tiene que ser de 6 valores
  // Test zone
  // Selection[] sel = new Selection[] {Selection.Double, Selection.Double, Selection.Double, Selection.Double, Selection.Double, Selection.Double};
  // Selection[] sel = new Selection[] {Selection.First, Selection.First, Selection.First, Selection.First, Selection.First, Selection.First};
  // Selection[] sel = new Selection[] {Selection.Second, Selection.Second, Selection.Second, Selection.Second, Selection.Second, Selection.Second};
  // Rotation[] rot = new Rotation[] {Rotation.One, Rotation.One, Rotation.One, Rotation.One, Rotation.One, Rotation.One};
  // Rotation[] rot = new Rotation[] {Rotation.Two, Rotation.Two, Rotation.Two, Rotation.Two, Rotation.Two, Rotation.Two};
  // Rotation[] rot = new Rotation[] {Rotation.Three, Rotation.Three, Rotation.Three, Rotation.Three, Rotation.Three, Rotation.Three};
  randomSeed(0);
  
  int size = 3;
  
  for(int _y = -(size-1); _y < size; _y++) {
    float center_offset_y = is_sq? sq_b: 3.0*hx_b/2.0;
    center_offset_y *= _y;

    for(int _x = -(size-1); _x < size; _x++) {
      if(!is_sq_grid && -_x-_y >= size) continue;
      if(!is_sq_grid && _x+_y >= size) continue;
      
      Selection[] sel = new Selection[] {
        random(3) < 1? Selection.Double: random(2) < 1? Selection.First : Selection.Second,
        random(3) < 1? Selection.Double: random(2) < 1? Selection.First : Selection.Second,
        random(3) < 1? Selection.Double: random(2) < 1? Selection.First : Selection.Second,
        random(3) < 1? Selection.Double: random(2) < 1? Selection.First : Selection.Second,
        random(3) < 1? Selection.Double: random(2) < 1? Selection.First : Selection.Second,
        random(3) < 1? Selection.Double: random(2) < 1? Selection.First : Selection.Second,
      };
      Rotation[] rot = new Rotation[] {
        random(3) < 1? Rotation.One: random(2) < 1? Rotation.Two : Rotation.Three,
        random(3) < 1? Rotation.One: random(2) < 1? Rotation.Two : Rotation.Three,
        random(3) < 1? Rotation.One: random(2) < 1? Rotation.Two : Rotation.Three,
        random(3) < 1? Rotation.One: random(2) < 1? Rotation.Two : Rotation.Three,
        random(3) < 1? Rotation.One: random(2) < 1? Rotation.Two : Rotation.Three,
        random(3) < 1? Rotation.One: random(2) < 1? Rotation.Two : Rotation.Three,
      };

      float center_offset_x = is_sq? sq_b: sqrt(3.0)*hx_b;
      center_offset_x *= _x;

      if(!is_sq)
        center_offset_x += _y*sqrt(3.0)*hx_b/2.0;
        
      boolean offset_color = is_sq? _y % 2 == 0 : true;
      Shape shape = new Shape();
      shape.draw(offset_color, center_offset_x, center_offset_y, is_sq, sel, rot);
    }
  }
}

void mousePressed() {
  if(mouseButton == LEFT)
    is_sq = !is_sq;

  if(mouseButton == RIGHT)
    is_sq_grid = !is_sq_grid;
}
