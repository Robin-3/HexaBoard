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

class Board {
  final Tile[] gameBoard;
  final Alliance[] alliancePieces;
  byte allianceMovement;
  
  Board(final ArrayList<Piece> pieces, Alliance allianceTurn) {
    this.gameBoard = new Tile[EMPTY_TILES_CACHE.length];
    for(int i = 0; i < this.gameBoard.length; i++) {
      this.gameBoard[i] = new EmptyTile(EMPTY_TILES_CACHE[i].tileId, EMPTY_TILES_CACHE[i].tileCoordinate);
    }
    ArrayList<Alliance> getAlliance = new ArrayList<Alliance>();
    boolean exist;
    for(Piece piece: pieces) {
      this.gameBoard[piece.pieceId] = new OccupiedTile(piece.pieceId, EMPTY_TILES_CACHE[piece.pieceId].tileCoordinate, piece);
      exist = false;
      for(Alliance a: getAlliance) {
        if(a == piece.pieceAlliance) {
          exist = true;
          break;
        }
      }
      if(!exist)
        getAlliance.add(piece.pieceAlliance);
    }
    Alliance[] alliances = new Alliance[getAlliance.size()];
    alliances = getAlliance.toArray(alliances);
    this.alliancePieces = alliances;
    exist = false;
    for(byte i = 0; i < alliancePieces.length; i++) {
      if(alliancePieces[i] == allianceTurn) {
        this.allianceMovement = i;
        exist = true;
        break;
      }
    }
    if(!exist) throw new IllegalArgumentException("Piece alliance "+allianceTurn+" does not participate in this game.");
  }
  
  Tile getTile(final Coordinate tileCoordinate) {
    return this.gameBoard[coordinateToId(tileCoordinate)];
  }
  
  Alliance getAllianceMovement() {
    return this.alliancePieces[allianceMovement];
  }
  
  ArrayList<Piece> getAlliancePieces(final Alliance pieceAlliance) {
    final ArrayList<Piece> pieces = new ArrayList<Piece>();
    for(Tile tile: gameBoard)
      if(tile.isTileOccupied() && tile.getPiece().pieceAlliance == pieceAlliance)
        pieces.add(tile.getPiece());
    return pieces;
  }
  
  ArrayList<Move> getAllMoves() {
    final ArrayList<Move> moves = new ArrayList<Move>();
    final ArrayList<Piece> getPieces = this.getAlliancePieces(this.getAllianceMovement());
    for(Piece piece: getPieces) {
      moves.addAll(piece.calculateLegalMoves(this));
    }
    return moves;
  }
  
  @Override
  String toString() {
    ArrayList<String> boardNotation = new ArrayList<String>();
    for(Tile tile: gameBoard) {
      if(tile.isTileOccupied()) {
        boardNotation.add(tile.toString());
      }
    }
    return this.getAllianceMovement()+":"+String.join(",", boardNotation);
  }
}
