class Bullet
{
  float x,y;
  float speed = 5;
  float speedX,speedY=5;
  PImage img;
  
  //constructors
  Bullet(float x, float y, float speedX, float speedY, PImage img)
  {
    this.x =x;
    this.y=y;
    this.speedX =speedX;
    this.speedY= speedY;
    this.img = img;
  }
  void update()
  {
    x +=speedX * speed;
    y +=speedY * speed;
  }
  void display()
  {
    image(img, x, y);
  }
  boolean goneOffScreen()
  {
    return x < 0 || x > width|| y < 0 ||y > height;
  }
  
  
}
