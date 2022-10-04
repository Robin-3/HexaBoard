abstract class Move {
  final Board board;
  final Piece movedPiece;
  final Coordinate destinationCoordinate;
  
  Move(final Board board, final Piece movedPiece, final Coordinate destinationCoordinate) {
    this.board = board;
    this.movedPiece = movedPiece;
    this.destinationCoordinate = destinationCoordinate;
  }
}

class MajorMove extends Move {
  MajorMove(final Board board, final Piece movedPiece, final Coordinate destinationCoordinate) {
    super(board, movedPiece, destinationCoordinate);
  }
}

class AttackMove extends Move {
  final Piece attackedPiece;
  
  AttackMove(final Board board, final Piece movedPiece, final Coordinate destinationCoordinate, final Piece attackedPiece) {
    super(board, movedPiece, destinationCoordinate);
    this.attackedPiece = attackedPiece;
  }
}

ArrayList<Move> flyMoves(final Board board, final Piece pieceMoved) {
  final Coordinate[] CANDIDATE_MOVE_COORDINATES = {
                       new Coordinate((byte)  7, (byte)  2), new Coordinate((byte)  5, (byte)  6), new Coordinate((byte)  2, (byte)  8),
                       new Coordinate((byte) -2, (byte)  8), new Coordinate((byte) -5, (byte)  6), new Coordinate((byte) -7, (byte)  2),
                       new Coordinate((byte) -7, (byte) -2), new Coordinate((byte) -5, (byte) -6), new Coordinate((byte) -2, (byte) -8),
                       new Coordinate((byte)  2, (byte) -8), new Coordinate((byte)  5, (byte) -6), new Coordinate((byte)  7, (byte) -2)
                     };
  final ArrayList<Move> legalMoves = new ArrayList<Move>();
  for(Coordinate currentCandidate: CANDIDATE_MOVE_COORDINATES) {
    final Coordinate candidateDestinationCoordinate = new Coordinate((byte) (EMPTY_TILES_CACHE[pieceMoved.pieceId].tileCoordinate.x + currentCandidate.x), (byte) (EMPTY_TILES_CACHE[pieceMoved.pieceId].tileCoordinate.y + currentCandidate.y));
    if(coordinateToId(candidateDestinationCoordinate) == -1)
      continue;
    final Tile candidateDestinationTile = board.getTile(candidateDestinationCoordinate);
    if(true || !candidateDestinationTile.isTileOccupied()) {
      legalMoves.add(new MajorMove(board, pieceMoved, candidateDestinationCoordinate));
    } else {
      final Piece pieceDestination = candidateDestinationTile.getPiece();
      final Alliance pieceAlliance = pieceDestination.pieceAlliance;
      if(pieceMoved.pieceAlliance != pieceAlliance) {
        legalMoves.add(new AttackMove(board, pieceMoved, candidateDestinationCoordinate, pieceDestination));
      }
    }
  }
  return legalMoves;
}

ArrayList<Move> diagonalMoves(final Board board, final Piece pieceMoved) {
  final Coordinate[] CANDIDATE_MOVE_VECTOR_COORDINATES = {
                       new Coordinate((byte)  4, (byte) 0), new Coordinate((byte)  2, (byte)  4), new Coordinate((byte) -2, (byte)  4),
                       new Coordinate((byte) -4, (byte) 0), new Coordinate((byte) -2, (byte) -4), new Coordinate((byte)  2, (byte) -4)
                     };
  final ArrayList<Move> legalMoves = new ArrayList<Move>();
  for(Coordinate candidateCoordinateOffset: CANDIDATE_MOVE_VECTOR_COORDINATES) {
    Coordinate candidateDestinationCoordinate = new Coordinate((byte) (EMPTY_TILES_CACHE[pieceMoved.pieceId].tileCoordinate.x + candidateCoordinateOffset.x), (byte) (EMPTY_TILES_CACHE[pieceMoved.pieceId].tileCoordinate.y + candidateCoordinateOffset.y));
    while(coordinateToId(candidateDestinationCoordinate) != -1) {
      final Tile candidateDestinationTile = board.getTile(candidateDestinationCoordinate);
      if(true || !candidateDestinationTile.isTileOccupied()) {
        legalMoves.add(new MajorMove(board, pieceMoved, candidateDestinationCoordinate));
      } else {
        final Piece pieceDestination = candidateDestinationTile.getPiece();
        final Alliance pieceAlliance = pieceDestination.pieceAlliance;
        if(pieceMoved.pieceAlliance != pieceAlliance) {
          legalMoves.add(new AttackMove(board, pieceMoved, candidateDestinationCoordinate, pieceDestination));
        }
      }
      candidateDestinationCoordinate = new Coordinate((byte) (candidateDestinationCoordinate.x + candidateCoordinateOffset.x), (byte) (candidateDestinationCoordinate.y + candidateCoordinateOffset.y));
    }
  }
  return legalMoves;
}
