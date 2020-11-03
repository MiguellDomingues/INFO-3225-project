// globals that completely break the game if i take them out of global scope

ArrayList<PImage> roomTiles;
ArrayList<PImage> outerWallTiles;
MainCharacter mainCharacter;

ArrayList<PImage> spriteSheetImages;
Room roomToDraw;

GameLevelFactory gameLevelFactory;

Level loadedLevel;

GameObjectFactory gameObjectFactory;

MovingObjectController movingObjectController;

class RunningGameState extends GameState
{
  RunningGameState()
  {
    initGameState();
  }
  
  void initGameState()
  {
    currentGameState = new MainMenuGameState();
    roomTiles = new ArrayList<PImage>();
    outerWallTiles = new ArrayList<PImage>();
 
   spriteSheetImages = loadSpriteSheet("s2.png");
  
   loadTiles();
 
    gameObjectFactory = new GameObjectFactory();
   
    mainCharacter = gameObjectFactory.buildMainCharacter();
   
   movingObjectController = new  MovingObjectController(mainCharacter, roomToDraw, this);
   
   
   
   gameLevelFactory = new GameLevelFactory(NUM_LEVELS, 
                                           STARTING_LEVEL_SIZE,
                                           spriteSheetImages.get(SpriteSheetTileType.ENTRANCE_DOOR.getIndex()),
                                           spriteSheetImages.get(SpriteSheetTileType.EXIT_DOOR.getIndex()),
                                           spriteSheetImages.get(SpriteSheetTileType.EXIT_STAIRS.getIndex()),
                                           mainCharacter);
                                           
   loadedLevel = gameLevelFactory.buildLevel();                       
                               
   roomToDraw = loadedLevel.getStartingRoom();
   movingObjectController.setCurrentRoom(roomToDraw);
  
  }
  
  void loadTiles()
{
  roomTiles.add(spriteSheetImages.get(SpriteSheetTileType.EMPTY.getIndex()));
  roomTiles.add(spriteSheetImages.get(SpriteSheetTileType.GRASS.getIndex()));
  outerWallTiles.add(spriteSheetImages.get(SpriteSheetTileType.WALL.getIndex()));
  
  roomTiles.add(spriteSheetImages.get(SpriteSheetTileType.HIGH_GRASS.getIndex()));
  roomTiles.add(spriteSheetImages.get(SpriteSheetTileType.BOOKSHELF.getIndex()));
  
}

/**
* This method take the name of spriteSheet as input, split and store 
* each tiles in an Image arrayList.
*  
* @Parameter String SpriteSheetName
* return An arrayList
/**
*  Load SpriteSheet and store each individual tiles into 
*  An Image array.
* @Parameter String SpriteSheetName
*/
ArrayList<PImage> loadSpriteSheet(String spriteSheetName){
  // Store the tiles into the image array
  
  PImage my_sprite_sheet = loadImage(spriteSheetName);
  
  ArrayList<PImage> tilesList = new ArrayList<PImage>();
  
  for(int y = 0; y < N_SPRITES_Y; y++){
    for(int x =0; x < N_SPRITES_X; x++){
        tilesList.add (my_sprite_sheet.get(x * 64, 
          y * 64, 64, 64)); // my_sprite is an image array. Declare it as a gloable variable
    }
  }
  return tilesList;
}
  
  void drawGameState()
  {
    
    roomToDraw.drawRoom();
  
    drawText();
  }
  
  void getMouseInputForGameState(int mouseX, int mouseY){};
  
  void getKeyboardInputForGameState(char key)
  {
    switch(key)
    {
      case 'a':
     {
        initGameTurn(Direction.WEST);
        break;
      }
      case 'w':
      {
         initGameTurn(Direction.NORTH);
         break;
      }
      case 'd':
      {
         initGameTurn(Direction.EAST);
        break;
      }
      case 's':
      {
         initGameTurn(Direction.SOUTH);
        break;
      }
      case ' ':
        initGameTurn();
        break;
  }  
  
  }
  
  /*
  YOU GUYS NEED TO WRITE YOUR GUI CODE IN HERE KTHX
  */
  void drawText()
  {
   rect(900,0,100,50);
   rect(900,50,100,50);
   rect(900,100,100,50);
  fill(100,100,100);
  /////
   textSize(60);
  text("Room", 730,  50);
  text(roomToDraw.getRoomNumber()+1, 900, 50);
  
   text ( "Level", 730, 100);
  text(gameLevelFactory.getCurrentLevelNumber(), 900, 100);
  
  text ("HP", 730, 150);
  text(mainCharacter.getCurrentHealth(), 900, 150);
  fill(1);
  
  textSize(16);
  text("Press A to move left .", 730, 200);
  text("Press D to move right", 730, 225);
  text("Press W to move Up.", 730, 250);
  text("Press S to move Down.", 730, 275);
  
  text("Move into a monster to", 730, 300);
  text("attack it", 730, 325);
  
  text("Pick up bombs to clear", 730, 375);
  text("the room", 730, 400);
  
  text("Pick up hearts for health", 730, 450);
  fill(0,0,0);
  }
  
void initGameTurn(Direction direction)
{
  
  
  if(!mainCharacter.isDead())
  {
    println("character moving " + direction);
    movingObjectController.moveMainCharacter(direction);
  //movingObjectController.moveMainCharacter(direction,roomToDraw);
  
    movingObjectController.moveMovingGameObjects();
 // movingObjectController.moveMovingGameObjects(roomToDraw);
  }
  else
  {
    changeStateLoseGame();
    println("YOU ARE DEAD");
  }
 
}



void initGameTurn()
{
   if(!mainCharacter.isDead())
    {
      println("skipping a turn!");
      movingObjectController.moveMovingGameObjects();
    }
    else
    {
      changeStateLoseGame();
      println("YOU ARE DEAD");
    }
  
}



void changeRoom(Room room, Direction direction)
{
    roomToDraw = room;
    //loadedLevel.setCurrentRoom(room);
    loadedLevel.setCurrentRoom(roomToDraw);
    mainCharacter.setPositionOnRoomChange(direction);
    movingObjectController.setCurrentRoom(room);
    println("successfully changed rooms!");
    roomToDraw.printRoomInfo();
    //roomToDraw = loadedLevel.getStartingRoom();
   //movingObjectController.setCurrentRoom(roomToDraw);
    
}

void changeLevel()
{
  Level newLevel = gameLevelFactory.buildLevel();  
  
  //loadedLevel = gameLevelFactory.buildLevel();  
  
  if(newLevel != null)
  {
    loadedLevel = newLevel;
    roomToDraw = loadedLevel.getStartingRoom(); 
     movingObjectController.setCurrentRoom(roomToDraw);
  }
   else
   {
     changeStateWinGame();
     println("GGWP NOOB EZ GAME FGT");
   }
 }
}