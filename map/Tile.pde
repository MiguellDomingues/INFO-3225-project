class Tile
{
  PImage tileImage;
  //PImage gameObject;
  int tilePosX;
  int tilePosY;
  
  Tile(int tilePosX, int tilePosY, PImage tileImage)
  {
    this.tilePosX = tilePosX;
    this.tilePosY = tilePosY;
    this.tileImage = tileImage;
  }
  
  Tile(PImage tileImage)
  {
    this.tileImage = tileImage;
  }
  
  void drawTile()
  {
    
    image(tileImage, tilePosX*TILE_WIDTH_PIXELS, tilePosY*TILE_HEIGHT_PIXELS);
  }
  
  int getPosX() { return tilePosX; }
  
  int getPosY() { return tilePosY; }
  
  void setPosX(int posX) { this.tilePosX = posX; }
  
  void setPosY(int posY) { this.tilePosY = posY; }
  
  void setNewTileImage(PImage tileImage)
  {
    this.tileImage = tileImage;
  }
 
  
  
  
}