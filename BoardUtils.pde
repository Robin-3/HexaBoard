final byte SIZE = 9;
final EmptyTile[] EMPTY_TILES_CACHE = createAllPossibleEmptyTiles();

short coordinateToId(final Coordinate tileCoordinate) {
  final byte iSize = SIZE*2-1;
  short counter = 0;
  for(byte i = 0; i < iSize; i++) {
    final byte jSize = (byte) (SIZE*2-1-abs(SIZE-1-i));
    for(byte j = 0; j < jSize; j++) {
      final byte x = jSize%2 == 0
                   ? (byte) (2*j-jSize+1)
                   : (byte) (2*(j-jSize/2)),
                 y = (byte) (2*(i-SIZE+1));
      if(tileCoordinate.x == x && tileCoordinate.y == y) {
        return counter;
      }
      counter++;
    }
  }
  return -1;
}

Coordinate idToCoordinate(final short tileId) {
  short counter = 0;
  final byte iSize = SIZE*2-1;
  for(byte i = 0; i < iSize; i++) {
    final byte jSize = (byte) (SIZE*2-1-abs(SIZE-1-i));
    for(byte j = 0; j < jSize; j++) {
      if(tileId == counter) {
        final byte x = jSize%2 == 0
                     ? (byte) (2*j-jSize+1)
                     : (byte) (2*(j-jSize/2)),
                   y = (byte) (2*(i-SIZE+1));
        return new Coordinate(x, y);
      }
      counter++;
    }
  }
  return null;
}

EmptyTile[] createAllPossibleEmptyTiles() {
  final EmptyTile[][] tempEmptyTiles = new EmptyTile[SIZE*2-1][];
  short counter = 0;
  for(byte i = 0; i < tempEmptyTiles.length; i++) {
    tempEmptyTiles[i] = new EmptyTile[SIZE*2-1-abs(SIZE-1-i)];
    for(byte j = 0; j < tempEmptyTiles[i].length; j++) {
      final byte x = tempEmptyTiles[i].length%2 == 0
                   ? (byte) (2*j-tempEmptyTiles[i].length+1)
                   : (byte) (2*(j-tempEmptyTiles[i].length/2)),
                 y = (byte) (2*(i-SIZE+1));
      final Coordinate tileCoords = new Coordinate(x, y);
      tempEmptyTiles[i][j] = new EmptyTile(counter, tileCoords);
      counter++;
    }
  }
  EmptyTile[] emptyTiles = new EmptyTile[counter];
  counter = 0;
  for(byte j = 0; j < tempEmptyTiles.length; j++) {
    for(byte i = 0; i < tempEmptyTiles[j].length; i++) {
      emptyTiles[counter] = tempEmptyTiles[j][i];
      counter++;
    }
  }
  return emptyTiles;
}
