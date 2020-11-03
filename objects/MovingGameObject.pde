class MovingGameObject extends GameObject
{
  MovingGameObject(int tilePosX, int tilePosY, PImage tileImage)
  {
    super(tilePosX, tilePosY, tileImage);
  }
  
  MovingGameObject(PImage tileImage)
  {
    super(tileImage);
  }
  
  void changeTile(Direction direction)
  {
    tilePosX+=direction.getPosX();
    tilePosY+=direction.getPosY();
  }
  
  void action(Room room)
  {
    /*
    println("attacking and killing monster then dropping a heart!!");
    room.getMovingGameObjects().remove(this);
    
    GameObject heartContainer = gameObjectFactory.buildHeartContainer();
    heartContainer.setPosX(tilePosX);
    heartContainer.setPosY(tilePosY);
    
    room.getGameObjects().add(heartContainer);
    */
    
  }
  
}