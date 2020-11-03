class Monster extends MovingGameObject implements Combatable
{
  int health;
  int damageDealt;
  final int HEART_CONTAINER_SPAWN_CHANCE = 10;
  
  Monster(int tilePosX, int tilePosY, PImage tileImage)
  {
    super(tilePosX, tilePosY, tileImage);
  }
  
  Monster(PImage tileImage)
  {
    super(tileImage);
  }
  
  void onAttack(MainCharacter mainCharacter, Room currentRoom){}
  
  /*
  void onDefend(MainCharacter mainCharacter, Room currentRoom)
  {
    health--;
    
    if(health <= 0)
      onDeath(mainCharacter, currentRoom);
  }
  */
  void onDefend(MainCharacter mainCharacter, Room currentRoom){}
  
  void onDeath(MainCharacter mainCharacter, Room currentRoom)
  {
      //println("RIP SWORD DUDE! DROPPING A HEART");
     //println("attacking and killing " + getClass().getName() + "then dropping a heart!!");
    currentRoom.getMovingGameObjects().remove(this);
    
    /*
    GameObject heartContainer = gameObjectFactory.buildHeartContainer();
    heartContainer.setPosX(tilePosX);
    heartContainer.setPosY(tilePosY);
    currentRoom.getGameObjects().add(heartContainer);
    */
    currentRoom.spawnHeartContainerAtLocation(HEART_CONTAINER_SPAWN_CHANCE, this );
  }
  
}
