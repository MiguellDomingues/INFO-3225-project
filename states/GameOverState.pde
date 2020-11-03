class GameOverState extends GameState
{
  Button gameStartButton;
  
  GameOverState()
  {
    gameStartButton = new Button("Restart?");
  }
  
  void changeState(GameState gameState){}
  
  void initGameState(){}
  
  void drawGameState()
  {
    
    background(255,255,255);
    textSize(70);
    gameStartButton.displayButton();
    text("A LOSER IS U GG NOOB", 10, 300); 
    fill(0, 102, 153);
    
  }
  
   void getMouseInputForGameState(int mouseX, int mouseY)
   {
    if(gameStartButton.overButton(mouseX, mouseY))
   { 
       println("i got pressed mah. start teh gameeee");// Do something here.
       //change the game state
       changeStateRunningGame();
   }
   }
  
  void getKeyboardInputForGameState(char key){};
  
}