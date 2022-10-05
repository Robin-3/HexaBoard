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

ArrayList<Move> flightMoves(final Board board, final Piece pieceMoved) {
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

ArrayList<Move> surfaceMoves(final Board board, final Piece pieceMoved, final Coordinate[] vectorMove, final boolean infiniteMoves) {
  final ArrayList<Move> legalMoves = new ArrayList<Move>();
  for(Coordinate candidateCoordinateOffset: vectorMove) {
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
      if(!infiniteMoves)
        break;
      candidateDestinationCoordinate = new Coordinate((byte) (candidateDestinationCoordinate.x + candidateCoordinateOffset.x), (byte) (candidateDestinationCoordinate.y + candidateCoordinateOffset.y));
    }
  }
  return legalMoves;
}

ArrayList<Move> fixedMoves(final Board board, final Piece pieceMoved, final boolean infiniteMoves) {
  final Coordinate[] fixedMoves = new Coordinate[3];
                     fixedMoves[0] = pieceMoved.pieceAlliance.getMoveDirection();
                     fixedMoves[1] = pieceMoved.pieceAlliance.getAttackDirection()[0];
                     fixedMoves[2] = pieceMoved.pieceAlliance.getAttackDirection()[1];
  return surfaceMoves(board, pieceMoved, fixedMoves, infiniteMoves);
}

ArrayList<Move> diagonalMoves(final Board board, final Piece pieceMoved, final boolean infiniteMoves) {
  final Coordinate[] diagonalVectorMoves = {
                       new Coordinate((byte)  4, (byte) 0), new Coordinate((byte)  2, (byte)  4), new Coordinate((byte) -2, (byte)  4),
                       new Coordinate((byte) -4, (byte) 0), new Coordinate((byte) -2, (byte) -4), new Coordinate((byte)  2, (byte) -4)
                     };
  return surfaceMoves(board, pieceMoved, diagonalVectorMoves, infiniteMoves);
}

ArrayList<Move> straightMoves(final Board board, final Piece pieceMoved, final boolean infiniteMoves) {
  final Coordinate[] straightVectorMoves = {
                       new Coordinate((byte)  3, (byte)  2), new Coordinate((byte) 0, (byte)  4), new Coordinate((byte) -3, (byte)  2),
                       new Coordinate((byte) -3, (byte) -2), new Coordinate((byte) 0, (byte) -4), new Coordinate((byte)  3, (byte) -2)
                     };
  return surfaceMoves(board, pieceMoved, straightVectorMoves, infiniteMoves);
}
