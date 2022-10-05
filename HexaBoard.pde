final byte SIZE = 9,
           edges = 6,
           edgesMouse = 5;
byte rot = 1;
final EmptyTile[] EMPTY_TILES_CACHE = createAllPossibleEmptyTiles();
final Board standardBoard = new Board(Alliance.PA, formationStandard());

void setup() {
  size(512, 512);
  textAlign(CENTER, CENTER);
  noStroke();
  // noLoop();
}

void keyPressed() {
  // 0: rigth->left, 1: bottom-left->top-rigth, 2: top-left->bottom-rigth
  rot = (byte) ((rot+1)%3);
}

void draw() {
  background(0);
  // Board
  fill(255);
  beginShape();
  for (byte k = 0; k < 6; k++) {
    final float theta = PI*k/3,
                x = width*(cos(theta)/2+0.5),
                y = height*(sin(theta)/2+0.5);
    vertex(x, y);
  }
  endShape(CLOSE);
  // Draw all hexagons tiles
  final byte iSize = SIZE*2-1;
  final float h = height/(iSize+.0);
  final float w = width/(iSize+.0);
  short counter = 0;
  for(byte i = 0; i < iSize; i++) {
    final byte jSize = (byte) (SIZE*2-1-abs(SIZE-1-i));
    final float offsetW = SIZE-1-i;
    for(byte j = 0; j < jSize; j++) {
      // Draw pieces
      if(standardBoard.gameBoard[counter].isTileOccupied()) {
        final Alliance pieceAlliance = standardBoard.gameBoard[counter].getPiece().pieceAlliance;
        if(pieceAlliance == Alliance.PA)
          fill(173,216,230); // #ADD8E6
        else if (pieceAlliance == Alliance.CI)
          fill(243,157,178); // #F39DB2
        else
          fill(148,193,145); // #94C191
        beginShape();
        for (byte k = 0; k < edges; k++) {
          final float theta = PI*(4.0*k+edges)/(2.0*edges),
                      x = w*(sqrt(3)*cos(theta)/3.0+0.5+j+abs(offsetW)/2.0),
                      y = h*(sqrt(3)*sin(theta)/3.0+0.5+i+offsetW*(2-sqrt(3))/2.0);
          vertex(x, y);
        }
        endShape(CLOSE);
        fill(0);
        final float x = w*(abs(offsetW)/2.0 + j)+w/2,
                    y = h*(offsetW*(2-sqrt(3))/2.0 + i)+h/2;
        text(standardBoard.gameBoard[counter].toString(), x, y);
      }
      // Draw mouse position
      final float collisionHeight = h*sin(60*PI/180.0);
      final boolean boardTileRow = mouseY >= h*(offsetW*(2-sqrt(3))/2.0 + i)+(h-collisionHeight)/2 && mouseY < h*(offsetW*(2-sqrt(3))/2.0 + i)+(h+collisionHeight)/2,
                    boardTileCol = mouseX >= w*(abs(offsetW)/2.0 + j) && mouseX < w*(abs(offsetW)/2.0 + j + 1);
      if(boardTileRow && boardTileCol) {
        noFill();
        stroke(0);
        beginShape();
        for (byte k = 0; k < edgesMouse; k++) {
          final float theta = 2.0*PI*k/edgesMouse+2.0*rot*PI/3.0,
                      x = w*(sqrt(3)*cos(theta)/3.0+0.5+j+abs(offsetW)/2.0),
                      y = h*(sqrt(3)*sin(theta)/3.0+0.5+i+offsetW*(2-sqrt(3))/2.0);
          vertex(x, y);
        }
        endShape(CLOSE);
        noStroke();
      }
      //CollisionBox Visualization
      //rect(w*(abs(offsetW)/2.0 + i), h*(offsetW*(2-sqrt(3))/2.0 + j)+(h-h_)/2, w, h_);
      //ellipse(w*(abs(offsetW)/2.0 + i)+w/2, h*(offsetW*(2-sqrt(3))/2.0 + j)+h/2, w, h_);
      counter++;
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
