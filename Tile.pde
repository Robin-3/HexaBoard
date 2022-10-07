abstract class Tile {
  final short tileId; //unsigned byte is better
  final Coordinate tileCoordinate;
  
  Tile(final short tileId, final Coordinate tileCoordinate) {
    this.tileId = tileId;
    this.tileCoordinate = tileCoordinate;
  }
  
  abstract boolean isTileOccupied();
  abstract Piece getPiece();
}

class EmptyTile extends Tile {
  EmptyTile(final short tileId, final Coordinate tileCoordinate) {
    super(tileId, tileCoordinate);
  }
  
  @Override
  boolean isTileOccupied() {
    return false;
  }
  
  @Override
  Piece getPiece() {
    return null;
  }

  @Override
  String toString() {
    return tileId+".-.-";
  }
}

class OccupiedTile extends Tile {
  final Piece pieceOnTile;
  
  OccupiedTile(final short tileId, final Coordinate tileCoordinate, final Piece pieceOnTile) {
    super(tileId, tileCoordinate);
    this.pieceOnTile = pieceOnTile;
  }
  
  @Override
  boolean isTileOccupied() {
    return true;
  }
  
  @Override
  Piece getPiece() {
    return pieceOnTile;
  }
  
  @Override
  String toString() {
    return tileId+"."+pieceOnTile.pieceType.toString()+"."+pieceOnTile.pieceAlliance.toString();
  }
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
