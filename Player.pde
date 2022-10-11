class Player {
  final Board board;
  final Alliance playerAlliance;
  final Ghost playerGhost;
  final ArrayList<Piece> playerPieces;
  
  Player(final Board board, final Alliance playerAlliance, final ArrayList<Piece> playerPieces) {
    this.board = board;
    this.playerAlliance = playerAlliance;
    this.playerPieces = playerPieces;
    boolean exist = false, isOne = true;
    Piece tempPiece = null;
    for(final Piece piece: this.playerPieces) {
      if(piece.pieceType == PieceType.GHOST || piece.pieceType == PieceType.DOPPELGANGER) {
        if(exist)
          isOne = false;
        else
          exist = true;
        tempPiece = piece;
      }
    }
    if(!exist || !isOne) throw new IllegalArgumentException("There should only be one Ghost piece in the game for alliance "+this.playerAlliance+".");
    this.playerGhost = (Ghost) tempPiece;
  }
  
  ArrayList<Move> getAllMoves() {
    final ArrayList<Move> moves = new ArrayList<Move>();
    for(final Piece piece: this.playerPieces) {
      moves.addAll(piece.calculateAllMoves(this.board));
    }
    return moves;
  }
  
  ArrayList<Move> getLegalMoves() {
    final ArrayList<Move> moves = new ArrayList<Move>();
    for(final Piece piece: this.playerPieces) {
      moves.addAll(piece.calculateLegalMoves(this.board));
    }
    return moves;
  }
}
