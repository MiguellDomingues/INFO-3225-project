interface Combatable
{
  void onAttack(MainCharacter mainCharacter, Room currentRoom);
  void onDefend(MainCharacter mainCharacter, Room currentRoom);
  void onDeath(MainCharacter mainCharacter, Room currentRoom);
}