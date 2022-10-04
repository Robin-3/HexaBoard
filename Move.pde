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
