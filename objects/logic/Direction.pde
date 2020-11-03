public static enum Direction
{
  NORTH(0,-1),
  EAST(1,0),
  SOUTH(0,1),
  WEST(-1,0);
  
  private int posX; 
  private int posY;
  
  private Direction(int posX, int posY)
  {
    this.posX = posX;
    this.posY = posY;
  }
  
  public int getPosX(){ return posX; }
  public int getPosY(){ return posY; }
}