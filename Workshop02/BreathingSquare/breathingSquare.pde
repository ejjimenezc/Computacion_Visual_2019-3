//"Breathing Square"

boolean grow=true;
PGraphics squareAnim;
float x=0, y1=1, y2=1, y3=1, y4=1;
float scaleSpeed=0.002, rotSpeed=0.02;

void setup() {
  size(600, 600);  
  squareAnim = createGraphics(600, 600);
}

void draw() {
  background(255);
  
  //Blue Square
  pushMatrix();
  squareAnim.beginDraw();
  rectMode(CENTER);
  fill(0,0,255);
  stroke(0,0,255);
  translate(width/2, height/2);
  rotate(x+=rotSpeed);
  rect(0, 0, 350, 350);
  squareAnim.endDraw();
  popMatrix();
  
  //Upper-left square
  pushMatrix();
  squareAnim.beginDraw();
  rectMode(CENTER); 
  fill(255, 255, 0);
  stroke(255, 255, 0);
  if(y1>2.38){
    grow=false;
  }
  if(y1<1.5){
    grow=true;
  }
  if(grow){
    scale(y1+=scaleSpeed);
  }else{
    scale(y1-=scaleSpeed);
  }
  rect(0, 0, 250, 250);
  squareAnim.endDraw();
  popMatrix();
  
  //Upper-right square
  pushMatrix();
  squareAnim.beginDraw();
  rectMode(CENTER); 
  fill(255, 255, 0);
  stroke(255, 255, 0);
  translate(width, 0);
  if(y2>2.38){
    grow=false;
  }
  if(y2<1.5){
    grow=true;
  }
  if(grow){
    scale(y2+=scaleSpeed);
  }else{
    scale(y2-=scaleSpeed);
  }
  rect(0, 0, 250, 250);
  squareAnim.endDraw();
  popMatrix();
  
  //Lower-left square
  pushMatrix();
  squareAnim.beginDraw();
  rectMode(CENTER); 
  fill(255, 255, 0);
  stroke(255, 255, 0);
  translate(0, height);
  if(y3>2.38){
    grow=false;
  }
  if(y3<1.5){
    grow=true;
  }
  if(grow){
    scale(y3+=scaleSpeed);
  }else{
    scale(y3-=scaleSpeed);
  }
  rect(0, 0, 250, 250);
  squareAnim.endDraw();
  popMatrix();
  
  //Lower-right square
  pushMatrix();
  squareAnim.beginDraw();
  rectMode(CENTER); 
  fill(255, 255, 0);
  stroke(255, 255, 0);
  translate(width, height);
  if(y4>2.38){
    grow=false;
  }
  if(y4<1.5){
    grow=true;
  }
  if(grow){
    scale(y4+=scaleSpeed);
  }else{
    scale(y4-=scaleSpeed);
  }
  rect(0, 0, 250, 250);
  squareAnim.endDraw();
  popMatrix();
}
