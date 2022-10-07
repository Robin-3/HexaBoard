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
      text(tile.getPiece().pieceType.toString(), x, y);
    }
  }
}

void drawMoves() {
  ArrayList<Short> pieceCandidateMoves = new ArrayList<Short>();
  for(Move move: moves) {
    final short startId = move.movedPiece.pieceId;
    if(startId == selectedTile)
    pieceCandidateMoves.add(coordinateToId(move.destinationCoordinate));
  }
  noStroke();
  fill(255, 255, 0, 200);
  short counter = -1;
  for(byte i = 0; i < iSize; i++) {
    final byte offsetW = (byte) (SIZE-1-i),
               jSize = (byte) (iSize-abs(offsetW));
    final float y = h*(0.5*(2-sqrt(3))*offsetW + i + 0.5);
    for(byte j = 0; j < jSize; j++) {
      counter++;
      if(!pieceCandidateMoves.contains(counter))
        continue;
      beginShape();
      final float x = w*(abs(offsetW)/2.0 + j + 0.5);
      for (byte k = 0; k < edges; k++) {
        final float theta = PI*(4.0*k+edges)/(2.0*edges),
                    xVertex = w*sqrt(3)*cos(theta)/3.0+x,
                    yVertex = h*sqrt(3)*sin(theta)/3.0+y;
        vertex(xVertex, yVertex);
      }
      endShape(CLOSE);
    }
  }
}

void drawSelection() {
  noFill();
  short counter = -1;
  for(byte i = 0; i < iSize; i++) {
    final byte offsetW = (byte) (SIZE-1-i),
               jSize = (byte) (iSize-abs(offsetW));
    if(!(cursorSelection > counter && cursorSelection <= counter+jSize)) {
      counter += jSize;
      continue;
    }
    final float y = h*(0.5*(2-sqrt(3))*offsetW + i);
    for(byte j = 0; j < jSize; j++) {
      counter++;
      if(counter != cursorSelection)
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
