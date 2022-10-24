abstract class Move {
  final Board board;
  final Piece movedPiece;
  final Coordinate destinationCoordinate;
  
  Move(final Board board, final Piece movedPiece, final Coordinate destinationCoordinate) {
    this.board = board;
    this.movedPiece = movedPiece;
    this.destinationCoordinate = destinationCoordinate;
  }
  
  abstract Board execute();
}

class MajorMove extends Move {
  MajorMove(final Board board, final Piece movedPiece, final Coordinate destinationCoordinate) {
    super(board, movedPiece, destinationCoordinate);
  }
  
  @Override
  Board execute() {
    if(!this.board.getActualLegalMoves().contains(this))
      return this.board;
    final ArrayList<Piece> pieces = new ArrayList<Piece>();
    for(final Alliance alliance: this.board.alliancePieces) {
      pieces.addAll(this.board.getAlliancePieces(alliance));
    }
    pieces.remove(this.movedPiece);
    final Piece moved = codeToPiece(this.movedPiece.pieceType.toString().charAt(0), coordinateToId(this.destinationCoordinate), this.movedPiece.pieceAlliance);
    pieces.add(moved);
    final Alliance nextMovement = this.board.getNextAllianceMovement();
    return new Board(pieces, this.board.capturePieces, nextMovement);
  }
  
  @Override
  String toString() {
    return "MM:"+this.movedPiece.pieceType+"."+this.movedPiece.pieceId+"->"+this.destinationCoordinate+":-";
  }
  
  @Override
  boolean equals(Object other) {
    if(!(other instanceof MajorMove))
      return false;
    MajorMove ptr = (MajorMove) other;
    return ptr.toString().equals(this.toString());
  }
}

class AttackMove extends Move {
  final Piece attackedPiece;
  
  AttackMove(final Board board, final Piece movedPiece, final Coordinate destinationCoordinate, final Piece attackedPiece) {
    super(board, movedPiece, destinationCoordinate);
    this.attackedPiece = attackedPiece;
  }
  
  @Override
  Board execute() {
    if(!this.board.getActualLegalMoves().contains(this))
      return this.board;
    final short startId = this.movedPiece.pieceId;
    final short endId = coordinateToId(this.destinationCoordinate);
    final ArrayList<Piece> pieces = new ArrayList<Piece>();
    for(final Alliance alliance: this.board.alliancePieces) {
      final ArrayList<Piece> piecesOfAlliance = this.board.getAlliancePieces(alliance);
      for(final Piece piece: piecesOfAlliance) {
        if(piece.pieceId == startId || piece.pieceId == endId)
          continue;
        pieces.add(piece);
      }
    }
    final Piece moved = codeToPiece(this.movedPiece.pieceType.toString().charAt(0), coordinateToId(this.destinationCoordinate), this.movedPiece.pieceAlliance);
    pieces.add(moved);
    final Alliance nextMovement = this.board.getNextAllianceMovement();
    return new Board(pieces, this.board.capturePieces, nextMovement);
  }

  @Override
  String toString() {
    return "AM:"+this.movedPiece.pieceType+"."+this.movedPiece.pieceId+"->"+this.destinationCoordinate+":"+this.attackedPiece.pieceType;
  }
  
  @Override
  boolean equals(Object other) {
    if(!(other instanceof AttackMove))
      return false;
    AttackMove ptr = (AttackMove) other;
    return ptr.toString().equals(this.toString());
  }
}

class ProtectMove extends Move {
  final Piece protectPiece;
  
  ProtectMove(final Board board, final Piece movedPiece, final Coordinate destinationCoordinate, final Piece protectPiece) {
    super(board, movedPiece, destinationCoordinate);
    this.protectPiece = protectPiece;
  }
  
  @Override
  Board execute() {
    return this.board;
  }

  @Override
  String toString() {
    return "PM:"+this.movedPiece.pieceType+"."+this.movedPiece.pieceId+"~"+this.destinationCoordinate+":"+this.protectPiece.pieceType;
  }
  
  @Override
  boolean equals(Object other) {
    if(!(other instanceof ProtectMove))
      return false;
    ProtectMove ptr = (ProtectMove) other;
    return ptr.toString().equals(this.toString());
  }
}

ArrayList<Move> calculateAllMoves(final Board board, final Piece pieceMoved, final Coordinate[] vectorMove, final boolean infiniteMoves, final boolean isDiagonal) {
  final ArrayList<Move> legalMoves = new ArrayList<Move>();
  for(Coordinate candidateCoordinateOffset: vectorMove) {
    Coordinate candidateDestinationCoordinate = new Coordinate((byte) (EMPTY_TILES_CACHE[pieceMoved.pieceId].tileCoordinate.x + candidateCoordinateOffset.x), (byte) (EMPTY_TILES_CACHE[pieceMoved.pieceId].tileCoordinate.y + candidateCoordinateOffset.y));
    while(coordinateToId(candidateDestinationCoordinate) != -1) {
      if(isDiagonal) {
        final Coordinate diagonalDestinationCoordinate = new Coordinate((byte) (candidateDestinationCoordinate.x - candidateCoordinateOffset.x/2), (byte) (candidateDestinationCoordinate.y - candidateCoordinateOffset.y/2));
        final Tile diagonalDestinationTile = board.getTile(diagonalDestinationCoordinate);
        if(diagonalDestinationTile.isTileOccupied()) {
          break;
        }
      }
      final Tile candidateDestinationTile = board.getTile(candidateDestinationCoordinate);
      if(!candidateDestinationTile.isTileOccupied()) {
        legalMoves.add(new MajorMove(board, pieceMoved, candidateDestinationCoordinate));
      } else {
        final Piece pieceDestination = candidateDestinationTile.getPiece();
        final Alliance pieceAlliance = pieceDestination.pieceAlliance;
        if(pieceMoved.pieceAlliance != pieceAlliance) {
          legalMoves.add(new AttackMove(board, pieceMoved, candidateDestinationCoordinate, pieceDestination));
          break;
        } else {
          legalMoves.add(new ProtectMove(board, pieceMoved, candidateDestinationCoordinate, pieceDestination));
          break;
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
  final ArrayList<Move> attackMoves = new ArrayList<Move>();
  final Coordinate[] attackMove = pieceMoved.pieceAlliance.getAttackDirection();
  attackMoves.addAll(calculateAllMoves(board, pieceMoved, attackMove, infiniteMoves, false));
  for(int i = attackMoves.size()-1;  i >= 0; i--) {
    if(attackMoves.get(i).getClass().getSimpleName().equals("MajorMove")) {
      attackMoves.remove(i);
    }
  }
  final ArrayList<Move> moves = new ArrayList<Move>();
  final Coordinate[] majorMoves = pieceMoved.pieceAlliance.getMajorDirection();
  moves.addAll(calculateAllMoves(board, pieceMoved, majorMoves, infiniteMoves, true));
  for(int i = moves.size()-1;  i >= 0; i--) {
    if(!moves.get(i).getClass().getSimpleName().equals("MajorMove")) {
      moves.remove(i);
    }
  }
  moves.addAll(attackMoves);
  return moves;
}

ArrayList<Move> flightMoves(final Board board, final Piece pieceMoved, final boolean infiniteMoves) {
  final Coordinate[] flightMoves = {
                       new Coordinate((byte)  7, (byte)  2), new Coordinate((byte)  5, (byte)  6), new Coordinate((byte)  2, (byte)  8),
                       new Coordinate((byte) -2, (byte)  8), new Coordinate((byte) -5, (byte)  6), new Coordinate((byte) -7, (byte)  2),
                       new Coordinate((byte) -7, (byte) -2), new Coordinate((byte) -5, (byte) -6), new Coordinate((byte) -2, (byte) -8),
                       new Coordinate((byte)  2, (byte) -8), new Coordinate((byte)  5, (byte) -6), new Coordinate((byte)  7, (byte) -2)
                     };
  return calculateAllMoves(board, pieceMoved, flightMoves, infiniteMoves, false);
}

ArrayList<Move> diagonalMoves(final Board board, final Piece pieceMoved, final boolean infiniteMoves) {
  final Coordinate[] diagonalVectorMoves = {
                       new Coordinate((byte)  4, (byte) 0), new Coordinate((byte)  2, (byte)  4), new Coordinate((byte) -2, (byte)  4),
                       new Coordinate((byte) -4, (byte) 0), new Coordinate((byte) -2, (byte) -4), new Coordinate((byte)  2, (byte) -4)
                     };
  return calculateAllMoves(board, pieceMoved, diagonalVectorMoves, infiniteMoves, true);
}

ArrayList<Move> straightMoves(final Board board, final Piece pieceMoved, final boolean infiniteMoves) {
  final Coordinate[] straightVectorMoves = {
                       new Coordinate((byte)  3, (byte)  2), new Coordinate((byte) 0, (byte)  4), new Coordinate((byte) -3, (byte)  2),
                       new Coordinate((byte) -3, (byte) -2), new Coordinate((byte) 0, (byte) -4), new Coordinate((byte)  3, (byte) -2)
                     };
  return calculateAllMoves(board, pieceMoved, straightVectorMoves, infiniteMoves, false);
}
