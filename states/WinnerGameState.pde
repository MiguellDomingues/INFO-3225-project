class WinnerGameState extends GameState
{
   Button gameStartButton;
  
  WinnerGameState()
  {
    gameStartButton = new Button("Restart?");
    initGameState();
  }
  
   void initGameState(){}
  
  void drawGameState()
  {
    background(255,255,255);
     textSize(70);
     gameStartButton.displayButton();
     text("A WINNAR IS U GGWP !!!!!1111111111111", 10, 300); 
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
  
  void getKeyboardInputForGameState(char key){}
  
}
