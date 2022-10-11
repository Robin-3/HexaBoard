enum Alliance {
  NO((byte) 0) {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte) -3, (byte) -2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte) -4, (byte)  0), new Coordinate((byte) -2, (byte) -4)};}
  },
  PA((byte) 1) {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  0, (byte) -4);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte) -2, (byte) -4), new Coordinate((byte)  2, (byte) -4)};}
  },
  RE((byte) 2) {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  3, (byte) -2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte)  2, (byte) -4), new Coordinate((byte)  4, (byte)  0)};}
  },
  CI((byte) 3) {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  3, (byte)  2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte)  4, (byte)  0), new Coordinate((byte)  2, (byte)  4)};}
  },
  VO((byte) 4) {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte)  0, (byte)  4);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte)  2, (byte)  4), new Coordinate((byte) -2, (byte)  4)};}
  },
  MU((byte) 5) {
    @Override Coordinate getMoveDirection() {return new Coordinate((byte) -3, (byte)  2);}
    @Override Coordinate[] getAttackDirection() {return new Coordinate[] {new Coordinate((byte) -2, (byte) 4), new Coordinate((byte) -4, (byte) 0)};}
  };
  
  byte allianceName;
  Alliance(final byte allianceName) {this.allianceName = allianceName;}
  @Override String toString() {return ""+this.allianceName;}
  abstract Coordinate getMoveDirection();
  abstract Coordinate[] getAttackDirection();
}

enum PieceType {
  ASSASIN('A'),
  DRAGON('D'),
  WIZARD('W'),
  ELF('E'),
  MIMIC('M'),
  GHOST('G'),
  DOPPELGANGER('Ä');
  
  char pieceName;
  PieceType(final char pieceName) {this.pieceName = pieceName;}
  @Override String toString() {return ""+this.pieceName;}
}

abstract class Piece {
  final short pieceId;
  final Alliance pieceAlliance;
  final PieceType pieceType;
  
  Piece(final short pieceId, final Alliance pieceAlliance, final PieceType pieceType) {
    this.pieceId = pieceId;
    this.pieceAlliance = pieceAlliance;
    this.pieceType = pieceType;
  }
  
  abstract ArrayList<Move> calculateAllMoves(final Board board);
  abstract ArrayList<Move> calculateLegalMoves(final Board board);
}

class Assasin extends Piece {
  Assasin(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance, PieceType.ASSASIN);
  }
  
  @Override
  ArrayList<Move> calculateAllMoves(final Board board) {
    return fixedMoves(board, this, false);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return this.calculateAllMoves(board);
  }
}

class Dragon extends Piece {
  Dragon(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance, PieceType.DRAGON);
  }
  
  @Override
  ArrayList<Move> calculateAllMoves(final Board board) {
    return flightMoves(board, this, false);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return this.calculateAllMoves(board);
  }
}

class Wizard extends Piece {
  Wizard(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance, PieceType.WIZARD);
  }
  
  @Override
  ArrayList<Move> calculateAllMoves(final Board board) {
    return diagonalMoves(board, this, true);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return this.calculateAllMoves(board);
  }
}

class Elf extends Piece {
  Elf(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance, PieceType.ELF);
  }
  
  @Override
  ArrayList<Move> calculateAllMoves(final Board board) {
    return straightMoves(board, this, true);
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return this.calculateAllMoves(board);
    //final ArrayList<Move> allMoves = this.calculateAllMoves(board);
    //for(int i = allMoves.size()-1;  i >= 0; i--) {
    //  println(allMoves.get(i));
    //  if(allMoves.get(i).getClass().getSimpleName().equals("MajorMove")) {
    //    allMoves.remove(i);
    //  }
    //}
    //return allMoves;
  }
}

class Mimic extends Piece {
  Mimic(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance, PieceType.MIMIC);
  }
  
  @Override
  ArrayList<Move> calculateAllMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    legalMoves.addAll(diagonalMoves(board, this, false));
    legalMoves.addAll(straightMoves(board, this, false));
    return legalMoves;
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return this.calculateAllMoves(board);
  }
}

class Ghost extends Piece {
  Ghost(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance, PieceType.GHOST);
  }
  
  Ghost(final short pieceId, final Alliance pieceAlliance, final PieceType pieceType) {
    super(pieceId, pieceAlliance, pieceType);
  }
  
  @Override
  ArrayList<Move> calculateAllMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    legalMoves.addAll(diagonalMoves(board, this, false));
    legalMoves.addAll(straightMoves(board, this, false));
    legalMoves.addAll(flightMoves(board, this, false));
    return legalMoves;
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return this.calculateAllMoves(board);
  }
}

class Doppelganger extends Ghost {
  Doppelganger(final short pieceId, final Alliance pieceAlliance) {
    super(pieceId, pieceAlliance, PieceType.DOPPELGANGER);
  }
  
  @Override
  ArrayList<Move> calculateAllMoves(final Board board) {
    final ArrayList<Move> legalMoves = new ArrayList<Move>();
    legalMoves.addAll(diagonalMoves(board, this, true));
    legalMoves.addAll(straightMoves(board, this, true));
    return legalMoves;
  }
  
  @Override
  ArrayList<Move> calculateLegalMoves(final Board board) {
    return this.calculateAllMoves(board);
  }
}
