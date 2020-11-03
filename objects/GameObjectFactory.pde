class GameObjectFactory
{
   final int NUM_MONSTERS = 2;
   final int NUM_ITEMS = 2;
   
   ArrayList<PImage> pImage_MainCharacters;
   
   ArrayList<PImage> pImage_MovingGameObjects;
   
   PImage pImage_MainCharacter;
  
  GameObjectFactory()
  {
    initMainCharacterImage();
   
  }
  
  void initMainCharacterImage()
  {
    pImage_MainCharacter = loadImage("main_character.png");
  }
  
  GameObject buildHeartContainer()
  {
    return new HeartContainer(loadImage("heart.png"));
  }
  
  GameObject buildNuclearBomb()
  {
    return new NuclearBomb(loadImage("bomb.png"));
  }
  
  GameObject buildRandomGameObject()
  {
    
    int random  = int(random(NUM_ITEMS));//number of item classes we have
    
    switch(random)
    {
      case 0:
        return buildHeartContainer();
      default:
        return buildNuclearBomb();
     }
    
  }
  
  MovingGameObject buildRandomMovingGameObject()
  {
    int random  = int(random(NUM_MONSTERS));
    
    switch(random)
    {
      case 0:
         return buildSwordDude();
      default:
         return buildkillerFox();
     }
    
  }
  
  MovingGameObject buildSwordDude()
  {
     return new SwordDude(loadImage("sword_dude.png"));
  }
  
  MovingGameObject buildkillerFox()
  {
     return new KillerFox(loadImage("fox.png"));
  }
  
  MainCharacter buildMainCharacter()
  {
   return new MainCharacter(loadImage("main_character.png"));
  }
  
}
