// #ADD8E6:(173,216,230), #F39DB2:(243,157,178), #94C191:(148,193,145)
enum Alliance {
  NO {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte) -3, (byte) -2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte) -4, (byte)  0), new Coordinate((byte) -2, (byte) -4)};}
  },
  PA {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  0, (byte) -4);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte) -2, (byte) -4), new Coordinate((byte)  2, (byte) -4)};}
  },
  RE {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  3, (byte) -2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte)  2, (byte) -4), new Coordinate((byte)  4, (byte)  0)};}
  },
  CI {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  3, (byte)  2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte)  4, (byte)  0), new Coordinate((byte)  2, (byte)  4)};}
  },
  VO {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  0, (byte)  4);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte)  2, (byte)  4), new Coordinate((byte) -2, (byte)  4)};}
  },
  MU {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte) -3, (byte)  2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte) -2, (byte) 4), new Coordinate((byte) -4, (byte) 0)};}
  };
  
  abstract Coordinate getMoveDirection();
  abstract Coordinate[] getAttackDirection();
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

class Assasin extends Piece {
  Assasin(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return fixedMoves(board, this, false);
  }
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
    return diagonalMoves(board, this, true);
  }
}

class Elf extends Piece {
  Elf(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return straightMoves(board, this, true);
  }
}

class Mimic extends Piece {
  Mimic(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    legalMoves.addAll(diagonalMoves(board, this, false));
    legalMoves.addAll(straightMoves(board, this, false));
    return legalMoves;
  }
}

class Doppelganger extends Piece {
  Doppelganger(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    legalMoves.addAll(diagonalMoves(board, this, true));
    legalMoves.addAll(straightMoves(board, this, true));
    return legalMoves;
  }
}
