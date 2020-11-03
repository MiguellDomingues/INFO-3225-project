class SwordDude extends Monster
{
  SwordDude(int tilePosX, int tilePosY, PImage tileImage)
  {
    super(tilePosX, tilePosY, tileImage);
    health = 1;
    damageDealt = 1;
  }
  
  SwordDude(PImage tileImage)
  {
    super(tileImage);
    health = 1;
    damageDealt = 1;
  }
  /*
  these actions happen when i KILL a monster
  
  */
  
  /*
  void action(Room room)
  {
    println("RIP SWORD DUDE! DROPPING A HEART");
     //println("attacking and killing " + getClass().getName() + "then dropping a heart!!");
    room.getMovingGameObjects().remove(this);
    
    GameObject heartContainer = gameObjectFactory.buildHeartContainer();
    heartContainer.setPosX(tilePosX);
    heartContainer.setPosY(tilePosY);
    
    room.getGameObjects().add(heartContainer);
  
  }
  */
  
  @Override
   void onDeath(MainCharacter mainCharacter, Room currentRoom)
   {
      println("RIP SWORD DUDE! DROPPING A HEART");
      super.onDeath(mainCharacter,currentRoom);
   }
   
   @Override
   void onAttack(MainCharacter mainCharacter, Room currentRoom)
   {
      mainCharacter.takeDamage(damageDealt);
      println("ouch! i just took " + damageDealt + " damage from sword dude!");
   }
   
   @Override
    void onDefend(MainCharacter mainCharacter, Room currentRoom)
    {
      health--;
      println("sword dude took 1 damage!");
    
    if(health <= 0)
      onDeath(mainCharacter, currentRoom);
    }
   
   
  
}

//**************************************************************************************************************//

class KillerFox extends Monster
{
  KillerFox(int tilePosX, int tilePosY, PImage tileImage)
  {
    super(tilePosX, tilePosY, tileImage);
    health = 2;
    damageDealt = 2;
  }
  
  KillerFox(PImage tileImage)
  {
    super(tileImage);
    health = 2;
    damageDealt = 2;
  }
  
 /*
  void action(Room room)
  {
    println("RIP KILLER FOX! DROPPING A HEART");
     //println("attacking and killing " + getClass().getName() + "then dropping a heart!!");
    room.getMovingGameObjects().remove(this);
    
    GameObject heartContainer = gameObjectFactory.buildHeartContainer();
    heartContainer.setPosX(tilePosX);
    heartContainer.setPosY(tilePosY);
    
    room.getGameObjects().add(heartContainer);
  
  }
  */
   @Override
   void onDeath(MainCharacter mainCharacter, Room currentRoom)
   {
      println("RIP KILLER FOX! DROPPING A HEART");
      super.onDeath(mainCharacter,currentRoom);
   }
   
    @Override
   void onAttack(MainCharacter mainCharacter, Room currentRoom)
   {
      mainCharacter.takeDamage(damageDealt);
      println("ouch! i just took " + damageDealt + " damage from killerfox!");
   }
   
     @Override
    void onDefend(MainCharacter mainCharacter, Room currentRoom)
    {
      health--;
      println("killer fox took 1 damage!");
    
    if(health <= 0)
      onDeath(mainCharacter, currentRoom);
    }
   
  
}
