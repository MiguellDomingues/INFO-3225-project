class Button
{
// Movement Buttons
int buttonX,buttonY; //Position of button

int rectWidth;     // Width of rect
int rectHeight;    // Height of rect
String buttonText;
boolean buttonOver;

Button(){ //Default constructor.
  this.buttonX = 300;
  this.buttonY = 300;
  this.buttonText = "START THE GAME BOIS";
  this.buttonOver = false;
  this.rectWidth = 300;
  this.rectHeight = 100;
}

Button(String buttonText){ //Default constructor.
  this.buttonX = 300;
  this.buttonY = 300;
  this.buttonText = buttonText;
  this.buttonOver = false;
  this.rectWidth = 300;
  this.rectHeight = 100;
}

Button(int x, int y, int w, int h, String txt, boolean flag){
  this.buttonX = x;
  this.buttonY = y;
  this.rectWidth = w;
  this.rectHeight = h;
  this.buttonText = txt;
  this.buttonOver = flag;
}

void displayButton(){
   fill(255);
   rect(buttonX,buttonY,rectWidth + 40,rectHeight);
   fill(1);
   textSize(26);
   text(this.buttonText, buttonX + 15, buttonY + 60);
}

  boolean overButton(int mouseX, int mouseY)
  {
    if (mouseX >= buttonX && mouseX <= buttonX+rectWidth && 
        mouseY >= buttonY && mouseY <= buttonY+rectHeight) 
          return true;
        else 
          return false; 
     }
}