import java.util.*;

int numMyRooms_GLOBALVAR = 0;

final int NUM_LEVELS = 1;
final int STARTING_LEVEL_SIZE = 1;

final int TILE_WIDTH_PIXELS = 64;
final int TILE_HEIGHT_PIXELS = 64;

final int N_SPRITES_X = 16;
final int N_SPRITES_Y = 4;

final int TILES_X = 11;
final int TILES_Y = 11;

GameState currentGameState;

void setup()
{
  assert(STARTING_LEVEL_SIZE != 0);
  assert(NUM_LEVELS != 0);
  
  currentGameState = new MainMenuGameState();
 
 //768
  size(960, 768);
  frameRate(20);
}


void draw()
{
  currentGameState.drawGameState();
}

void keyPressed() 
{
  currentGameState.getKeyboardInputForGameState(key);
}

void mousePressed()
{
   currentGameState.getMouseInputForGameState(mouseX, mouseY);
}