//Keeps strack of key releases //<>// //<>// //<>//
char RKey = ')' ;
boolean KeyW = false;
boolean KeyA = false;
boolean KeyS = false;
boolean KeyD = false;
boolean KeyI = false;
boolean KeyJ = false;
boolean KeyK = false;
boolean KeyL = false;

//define players
Player playerOne;
Player playerTwo;

//define goal
Goal goal;

//Start and current blocks
Block start1;
Block start2;
Block curr1;
Block curr2;

Block drop1;
Block drop2;

//define images
PImage goalLogo;
PImage windowLogo;
PImage coogleLogo;
PImage hexLogo;
PImage blockPile;

//define nodes 
Node window1;
Node window2;
Node coogle1;
Node coogle2;
Node hex1;
Node hex2;

//random variables for nodes
int randomX1 = int(random(25, 600));
int randomX2 = int(random(25, 600));
int randomX3 = int(random(25, 600));

int randomY1 = int(random(50, 300));
int randomY2 = int(random(315, 600));
int randomY3 = int(random(615, 700));

//Define Tutorial
Tutorial startScreen;
boolean showStart;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup()
{
  //set up start screen
  startScreen = new Tutorial();
  showStart = true;
  
  //set the canvas
  size(1400, 1000);
  
  //initialize players
  playerOne = new Player(1, color(255, 0, 0), 100, 800);
  playerTwo = new Player(2, color(0, 255, 0), 1300, 800);
  
  //setup the images
  goalLogo = loadImage("HackArizonaLogo1.png");
  goalLogo.resize(100, 100);
  
  windowLogo = loadImage("Windows Logo.png");
  coogleLogo = loadImage("GoogleLogo.png");
  hexLogo = loadImage("HexagonLogo.png");
  blockPile = loadImage("PileOfBlocks.png");
  
 
  //construct nodes
  window1 = new Node(70, window2, randomX1, randomY1);
  window2 = new Node(70, window1, 1325 - randomX1, randomY1);
  window1.setPair(window2);
  
  coogle1 = new Node(70, coogle2, randomX2, randomY2);
  coogle2 = new Node(70, coogle1, 1325 - randomX2, randomY2);
  coogle1.setPair(coogle2);
  
  hex1 = new Node(70, hex2, randomX3, randomY3);
  hex2 = new Node(70, hex1, 1325 - randomX3, randomY3);
  hex1.setPair(hex2);
  
  //initialize goal
  goal = new Goal(100, 650, 0);
  
  //draw starting block
  start1 = new Block(70, 70, 300, 930);
  curr1 = new Block(70, 70, 300, 930);
  
  start2 = new Block(70, 70, 1030, 930);
  curr2 = new Block(70, 70, 1030, 930);
  
  //initialize drop boxes
  drop1 = new Block(70, 70, 0, 930);
  drop2 = new Block(70, 70, 1330, 930);
  
}
//this method loops everything within it
void draw()
{
  if(showStart == true)
  {
    background(30, 30, 50);
    startScreen.drawTutorial();
    if(key == 'h')
    {
      showStart = false;
    }
  }
  else
  {
    if(goal.isGoalReached() == false)
  {
    background(30, 30, 50);
    stroke(200, 300, 20);
    line(700, 0, 700, 1000);
    
    //draw goal
    fill(209, 42, 103);
    goal.drawGoal();
    image(goalLogo, 650, 0);
    
    //draws nodes, testing randomness
    
    window1.drawNode();
    window2.drawNode();
    image(windowLogo, window1.getXPos(), window1.getYPos());
    image(windowLogo, window2.getXPos(), window2.getYPos());
    if(window1.getIsActive())
    {
      tint(259, 100, 100);
      image(windowLogo, window1.getXPos(), window1.getYPos());
      image(windowLogo, window2.getXPos(), window2.getYPos());
    }
    noTint();
    
    coogle1.drawNode();
    coogle2.drawNode();
    image(coogleLogo, coogle1.getXPos(), coogle1.getYPos());
    image(coogleLogo, coogle2.getXPos(), coogle2.getYPos());
    if(coogle1.getIsActive())
    {
      tint(259, 100, 100);
      image(coogleLogo, coogle1.getXPos(), coogle1.getYPos());
      image(coogleLogo, coogle2.getXPos(), coogle2.getYPos());
    }
    noTint();
    
    hex1.drawNode();
    hex2.drawNode();
    image(hexLogo, hex1.getXPos(), hex1.getYPos());
    image(hexLogo, hex2.getXPos(), hex2.getYPos());
    if(hex1.getIsActive())
    {
      tint(259, 100, 100);
      image(hexLogo, hex1.getXPos(), hex1.getYPos());
      image(hexLogo, hex2.getXPos(), hex2.getYPos());
    }
    noTint();
   
    //draws blocks
    fill(129, 42, 103);
    drawList(start1);
    drawList(start2);
    
    //drawing curr blocks
    curr1.moveBlock(playerOne);
    curr1.drawBlock();
    
    curr2.moveBlock(playerTwo);
    curr2.drawBlock();
    
    //drawing drop boxes
    drop1.drawBlock();
    drop2.drawBlock();
    
    image(blockPile, 0, 930);
    image(blockPile, 1330, 930);
      
    //draws players and calls player control methods
    playerOne.drawPlayer();
    playerTwo.drawPlayer();
    playerOne.playerOneControl();
    playerTwo.playerTwoControl();
    playerOne.isPickUp();
    playerTwo.isPickUp();
    playerOne.blockPlaced(curr1, end(start1));
    playerTwo.blockPlaced(curr2, end(start2));
  }
  else
  {
    background(30, 30, 50);
    goal.drawWin();
  }
  }
  
}


//KeyPressed() and KeyReleased() are used to keep track of the keys for both players
//This ensures that both players can move at the same time
void keyPressed()
{
  if(key == 'w')
  {
    KeyW = true;
  }
  else if(key == 'a')
  {
    KeyA = true;
  }
  else if(key == 's')
  {
    KeyS = true;
  }
  else if(key == 'd')
  {
    KeyD = true;
  }
  if(key == 'i')
  {
    KeyI = true;
  }
  else if(key == 'j')
  {
    KeyJ = true;
  }
  else if(key == 'k')
  {
    KeyK = true;
  }
  else if(key == 'l')
  {
    KeyL = true;
  }
}


//Assigns the 
void keyReleased()
{ 
  if(key == 'w')
  {
    KeyW = false;
  }
  else if(key == 'a')
  {
    KeyA = false;
  }
  else if(key == 's')
  {
    KeyS = false;
  }
  else if(key == 'd')
  {
    KeyD = false;
  }
  if(key == 'i')
  {
    KeyI = false;
  }
  else if(key == 'j')
  {
    KeyJ = false;
  }
  else if(key == 'k')
  {
    KeyK = false;
  }
  else if(key == 'l')
  {
    KeyL = false;
  }

}
//draws block path
void drawList(Block start)
{
  Block cc = start;
  do{
    cc.drawBlock();
    cc = cc.getNext();
  } while(cc != null);
}

boolean overlap(int x1, int x2, int y1, int y2, int s1, int s2){
  if (((y1+s1 < y2) || (y2 +s2 < y1)) || ((x1 +s1 < x2) || (x2 + s2 < x1))){
    return false;
  }
  
  else{
    return true;
  }
}

//finds the last block
Block end(Block start)
{
  Block cc = start;
  
  while(cc.getNext() != null)
  {
    cc = cc.getNext();
  }
 
  return cc;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//the class for the player object
class Player
{
  //variables
  //starting coordinates of the player
  //x coordinate
  int px;
  //y coordinate
  int py;
  //color of player ellipse
  color c;
  /* assigns player a number to be used in keyPressed() to assign a set of controls
     number should only be 1 or 2 (player 1 and player 2) */
  int playerNum;
  //determines if the player is holding a block
  boolean isHolding;
  //determines if the player is blocked
  boolean isBlocked;
  
  //constructors
  //creates Player as a 50 x 50 ellipse at the given starting coordinates
   Player(int n, color rgb, int x, int y){
    playerNum = n;
    c = rgb;
    px = x;
    py = y;
    isHolding = false;
    isBlocked = false;
  }
  
  //method that draws player
  void drawPlayer(){
    fill(c);
    ellipse(px, py, 50, 50);
  }
  
  //accessor methods
  //gets player coordinates
  int getPlayerX(){
    return px;  
  }
  
  int getPlayerY(){
    return py;
  }
  
  //methods
  /* two methods, one for each player, to control movement
   * allows player to use WASD and IJKL controls 
   * uses assigned number from playerNum variable to assign controls so the keys don't
     effect both players
   * player 1 uses WASD
   * player 2 uses IJKL */
  public void playerOneControl(){
    //player 1 controls (WASD)
    if(keyPressed == true && playerNum == 1){
      if ((KeyW || key == 'w') && py > 25){
        py -= 7;
      }
      if ((KeyA || key == 'a') && px > 25){
        px -= 7;
      }
      if ((KeyS || key == 's') && py < 975){
        py += 7;
      }
      if ((KeyD || key == 'd') && px < 665){
        px += 7;
      }
    }
  }
    //player 2 controls (IJKL)
  public void playerTwoControl(){
    if(keyPressed == true && playerNum == 2){
      if ((KeyI || key == 'i') && py > 25){
        py -= 7;
      }
      if ((KeyJ || key == 'j') && px > 735){
        px -= 7;
      }
      if ((KeyK || key == 'k') && py < 975){
        py += 7;
      }
      if ((KeyL || key == 'l') && px < 1375){
        px += 7;
      }
    }
    
  }
  
  //Determines if the Player has met the proper conditions for picking up a block
  void isPickUp()
  {
    if(keyPressed == true && playerNum == 1 && key=='r'){
      if(overlap(px, drop1.getXPos(), py, drop1.getYPos(), 50, 70) && !isHolding)//overlap will replace the true statement
      {
        
        //Replaces curr1 with the block that the player has grabbed
        curr1 = new Block(70, 70, px, py);
        curr1.setUp();
        isHolding = true;
      }
    }    
    else if(keyPressed == true && playerNum == 2 && key=='p'){
      if(overlap(px, drop2.getXPos(), py, drop2.getYPos(), 50, 70) && !isHolding)//overlap
      {
        //Replaces curr1 with the block that the player has grabbed
        curr2 = new Block(70, 70, px, py);
        curr2.setUp();
        isHolding = true;
      }
    }
  }
  
   //method for checking what to do when the block is placed
public void blockPlaced(Block curr, Block endd)
{
  if(keyPressed == true && playerNum == 1 && key=='r')
  {
    //if overlap, set the new block
    if(overlap(curr.getXPos(), endd.getXPos(), curr.getYPos(), endd.getYPos(), 70, 70) && isHolding)
    {
      endd.setNext(new Block(70, 70, curr.getXPos(), curr.getYPos()));
      endd = endd.getNext();
      endd.setUp();
      
      curr.setUp();
      curr = new Block(70, 70, drop1.getXPos(), drop1.getYPos());
      
      isHolding = false;
      
      //check if overlaps with a node
        if(overlap(endd.getXPos(), window1.getXPos(), endd.getYPos(), window1.getYPos(), 70, 70))
        {
          window1.onBlockCollision();
        }
        else if(overlap(endd.getXPos(), coogle1.getXPos(), endd.getYPos(), coogle1.getYPos(), 70, 70))
        {
          coogle1.onBlockCollision();
        }
        else if(overlap(endd.getXPos(), hex1.getXPos(), endd.getYPos(), hex1.getYPos(), 70, 70))
        {
          hex1.onBlockCollision();
        }
        
      //check if overlaps with the goal
      if(overlap(endd.getXPos(), 650, endd.getYPos(), 0, 70, 100) && !isBlocked)//overlaps with goal)
      {
          goal.onBlockColision(playerNum);
      }
    }
  }
  else if(keyPressed == true && playerNum == 2 && key=='p')
  {
    //if overlap, set the new block
    if(overlap(curr.getXPos(), endd.getXPos(), curr.getYPos(), endd.getYPos(), 70, 70) && isHolding)
    {
      endd.setNext(new Block(70, 70, curr.getXPos(), curr.getYPos()));
      endd = endd.getNext();
      endd.setUp();
      
      curr.setUp();
      curr = new Block(70, 70, drop2.getXPos(), drop2.getYPos());
      
      isHolding = false;
      
 
      //check if overlaps with a node
        if(overlap(endd.getXPos(), window2.getXPos(), endd.getYPos(), window2.getYPos(), 70, 70))
        {
          window2.onBlockCollision();
        }
        else if(overlap(endd.getXPos(), coogle2.getXPos(), endd.getYPos(), coogle2.getYPos(), 70, 70))
        {
          coogle2.onBlockCollision();
        }
        else if(overlap(endd.getXPos(), hex2.getXPos(), endd.getYPos(), hex2.getYPos(), 70, 70))
        {
          hex2.onBlockCollision();
        }
        
      //check if overlaps with the goal
      if(overlap(endd.getXPos(), 650, endd.getYPos(), 0, 70, 100) && !isBlocked)//overlaps with goal)
      {
          goal.onBlockColision(playerNum);
      }
    }
  }
}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//the class for the block object
class Block
{
//variables
private int bHeight, bWidth, xPos, yPos;
private boolean isPlaced, isUp;
private Block blockNext;

//constructors
public Block(int h, int w, int x, int y){
    bHeight = h;
    bWidth = w;
    xPos = x;
    yPos = y;
    isPlaced = false;
    isUp = false;
    blockNext = null;
  }
 
  
  
  //methods
 
  public void setNext(Block toSet)
  {
    blockNext = toSet;
  }
  
  public Block getNext()
  {
    return blockNext;
  }
 
  //Draws the Block on the canvas
  public void drawBlock(){
    rect(xPos, yPos, bHeight, bWidth);
  }
 
//Moves the Block depending on what keys are pressed
//Should be called in the draw function so that it is called continuously
  public void moveBlock(Player player){
     if(isUp){
       xPos = player.getPlayerX();
       yPos = player.getPlayerY();
     }
  }
  
  public void setUp(){
    isUp = !isUp;
  }
  public boolean getUp()
  {
    return isUp;
  }
  
  public void setPlaced()
  {
    isPlaced = !isPlaced;
  }
  
  //Getter Methods
  int getXPos(){
    return xPos;
  }
  
  int getYPos(){
    return yPos;
  }
  
  int getWidth(){
    return bWidth;
  }
  
  int getHeight(){
    return bHeight;
  }
  //End of Getter Methods
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//the class for the node object
class Node
{
  //variables
  private int size;
  private boolean blockPlayer; //turns true once the matching node on the other side is activated
  private boolean isActive; //turns true when the player hits the node before the other player 
  private boolean isDead; //turns true when the second player builds to the node
  private Node pair; //the node on the other side of the screen that pairs with this one
  private int xPos;
  private int yPos;
  
  //constructors
  public Node(int nSize, Node nPair, int nX, int nY)
  {
    size = nSize;
    pair = nPair;
    xPos = nX;
    yPos = nY;
    
    blockPlayer = false;
    isActive = false;
    isDead = false;
    
    rect(xPos, yPos, size, size);
  }
  
  //methods
  
  public int getXPos()
  {
    return xPos;
  }
  
  public int getYPos()
  {
    return yPos;
  }
  
  //draws the node
  public void drawNode()
  {
     rect(xPos, yPos, size, size);
  }
  
  
  public boolean getIsActive()
  {
    return isActive;
  }
  
   public void setIsActive(boolean toSet)
  {
    isActive = toSet;
  }
  
  public boolean isPlayerBlocked()
  {
    return blockPlayer;
  }
  
  public void setBlockPlayer(boolean toSet)
  {
    blockPlayer = toSet;
  }
  
  public void setPair(Node toPair)
  {
    pair = toPair;
  }
  
  public void setIsDead(boolean toSet)
  {
    isDead = toSet;
  }

  //handles what happens when a block collides with the node
  public void onBlockCollision()
  { 
    //if isActive is false and isDead is false, activate the this node and set the other node to block the player
    if((isActive == false) && (isDead == false))
    {
      isActive = true;
      pair.setIsActive(true);
      pair.setBlockPlayer(true);
      
      isDead = true;
      
    }
    
    //if the node is blocking the player, turn that off and kill both nodes
    if(blockPlayer == true)
    {
      blockPlayer = false;
      isDead = true;
      pair.setIsDead(true);
      
      isActive = false;
      pair.setIsActive(false);
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//the class for the goal object 
class Goal
{
  //variables
  private int size;
  private int xPos;
  private int yPos;
  private boolean goalReached;
  private String winText;
  
  //constructors
  public Goal(int nSize, int nX, int nY)
  {
    size = nSize;
    xPos = nX;
    yPos = nY;
    
    goalReached = false;
    winText = "";
    
    rect(xPos, yPos, size, size);
  }
  
  //methods
  //draws the goal
  public void drawGoal()
  {
     rect(xPos, yPos, size, size);
  }
  
  public boolean isGoalReached()
  {
    return goalReached;
  }
  
  //what happens when a player reaches the goal and can win
  public void onBlockColision(int winner)
  {  
      textSize(100);
      textAlign(CENTER);
      
      if(winner == 1)
      {
        if(!window1.isPlayerBlocked() && !coogle1.isPlayerBlocked() && !hex1.isPlayerBlocked())
        {
          winText = "Hacker 1 Wins!!!";
          goalReached = true;
        }
       
      }
      
      if(winner == 2)
      {
        if(!window2.isPlayerBlocked() && !coogle2.isPlayerBlocked() && !hex2.isPlayerBlocked())
        {
          winText = "Hacker 2 Wins!!!";
          goalReached = true;
        }
      }
      
      text(winText,width/2,300); 
      
  }
  
  public void drawWin()
  {
    textSize(100);
    textAlign(CENTER);
    text(winText,width/2,300); 
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Title Page / Manual class
public class Tutorial
{
  //variables
  
  //constructors
  public Tutorial()
  {
  }
  
  public void drawTutorial()
  {
    String title = "HACKER V HACKER";
    String tutorialText = "As a hacker, your goal is to hack into the Hack Arizona mainframe by creating a path from your\n";
    tutorialText += "computer to their system. However, there is another hacker attempting to do the same thing as \n";
    tutorialText += "you! Reach the goal before your opponent to succeed in your mission.\n\n";
    tutorialText += "To connect your computer to the mainframe. You will have to build a path of code blocks from\n";
    tutorialText += "the bottom of the screen to the Hack Arizona mainframe at the top of the screen You can only\n";
    tutorialText += "build off of the block that you most recently placed down.\n\n";
    tutorialText += "Utilize the helpful sponsors you find along the way! If you get to them first, the other hacker \n";
    tutorialText += "can’t reach the mainframe until they get to them too.\n\n";
    tutorialText += "CONTROLS\n\n";
    tutorialText += "Hacker 1 is located on the left side of the screen while Hacker 2 is on the right. Hacker 1 must \n";
    tutorialText += "use the keys WASD and Hacker 2 must use IJKL. Hacker 1 uses R to pick up and place blocks \n";
    tutorialText += "while Hacker 2 uses P. \n\n";
    tutorialText += "Good Luck, and may the best hacker win!\n\n\n";
    tutorialText += "Press H to Start";
    
    fill(0, 255, 0);
    
    textSize(75);
    textAlign(CENTER);
    text(title, width/2, 100);
    
    textSize(25);
    text(tutorialText,width/2,300); 
  }
}