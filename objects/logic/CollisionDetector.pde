//this class finds walls, monsters, obstracles, room doors and other objects to compare there positions to each other and the main character
//all data will be fetched from the current room

class CollisionDetector
{
  Room currentRoom;
  RunningGameState runningGameState;
  
  CollisionDetector(Room currentRoom, RunningGameState runningGameState)
  {
    this.currentRoom = currentRoom;
    this.runningGameState = runningGameState;
    
  }
  
  void setCurrentRoom(Room room)
  {
    this.currentRoom = room;
  }
  
   /*
        check the north wall by taking current  y position - 1 == 0 && NORTH
       OR check south wall by taking y position + 1 == TILES_Y && SOUTH
       OR check east wall by taking x position + 1 == TILES_X && EAST
       OR check west wall by taking x position - 1 == 0 && WEST
   */
  
  public boolean isWalkingIntoWall(MovingGameObject movingGameObject, Direction direction)
  {
    if(isNorthWall(movingGameObject.getPosY(),direction) ||
      isSouthWall(movingGameObject.getPosY(),direction)||
      isEastWall(movingGameObject.getPosX(),direction)||
      isWestWall(movingGameObject.getPosX(),direction))
      return true;
      
      return false;
  }
  
   public Actionable checkForGameObject(MovingGameObject movingGameObject, Direction direction,  ArrayList<GameObject> gameObjects)
   {
     /*
     for each object in the hashmap
       take the moving game objects direction and add direction.getx and y to its position
       create a tile position object with those values
       see if they get a hit on the current object in thehashmap
     */
         //MovingGameObject movingGameObjectToCheck = entry.getValue();
         
         Iterator<GameObject> it = gameObjects.iterator();
        
         
          while (it.hasNext())
          {
       
             GameObject gameObjectToCheck = it.next();
         
             int posXToCheck = movingGameObject.getPosX() + direction.getPosX();
             int posYToCheck = movingGameObject.getPosY() + direction.getPosY();
         
             if((gameObjectToCheck.getPosX() == posXToCheck) && (gameObjectToCheck.getPosY() == posYToCheck))
             {
               println("collision with game object found!!");
               return gameObjectToCheck;
             }
          }
        
         return null;
   }
  
   public Combatable checkForMovingGameObject(MovingGameObject movingGameObject, Direction direction,  ArrayList<MovingGameObject> movingGameObjects)
   {
     /*
     for each object in the hashmap
       take the moving game objects direction and add direction.getx and y to its position
       create a tile position object with those values
       see if they get a hit on the current object in thehashmap
     */
         //MovingGameObject movingGameObjectToCheck = entry.getValue();
         
         Iterator<MovingGameObject> mgo_it = movingGameObjects.iterator();
        
         
          while (mgo_it.hasNext())
          {
       
             MovingGameObject combatableMovingGameObjectToCheck = mgo_it.next();
         
             int posXToCheck = movingGameObject.getPosX() + direction.getPosX();
             int posYToCheck = movingGameObject.getPosY() + direction.getPosY();
         
             if((combatableMovingGameObjectToCheck.getPosX() == posXToCheck) && (combatableMovingGameObjectToCheck.getPosY() == posYToCheck))
             {
               println("collision with moving game object found!!");
               return  (Combatable)combatableMovingGameObjectToCheck;
             }
          }
        
         return null;
   }
   
   public boolean isRunningIntoMainCharacter(MainCharacter mainCharacter, MovingGameObject movingGameObject, Direction direction)
   {
      int posXToCheck = movingGameObject.getPosX() + direction.getPosX();
      int posYToCheck = movingGameObject.getPosY() + direction.getPosY();
      
       if((mainCharacter.getPosX() == posXToCheck) && (mainCharacter.getPosY() == posYToCheck))
       {
         println("collision with main character found!!");
         return true;
       }
     
     return false;
   }
   
   public Combatable checkForAdjacentMainCharacter(MainCharacter mainCharacter, MovingGameObject movingGameObject)
   {
     /*
      loop through every direction and add its x/y increment values to the position of the moving game object.
      if any of them match the location of the main characters position they are next to it!!
     
     */
      for (Direction direction: Direction.values())
      {
        if(mainCharacter.getPosX() == (movingGameObject.getPosX() + direction.getPosX()) &&
           mainCharacter.getPosY() == (movingGameObject.getPosY() + direction.getPosY()))
             return (Combatable)movingGameObject;
      }
      
      return null;
     
   }
  
  /*
  returning room is just a quick hack for testing right now. rename and think of a less hacker job way of doing this.
  */
  public Room checkForDoors(MainCharacter mainCharacter, Direction direction)
  {
    Room roomDoor = null;
    /*
    check if character posX == TILES_X/2 && posy == [1] for NORTH
      grab a reference to the north room from the room object
        set the char position to the SOUTH in front of the door 
        return true
        
      check if character posX == TILES_X/2 && posy == [TILES_Y-2] for SOUTH
         grab a reference to the south room from the room object
          set the char position to the NORTH in front of the door 
          return true
          
       check if character posX == TILES_X-2 && posy == [int(TILES_Y/2)] for EAST
          grab a reference to the east room from the room object
          set the char position to the EAST in front of the door 
          return true
         
       check if character posX == 1 && posy == [int(TILES_Y/2)] for WEST
          grab a reference to the west room from the room object
          set the char position to the EAST in front of the door 
          return true
     */
     
    if(isNorthDoor(mainCharacter.getPosX(),mainCharacter.getPosY(), direction))
    {
      println("ENTERING A NORTH DOOR");
      roomDoor = loadedLevel.getCurrentRoom().getNorthRoom();
     
      return roomDoor;
      
    }
    //if((mainCharacter.getPosX() == int(TILES_X/2)) && (mainCharacter.getPosY() == TILES_Y-2) && (direction == Direction.SOUTH))
    if(isSouthDoor(mainCharacter.getPosX(),mainCharacter.getPosY(), direction))
    {
      println("ENTERING A SOUTH DOOR");
      
      
       roomDoor = loadedLevel.getCurrentRoom().getSouthRoom();
    
      return roomDoor;
     
    }
     //if((mainCharacter.getPosX() == (TILES_X-2)) && (mainCharacter.getPosY() == int(TILES_Y/2)) && (direction == Direction.EAST))
     if(isEastDoor(mainCharacter.getPosX(),mainCharacter.getPosY(), direction))
    {
      println("ENTERING A EAST DOOR");
        roomDoor = loadedLevel.getCurrentRoom().getEastRoom();
     
      return roomDoor;
     
    }
     //else if((mainCharacter.getPosX() == 1) && (mainCharacter.getPosY() == int(TILES_Y/2)) && (direction == Direction.WEST))
     if(isWestDoor(mainCharacter.getPosX(),mainCharacter.getPosY(), direction))
    {
      println("ENTERING A WEST DOOR");
        roomDoor = loadedLevel.getCurrentRoom().getWestRoom();
      
      return roomDoor;
      
    }
    
    return null;
    
    
  }
  
  
  public boolean checkForLevelExit(MainCharacter mainCharacter, Tile exitTile)
  {
     return (mainCharacter.getPosX() == exitTile.getPosX() &&
             mainCharacter.getPosY() == exitTile.getPosY());
  }
  
    
  
  private boolean isNorthWall(int posY, Direction direction){return ((posY - 1 == 0) && (direction == Direction.NORTH));}
  
  private boolean isSouthWall(int posY, Direction direction){return ((posY +1 == TILES_Y - 1) && (direction == Direction.SOUTH));}
  
  private boolean isEastWall(int posX, Direction direction){return ((posX +1 == TILES_X - 1) && (direction == Direction.EAST));}
  
  private boolean isWestWall(int posX, Direction direction){return ((posX -1 == 0) && (direction == Direction.WEST));}
  
  private boolean isNorthDoor(int posX, int posY, Direction direction) {return (posX == int(TILES_X/2)) && (posY == 1) && (direction == Direction.NORTH);}
  
  private boolean isSouthDoor(int posX, int posY, Direction direction) {return (posX == int(TILES_X/2)) && (posY == TILES_Y-2) && (direction == Direction.SOUTH);}
  
  private boolean isEastDoor(int posX, int posY, Direction direction) {return (posX == TILES_X-2) && (posY == int(TILES_Y/2)) && (direction == Direction.EAST);}
  
  private boolean isWestDoor(int posX, int posY, Direction direction) {return (posX == 1) && (posY == int(TILES_Y/2)) && (direction == Direction.WEST);}
 
 
  
  
  
  
  
}