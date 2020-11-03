class GameObject extends Tile implements Actionable
{
  
  GameObject(int tilePosX, int tilePosY, PImage tileImage)
  {
    super(tilePosX, tilePosY, tileImage);
  }
  
  GameObject(PImage tileImage)
  {
    super(tileImage);
  }
  
  void drawGameObject()
  {
    drawTile();  
  }
  
  void action(Room currentRoom){}
}
