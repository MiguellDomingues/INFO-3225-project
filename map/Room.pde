
/*
IMPROVEMENT:
  change the n/s/w/s room references into doors and put the room references into the appropriate door objects. improves readability and lets me put more code
  into the room class
  
  BUG: objects and monsters can spawn on top of each other. wgaf? easy fix though

*/

public class Room
{
  final int STARTING_NUM_GAMEOBJECTS = 5;
  final int STARTING_NUM_MOVING_GAME_OBJECTS = 5;
  final int BOMB_SPAWN_CHANCE = 25;
 
  Tile[][] roomTiles;
  
  int roomNumber;
  
  PImage innerRoomTile;
  PImage outerWallTile;
  
  ArrayList<Room> connectingRooms;
  Room previousRoom;
 
  ArrayList<MovingGameObject> movingGameObjects;
  ArrayList<GameObject> gameObjects;
  Tile exitTile;
  
  Door previousRoomDoor;
  
  Room northRoom;
  Room southRoom;
  Room eastRoom;
  Room westRoom;
  
  boolean isExitRoom;
  
  boolean hasBomb;
  
  MainCharacter mainCharacter;
  
  int levelNumber;
 
  
  Room(PImage innerRoomTile, PImage outerWallTile, MainCharacter mainCharacter, int levelNumber)
  {
    roomTiles = new Tile[TILES_X][TILES_Y];
    
    roomNumber = numMyRooms_GLOBALVAR++;
    this.levelNumber = levelNumber;
  
    connectingRooms = new ArrayList<Room>();
    
    gameObjects = new ArrayList<GameObject>();
    movingGameObjects = new ArrayList<MovingGameObject>();
    
    exitTile = null;
    
    isExitRoom = false;
    
    hasBomb = false;
   
   this.mainCharacter = mainCharacter;
   
   previousRoom = null;
    
    northRoom = null;
    southRoom = null;
    eastRoom = null;
    westRoom = null;
    
    mainCharacter = null;
    
    this.innerRoomTile = innerRoomTile;
    this.outerWallTile = outerWallTile;
    
    initRoom();
    initGameObjects();
    initMovingGameObjects();
  }
  
  void setAsExitRoom()
  {
    isExitRoom = true;
  }
  
  void setRandomExitStairs(PImage exitStairs)
  {
    int randomX = int(random(1,TILES_X-2));
    int randomY = int(random(1,TILES_Y-2));
    
     exitTile = new Tile(randomX,randomY, exitStairs); 
     roomTiles[randomX][randomY] = exitTile;
  }
  
  Tile getExitTile()
  {
    return exitTile;
  }
  
  void setMainCharacter(MainCharacter mainCharacter)
  {
    this.mainCharacter = mainCharacter;
  }
  
  MainCharacter getMainCharacter()
  {
    return  mainCharacter;
  }
  
  ArrayList<Room> getConnectingRooms()
  {
    return connectingRooms;
  }
  
  
  ArrayList<MovingGameObject> getMovingGameObjects()
  {
    return movingGameObjects;
  }
  
  void initRoom()
  {
    for (int i = 0; i < TILES_X; i++) 
    {
      for (int j = 0; j < TILES_Y; j++) 
      {
        Tile tileToDraw = null;
       
        if (isOuterWall(i,j))
          tileToDraw = new Tile(i, j, outerWallTile) ;
        else
          tileToDraw = new Tile(i, j, innerRoomTile) ;
          
          roomTiles[i][j] = tileToDraw;
       }
    }
    
    
  }
  
  void drawRoom()
  {
    for (int i = 0; i < TILES_X; i++) 
    {
      for (int j = 0; j < TILES_Y; j++) 
      {
        if( roomTiles[i][j] != null)
          roomTiles[i][j].drawTile();
      }
    }
    
    drawGameObjects();
    drawMovingGameObjects();
    drawMainCharacter();
  }
  
   /* change to hashmap iteration */
  void drawMovingGameObjects()
  {
    
     Iterator<MovingGameObject> it = movingGameObjects.iterator();
      
      while (it.hasNext())
        it.next().drawTile();
  }
  
  
  
  void drawMainCharacter()
  {
    mainCharacter.drawTile();
  }
  
  boolean isExitRoom()   
  {
    return isExitRoom;
  }
  
  /* change to hashmap iteration */
  void drawGameObjects()
  {
    
     Iterator<GameObject> it = gameObjects.iterator();
      
      while (it.hasNext())
        it.next().drawTile();
  }
  
   void initMovingGameObjects()
  {
    int random = int(random(STARTING_NUM_GAMEOBJECTS + levelNumber)) + 1;
    
    for(int i = 0; i < random; i++)
    {
      MovingGameObject movingGameObject; 
      
      int randomX = 0;
      int randomY = 0;
      
      do
      {
        randomX = int(random(1,TILES_X-2));
        randomY = int(random(1,TILES_Y-2));
        
      }
      while(false);//needs a check to make sure multtiple objects dont spawn on top of each other
      
      movingGameObject = gameObjectFactory.buildRandomMovingGameObject();
      
       movingGameObject.setPosX(randomX);
       
      movingGameObject.setPosY(randomY);
 
      movingGameObjects.add(movingGameObject);
    }
  
  
  }
  
   /*
    - get a list of possible game objects total in the game. pass it in as its own factory class that returns a random GameObject or just as a pImage
    objects could be monsters, items etc etc. Monsters might need their own list because they are game objects that can actually move
    
    for some random number:
      - get a random game object from the factory. init it in main with a list of objects
      
      do
      {
        - pick a random x between x1 and (TILE_WIDTH-2) this avoids placing objects on the left and right outer walls
        - pick a random y between y1 and (TILE_HEIGHT-2) this avoids placing objects the upper and lower walls
      {
      while(the random x/y is NOT occupied by another object(rare));
         
      - set the game objects x and y tile position IMPORTANT
      - add the game object to the list of game objects
    
    */
  
  void initGameObjects()
  {
    int random = int(random(STARTING_NUM_GAMEOBJECTS+ levelNumber)) + 1;
    
    for(int i = 0; i < random; i++)
    {
      GameObject gameObject; 
      
      int randomX = 0;
      int randomY = 0;
      
      do
      {
        randomX = int(random(1,TILES_X-2));
        randomY = int(random(1,TILES_Y-2));
        
      }
      while(false);//do the check later
      
      if(!hasBomb)
        spawnBombAtLocation(randomX, randomY);
    
    /*
       gameObject = gameObjectFactory.buildRandomGameObject();
      
       gameObject.setPosX(randomX);
       
       gameObject.setPosY(randomY);
  
       gameObjects.add(gameObject);
       */
       
     
    }
  
  
  }
  
  void spawnBombAtLocation(int xPos, int yPos)
  {
    int random = int(random(0, 100));
    
    if(random <= BOMB_SPAWN_CHANCE)
    {
      GameObject gameObject = gameObjectFactory.buildNuclearBomb();
      gameObject.setPosX(xPos);
      gameObject.setPosY(yPos);
      gameObjects.add(gameObject);
      hasBomb = true;
    }
  }
  
  void addGameObject(GameObject roomObject)
  {
    gameObjects.add(roomObject);
  }
  
  //gameObjects_1 = new HashMap<TilePosition,GameObject>();
  
  ArrayList<GameObject> getGameObjects()
  {
     return gameObjects; 
  }
   
  void setPreviousDoor(Door previousDoor)
  {
    this.previousRoomDoor = previousDoor;
  }
  
  Door getPreviousRoomDoor()
  {
    return previousRoomDoor;
  }
  
  void buildAndConnectRoomDoor(Direction wallDirection, Room room, PImage door)
  {
    switch(wallDirection)
    {
      case NORTH:
      {
        roomTiles[int(TILES_X/2)][0].setNewTileImage(door);
        northRoom = room;
        break;
      } 
      case SOUTH:
      {
           roomTiles[int(TILES_X/2)][TILES_Y-1].setNewTileImage(door);
           southRoom = room;
           break;
      }
      case EAST:
      {
          roomTiles[TILES_X-1][int(TILES_Y/2)].setNewTileImage(door);
          eastRoom = room;
          break;
      }
      //west
      default:
        roomTiles[0][int(TILES_Y/2)].setNewTileImage(door);
        westRoom = room;
     }
  }
 /*
  need to modify loop to use a different tileset for the outer walls
  upper wall:  j = 0
  left wall: when i = 0
  right wall: when i = TILES_X - 1
  bottom wall:  when j = TILES_Y - 1
  */
  
  boolean isOuterWall(int i, int j)
  {
     if(i == 0 ||
        j == 0 || 
        i == TILES_X - 1 || 
        j == TILES_Y - 1)
     {
       
      return true;
     }
     else
      return false;
    
  }
  
  void addConnectingRoom(Room room)
  {
    connectingRooms.add(room);
  }
  
  void addPreviousRoom(Room room)
  {
    previousRoom = room; 
  }
  Room getPreviousRoom()
  {
   return previousRoom; 
  }
  
  int getRoomNumber()
  {
    return roomNumber; 
  }
  
  Room getThisRoom()
  {
    return this;  
  }
  
  void spawnHeartContainerAtLocation(int chance, MovingGameObject movingGameObject )
  {
    int random = int(random(0, 100));
    
    if(random <= chance)
     {
        GameObject heartContainer = gameObjectFactory.buildHeartContainer();
        heartContainer.setPosX(movingGameObject.getPosX());
        heartContainer.setPosY(movingGameObject.getPosY());
        gameObjects.add(heartContainer);
        println("spawned a heart container!");
     }
  }
  
  void printRoomInfo()
  {
    println("----------------------Room number: " + roomNumber + "-------------------------");
    //println("Previous room door located at " + previousRoomDoor.getDirection());
    
    if(previousRoom != null &&  previousRoomDoor!= null)
    {
      println("Previous Room number: " + previousRoom.getRoomNumber());
      println("Previous room door located at " + previousRoomDoor.getDirection());
    }
    else
      println("No previous room");
      
      
      
     println("Number of ajoining rooms: " + connectingRooms.size());
     //println("Number of ajoining doors: " + connectingRoomDoors.size());
     
     
     String doors = "";
     
      
     println("direction of ajoining rooms: " + doors);
     
     println("direction of doors: ");
     
     if(northRoom != null)
       print("N ");
      if(southRoom != null)
       print("S ");
      if(eastRoom != null)
       print("E ");
      if(westRoom != null)
       print("W ");
       
       println();
       
       if(isExitRoom)
         println("this should be the only exit room!!!");
     
     
     
     
     println("------------------------------------------------------------------------------");
     println("");
     
     
  }
  
  Room getNorthRoom() { return northRoom; }
  Room getSouthRoom() { return southRoom; }
  Room getEastRoom() { return eastRoom; }
  Room getWestRoom() { return westRoom; }
  
  
}