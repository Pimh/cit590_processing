/* CIT590 HW7 - Draw a picture
Pimkhuan (Pim) Hannanta-anan 
Due 10/23/2016 */ 

void setup() {
  size(360,300);
  gradient();
  
  // Draw the side of the owl's head
  stroke(139, 69, 19);
  swirl(180, 100, 270, 70, 5, false);
  
  // Draw the owl's body
  stroke(139, 69, 19);
  swirl(180, 240, 240, 260, 8, false);
  point(180, 220); 
  
  // Draw the owl's bill
  stroke(204, 102, 0);
  translate(160, 185);
  beak();
  resetMatrix();
  
  // Draw the owl's eyes
  stroke(0, 0, 0);
  swirl(110, 140, 140, 145, 15, false);
  swirl(250, 140, 140, 145, 15, false);
  
  // Draw the owl's eyebrow
  translate(30, 15);
  eyeBrow();
  translate(300, 0);
  scale(-1, 1);
  eyeBrow();
  resetMatrix();
 
  // Add text to the corner of the picture
  fill(0);
  text("Pim Hannanta-anan", 240, 295);
}

/** Draw a swirly eye */
void swirl(int x, int y, int w, int h, int n, boolean isArc) {
  
  for (int i = 0; i < n; i++) {
    strokeWeight(3 - 0.2*i);
    fill(255, 255, 255);
    if (isArc) {
      arc(x, y, w - 10*i, h - 10*i, -PI/8, 6*PI/8);
    }
    else {
      ellipse(x, y, w - 10*i, h - 10*i);
    }
  }
}

/** Draw a curly line */
void curlyLine(int[] coords, color clr) {
  int x1 = coords[0]; int y1 = coords[1];
  int x2 = coords[2]; int y2 = coords[3];
  int x3 = coords[4]; int y3 = coords[5];
  int x4 = coords[6]; int y4 = coords[7];
  fill(clr);
 
  strokeWeight(4);
  curveVertex(x1, y1);
  curveVertex(x1, y1);
  curveVertex(x2, y2);
  curveVertex(x3, y3);
  curveVertex(x4, y4);
  curveVertex(x4, y4);  
 }

/** Draw an eyebrow */
void eyeBrow() {
  int[] coords1 = {0, 0, 40, 30, 120, 40, 150, 70};
  int[] coords2 = {150, 70, 120, 50, 25, 45, 0, 0};
  beginShape();
    curlyLine(coords2, color(0, 0, 0));
    curlyLine(coords1, color(0, 0, 0));
  endShape();
}
 
/** Draw a bill */
void beak() {
  int[] coords1 = {0, 0, 5, 20, 15, 38, 20, 45};
  int[] coords2 = {20, 45, 25, 38, 35, 20, 40, 0};
  beginShape();
    curlyLine(coords2, color(204, 102, 0));
    curlyLine(coords1, color(204, 102, 0));
  endShape();
}

/** Draw a head */
void head() {
  translate(50, -75);
  rotate(radians(80));
  swirl(150, 0, 55, 50, 5, true);
  resetMatrix();
  
  translate(285, 72);
  rotate(radians(270));
  swirl(0, 0, 55, 50, 5, true);
  resetMatrix();
}

/** Create a gradient background */
void gradient() {
  int[] sq1 = {0, 0, 360, 360};
  int[] sq2 = {60, 60, 240, 240};
  float n = sq2[0] - sq1[0];
  color colr1 = color(164, 244, 249);
  color colr2 = color(237, 209, 47);
  for (float i = 0; i <= n; i++) {
    stroke(lerpColor(colr1, colr2, i/n));
    strokeWeight(1);
    noFill();
    if (i == n) { fill(lerpColor(colr1, colr2, i/n));}
    rect(0+i, 0+i, 360-2*i, 360-2*i);
  }
}