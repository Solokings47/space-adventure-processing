class Coin
{
  float x, y;  ///Data Members : variables in object of this class
  float speed = 5;
  PImage[] coinImages;//array of PImage
  int currentImage;
  int imageDelay;
  int imageCounter; // decides which image to render
  int imageTimer;
  
  


  //constructor
  Coin(float x, float y, PImage[] coinImages, int imageTimer)
  {
    this.x =x;
    this.y=y;
    this.coinImages = coinImages;
    this.currentImage=0;
    this.imageDelay = 10;
    this.imageCounter=0;
    this.imageTimer = imageTimer;
    
  }
  

  void move()
  {
   
   y +=((int)random(0,2));
  //  x = ((int)random(width));
  
  }

  void display()
  {

    image(coinImages[currentImage],x,y);
  }

  void update()
  {
    imageCounter++;
    if(imageCounter >= imageDelay)
    {
      currentImage = (currentImage + 1) %coinImages.length;
      imageCounter=0;
    }
    move();
  }
   void moveDown()
  {
    y = y +speed;
  }
  void moveLeft()
  {
    x = x -speed;
  }
  void moveRight()
  {
    x= x+speed;
  }
  void moveUp()
  {
    y=y-speed;
  }
  boolean isCollected(Player player)
  {
    return dist (this.x, this.y, player.x, player.y)<20;
  }
}
