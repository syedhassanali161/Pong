//Hassan Ali
//Assignment 2 - Pong
//Computer Science 10 Block 3
//December 13, 2020  
//This program is my own work. However, I did take some help from a youtube video, (https://www.youtube.com/watch?v=vGLXx_OEtc4&list=LL&index=1&t=601s) - H.A.

//Use "w" and "s" to move your paddle up and down. Don't let the ball hit the left wall or else you will lose the game


//Importing the sound library
import processing.sound.*;


//Declaring the sound file
SoundFile beepsound;


//initializing the starting location of the padlle in the game
int rectX = 20; 
int rectY = 400; 

//Initializing the speed at which the paddle will move
int paddlespeed = 7;

//initializing the starting location of the ball
int ballX = 400;
int ballY = 400;

//These two booleans will later on determine whether the ball is moving right or left, and whether its moving up or down, 
boolean moveright = true;
boolean movedown = true;

//Initializing the horizontal speed of the ball (this will stay constant throughout the program
float ballspeedhori = 4;

//Initializing the starting score of the player
int score = 0;

//declaring the font that we are going to use (we will initialize this later)
PFont font;  

void setup () {

  //intiallizing the beepsound variable
  beepsound = new SoundFile(this, "Cyber Duck.wav");

  //Declaring the size of the screen
  size(800, 800);

  //Initializing and loading the font that will be used
  font = loadFont("MicrosoftPhagsPa-Bold-48.vlw");
}


void draw () {

  //declaring the initial vertical speed of the ball
  float ballspeedvert;

  //initializing the vertical speed of the ball as a random number between 4 and 10 so the game is a little bit challenging. This value will change everytime the ball hits a wall or the paddle 
  ballspeedvert = random(4, 10);

  //making the background black
  background(0);

  //making the white coloured net in the middle of the screen
  for (int y = 10; y <= 800; y += 20) {
    fill(255);
    textSize(14);
    text("|", 400, y);
  }

  //writing the font at the top of the screen
  fill(255, 0, 0);
  textFont(font);
  text("Score:", 250, 50);
  text(score, 420, 50);

  //making the rectangle (paddle)
  fill(255);
  rectMode(CENTER);
  rect(rectX, rectY, 10, 80);

  //making the ball
  ellipseMode(CENTER);
  ellipse(ballX, ballY, 15, 15);

  //if "w" is pressed, and the paddle is inside the screen it will move up
  if (keyPressed && key == 'w' && rectY >= 0 + 40) {
    rectY -= paddlespeed;
  }

  //if "s" is pressed and the paddle is inside the screen it will move down
  if (keyPressed && key == 's' && rectY <= 800 - 40) {
    rectY += paddlespeed;
  }

  //if the boolean moveright is true, the ball will move right otherwise it will move left
  if (moveright == true) {
    ballX += ballspeedhori;
  } else {
    ballX -= ballspeedhori;
  }  

  //if the variable moverdown is true, the ball will move down, otherwise it will move up
  if (movedown == true) {
    ballY += ballspeedvert;
  } else {
    ballY -= ballspeedvert;
  }  

  //if the paddle misses the ball and the ball goes behind the paddle, the screen will change, putting both the ball and paddle in their orignal positions, and writing game over, with the score in the middle of the screen
  if (ballX < rectX) {
    ballspeedvert = 0;
    ballspeedhori = 0;
    paddlespeed = 0;

    background(0);

    for (int y = 10; y <= 800; y += 20) {
      fill(255);
      textSize(14);
      text("|", 400, y);
    }

    fill(255, 0, 0);
    textFont(font);
    text("GAME OVER", 250, 200);
    text("Score:", 250, 300);
    text(score, 420, 300);


    fill(255);
    rectMode(CENTER);
    rect(20, 400, 10, 80);

    ellipseMode(CENTER);
    ellipse(400, 400, 15, 15);


    //I had a bug here. The program made sounds even after the game was over so i changed the beepsound variable to an empty sound file
    beepsound = new SoundFile(this, "Grand Piano.wav");
  }

  //if the ball hits the top of the screen, the ball will be bounced downward and a beep sound will be played
  if (ballY <= 10) {
    movedown = true;
    beepsound.play();
  }

  //if the ball hits the bottom of the screen, the ball will be bounced upwards and a beep sound will be played
  if (ballY >= 790) {
    movedown = false;
    beepsound.play();
  }

  //If the ball hits the paddle it will be bounced back. If it was previously going upwards, it will still go upwards, and if it was going downwards it will still go downwards
  if ((ballX == rectX) && (ballY <= rectY + 50 && ballY >= rectY -50)) {
    moveright = true;
    if (movedown == false) {
      movedown = false;
    } else {
      movedown = true;
    }
    //The score will increase any time the ball hits the paddle and a sound will be played
    score += 1;
    beepsound.play();
  }

  //if the ball hits the right side of the screen, it will start moving towards the left, and a sound will be played
  if (ballX >= 790) {
    moveright = false;
    beepsound.play();
  }
}
