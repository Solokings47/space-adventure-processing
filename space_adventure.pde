Player player;
ArrayList<Obstacle> asteroids;
ArrayList<Coin> coins; //arrayList of coins
ArrayList<Bullet> bullets;
boolean gameOver = false;
int obstacleTimer = 0;
PImage[] asteroidImages;
PImage[] coinImages;
PImage bulletImage;
PImage background;
PImage playerUp, playerDown, playerRight, playerLeft;
PImage explosionImage;
int x = 0;
int y =0;
int score =0;
int step =5;
int numFrames =6;
String direction = "UP";


void setup() // runs once at the start - initialise objects
{
  size(800, 600);
  background = loadImage("spaceBackground.png");
  background.resize(width, height);
  playerUp = loadImage ("rocket1.png");
  playerDown=loadImage ("rocket3.png");
  playerRight=loadImage ("rocket2.png");
  playerLeft=loadImage ("rocket4.png");

  //resize the images
  int playerWidth =50;
  int playerHeight =50;
  playerUp.resize(playerWidth, playerHeight);
  playerDown.resize(playerWidth, playerHeight);
  playerLeft.resize(playerWidth, playerHeight);
  playerRight.resize(playerWidth, playerHeight);
  player =new Player(width/2, height/2, playerUp);

  bullets = new ArrayList<Bullet>();
  bulletImage= loadImage("laser.png");
  bulletImage.resize(10, 10); // resize bullet

  explosionImage=loadImage("explosion.png");
  explosionImage.resize(40, 40); //resize explosion image

  asteroidImages= new PImage[3];
  asteroidImages[0] = loadImage("asteroid1.png");
  asteroidImages[1] = loadImage("asteroid2.png");
  asteroidImages[2] = loadImage("asteroid3.png");
  for (PImage img : asteroidImages) {
    int randomW = int(random(70, 140));
    int randomH = int( random (70, 140));
    img.resize(randomW, randomH); // resize obstacle
  }
  coinImages = new PImage[3];
  // coinImage= loadImage ("starCoin1.png");
  for (int i=0; i<numFrames; i++) {
    coinImages[0] = loadImage ("starCoin1.png");
    //coinImages[1] = loadImage ("starCoin2.png");
    coinImages[1] = loadImage ("starCoin3.png");
   // coinImages[3] = loadImage ("starCoin4.png");
    coinImages[2] = loadImage ("starCoin5.png");
  //  coinImages[5] = loadImage ("starCoin6.png");
    //resize coin image
    coinImages[0].resize(20,20);
    coinImages[1].resize(20,20);
    coinImages[2].resize(20,20);
    //coinImages[3].resize(20,20);
   // coinImages[4].resize(20,20);
   // coinImages[5].resize(20,20);
  }
  coins =new ArrayList<Coin>();
  for(int i =0; i < 5;i++)
  {
    float randomX = random( width);
  float randomY = random(height);
 int randomTimer = int(random(60, 300));
  coins.add(new Coin(randomX, randomY, coinImages, randomTimer));
  }
  // coinImage.resize(10, 10); //resize the coin image
  restartGame();
}

void draw() // runs every 60th of a second
{
  //draw things, possibly move things, has there been any collisions?
  if (!gameOver) {
    drawBackground();
    if (player !=null) {
      player.display();
    }
    renderBullets();
    for(Coin coin : coins){
      coin.update();
      coin.display();
    }
    for (int i = 0; i< asteroids.size(); i++)
    {
      Obstacle asteroid =asteroids.get(i);
      if (asteroid != null)
      {
        asteroid.update();
        //has player collided with any enemy
        if (player !=null && player.collidesWith(asteroid))
        {
          gameOver = true;
          println("GAME OVER!! collision with asteroid ");
        }
        //remove obstacle if it moves off the screen
        if (asteroid.y>=height || asteroid.x >= width || asteroid.x < 0)
        {
          asteroids.remove(i);
        }
      }
    }
    updateCoins();
    //if (player.crash(coin))
    //{
    //  println("Coin collected!");
    //  float randomX = random(0,width);
    //  float randomY = random(0,20);// reset coin position
    //  coin = new Coin (randomX,randomY, coinImage);
    // }
    //add new obstacles based on game progress
    obstacleTimer++;
    if (obstacleTimer > 30)//add new image every  second
    {
      addNewObstacle();
      // addNewCoin();
      obstacleTimer=0;
    }
    displayScore();
  } else
  {
    //display game over messgage
    background(0);
    fill(255);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("GAME OVER!!! \n SCORE: " + score + " \nPress SPACE to restart ", width/2, height/2);
  }
}

void keyPressed()// runs every time a key is pressed
{

  if (!gameOver)
  {
    if (keyCode==UP) {
      for (Coin coin : coins) {
        coin.y +=step;
      }
      player.setImage(playerUp);
      y=y+step;
      direction="UP";

      for (int i = 0; i< asteroids.size(); i++)
      {

        Obstacle asteroid = asteroids.get(i);
        asteroid.moveDown(); //move all obstacles down
      }
    } else if (keyCode==LEFT) {
       for (Coin coin : coins) {
        coin.x +=step;
      }
      player.setImage(playerLeft);
      x=x+step;
      direction = "LEFT";

      for (int i = 0; i< asteroids.size(); i++)
      {
        Obstacle asteroid = asteroids.get(i);
        asteroid.moveRight();   //move all obstacles right
      }
    } else if (keyCode==RIGHT) {
       for (Coin coin : coins) {
        coin.x -=step;
      }
      player.setImage(playerRight);
      x=x-step;
      direction = "RIGHT";
      for (int i = 0; i< asteroids.size(); i++)
      {
        Obstacle asteroid = asteroids.get(i);
        asteroid.moveLeft();//move all obstacle left
      }
    } else if (keyCode==DOWN) {
       for (Coin coin : coins) {
        coin.y -=step;
      }
      player.setImage(playerDown);
      y=y-step;
      direction = "DOWN";
      for (int i = 0; i< asteroids.size(); i++)
      {
        Obstacle asteroid = asteroids.get(i);
        asteroid.moveUp();
      }
    } else if (keyCode =='B')
    {
      float speedX =0, speedY=0;
      if (direction.equals("UP")) {
        speedX=0;
        speedY=-1;
      } else if (direction.equals("LEFT")) {
        speedX=-1;
        speedY=0;
      } else if (direction.equals("RIGHT")) {
        speedX=1;
        speedY=0;
      } else if (direction.equals("DOWN")) {
        speedX=0;
        speedY=1;
      }
      bullets.add(new Bullet(player.x + player.img.width/2, player.y+player.img.height/2, speedX, speedY, bulletImage));
    }
  }
  if (keyCode== ' ')
  {
    restartGame();
  }

  if (x>width||x<-width)
    x=0;
  if (y>height||y<-height)
    y=0;
}
void restartGame() {

  player =new Player(width/2, height/2, playerUp);
  asteroids = new ArrayList< Obstacle>();
  coins = new ArrayList<Coin>();
  for (int i = 0; i<5; i++) {

    float randomX = random( width);
    float randomY = random(height);// start obstacles above the top half of screen
    PImage randomImage = asteroidImages[int(random(asteroidImages.length))];
    asteroids.add(new Obstacle(randomX, randomY, randomImage));
  }
  for (int i=0; i<5; i++) {
    float randomX = random(0, width);
    float randomY = random(0, 20);// coin starts at the top
    int randomTimer = int(random(60, 300));// random timer betweeen 1-5 seconds
    coins.add( new Coin(randomX, randomY, coinImages, randomTimer));//iniatialize coin
  }
  score = 0; // reset the score
  gameOver = false;
}
void addNewObstacle()
{
  float randomX = random(0, width);
  float randomY = random(0, 50 );
  PImage randomImage=asteroidImages[int(random(asteroidImages.length))];
  asteroids.add(new Obstacle(randomX, randomY, randomImage));
}
void drawBackground()// draw 3*3 grid of images: wrapped background all direction
{
  for (int col = -1; col<2; col++)// 3 columns of background image
    for ( int row =-1; row<2; row++)//3 rows of background image
    {
      image (background, x+(width* col), y+(height *row));
    }
}

void addNewCoin()
{
   coins =new ArrayList<Coin>();
  for(int i =0; i<5;i++)
  {
    float randomX = random(0, width);
  float randomY = random(0, 10);
  int randomTimer = int(random(60, 300));
  coins.add(new Coin(randomX, randomY, coinImages, randomTimer));
  }
}
  
void renderBullets()
{
  for (int i= bullets.size() -1; i>=0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.update();
    bullet.display();
    boolean collision = false;

    for (int j = asteroids.size()-1; j>=0; j--) {
      Obstacle asteroid = asteroids.get(j);
      if (dist(bullet.x, bullet.y, asteroid.x, asteroid.y)<20) {
        collision = true;
        asteroids.remove(j);// remove the asteroid
        break; //exit once a collision is detected
      }
    }
    if (collision) {
      //display the explosion image at the point of collision
      image(explosionImage, bullet.x-explosionImage.width/2, bullet.y- explosionImage.height/2);
      bullets.remove(i);
    } else if (bullet.goneOffScreen()) {
      bullets.remove(i);
    }
  }
}
void updateCoins()
{
  for (int i=  coins.size() - 1; i>=0; i--)
  {
    Coin coin = coins.get(i);
    coin.update();
    if (player.crash(coin))
    {
      println("coin collected!");
      score=score++ +2; //increase score
      coins.remove(i);
      if(coins.size() < 4) {
      respawnCoin();//respawn a new coin
      }
    } else if (coin.y>= height)
    {
      coins.remove(i);
     if(coins.size() < 4) {
      respawnCoin();//respawn a new coin
      }
    }
  }
}
void respawnCoin() {
  float randomX = random(0, width);
  float randomY = random(0,height);
  int randomTimer = int (random(60,300));
  coins.add(new Coin(randomX, randomY,coinImages,randomTimer));
}

void displayScore()
{
  fill(255);
  textSize(24);
  textAlign(LEFT, TOP);
  text("Score: " + score, 10, 10);
}
