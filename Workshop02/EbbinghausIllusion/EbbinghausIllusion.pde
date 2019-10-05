//"Ebbinghaus Illusion"

float x=0;
boolean colorCircle=true;
PGraphics orangeCircles, blueCircles;

void setup() {
  size(800, 500);
  orangeCircles = createGraphics(800, 500);
  blueCircles = createGraphics(800, 500);
}

void draw() {
  background(255);
  
  orangeCircles.beginDraw();
  fill(255,165,0);
  stroke(255,165,0);
  //right
  circle(600, 255, 85);
  //left
  circle(200, 255, 85);
  orangeCircles.endDraw();
  
  blueCircles.beginDraw();
  if(colorCircle){
    fill(100,149,237);
    stroke(100,149,237);
  }else{
    fill(255);
    stroke(255);
  }
  //right
  circle(600, 180, 30);
  circle(600, 325, 30);
  circle(670, 255, 30);
  circle(530, 255, 30);
  circle(660, 220, 30);
  circle(635, 195, 30);
  circle(540, 220, 30);
  circle(565, 195, 30);
  circle(660, 291, 30);
  circle(540, 291, 30);
  circle(632, 312, 30);
  circle(568, 312, 30);
  
  //left
  circle(200, 130, 90);
  circle(200, 375, 90);
  circle(330, 255, 90);
  circle(70, 255, 90);
  circle(115, 173, 90);
  circle(285, 173, 90);
  circle(115, 337, 90);
  circle(285, 337, 90);
  blueCircles.endDraw();
}

void mousePressed() {
    colorCircle = !colorCircle;
}
