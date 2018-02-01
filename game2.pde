// Fully functional snake game without a wall
import java.awt.Point;
import java.util.ArrayList;

ArrayList<Point> snake = new ArrayList<Point>();
int len0 = 10;
int pix = 10;
String dir = "right"; 
int xBound = 500;
int yBound = 500;
boolean isOver = false;
Point appleLoc = new Point(250, 250);
int score = 0;
int time = 0;
Boolean isExtend = false;

void setup(){
  size(500, 500);
  background(0);
  drawStartSnake();
  frameRate(10);
}

void draw(){
  background(0);
  
  // Draw the snake
  drawSnake();
  
  // Change travelling direction
  Point newHead = updateHead();
  
  // Update the snake location
  makeNewSnake(newHead, isExtend);
  
  // Check if the snake runs into the wall
  boolean isOver = isGameOver(newHead);
  if (isOver) drawHitEffect(newHead);
  displayGameOver(isOver);
  
  // Check if the snake eats the apple
  Boolean isHit = hitApple(newHead);
  
  // Draw the apple
  drawApple(appleLoc);
  
  // Make a new apple if the previous one was eaten
  if (isHit) updateAppleLoc();
  
  // Update score
  fill(255, 255, 255);
  text("Score: " + score, 420, 20);
  
  // Update the timer for extending the length of the snake
  time = time + 1;
  isExtend = extendSnake(time);
  
}

void displayGameOver(Boolean isOver){
  if (isOver) {
    fill(255);
    text("Game Over!", 220, 250);
    noLoop();
  }  
}

Boolean extendSnake(int time){
  if (time % 10 == 0) {
    return true;
  } else {
    return false;
  }
}

Boolean hitApple(Point newHead){
  if (newHead.x == appleLoc.x && newHead.y == appleLoc.y) {
    drawHitEffect(newHead);
    return true;
  } else {
    return false;
  }
}

void drawHitEffect(Point newHead){
  stroke(255, 255, 0);
  strokeWeight(5); 
  line(newHead.x - 5, newHead.y - 5, newHead.x + 5, newHead.y + 5);
  line(newHead.x - 5, newHead.y + 5, newHead.x + 5, newHead.y - 5);
}

void updateAppleLoc(){
    appleLoc.setLocation(int(random(50))*pix, int(random(50))*pix);
    score = score + 1;
    println("score: ", score);
  //println("ax", appleLoc.x);
  //println("ay", appleLoc.y);
  //println("hx", newHead.x);
  //println("hy", newHead.y);
}

void drawApple(Point appleLoc){
  fill(200, 0, 0);
  ellipse(appleLoc.x, appleLoc.y, 5, 5); 
}

boolean isGameOver(Point newHead){
  if (newHead.x < 0 || newHead.x > xBound || newHead.y < 0 || newHead.y > yBound){
    return true;
  } 
  
  for (int i = 0; i < snake.size() - 1; i++) {
    if (newHead.x == snake.get(i).x && newHead.y == snake.get(i).y){
    return true;
    }
  }
  
  return false;
}

void makeNewSnake(Point newHead, Boolean isExtend){
  snake.add(newHead);
  if (!isExtend) {snake.remove(0);}
}

Point updateHead(){
  Point newHead = new Point();
  if (keyPressed) {
      newHead = updateHeadKey();
    } else {
      newHead = updateHeadAut();
    } 
  return newHead;
}

Point updateHeadKey(){
  Point newHead = new Point();
  Point oldHead = snake.get(snake.size()-1);
  //String dir;
  if (keyCode == LEFT) {
      newHead.x = oldHead.x - pix; 
      newHead.y = oldHead.y;
      dir = "left";
    }else if (keyCode == RIGHT) {
      newHead.x = oldHead.x + pix; 
      newHead.y = oldHead.y;
      dir = "right";
    }else if (keyCode == UP) {
      newHead.x = oldHead.x; 
      newHead.y = oldHead.y - pix;
      dir = "up";
    }else if (keyCode == DOWN) {
      newHead.x = oldHead.x; 
      newHead.y = oldHead.y + pix;
      dir = "down";
    }
    return newHead;
}

Point updateHeadAut(){
  Point newHead = new Point();
  Point oldHead = snake.get(snake.size()-1);
  //String dir;
  if (dir == "left") {
      newHead.x = oldHead.x - pix; 
      newHead.y = oldHead.y;
    }else if (dir == "right") {
      newHead.x = oldHead.x + pix; 
      newHead.y = oldHead.y;
    }else if (dir == "up") {
      newHead.x = oldHead.x; 
      newHead.y = oldHead.y - pix; 
    }else if (dir == "down") {
      newHead.x = oldHead.x; 
      newHead.y = oldHead.y + pix;
    }
    return newHead;
}
  
void drawStartSnake(){
  for (int i = 0; i < len0; i++){
    snake.add(new Point(0 + i*10, 10));
  }
}

void drawSnake(){ 
  int snakeLen = snake.size();
  noFill();
  beginShape();
  stroke(0, 255, 0);
  strokeWeight(pix/2);
    for (Point p : snake) {
      vertex(p.x, p.y);
    }
  endShape();
  stroke(255, 0, 0);
  point(snake.get(snakeLen-1).x, snake.get(snakeLen-1).y);
}