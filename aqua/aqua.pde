/* @pjs preload="0.png,1.png,2.png,3.png,bgImage.png,btn_0.png,btn_1.png,net.png,turtle.png"; */


final int GAME_RUN = 0;
final int GAME_WIN = 1;
final int GAME_LOSE = 2;

int gameState = 0;

// background, control button
PImage bgImg ;
PFont myFont;

Net net;
Timer timer;

// variables for the fish
PImage img ;
float w, h, x, y, xSpeed, ySpeed ;

Fish fish1, fish2;

void setup() {
  size(800, 600) ;

  // loading bg, control button
  bgImg = loadImage("img/bgImage.png") ;
  myFont = createFont("Arial", 48); 
  
  // create a fish
  generateFish();
  
  net = new Net();
  timer = new Timer(15);
}


void draw() {
  
  switch(gameState) {
    case GAME_RUN:
    // show the bg, control button
    image(bgImg, 0, 0, width, height) ;
  
    // move the fish
    swim();      
    // display the fish
    display();
      
    
    net.move();
    net.display();
    
    timer.update();
    timer.displayUI();
    if(timer.isTimeUp()) gameState = GAME_LOSE;
    break;
    
    case GAME_WIN:
    image(bgImg, 0, 0, width, height) ;
    drawText("You win!", #8BFFDB);
    break;
    
    case GAME_LOSE:
    drawText("GAME OVER", #ff0000);
    break;
  }
}

void generateFish(){
  img = loadImage("img/" + str(floor(random(4))) + ".png") ;
  float ratio = random(0.5, 0.7) ;
  w = img.width * ratio ;
  h = img.height * ratio ;
  x = random(width - w) ;
  y = 0 ;
  xSpeed = random(1, 2) * (random(1) < 0.5 ? 1 : -1) ;  
  ySpeed = random(1, 2) * (random(1) < 0.5 ? 1 : -1) ;
}

void swim() {
  x += xSpeed ;
  y += ySpeed ;
  
  if (x < 0 || x > width - w) { 
    xSpeed *= -1 ;
  }
  if (y < 0 || y > height - h) {
    ySpeed *= -1 ;
  }
}

void display() {
  int direction = (xSpeed > 0) ? RIGHT : LEFT;
  
  pushMatrix();
  translate(x, y);
  if (direction == RIGHT) {
    scale(1, 1);
    image(img, 0, 0, w, h); 
  } else {
    scale(-1, 1);
    image(img, -w, 0, w, h); 
  }
  popMatrix();
}


void drawText(String s, color textColor){
  textFont(myFont);
  textAlign(CENTER, CENTER);
  // shadow
  fill(0, 120);
  text(s, width / 2 + 3, height / 2 + 3);
  // text
  fill(textColor);
  text(s, width / 2, height / 2);
}

void mouseClicked() {
  net.drop(mouseX);
}
