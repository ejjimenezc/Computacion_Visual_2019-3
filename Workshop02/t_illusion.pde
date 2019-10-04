int line_length = 300;
int y_initial = 400;

void t_illusion(){
  
  int h = 500-line_length;
  
  illusion.beginDraw();
  
  illusion.clear();
  illusion.background(255);
  illusion.strokeCap(ROUND);
  illusion.strokeWeight(10);
  illusion.stroke(100,0,0);
  
  illusion.line(h/2,y_initial,500-h/2,y_initial);
  illusion.line(250,y_initial,250,mouseY);
  
  if (mousePressed == true) {
    illusion.strokeWeight(2);
    illusion.stroke(0,200,0);
    illusion.line(250,y_initial,250,y_initial-line_length);
  }
  
  illusion.endDraw();
  helpText = "Change the length of the vertical line moving the mouse, "+
             "drag the size until the vertical and horizontal are identical in length. "+
             "Press Left Click to view the true size.";
}
