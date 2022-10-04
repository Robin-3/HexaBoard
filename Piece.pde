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
  Dragon(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return flightMoves(board, this);
  }
}

class Wizard extends Piece {
  Wizard(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return diagonalMoves(board, this);
  }
}

class Elf extends Piece {
  Elf(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return straightMoves(board, this);
  }
}

class Doppelganger extends Piece {
  Doppelganger(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    legalMoves.addAll(diagonalMoves(board, this));
    legalMoves.addAll(straightMoves(board, this));
    return legalMoves;
  }
}
