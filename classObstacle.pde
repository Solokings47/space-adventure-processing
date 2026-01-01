class Obstacle
{
  // class members
  float x, y;
  float speedX, speedY;
  float speed =8;
  PImage img;


  //Constructor(s)
  Obstacle (float x, float y, PImage img)
  {
    this.x = x;
    this.y = y;
    this.img =  img;
    float angle = random(TWO_PI); // Random angle for direction
    float speed = random(1, 3); // Random speed between 1 and 3
    speedX = cos(angle) * speed;
    speedY = sin(angle) * speed;
    
  
  }

  //methods

  void move()
  {
    y +=speedY;
    x +=speedX;
  }
  void display()
  {
    image(img, x, y);
   
  }
  void update()
  {
    move();
    
    if (x > width) x = -img.width;
    if(x < -img.width) x = width;
    if (y > height) y = -img.height;
    if(y< -img.height) y = height;
    
    display();
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
}
