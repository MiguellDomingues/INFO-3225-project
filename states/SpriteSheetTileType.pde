public static enum SpriteSheetTileType
{
   EMPTY (1),
   GRASS(2),
   WALL(4),
   ENTRANCE_DOOR(5),
   EXIT_DOOR(6),
   ENTRANCE_STAIRS(7),
   EXIT_STAIRS(8),
   HIGH_GRASS(15),
   BOOKSHELF(41);
   /*
   EMBERS      = 9;
   LOCKED_DOOR    = 10;
   PEDESTAL    = 11;
   WALL_DECO    = 12;
   BARRICADE    = 13;
   EMPTY_SP    = 14;
   
   EMPTY_DECO    = 24;
   LOCKED_EXIT    = 25;
   UNLOCKED_EXIT  = 26;
   SIGN      = 29;
   WELL      = 34;
   STATUE      = 35;
   STATUE_SP    = 36;
   
   ALCHEMY      = 42;
   CHASM_FLOOR    = 43;
   CHASM_FLOOR_SP  = 44;
   CHASM_WALL    = 45;
   CHASM_WATER    = 46;

   SECRET_DOOR        = 16;
   TOXIC_TRAP        = 17;
   SECRET_TOXIC_TRAP    = 18;
   FIRE_TRAP        = 19;
   SECRET_FIRE_TRAP    = 20;
   PARALYTIC_TRAP      = 21;
   SECRET_PARALYTIC_TRAP  = 22;
   INACTIVE_TRAP      = 23;
   POISON_TRAP        = 27;
   SECRET_POISON_TRAP    = 28;
   ALARM_TRAP        = 30;
   SECRET_ALARM_TRAP    = 31;
   LIGHTNING_TRAP      = 32;
   SECRET_LIGHTNING_TRAP  = 33;
   GRIPPING_TRAP      = 37;
   SECRET_GRIPPING_TRAP  = 38;
   SUMMONING_TRAP      = 39;
   SECRET_SUMMONING_TRAP  = 40;

   WATER_TILES  = 48;
   WATER    = 63;
   */
   
   private int index; 
   
  private SpriteSheetTileType(int index)
  {
    this.index = index;
  }
  
  public int getIndex(){ return index; }
   
}