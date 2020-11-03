/*
creates a level in the form of an n-ary tree
the numRoomLevels is the depth/number of levels of the tree

still need to generate an exit point to the next level as a staircase is spawned at a random tile element
  - this is done but for very large levels (like roomLevels 6/7 or above) the behavior is strange
*/

class Level
{
  int currentExitRoomChance;
  int levelExitChanceIncrement;
  
  boolean exitRoomGenerated;
  
  int numRoomLevels;
  
  Room startingRoom;
  Room currentRoom;
  
  MainCharacter mainCharacter;
  
  PImage entryDoor;
  PImage exitDoor;
  PImage exitStairs;
  
  int levelNumber;
  

  
  Level(int numRoomLevels, PImage entryDoor, PImage exitDoor, PImage exitStairs, MainCharacter mainCharacter, int levelNumber)
  {
    this.numRoomLevels = numRoomLevels;
    this.entryDoor = entryDoor;
    this.exitDoor = exitDoor;
    this.exitStairs = exitStairs;
    this.mainCharacter = mainCharacter;
    
    this.levelNumber = levelNumber;
    
    
    currentExitRoomChance = 0;
    levelExitChanceIncrement = 0;
    
    exitRoomGenerated = false;
    
    generateRandomLevel();
    println(numMyRooms_GLOBALVAR + " rooms in our level!");
    println("resetting the num rooms global to zero");
    numMyRooms_GLOBALVAR = 0;
  }
  
  Room getCurrentRoom()
  {
   return currentRoom; 
  }
  
  Room getStartingRoom()
  {
    return startingRoom;
  }
  
  Room backToPreviousRoom()
  {
    if(currentRoom.getPreviousRoom() == null)
    {
      println("this room has no previous room!");
      return null;
       
    }
    
    currentRoom = currentRoom.getPreviousRoom();//POINT OUR CURRENT ROOM TO THE PREVIOUS ROOM
    currentRoom.printRoomInfo();
    return currentRoom;
  }
  
  Room changeRoom(Direction direction)
  {
    Room roomToChange = null;
    
    switch(direction)
    {
      case NORTH:
        roomToChange = currentRoom.getNorthRoom();
        break;
      case SOUTH:
        roomToChange = currentRoom.getSouthRoom();
        break;
      case EAST:
         roomToChange = currentRoom.getEastRoom();
        break;
      default:
        roomToChange = currentRoom.getWestRoom();
        
      
       
      
    }
    
    if(roomToChange != null)
      currentRoom = roomToChange;
      
    
     return roomToChange;
    
  }
  
  void setCurrentRoom(Room room)
  {
    currentRoom = room;
  }
  
  void generateRandomLevel()
  {
    
    
    startingRoom = generateRoomNode(null, numRoomLevels);
    
    currentRoom = startingRoom;
    
    levelExitChanceIncrement = int(100/numMyRooms_GLOBALVAR);
    currentExitRoomChance = levelExitChanceIncrement;
    
    //println("our increment is " + levelExitChanceIncrement);
    
    generateMapDoorsAndLevelExit(currentRoom);
    traverse(currentRoom);
    
   
  }
  
 
  
  ArrayList<Door> initListOfEachDoorType()
  {
     ArrayList<Door> doorList = new ArrayList<Door>();
     
     //add one of each door type
     doorList.add(new Door(Direction.NORTH));
     doorList.add(new Door(Direction.EAST));
     doorList.add(new Door(Direction.SOUTH));
     doorList.add(new Door(Direction.WEST));
     
     //randomize it
     Collections.shuffle(doorList);
     
     return doorList;
  }
  
     /*
  
   //
    //init a stack of 4 door directions then randomize it
    //
    // if (previousDoor != null)
    //    remove this door from the list
    //    draw it on the correct wall based on direction
    //
    for(for each connecting rooms 0-3)
              get a random number between 0-listsize
              get that door and draw it
              remove it from the list
              add it to this rooms doorlist
              !!!!!!!!!!reference the pointed room and make its previous door = OPPOSITE of this door!!!!!!!!
              next
    
    */
  
   void generateMapDoorsAndLevelExit(Room thisRoom)
   {
      //init door list
      ArrayList<Door> doorList = initListOfEachDoorType();
       
       //if the room has a previous door ie ITS NOT THE FIRST ROOM....
      if(thisRoom.getPreviousRoomDoor() != null)
      { 
         //then build an exit door and remove it from the list of possible doors to build..
        thisRoom.buildAndConnectRoomDoor(thisRoom.getPreviousRoomDoor().getDirection(),thisRoom.getPreviousRoom(), exitDoor);
        doorList.remove(thisRoom.getPreviousRoomDoor());
      }
      
     // exitRoomGenerated = tryToGenerateExitRoom();
      
      //if an exit room was not identified....
       //println("our exit room generation flag before the check: " + exitRoomGenerated);
      if(!exitRoomGenerated)
      {
         exitRoomGenerated = tryToGenerateExitRoom(thisRoom);
         
         //debug code
         if(exitRoomGenerated )
         {
          // println("random room generated in " + thisRoom.getRoomNumber());
           thisRoom.setAsExitRoom();
           thisRoom.setRandomExitStairs(exitStairs);
         }
       }
       // println("our exit room generation flag after the check: " + exitRoomGenerated);
      
       for(Room connectingRoom : thisRoom.getConnectingRooms())
       {
     
      
      int random = int(random(doorList.size()-1));//get a random number between 0-size of door list
      
      Door randomlySelectedDoor = doorList.get(random); //grab a door from the door list. this results in a door at a random side wall with no exit door
      
      thisRoom.buildAndConnectRoomDoor(randomlySelectedDoor.getDirection(), connectingRoom, entryDoor); // draw that door
      
      doorList.remove(randomlySelectedDoor);
         
      //connectingRoom.addConnectingRoomDoor(randomlySelectedDoor); // add it to the door list
        
      // !!!!!!!!!!reference the pointed room and make its previous door = OPPOSITE of this door!!!!!!!! //
      connectingRoom.setPreviousDoor(new Door(randomlySelectedDoor.getOppositeDoorDirection()));
      
      }
        
       for(Room connectedRoom : thisRoom.getConnectingRooms() )
       {
        
         generateMapDoorsAndLevelExit(connectedRoom);
       }
     
   }
   
   /*
     levelExitChance = numMyRooms_GLOBALVAR;
    currentExitRoomChance = 0;
    levelExitChanceIncrement = int(100/numMyRooms_GLOBALVAR);
   
   */
   
   boolean tryToGenerateExitRoom(Room thisRoom)
   {
     //int random = int(random(currentExitRoomChance, numMyRooms_GLOBALVAR));
     int random = int(random(0, 100));
     
     //println("our current random number is" + random);
     
    // println("checking if our random number is LESS OR EQUAL TO our current exit room chance:" + currentExitRoomChance);
     
     // int(numMyRooms_GLOBALVAR/2) <= thisRoom.getRoomNumber() ensures that at least half of the level has been traversed before we consider building an exit
     if(random <= currentExitRoomChance+1 && int(numMyRooms_GLOBALVAR/2) <= thisRoom.getRoomNumber())
       return true;
     
       
       
      // println("incrementing our exit room chance by" + levelExitChanceIncrement);
       currentExitRoomChance = levelExitChanceIncrement + currentExitRoomChance;
       
       //println("our exit room chance is now " + currentExitRoomChance);
       
      // println("----------------------------------------------");
       
      return false;
   }
    
  Room generateRoomNode(Room previousRoom, int treeDepth)
  {
     if(treeDepth <= 0)
    { 
      //println("cant make anymore rooms! " + treeDepth);
      return null;
    }
    
    Room newRoom = new Room(getRandomImageForTile(roomTiles), getRandomImageForTile(outerWallTiles), mainCharacter, levelNumber);
    treeDepth--;
   // println("made a room! " + treeDepth + " rooms left");
   
    newRoom.addPreviousRoom(previousRoom);//connect this node to the previous node
    
    int numRandomRooms = int(random(3))+1;//generates 1-3
    //println("making " + numRandomRooms + " connecting rooms");
    
    for(int i = 0; i < numRandomRooms; i++)
    {
      newRoom.addConnectingRoom(generateRoomNode(newRoom, treeDepth));//add 1-3 new nodes to this node
     // println("making room # " + i + " in the loop!");
    }
    
    pruneNulls(newRoom);//remove null rooms from the list
    return newRoom;
  }
  
  void pruneNulls(Room room)
  {
    Iterator<Room> it = room.getConnectingRooms().iterator();
      
      while (it.hasNext())
      {
        if (it.next() == null) 
          it.remove();
      }
  }
  
  PImage getRandomImageForTile(ArrayList<PImage> tile)
{
  
  return tile.get(int(random(tile.size())));
}
  
  
  
  /*debug code for checking the map*/
  void traverse(Room room)
  {
    if(room == null)
        return;
        
     if(room.isExitRoom())
     {
       println("exit found at room# " + room.getRoomNumber());
       
     }
       
        
        
        
     //room.printRoomInfo();
      
     for(Room connectedRoom : room.getConnectingRooms() )
        traverse(connectedRoom);
      
  }
  
}