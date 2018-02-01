/* CIT590 HW8 - animations 
Pimkhuan(Pim) Hannanta-anan */

import java.awt.Point;
import java.util.ArrayList;

ArrayList<Point> snake = new ArrayList<Point>();
ArrayList<Point> obstacles = new ArrayList<Point>();
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
  frameRate(12);
}

void draw(){
  background(0);
  
  // Draw wall
  drawWall();
  
  // Change travelling direction
  Point newHead = updateHead();
  
  // Update the snake location
  makeNewSnake(newHead, isExtend);
  
  // Draw the snake
  drawSnake();
  
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
  
  // Add obstacles - increase with the score
  if (time % 100 == 0) makeObstacles();
  drawObstacles();
}

void makeObstacles(){
  int numObs = floor(score/2);
  obstacles.clear(); 
  for (int i = 0; i < numObs; i++) {
      int x = int(random(46) + 2)*pix;
      int y = int(random(46) + 2)*pix;
      Point p = new Point(x, y);
      while (isObstacleLoc(x, y) || isSnakeLoc(x, y)) {
        x = int(random(46) + 2)*pix;
        y = int(random(46) + 2)*pix;
        p = new Point(x, y);
      }
      obstacles.add(p);    
  }
}

void drawObstacles(){
  int numObs = obstacles.size(); 
  for (int i = 0; i < numObs; i++) {
    stroke(0);
    strokeWeight(1);
    fill(139,69,19);
    rect(obstacles.get(i).x - 5, obstacles.get(i).y - 5, 10, 10);
  }
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
  int x = int(random(48) + 1)*pix;
  int y = int(random(48) + 1)*pix;
  while (isObstacleLoc(x, y) || isSnakeLoc(x, y)) {
    x = int(random(48) + 1)*pix;
    y = int(random(48) + 1)*pix;
  }
  appleLoc.setLocation(x, y);
  score = score + 1; 
}

boolean isObstacleLoc(int x, int y){
  for (int i = 0; i < obstacles.size(); i++){
    if (obstacles.get(i).x == x && obstacles.get(i).y == y) {
      return true;
    }
  }
  return false;
}

boolean isSnakeLoc(int x, int y){
  for (int i = 0; i < snake.size(); i++){
    if (snake.get(i).x == x && snake.get(i).y == y) {
      return true;
    }
  }
  return false;
}

void drawApple(Point appleLoc){
  fill(200, 0, 0);
  ellipse(appleLoc.x, appleLoc.y, 5, 5); 
}

boolean isGameOver(Point newHead){
  if (newHead.x < 10 || newHead.x > xBound - 10
  || newHead.y < 10 || newHead.y > yBound - 10){
    return true;
  } 
  
  for (int i = 0; i < snake.size() - 1; i++) {
    if (newHead.x == snake.get(i).x && newHead.y == snake.get(i).y){
    return true;
    }
  }
  
  for (int i = 0; i < obstacles.size(); i++) {
    if (newHead.x == obstacles.get(i).x && newHead.y == obstacles.get(i).y){
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

void drawWall(){
  float w = 2.5;
  stroke(139,69,19);
  strokeWeight(pix);  
  noFill();
  beginShape();
    vertex(w, w);
    vertex(w, yBound - w);
    vertex(xBound - w, yBound - w);
    vertex(xBound - w, w);
    vertex(w, w);
  endShape();   
}