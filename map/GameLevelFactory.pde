/*
the way i decided to approach this class is to make it a mostly-dumb factory class. levels ARE NOT connected to each other. this makes for a much simpler implementation. 
once a level is done ie player reaches the exit staircase, the main class will call buildLevel for a new level, decrement the numLevels, increment levelNumber
and increase the level size by 1. when numLevels is 0, the builder will return null and the player has completed the game
*/

class GameLevelFactory
{
  Level currentLevel;
  
  int numLevels;
  int startingLevelSize;
  int levelNumber;
  
 // ArrayList<Level> gameLevels;
  
  PImage entryDoor;
  PImage exitDoor;
  PImage exitStairs;
  
  MainCharacter mainCharacter;
  
  GameLevelFactory(int numLevels, int startingLevelSize,PImage entryDoor, PImage exitDoor, PImage exitStairs, MainCharacter mainCharacter)
  {
    this.numLevels = numLevels;
    this.startingLevelSize = startingLevelSize;
    
    this.entryDoor = entryDoor;
    this.exitDoor = exitDoor;
    this.exitStairs = exitStairs;
    this.mainCharacter = mainCharacter;
    
    //gameLevels = new ArrayList<Level>();
  }
  
  Level buildLevel()
  {
    if(numLevels == 0)
    {
      println("no more levels to beat! a winnAr is u!!!!11111:):);0:0:0");
      return null;
    }
    
    Level levelToBuild = new Level(startingLevelSize, entryDoor, exitDoor, exitStairs, mainCharacter, levelNumber);
    
    mainCharacter.setStartingPosition(int(random(1,TILES_X-2)), int(random(1,TILES_Y-2)));
    
    currentLevel = levelToBuild;
    
    levelNumber++;
    numLevels--;
    startingLevelSize++;
    
    return levelToBuild;
    
  }
  
  Level getCurrentLevel()
  {
    return currentLevel;
  }
  
  int getCurrentLevelNumber()
  {
    return  levelNumber;
  }
  
  
  
}