class NuclearBomb extends GameObject
{
  NuclearBomb(PImage tileImage)
  {
    super(tileImage);
  }
  
  @Override
  void action(Room room)
  {
    println("picked up a BOMB!! at " + tilePosX + " " + tilePosY + " in room " + room.getRoomNumber());
    //println("removing it from the map!");
    room.getGameObjects().remove(this);
    room.getMovingGameObjects().clear();
  
  }
  
}
