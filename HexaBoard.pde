final byte SIZE = 9,
           edges = 6,
           pieceEdges = 5;
short cursorSelection = coordinateToId(new Coordinate((byte) 0, (byte) 0)),
      selectedTile = -1;
final EmptyTile[] EMPTY_TILES_CACHE = createAllPossibleEmptyTiles();
Board standardBoard = formation2players();
ArrayList<Move> moves = standardBoard.getActualAllMoves();
PImage boardImage;
PGraphics pieceText;
final byte iSize = SIZE*2-1;
final float piecePaddingPercentaje = 0.9;
float h, w;
final HashMap<String, Integer> boardColors = loadBoardColors();

void setup() {
  size(512, 512);
  h = height/(iSize+.0);
  w = width/(iSize+.0);
  boardImage = drawBoard();
  pieceText = createGraphics(width, height);
  noLoop();
}

void draw() {
  background(boardColors.get("gameBackground"));
  image(boardImage, 0, 0);
  drawPieces();
  if(selectedTile != -1)
    drawMoves();
  drawSelection();
  image(pieceText, 0 , 0);
}
