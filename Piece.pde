// #ADD8E6:(173,216,230), #F39DB2:(243,157,178), #94C191:(148,193,145)
enum Alliance {
  PA,
  RE,
  CI
}

abstract class Piece {
  final short pieceId;
  final Alliance pieceAlliance;
  
  Piece(final short pieceId, final Alliance pieceAlliance) {
    this.pieceId = pieceId;
    this.pieceAlliance = pieceAlliance;
  }
  
  abstract ArrayList<Move> calculateLegalMoves(final Board board);
}

class Dragon extends Piece {
  final Coordinate[] CANDIDATE_MOVE_COORDINATES = {
                       new Coordinate((byte)  7, (byte)  2), new Coordinate((byte)  5, (byte)  6), new Coordinate((byte)  2, (byte)  8),
                       new Coordinate((byte) -2, (byte)  8), new Coordinate((byte) -5, (byte)  6), new Coordinate((byte) -7, (byte)  2),
                       new Coordinate((byte) -7, (byte) -2), new Coordinate((byte) -5, (byte) -6), new Coordinate((byte) -2, (byte) -8),
                       new Coordinate((byte)  2, (byte) -8), new Coordinate((byte)  5, (byte) -6), new Coordinate((byte)  7, (byte) -2)
                     };
  
  Dragon(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    for(Coordinate currentCandidate: CANDIDATE_MOVE_COORDINATES) {
      final Coordinate candidateDestinationCoordinate = new Coordinate((byte) (EMPTY_TILES_CACHE[this.pieceId].tileCoordinate.x + currentCandidate.x), (byte) (EMPTY_TILES_CACHE[this.pieceId].tileCoordinate.y + currentCandidate.y));
      if(coordinateToId(candidateDestinationCoordinate) == -1)
        continue;
      Tile candidateDestinationTile = board.getTile(candidateDestinationCoordinate);
      if(true) {//if(!candidateDestinationTile.isTileOccupied()) {
        legalMoves.add(new MajorMove(board, this, candidateDestinationCoordinate));
      } else {
        final Piece pieceDestination = candidateDestinationTile.getPiece();
        final Alliance pieceAlliance = pieceDestination.pieceAlliance;
        if(this.pieceAlliance != pieceAlliance) {
          legalMoves.add(new AttackMove(board, this, candidateDestinationCoordinate, pieceDestination));
        }
      }
    }
    return legalMoves;
  }
}
