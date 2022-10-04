class Coordinate {
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

abstract class Tile {
  final short tileId; //unsigned byte is better
  final Coordinate tileCoordinate;
  
  Tile(final short tileId, final Coordinate tileCoordinate) {
    this.tileId = tileId;
    this.tileCoordinate = tileCoordinate;
  }
  
  Tile createTile(final short tileId, final Piece piece) {
    return piece == null? EMPTY_TILES_CACHE[tileId]: new OccupiedTile(tileId, EMPTY_TILES_CACHE[tileId].tileCoordinate, piece);
  }
  
  abstract boolean isTileOccupied();
  abstract Piece getPiece();

  @Override
  String toString() {
    return ""+tileId+":"+tileCoordinate;
  }
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
}

class Board {
  Tile getTile(final Coordinate tileCoordinate) {
    return null;
  }
  
  Tile getTile(final short tileCoordinate) {
    return null;
  }
}
