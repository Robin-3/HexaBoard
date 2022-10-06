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

Board formationStandard() {
  return loadBoard("1:0.E.3,1.A.3,7.A.5,8.E.5,9.D.3,10.A.3,11.A.3,16.A.5,17.A.5,18.W.5,19.W.3,20.W.3,21.A.3,27.A.5,28.W.5,29.D.5,30.M.3,31.D.3,32.A.3,39.A.5,40.D.5,41.G.5,42.E.3,43.A.3,44.A.3,52.A.5,53.A.5,54.E.5,55.G.3,56.A.3,57.A.3,66.A.5,67.A.5,68.M.5,69.D.3,70.D.3,71.A.3,81.A.5,82.D.5,83.W.5,84.W.3,85.W.3,86.A.3,97.A.5,98.W.5,99.D.5,100.E.3,101.A.3,102.A.3,114.A.5,115.A.5,116.E.5,117.A.3,118.A.3,131.A.5,132.A.5,188.A.1,189.A.1,190.A.1,191.A.1,192.A.1,193.A.1,194.A.1,195.A.1,196.A.1,198.A.1,199.A.1,200.W.1,201.D.1,202.A.1,203.A.1,204.D.1,205.W.1,206.A.1,207.A.1,208.E.1,209.D.1,210.W.1,211.M.1,212.E.1,213.G.1,214.D.1,215.W.1,216.E.1");
}

Board loadBoard(final String board) {
  final String[] boardConfig = board.split(":");
  if(boardConfig.length != 2) {throw new IllegalArgumentException("Error Board notation.");}
  final Alliance boardAllianceMovement = codeToAlliance((byte) Integer.parseInt(boardConfig[0]));
  final ArrayList<Piece> pieces = new ArrayList<Piece>();
  final String[] boardPieces = boardConfig[1].split(",");
  for(String piece: boardPieces) {
    final String[] pieceData = piece.split("\\.");
    if(pieceData.length != 3) {throw new IllegalArgumentException("Error Piece data.");}
    final short pieceId = (short) Integer.parseInt(pieceData[0]);
    final Alliance pieceAlliance = codeToAlliance((byte) Integer.parseInt(pieceData[2]));
    final char type = pieceData[1].charAt(0);
    final Piece pieceType;
    switch(type) {
      case 'A': pieceType = new Assasin(pieceId, pieceAlliance); break;
      case 'D': pieceType = new Dragon (pieceId, pieceAlliance); break;
      case 'W': pieceType = new Wizard (pieceId, pieceAlliance); break;
      case 'E': pieceType = new Elf    (pieceId, pieceAlliance); break;
      case 'M': pieceType = new Mimic  (pieceId, pieceAlliance); break;
      case 'G': pieceType = new Ghost  (pieceId, pieceAlliance); break;
      default: throw new IllegalArgumentException("Piece type "+type+" does not exist.");
    }
    pieces.add(pieceType);
  }
  return new Board(pieces, boardAllianceMovement);
}

Alliance codeToAlliance(final byte code) {
  final Alliance alliance;
  switch(code) {
    case 0: alliance = Alliance.NO; break;
    case 1: alliance = Alliance.PA; break;
    case 2: alliance = Alliance.RE; break;
    case 3: alliance = Alliance.CI; break;
    case 4: alliance = Alliance.VO; break;
    case 5: alliance = Alliance.MU; break;
    default: throw new IllegalArgumentException("Piece alliance "+code+" does not exist.");
  }
  return alliance;
}
