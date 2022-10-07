static class Coordinate {
  final byte x, y;
  
  Coordinate(final byte x, final byte y) {
    this.x = x;
    this.y = y;
  }
  
  @Override
  String toString() {
    return "("+x+","+y+")";
  }
}

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
