class HeartContainer extends GameObject 
{
  HeartContainer(PImage tileImage)
  {
    super(tileImage);
  }
  
  @Override
  void action(Room room)
  {
    println("picked up a heart at " + tilePosX + " " + tilePosY + " in room " + room.getRoomNumber());
   // println("removing it from the map!");
    room.getMainCharacter().increaseHealth();
    room.getGameObjects().remove(this);
  
  }
  
}
