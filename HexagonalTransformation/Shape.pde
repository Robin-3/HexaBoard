enum IsSq {
  None,
  Corner,
  Edge,
}

enum Rotation {
  One,
  Two,
  Three,
}

enum Selection {
  None,
  First, // Rotation
  Second, // Rotation
  Double, // Rotation?
}

class Point {
  final float x, y;
  
  Point(float _x, float _y) {
    this.x = _x;
    this.y = _y;
  }
}

class PartialShape {
  final Point[][] points;
  
  PartialShape() {
    points = new Point[3][7];
    
    // sq corner points
    points[0][0] = new Point(0, 0);
    points[0][1] = new Point(0, sq_b/3.0);
    points[0][2] = new Point(0, sq_b/2.0);
    points[0][3] = new Point(sq_b/3.0, sq_b/2.0);
    points[0][4] = new Point(sq_b/2.0, sq_b/2.0);
    points[0][5] = new Point(sq_b/2.0, sq_b/3.0);
    points[0][6] = new Point(sq_b/3.0, 2.0*sq_b/9.0);
    
    // sq edge points
    points[1][0] = new Point(0, 0);
    points[1][1] = new Point(0, sq_b/3.0);
    points[1][2] = new Point(0, 2.0*sq_b/3.0);
    points[1][3] = new Point(sq_b/4.0, sq_b/2.0);
    points[1][4] = new Point(3.0*sq_b/8.0, 5.0*sq_b/12.0);
    points[1][5] = new Point(sq_b/2.0, sq_b/3.0);
    points[1][6] = new Point(sq_b/4.0, sq_b/6.0);
    
    // hx points
    points[2][0] = new Point(0, 0);
    points[2][1] = new Point(0, hx_b/2.0);
    points[2][2] = new Point(0, hx_b);
    points[2][3] = new Point(sqrt(3.0)*hx_b/4.0, 3.0*hx_b/4.0);
    points[2][4] = new Point(3.0*sqrt(3)*hx_b/8.0, 5.0*hx_b/8.0);
    points[2][5] = new Point(sqrt(3.0)*hx_b/2.0, hx_b/2.0);
    points[2][6] = new Point(sqrt(3.0)*hx_b/4.0, hx_b/4.0);
  }
  
  Point[] selection(Selection sel, IsSq is_sq, Rotation rot) {
    Point[] points = new Point[] {};
    int piece_index = is_sq == IsSq.None? 2: is_sq == IsSq.Edge? 1: 0;
    if(rot == Rotation.One) {
      if(sel == Selection.Double) {
        points = new Point[9];
        points[0] = this.points[piece_index][0];
        points[1] = this.points[piece_index][2];
        points[2] = this.points[piece_index][3];
        points[3] = this.points[piece_index][0];
        points[4] = this.points[piece_index][3];
        points[5] = this.points[piece_index][4];
        points[6] = this.points[piece_index][0];
        points[7] = this.points[piece_index][4];
        points[8] = this.points[piece_index][5];
      } else if(sel == Selection.First) {
        points = new Point[3];
        points[0] = this.points[piece_index][0];
        points[1] = this.points[piece_index][2];
        points[2] = this.points[piece_index][3];
      } else if(sel == Selection.Second) {
        points = new Point[6];
        points[0] = this.points[piece_index][0];
        points[1] = this.points[piece_index][3];
        points[2] = this.points[piece_index][4];
        points[3] = this.points[piece_index][0];
        points[4] = this.points[piece_index][4];
        points[5] = this.points[piece_index][5];
      }
    } else if(rot == Rotation.Two) {
      if(sel == Selection.Double) {
        points = new Point[9];
        points[0] = this.points[piece_index][0];
        points[1] = this.points[piece_index][1];
        points[2] = this.points[piece_index][5];
        points[3] = this.points[piece_index][1];
        points[4] = this.points[piece_index][2];
        points[5] = this.points[piece_index][4];
        points[6] = this.points[piece_index][1];
        points[7] = this.points[piece_index][4];
        points[8] = this.points[piece_index][5];
      } else if(sel == Selection.First) {
        points = new Point[3];
        points[0] = this.points[piece_index][0];
        points[1] = this.points[piece_index][1];
        points[2] = this.points[piece_index][5];
      } else if(sel == Selection.Second) {
        points = new Point[6];
        points[0] = this.points[piece_index][1];
        points[1] = this.points[piece_index][2];
        points[2] = this.points[piece_index][4];
        points[3] = this.points[piece_index][1];
        points[4] = this.points[piece_index][4];
        points[5] = this.points[piece_index][5];
      }
    } else if(rot == Rotation.Three) {
      if(sel == Selection.Double) {
        points = new Point[9];
        points[0] = this.points[piece_index][0];
        points[1] = this.points[piece_index][2];
        points[2] = this.points[piece_index][6];
        points[3] = this.points[piece_index][2];
        points[4] = this.points[piece_index][4];
        points[5] = this.points[piece_index][5];
        points[6] = this.points[piece_index][2];
        points[7] = this.points[piece_index][5];
        points[8] = this.points[piece_index][6];
      } else if(sel == Selection.First) {
        points = new Point[3];
        points[0] = this.points[piece_index][0];
        points[1] = this.points[piece_index][2];
        points[2] = this.points[piece_index][6];
      } else if(sel == Selection.Second) {
        points = new Point[6];
        points[0] = this.points[piece_index][2];
        points[1] = this.points[piece_index][4];
        points[2] = this.points[piece_index][5];
        points[3] = this.points[piece_index][2];
        points[4] = this.points[piece_index][5];
        points[5] = this.points[piece_index][6];
      }
    }
    
    return points;
  }
}

PartialShape ps = new PartialShape();

class Position {
  final IsSq is_sq;
  final float offset_x;
  final float offset_y;
  final float flip_x;
  final float flip_y;
  
  Position(IsSq _is_sq, float _offset_x, float _offset_y, float _flip_x, float _flip_y) {
    this.is_sq = _is_sq;
    this.offset_x = _offset_x;
    this.offset_y = _offset_y;
    this.flip_x = _flip_x;
    this.flip_y = _flip_y;
  }
}

class Shape {
  void draw(boolean offset_color, float _x, float _y, boolean is_sq, Selection[] selections, Rotation[] rotations) {
    float b = is_sq? sq_b : hx_b;
    Position[] pos = is_sq
      ? new Position[] { // sq
          new Position(IsSq.Corner, 0, 0, -1, 1), // Left up
          new Position(IsSq.Edge, -b/2.0, -b/3.0, 1, 1), // Left
          new Position(IsSq.Corner, 0, 0, -1, -1), // Left down
          new Position(IsSq.Corner, 0, 0, 1, 1), // Right up
          new Position(IsSq.Edge, b/2.0, b/3.0, -1, -1), // Right
          new Position(IsSq.Corner, 0, 0, 1, -1), // Right down
        }
      : new Position[] { // hx
          new Position(IsSq.None, 0, 0, -1, 1), // Left up
          new Position(IsSq.None, -sqrt(3)*b/2.0, -b/2.0, 1, 1), // Left
          new Position(IsSq.None, 0, 0, -1, -1), // Left down
          new Position(IsSq.None, 0, 0, 1, 1), // Right up
          new Position(IsSq.None, sqrt(3)*b/2.0, b/2.0, -1, -1), // Right
          new Position(IsSq.None, 0, 0, 1, -1), // Right down
        };

    beginShape(TRIANGLES);
    for(int j = 0; j < selections.length; j++) {
      Point[] points = ps.selection(selections[j], pos[j].is_sq, rotations[j]);
      if(j%2 == int(offset_color))
        fill(255, 0, 255, 255/2.0);
      else
        fill(0, 255, 255, 255/2.0);
      for(int i = 0; i < points.length; i++) {
        Point p = points[i];
        vertex(p.x*pos[j].flip_x+pos[j].offset_x+_x, p.y*pos[j].flip_y+pos[j].offset_y+_y);
      }
    }

    endShape();
  }
}
