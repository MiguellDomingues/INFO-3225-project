/*
all moving game object movement will be processed in this class. first we move the player, then the game objects

movement is done for the player by getting the direction, checking the tile we want to move into for collision-able objects like walls, doors and other game objects.
this will require a lot of list checking and if statements. !!!!use a hashmap for game objects using the xpos/ypo wrapped into a class as a key!!! much quicker then 
scanning a list for x/y positions!!

player movement: 
  check for doors
  check for walls
  check for game objects
  
 moving game object movement:
   pick a random direction try to move into
   check for walls
   check for collisonable game objects
   check for the player (init combat!!)



*/



class MovingObjectController
{
  CollisionDetector collisionDetector;
  
  Room currentRoom;
  
  MainCharacter mainCharacter;
  
  RunningGameState runningGameState;
  
  MovingObjectController(MainCharacter mainCharacter,  Room currentRoom, RunningGameState runningGameState)
  {
    this.mainCharacter = mainCharacter;
    //this.currentRoom = currentRoom;
    this.runningGameState = runningGameState;
    
    collisionDetector = new CollisionDetector(currentRoom, runningGameState);
  }
 
  void setCurrentRoom(Room room)
  {
    collisionDetector.setCurrentRoom(room);
    currentRoom = room;
  }
  
  /*
  messing around with the order of door checking, wall hit detection, monster hit detection, and object hit detection to influence the order of events
  
  */
  //public void moveMainCharacter(Direction direction, Room currentRoom)
  public void moveMainCharacter(Direction direction)
  {
    println("character moving " + direction);
  
  //CollisionDetector collisionDetector = new CollisionDetector(loadedLevel.getCurrentRoom());
  
     ArrayList<MovingGameObject> movingGameObjects = currentRoom.getMovingGameObjects();
     ArrayList<GameObject> gameObjects = currentRoom.getGameObjects();
     Combatable combatableGameObject;
     Actionable actionableGameObject;
   
  
    //first check for doors...
    Room roomChange = collisionDetector.checkForDoors(mainCharacter, direction);
    
    if(roomChange != null)
    {
      runningGameState.changeRoom(roomChange, direction);
      return;
    }
    
    //!!----CHECK FOR ITEMS IN THE TILE I AM MOVING INTO---!!!
    actionableGameObject = collisionDetector.checkForGameObject(mainCharacter, direction, gameObjects);
    
    if(actionableGameObject != null)
    {
      println("picked up something!");
      actionableGameObject.action(currentRoom);
    }
    
    //!!!---CHECK FOR MONSTERS IN ADJACENT TILES--!!
    combatableGameObject = collisionDetector.checkForMovingGameObject(mainCharacter, direction, movingGameObjects);
    
    if(combatableGameObject != null)
    {
      println("fighting a monster!!");
      combatableGameObject.onDefend(mainCharacter, currentRoom);
    }
    else
    {
    //check for walls and then move if no monster was found
      if(!collisionDetector.isWalkingIntoWall(mainCharacter, direction))
      {
          mainCharacter.changeTile(direction);
      
          //once we move.... check if we end our turn on the level exit tile...
          if(currentRoom.isExitRoom())
          {
            if(collisionDetector.checkForLevelExit(mainCharacter, currentRoom.getExitTile()))
            {
              println("stepping on the exit tile!");
              runningGameState.changeLevel();
            }
          
      }
      
      
     
        
      }
    }
    
  }
  
  /*
     for each moving game object......
       grab a random direction
         if that direction dosent run it into a wall..(and later another moving game object!)
           update its position
           
      */
      
  /*
  the current implementation of moving game objects is as follows:
    check for adjacent main character...
      IF adjacent player FOUND..
        fight it. (need new classes for combat logic. defending attacking, ondeath etc)
        finish game object turn
      ELSE
        check for walls, other moving game object (and other collisionable objects), and the main character (legacy code)
          if none of the above, move a random direction
        
  so monsters CHECK FOR MAIN CHARACTER and ATTACK (action method), otherwise they MOVE. other implementations can be MOVE and then CHECK FOR MAIN CHARACTER, or
  MOVE, CHECK FOR MAIN CHARACTER MOVE. experiemtn with different orders to change the feel of the game
  
  for attacking/defending, i may need more interfaces that are implemented in each different monster class
        
  
  */
  public void moveMovingGameObjects()
  //public void moveMovingGameObjects(Room currentRoom)
  {
    if(currentRoom == null)
      println("current room is null");
      
      
      ArrayList<MovingGameObject> movingGameObjects = currentRoom.getMovingGameObjects();
      Combatable combatableGameObject;
      
    
     //ArrayList<MovingGameObject> movingGameObjects = currentRoom.getMovingGameObjects();
     Iterator<MovingGameObject> it = movingGameObjects.iterator();
      
      while (it.hasNext())
      {
        MovingGameObject movingGameObject = it.next();
        
        //!-----check for adjacent main character---------!
        combatableGameObject = collisionDetector.checkForAdjacentMainCharacter(mainCharacter, movingGameObject);
        
        //if theres an adjacent  maincharacter...
        if(combatableGameObject != null)
        {
          //fight and move ont to next moving game object to check
          combatableGameObject.onAttack(mainCharacter,currentRoom);
          println("mortal combat!!");
          continue;
        }
        
        Direction randomDirection = getRandomDirection();
        
         if(!collisionDetector.isWalkingIntoWall(movingGameObject, randomDirection) &&
            (collisionDetector.checkForMovingGameObject(movingGameObject, randomDirection, movingGameObjects) == null) &&
            !collisionDetector.isRunningIntoMainCharacter(mainCharacter, movingGameObject, randomDirection))//AND there is no other collisionable objects such as players, and other monsters
              movingGameObject.changeTile(randomDirection);
         
   
      }
   }
   
 
   
   private Direction getRandomDirection()
   {
     int random = int(random(4));
     
     switch(random)
     {
       case 0:
         return Direction.NORTH;
       case 1:
         return Direction.SOUTH;
       case 2:
         return Direction.EAST;
       default:
          return Direction.WEST;
     }
     
   }
  
  
  
}