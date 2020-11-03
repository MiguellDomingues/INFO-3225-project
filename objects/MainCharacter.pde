class MainCharacter extends MovingGameObject
{
  final int STARTING_HEALTH = 6;
  
  String name;
  int currentHealth;
  
  MainCharacter(int tilePosX, int tilePosY, PImage tileImage, String name)
  {
    super(tilePosX, tilePosY, tileImage);
    this.name = name;
    currentHealth = STARTING_HEALTH;
  }
  
  MainCharacter(PImage tileImage)
  {
    super(tileImage);
    currentHealth = STARTING_HEALTH;
  }
  
  void setStartingPosition(int posX, int posY)
  {
    setPosX(posX);
    setPosY(posY);
  }
  
    void setPositionNorthDoor() 
  { 
    mainCharacter.setPosX(int(TILES_X/2));
    mainCharacter.setPosY(1);
  }
  
  
  void setPositionSouthDoor() 
  {
    mainCharacter.setPosX(int(TILES_X/2));
    mainCharacter.setPosY(TILES_Y-2);
  
  }
  
  
  void setPositionEastDoor() 
  {
      mainCharacter.setPosX(TILES_X-2);
    mainCharacter.setPosY(int(TILES_Y/2));
  }
  
 
  void setPositionWestDoor() 
  {
      mainCharacter.setPosX(1);
      mainCharacter.setPosY(int(TILES_Y/2));
  }
  
  void setPositionOnRoomChange(Direction direction)
  {
    switch(direction)
    {
      case NORTH:
        setPositionSouthDoor();
        break;
      case SOUTH:
      setPositionNorthDoor();
         break;
      case EAST:
        setPositionWestDoor();
        break;
      default:
        setPositionEastDoor();
        
    }
    
  }
  
  int getCurrentHealth()
  {
    return currentHealth;
  }
  
  @Override
  void action(Room room)
  {
   println("monster attacked me and stuff!");
   currentHealth--;
    
  }
  
  void increaseHealth()
  {
    currentHealth++;
  }
  
  void takeDamage(int damageTaken)
  {
    currentHealth = currentHealth - damageTaken;
  }
  
  boolean isDead()
  {
    return currentHealth <= 0;
  }
  
  
  
  
  
}
