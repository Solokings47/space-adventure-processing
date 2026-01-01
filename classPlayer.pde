class Player
{

  float x, y; //class members: //data stored for a player object
  int imageCounter =0;// used to decide which image to render
  
PImage img;//array of PImage
  //constructors

  Player(float x, float y, PImage img)
  {
    this.x =x;
    this.y =y;
    this.img=img;
    
  }

  //methods
  
  void setImage(PImage img)
  {
    this.img=img;
  }
  void display()
  {
    image(img,x,y);
  }
  boolean collidesWith (Obstacle other )
  {
    return dist (this.x, this.y, other.x, other.y) <40;
  }
  boolean crash (Coin coin)
  {
    // return the result of checking if the player has crashed into the coin
    return dist (this.x, this.y, coin.x, coin.y) <40;
  } 
}
