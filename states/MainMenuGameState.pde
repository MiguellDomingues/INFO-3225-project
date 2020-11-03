class MainMenuGameState extends GameState
{
  Button gameStartButton;
  
  //void changeState(GameState gameState){}
  MainMenuGameState()
  {
    initGameState();
  }
  
  void initGameState()
  {
    gameStartButton = new Button();
    //ADD SPLASH SCREENS, MORE BUTTONS AND SHIT WHATEVER
  }
  
  void drawGameState()
  {
    //PRETEND THIS IS YOUR DRAW LOOP
    gameStartButton.displayButton();
  }
  
  
  
  void getKeyboardInputForGameState(char key){};
  
  //ADD CHECKS FOR BUTTON PRESSES HERE IDGAF
  void getMouseInputForGameState(int mouseX, int mouseY)
  {
   if(gameStartButton.overButton(mouseX, mouseY))
   { 
       println("i got pressed mah. start teh gameeee");// Do something here.
       //change the game state
       changeStateRunningGame();
   }
 
 }
 
  
 
 
  

  
}