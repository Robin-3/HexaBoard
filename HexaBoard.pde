final byte SIZE = 9,
           edges = 6;
short tileSelected = coordinateToId(new Coordinate((byte) 0, (byte) 0));
final EmptyTile[] EMPTY_TILES_CACHE = createAllPossibleEmptyTiles();
final Board standardBoard = formationStandard();
PImage boardImage;
final byte iSize = SIZE*2-1;
float h, w;

void setup() {
  size(512, 512);
  textAlign(CENTER, CENTER);
  h = height/(iSize+.0);
  w = width/(iSize+.0);
  boardImage = drawBoard();
  noLoop();
}

void draw() {
  image(boardImage, 0, 0);
  drawPieces();
  drawSelection();
}

void keyPressed() {
  final Coordinate actualCoordinate = idToCoordinate(tileSelected);
  byte x = 0, y = 0;
  if(keyCode == UP) {
    x = actualCoordinate.x%2 == 0 ? (byte) 1 : (byte) -1;
    y = -2;
  } else if(keyCode == DOWN) {
    y = 2;
    x = actualCoordinate.x%2 == 0 ? (byte) 1 : (byte) -1;
  } else if(keyCode == LEFT) {
    x = -2;
  } else if(keyCode == RIGHT) {
    x = 2;
  }
  final short checkTile = coordinateToId(new Coordinate((byte) (actualCoordinate.x+x), (byte) (actualCoordinate.y+y)));
  if(checkTile != -1) {
    tileSelected = checkTile;
    redraw();
  }
}

void mouseMoved() {
  for(byte i = 0; i < iSize; i++) {
    final byte offsetW = (byte) (SIZE-1-i),
               jSize = (byte) (iSize-abs(offsetW));
    final float y = h*(0.5*(2-sqrt(3))*offsetW + i);
    for(byte j = 0; j < jSize; j++) {
      final float collisionHeight = h*sin(PI/3.0),
                  x = w*(abs(offsetW)/2.0 + j);
      final boolean boardTileRow = mouseY >= y+(h-collisionHeight)/2 && mouseY < y+(h+collisionHeight)/2,
                    boardTileCol = mouseX >= x && mouseX < x+w;
      if(!(boardTileRow && boardTileCol))
        continue;
      final byte xSelected = jSize%2 == 0
                           ? (byte) (2*j-jSize+1)
                           : (byte) (2*(j-jSize/2)),
                 ySelected = (byte) (2*(i-SIZE+1));
      tileSelected = coordinateToId(new Coordinate(xSelected, ySelected));
      i = iSize;
      //CollisionBox Visualization
      //rect(x, y+(h-collisionHeight)/2, w, collisionHeight);
      //ellipse(x+w/2, y+h/2, w, collisionHeight);
      redraw();
      break;
    }
  }
}

PImage drawBoard() {
  final PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(255);
  pg.stroke(250, 248, 255); // #FAF8FF
  pg.noFill();
  for(byte i = 0; i < iSize; i++) {
    final byte offsetW = (byte) (SIZE-1-i),
               jSize = (byte) (iSize-abs(offsetW));
    final float y = h*(0.5*(2-sqrt(3))*offsetW + i + 0.5);
    for(byte j = 0; j < jSize; j++) {
      pg.beginShape();
      final float x = w*(abs(offsetW)/2.0 + j + 0.5);
      for (byte k = 0; k < edges; k++) {
        final float theta = PI*(4.0*k+edges)/(2.0*edges),
                    xVertex = w*sqrt(3)*cos(theta)/3.0+x,
                    yVertex = h*sqrt(3)*sin(theta)/3.0+y;
        pg.vertex(xVertex, yVertex);
      }
      pg.endShape(CLOSE);
    }
  }
  pg.noStroke();
  pg.fill(0);
  pg.beginShape();
  pg.vertex(width, 0);
  pg.vertex(0, 0);
  pg.vertex(0, height);
  pg.vertex(width, height);
  for (byte k = 0; k <= edges; k++) {
    final float theta = 2.0*PI*k/edges,
                x = width*(cos(theta)/2+0.5),
                y = height*(sin(theta)/2+0.5);
    pg.vertex(x, y);
  }
  pg.endShape(CLOSE);
  pg.endDraw();
  return pg.get();
}

void drawPieces() {
  noStroke();
  short counter = -1;
  for(byte i = 0; i < iSize; i++) {
    final byte offsetW = (byte) (SIZE-1-i),
               jSize = (byte) (iSize-abs(offsetW));
    final float y = h*(0.5*(2-sqrt(3))*offsetW + i + 0.5);
    for(byte j = 0; j < jSize; j++) {
      counter++;
      final Tile tile = standardBoard.gameBoard[counter];
      if(!tile.isTileOccupied())
        continue;
      final Alliance pieceAlliance = tile.getPiece().pieceAlliance;
      if(pieceAlliance == Alliance.PA)
        fill(173,216,230); // #ADD8E6
      else if (pieceAlliance == Alliance.CI)
        fill(243,157,178); // #F39DB2
      else
        fill(148,193,145); // #94C191
      beginShape();
      final float x = w*(abs(offsetW)/2.0 + j + 0.5);
      for (byte k = 0; k < edges; k++) {
        final float theta = PI*(4.0*k+edges)/(2.0*edges),
                    xVertex = w*sqrt(3)*cos(theta)/3.0+x,
                    yVertex = h*sqrt(3)*sin(theta)/3.0+y;
        vertex(xVertex, yVertex);
      }
      endShape(CLOSE);
      fill(0);
      text(tile.toString(), x, y);
    }
  }
}

void drawSelection() {
  noFill();
  short counter = -1;
  for(byte i = 0; i < iSize; i++) {
    final byte offsetW = (byte) (SIZE-1-i),
               jSize = (byte) (iSize-abs(offsetW));
    if(!(tileSelected > counter && tileSelected <= counter+jSize)) {
      counter += jSize;
      continue;
    }
    final float y = h*(0.5*(2-sqrt(3))*offsetW + i);
    for(byte j = 0; j < jSize; j++) {
      counter++;
      if(counter != tileSelected)
        continue;
      final Tile tile = standardBoard.gameBoard[counter];
      stroke(126, 0, 0); // #7E0000
      if(tile.isTileOccupied()) {
        final Alliance pieceAlliance = tile.getPiece().pieceAlliance;
        if(pieceAlliance == standardBoard.getAllianceMovement()) {
          strokeWeight(1.5);
          stroke(162, 0, 169); // #A200A9
        }
      }
      final float x = w*(abs(offsetW)/2.0 + j);
      beginShape();
      for (byte k = 0; k < edges; k++) {
        final float theta = PI*(4.0*k+edges)/(2.0*edges),
                    xVertex = w*(sqrt(3)*cos(theta)/3.0+0.5)+x,
                    yVertex = h*(sqrt(3)*sin(theta)/3.0+0.5)+y;
        vertex(xVertex, yVertex);
      }
      endShape(CLOSE);
      strokeWeight(1);
    }
  }
}
