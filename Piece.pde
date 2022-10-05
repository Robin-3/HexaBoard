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
  abstract String symbol();
}

class Assasin extends Piece {
  Assasin(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return fixedMoves(board, this, false);
  }
  
  @Override
  String symbol() {
    return "A";
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

  @Override
  String symbol() {
    return "D";
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

  @Override
  String symbol() {
    return "W";
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

  @Override
  String symbol() {
    return "E";
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

  @Override
  String symbol() {
    return "M";
  }
}

class Ghost extends Piece {
  Ghost(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    legalMoves.addAll(diagonalMoves(board, this, true));
    legalMoves.addAll(straightMoves(board, this, true));
    return legalMoves;
  }

  @Override
  String symbol() {
    return "G";
  }
}
