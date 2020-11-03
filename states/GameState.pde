abstract class GameState
{
  abstract void initGameState();
  
  abstract void drawGameState();
  
  abstract void getMouseInputForGameState(int mouseX, int mouseY);
  
  abstract void getKeyboardInputForGameState(char key);
  
  void changeState(GameState gameState){ currentGameState = gameState; }
  
  void changeStateRunningGame() { currentGameState = new RunningGameState(); }
  void changeStateMainMenu() { currentGameState = new MainMenuGameState(); }
  void changeStateWinGame() { currentGameState = new WinnerGameState(); }
  void changeStateLoseGame() { currentGameState = new GameOverState(); }
  
}
