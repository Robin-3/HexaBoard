class Board {
  final Tile[] gameBoard;
  final Piece[] capturePieces;
  final Alliance[] alliancePieces;
  final Player[] players;
  byte allianceMovement;
  
  Board(final ArrayList<Piece> pieces, final Piece[] capturePieces, final Alliance allianceTurn) {
    this.gameBoard = new Tile[EMPTY_TILES_CACHE.length];
    for(int i = 0; i < this.gameBoard.length; i++) {
      this.gameBoard[i] = new EmptyTile(EMPTY_TILES_CACHE[i].tileId, EMPTY_TILES_CACHE[i].tileCoordinate);
    }
    ArrayList<Alliance> getAlliance = new ArrayList<Alliance>();
    boolean exist;
    for(Piece piece: pieces) {
      this.gameBoard[piece.pieceId] = new OccupiedTile(piece.pieceId, EMPTY_TILES_CACHE[piece.pieceId].tileCoordinate, piece);
      exist = false;
      for(Alliance a: getAlliance) {
        if(a == piece.pieceAlliance) {
          exist = true;
          break;
        }
      }
      if(!exist)
        getAlliance.add(piece.pieceAlliance);
    }
    Alliance[] alliances = new Alliance[getAlliance.size()];
    alliances = getAlliance.toArray(alliances);
    this.alliancePieces = alliances;
    exist = false;
    for(byte i = 0; i < alliancePieces.length; i++) {
      if(alliancePieces[i] == allianceTurn) {
        this.allianceMovement = i;
        exist = true;
        break;
      }
    }
    this.capturePieces = capturePieces;
    if(!exist) throw new IllegalArgumentException("Piece alliance "+allianceTurn+" does not participate in this game.");
    players = new Player[alliances.length];
    for(byte i = 0; i < players.length; i++) {
      players[i] = new Player(this, this.alliancePieces[i], this.getAlliancePieces(this.alliancePieces[i]));
    }
  }
  
  Tile getTile(final Coordinate tileCoordinate) {
    return this.gameBoard[coordinateToId(tileCoordinate)];
  }
  
  Alliance getAllianceMovement() {
    return this.alliancePieces[this.allianceMovement];
  }
  
  Alliance getNextAllianceMovement() {
    final byte allianceNextMovement = (byte) ((this.allianceMovement+1)%this.alliancePieces.length);
    return this.alliancePieces[allianceNextMovement];
  }
  
  Player getPlayerMovement() {
    return this.players[allianceMovement];
  }
  
  ArrayList<Piece> getAlliancePieces(final Alliance pieceAlliance) {
    final ArrayList<Piece> pieces = new ArrayList<Piece>();
    for(Tile tile: gameBoard)
      if(tile.isTileOccupied() && tile.getPiece().pieceAlliance == pieceAlliance)
        pieces.add(tile.getPiece());
    return pieces;
  }
  
  ArrayList<Move> getActualAllMoves() {
    return this.getPlayerAllMoves(this.getPlayerMovement());
  }
  
  ArrayList<Move> getPlayerAllMoves(final Player player) {
    return player.getAllMoves();
  }
  
  ArrayList<Move> getActualLegalMoves() {
    return this.getLegalMoves(this.getPlayerMovement());
  }
  
  ArrayList<Move> getLegalMoves(final Player player) {
    return player.getLegalMoves();
  }
  
  @Override
  String toString() {
    ArrayList<String> boardNotation = new ArrayList<String>();
    for(Tile tile: gameBoard) {
      if(tile.isTileOccupied()) {
        boardNotation.add(tile.toString());
      }
    }
    return this.getAllianceMovement()+":"+String.join(",", boardNotation);
  }
}
