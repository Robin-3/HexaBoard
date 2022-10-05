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

Piece[] formationStandard() {
  ArrayList<Piece> formationList = new ArrayList<Piece>();
  //first alliance
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -8, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -6, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -4, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -2, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   0, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   2, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   4, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   6, (byte)  12)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   8, (byte)  12)), Alliance.PA));
    
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -9, (byte)  14)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -7, (byte)  14)), Alliance.PA));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)  -5, (byte)  14)), Alliance.PA));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)  -3, (byte)  14)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -1, (byte)  14)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   1, (byte)  14)), Alliance.PA));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)   3, (byte)  14)), Alliance.PA));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)   5, (byte)  14)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   7, (byte)  14)), Alliance.PA));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   9, (byte)  14)), Alliance.PA));
  
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte)  -8, (byte)  16)), Alliance.PA));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)  -6, (byte)  16)), Alliance.PA));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)  -4, (byte)  16)), Alliance.PA));
    formationList.add(new Mimic  (coordinateToId(new Coordinate((byte)  -2, (byte)  16)), Alliance.PA));
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte)   0, (byte)  16)), Alliance.PA));
    formationList.add(new Ghost  (coordinateToId(new Coordinate((byte)   2, (byte)  16)), Alliance.PA));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)   4, (byte)  16)), Alliance.PA));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)   6, (byte)  16)), Alliance.PA));
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte)   8, (byte)  16)), Alliance.PA));
  
  //second alliance
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -5, (byte) -14)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -6, (byte) -12)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -7, (byte) -10)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -8, (byte)  -8)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -9, (byte)  -6)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -10, (byte)  -4)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -11, (byte)  -2)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -12, (byte)   0)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -13, (byte)   2)), Alliance.CI));
    
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -6, (byte) -16)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  -7, (byte) -14)), Alliance.CI));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)  -8, (byte) -12)), Alliance.CI));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)  -9, (byte) -10)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -10, (byte)  -8)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -11, (byte)  -6)), Alliance.CI));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte) -12, (byte)  -4)), Alliance.CI));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte) -13, (byte)  -2)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -14, (byte)   0)), Alliance.CI));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte) -15, (byte)   2)), Alliance.CI));
  
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte)  -8, (byte) -16)), Alliance.CI));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)  -9, (byte) -14)), Alliance.CI));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte) -10, (byte) -12)), Alliance.CI));
    formationList.add(new Mimic  (coordinateToId(new Coordinate((byte) -11, (byte) -10)), Alliance.CI));
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte) -12, (byte)  -8)), Alliance.CI));
    formationList.add(new Ghost  (coordinateToId(new Coordinate((byte) -13, (byte)  -6)), Alliance.CI));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte) -14, (byte)  -4)), Alliance.CI));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte) -15, (byte)  -2)), Alliance.CI));
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte) -16, (byte)   0)), Alliance.CI));
  
  //third alliance
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  13, (byte)   2)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  12, (byte)   0)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  11, (byte)  -2)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  10, (byte)  -4)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   9, (byte)  -6)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   8, (byte)  -8)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   7, (byte) -10)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   6, (byte) -12)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   5, (byte) -14)), Alliance.MU));
    
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  15, (byte)   2)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  14, (byte)   0)), Alliance.MU));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)  13, (byte)  -2)), Alliance.MU));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)  12, (byte)  -4)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  11, (byte)  -6)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)  10, (byte)  -8)), Alliance.MU));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)   9, (byte) -10)), Alliance.MU));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)   8, (byte) -12)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   7, (byte) -14)), Alliance.MU));
    formationList.add(new Assasin(coordinateToId(new Coordinate((byte)   6, (byte) -16)), Alliance.MU));
  
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte)  16, (byte)   0)), Alliance.MU));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)  15, (byte)  -2)), Alliance.MU));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)  14, (byte)  -4)), Alliance.MU));
    formationList.add(new Mimic  (coordinateToId(new Coordinate((byte)  13, (byte)  -6)), Alliance.MU));
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte)  12, (byte)  -8)), Alliance.MU));
    formationList.add(new Ghost  (coordinateToId(new Coordinate((byte)  11, (byte) -10)), Alliance.MU));
    formationList.add(new Dragon (coordinateToId(new Coordinate((byte)  10, (byte) -12)), Alliance.MU));
    formationList.add(new Wizard (coordinateToId(new Coordinate((byte)   9, (byte) -14)), Alliance.MU));
    formationList.add(new Elf    (coordinateToId(new Coordinate((byte)   8, (byte) -16)), Alliance.MU));
  
  Piece[] formation = new Piece[formationList.size()];
  formation = formationList.toArray(formation);
  return formation;
}
