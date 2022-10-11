void selectTile() {
  if(selectedTile == -1) {
    final Tile tile = standardBoard.gameBoard[cursorSelection];
    if(!tile.isTileOccupied()) {
      selectedTile = -1;
      return;
    }
    final Alliance pieceAlliance = tile.getPiece().pieceAlliance;
    if(pieceAlliance != standardBoard.getAllianceMovement()) {
      selectedTile = -1;
      return;
    }
    selectedTile = cursorSelection;
  } else {
    boolean moveIsExcute = false;
    for(Move move: moves) {
      final short startId = move.movedPiece.pieceId;
      final short endId = coordinateToId(move.destinationCoordinate);
      if(endId == cursorSelection && startId == selectedTile) {
        standardBoard = move.execute();
        moveIsExcute = true;
        moves = standardBoard.getActualAllMoves();
        break;
      }
    }
    selectedTile = -1;
    if(!moveIsExcute) {
      selectTile();
    }
    redraw();
  }
}

void keyPressed() {
  final Coordinate actualCoordinate = idToCoordinate(cursorSelection);
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
  } else if(keyCode == ENTER) {
    selectTile();
  }
  final short checkTile = coordinateToId(new Coordinate((byte) (actualCoordinate.x+x), (byte) (actualCoordinate.y+y)));
  if(checkTile != -1) {
    cursorSelection = checkTile;
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
      cursorSelection = coordinateToId(new Coordinate(xSelected, ySelected));
      i = iSize;
      //CollisionBox Visualization
      //rect(x, y+(h-collisionHeight)/2, w, collisionHeight);
      //ellipse(x+w/2, y+h/2, w, collisionHeight);
      break;
    }
    redraw();
  }
}

void mousePressed() {
  if(mouseButton == LEFT) {
    selectTile();
    redraw();
  }
}
