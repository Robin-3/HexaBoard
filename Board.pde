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
    return pieceOnTile.symbol();
  }
}

class Board {
  final Tile[] gameBoard;
  Alliance allianceMovement;
  
  Board(final Alliance allianceMovement) {
    this.gameBoard = new Tile[EMPTY_TILES_CACHE.length];
    for(int i = 0; i < this.gameBoard.length; i++) {
      this.gameBoard[i] = new EmptyTile(EMPTY_TILES_CACHE[i].tileId, EMPTY_TILES_CACHE[i].tileCoordinate);
    }
    this.allianceMovement = allianceMovement;
  }
  
  Board(final Alliance allianceMovement, final Piece[] pieces) {
    this(allianceMovement);
    for(Piece piece: pieces) {
      this.gameBoard[piece.pieceId] = new OccupiedTile(piece.pieceId, EMPTY_TILES_CACHE[piece.pieceId].tileCoordinate, piece);
    }
  }
  
  Tile getTile(final Coordinate tileCoordinate) {
    return null;
  }
  
  Tile getTile(final short tileCoordinate) {
    return null;
  }
}
