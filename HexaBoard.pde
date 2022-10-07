final byte SIZE = 9,
           edges = 6;
short cursorSelection = coordinateToId(new Coordinate((byte) 0, (byte) 0));
short selectedTile = -1;
final EmptyTile[] EMPTY_TILES_CACHE = createAllPossibleEmptyTiles();
Board standardBoard = formationStandard();
ArrayList<Move> moves = standardBoard.getValidMoves();
PImage boardImage;
final byte iSize = SIZE*2-1;
float h, w;

void setup() {
  size(512, 512);
  textAlign(CENTER, CENTER);
  h = height/(iSize+.0);
  w = width/(iSize+.0);
  boardImage = drawBoard();
  noLoop();
}

void draw() {
  image(boardImage, 0, 0);
  drawPieces();
  if(selectedTile != -1)
    drawMoves();
  drawSelection();
}
