class Door
{
  //need to make door extend tile, give it a position, and check ifDoor
  Direction wallDirection;
  
  Door(Direction direction)
  {
    this.wallDirection = direction;
  }
  
  Direction getDirection()
  {
    return wallDirection;
  }
  
  Direction getOppositeDoorDirection()
  {
    switch(wallDirection)
    {
      case NORTH:
        return Direction.SOUTH;
        
      case SOUTH:
          return Direction.NORTH;
      
      case EAST:
          return Direction.WEST;
      
      default:
        return Direction.EAST;
     }
  }
  
  @Override
  boolean equals(Object o)
  {
    Door door = (Door)o;
    
    if(this.getDirection() == door.getDirection())
      return true;
    else
      return false;
  }
}