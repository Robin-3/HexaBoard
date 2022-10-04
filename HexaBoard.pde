boolean[][] boardTiles;
int rot = 0;
final int edges = 5;
// final color[] col_fill = {color(0, 0, 255, 127), color(0, 255, 0, 127), color(255, 0, 0, 127)};

void setup() {
  size(512, 512);
  boardTiles = new boolean[SIZE*2-1][];
  for(int j = 0; j < boardTiles.length; j++) {
    boardTiles[j] = new boolean[SIZE*2-1-abs(SIZE-1-j)];
  }
  textAlign(CENTER, CENTER);
  fill(255);
  stroke(0);
  // noLoop();
  //printArray(EMPTY_TILES_CACHE); // Check valid coordinates
  //show valid moves - wizard piece
  Wizard moveTest = new Wizard(coordinateToId(new Coordinate((byte) 0, (byte) 0)), Alliance.PA);
  ArrayList<Move> dTestMove = moveTest.calculateLegalMoves(new Board());
  for(Move move: dTestMove) {
    println(move.destinationCoordinate);
    int[] index = coordinateToIndex(move.destinationCoordinate);
    boardTiles[index[0]][index[1]] = true;
  }
}

void keyPressed() {
  // 0: rigth->left, 1: bottom-left->top-rigth, 2: top-left->bottom-rigth
  rot = (rot+1)%3;
}

void draw() {
  background(255);
  // board
  beginShape();
  for (int k = 0; k < 6; k++) {
    final float theta = PI*k/3,
                x = width*(cos(theta)/2+0.5),
                y = height*(sin(theta)/2+0.5);
    vertex(x, y);
  }
  endShape(CLOSE);
  // Tile
  final float h = height/(boardTiles.length+.0);
  boolean isDraw = false;
  short counter = -1;
  for(int j = 0; j < boardTiles.length && !isDraw; j++) {
    final float offsetW = SIZE-1-j;
    final float w = width/(boardTiles[boardTiles.length/2].length+.0);
    for(int i = 0; i < boardTiles[j].length; i++) {
      counter++;
      //if(j <= boardTiles[j].length/2) fill(col_fill[(i+j)% 3]);
      //else fill(col_fill[(i+j*boardTiles.length+1) % 3]);
      beginShape();
      final float collisionHeight = h*sin(60*PI/180.0);
      final boolean boardTileRow = mouseY > h*(offsetW*(2-sqrt(3))/2.0 + j)+(h-collisionHeight)/2 && mouseY < h*(offsetW*(2-sqrt(3))/2.0 + j)+(h+collisionHeight)/2,
                    boardTileCol = mouseX > w*(abs(offsetW)/2.0 + i) && mouseX < w*(abs(offsetW)/2.0 + i + 1);
      // Draw one tile
      if(!boardTiles[j][i] && !(boardTileRow && boardTileCol))
        continue;
      // Draw all hexagons tiles, edges = 6 and theta = PI*(4.0*k+edges)/(2.0*edges)
      beginShape();
      for (int k = 0; k < edges; k++) {
        final float theta = 2.0*PI*k/edges+2.0*rot*PI/3.0,
                    x = w*(sqrt(3)*cos(theta)/3.0+0.5+i+abs(offsetW)/2.0),
                    y = h*(sqrt(3)*sin(theta)/3.0+0.5+j+offsetW*(2-sqrt(3))/2.0);
        vertex(x, y);
      }
      endShape(CLOSE);
      // isDraw = true;
      //CollisionBox Visualization
      //rect(w*(abs(offsetW)/2.0 + i), h*(offsetW*(2-sqrt(3))/2.0 + j)+(h-h_)/2, w, h_);
      //ellipse(w*(abs(offsetW)/2.0 + i)+w/2, h*(offsetW*(2-sqrt(3))/2.0 + j)+h/2, w, h_);
      fill(0);
      final float x = w*(abs(offsetW)/2.0 + i)+w/2,
                  y = h*(offsetW*(2-sqrt(3))/2.0 + j)+h/2;
      text(idToCoordinate(counter).toString(), x, y);
      noFill();
    }
  }
}

//---TestZone---

int[] coordinateToIndex(final Coordinate tileCoordinate) {
  final byte iSize = SIZE*2-1;
  for(byte i = 0; i < iSize; i++) {
    final byte jSize = (byte) (SIZE*2-1-abs(SIZE-1-i));
    for(byte j = 0; j < jSize; j++) {
      final byte x = jSize%2 == 0
                   ? (byte) (2*j-jSize+1)
                   : (byte) (2*(j-jSize/2)),
                 y = (byte) (2*(i-SIZE+1));
      if(tileCoordinate.x == x && tileCoordinate.y == y) {
        return new int[] {i, j};
      }
    }
  }
  return null;
}
