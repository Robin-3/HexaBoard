PImage drawBoard() {
  final PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(boardColors.get("tilesFill"));
  pg.stroke(boardColors.get("tilesStroke"));
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
  pg.fill(boardColors.get("gameBackground"));
  pg.stroke(boardColors.get("gameStroke"));
  pg.beginShape();
  pg.vertex(width-1, 0);
  pg.vertex(0, 0);
  pg.vertex(0, height-1);
  pg.vertex(width-1, height-1);
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
  short counter = -1;
  pieceText.beginDraw();
  pieceText.clear();
  pieceText.textAlign(CENTER, CENTER);
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
      fill(boardColors.get("piece"+pieceAlliance+"Fill"));
      stroke(boardColors.get("piece"+pieceAlliance+"Stroke"));
      beginShape();
      final float x = w*(abs(offsetW)/2.0 + j + 0.5);
      final float allianceRotation = tile.getPiece().pieceAlliance.allianceName;
      for (byte k = 0; k < pieceEdges; k++) {
        final float theta = 2*PI*(k/(pieceEdges+0.0)+allianceRotation/edges)-6*PI/180, // fix this magic number
                    xVertex = w*sqrt(3)*cos(theta)*piecePaddingPercentaje/3.0+x,
                    yVertex = h*sqrt(3)*sin(theta)*piecePaddingPercentaje/3.0+y;
        vertex(xVertex, yVertex);
      }
      endShape(CLOSE);
      pieceText.fill(boardColors.get("piece"+pieceAlliance+"Text"));
      pieceText.text(tile.getPiece().pieceType.toString(), x, y);
    }
  }
  pieceText.endDraw();
}

void drawMoves() {
  ArrayList<Short> pieceCandidateMoves = new ArrayList<Short>();
  HashMap<Short, String> typeOfMove = new HashMap<Short, String>();
  for(Move move: moves) {
    final short startId = move.movedPiece.pieceId;
    if(startId == selectedTile) {
      final short destinationCoordinate = coordinateToId(move.destinationCoordinate);
      pieceCandidateMoves.add(destinationCoordinate);
      typeOfMove.put(destinationCoordinate, move.getClass().getSimpleName());
    }
  }
  short counter = -1;
  for(byte i = 0; i < iSize; i++) {
    final byte offsetW = (byte) (SIZE-1-i),
               jSize = (byte) (iSize-abs(offsetW));
    final float y = h*(0.5*(2-sqrt(3))*offsetW + i + 0.5);
    for(byte j = 0; j < jSize; j++) {
      counter++;
      if(pieceCandidateMoves.contains(counter)) {
        stroke(boardColors.get(typeOfMove.get(counter)+"Stroke"));
        fill(boardColors.get(typeOfMove.get(counter)+"Fill"));
      } else if(selectedTile != -1 && counter == selectedTile) {
        stroke(boardColors.get("selectPieceStroke"));
        fill(boardColors.get("selectPieceFill"));
      } else
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
      fill(boardColors.get("selectorFill"));
      stroke(boardColors.get("selectorStroke"));
      if(tile.isTileOccupied()) {
        final Alliance pieceAlliance = tile.getPiece().pieceAlliance;
        if(pieceAlliance == standardBoard.getAllianceMovement()) {
          fill(boardColors.get("alianceTurnFill"));
          stroke(boardColors.get("alianceTurnStroke"));
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
    }
  }
}
