PShape side1,side2,side3,necker_cube1,necker_cube2;

void necker(){
  
  necker_cube1 = createShape(GROUP);
  necker_cube2 = createShape(GROUP);
  side1 = createShape();
  side2 = createShape();
  side3 = createShape();
  
  side1.beginShape();
  side1.vertex(30, 130);
  side1.vertex(130, 130);
  side1.vertex(130, 230);
  side1.vertex(30, 230);
  side1.endShape();
  
  side2.beginShape();
  side2.vertex(30, 130);
  side2.vertex(130, 130);
  side2.vertex(190, 100);
  side2.vertex(90, 100);
  side2.endShape();
  
  side3.beginShape();
  side3.vertex(190, 100);
  side3.vertex(190, 200);
  side3.vertex(130, 230);
  side3.vertex(130, 130);
  side3.endShape();
  
  side1.setFill(color(100,0,0));
  side2.setFill(color(150,0,0));
  side3.setFill(color(150,0,0));
  
  necker_cube1.addChild(side3);
  necker_cube1.addChild(side2);
  necker_cube1.addChild(side1);
  
  side1 = createShape();
  side2 = createShape();
  side3 = createShape();
  
  side1.beginShape();
  side1.vertex(300, 300);
  side1.vertex(400, 300);
  side1.vertex(400, 400);
  side1.vertex(300, 400);
  side1.endShape();
  
  side2.beginShape();
  side2.vertex(300, 300);
  side2.vertex(240, 330);
  side2.vertex(240, 430);
  side2.vertex(300, 400);
  side2.endShape();

  side3.beginShape();
  side3.vertex(400, 400);
  side3.vertex(340, 430);
  side3.vertex(240, 430);
  side3.vertex(300, 400);
  side3.endShape();
  
  side1.setFill(color(0,100,0));
  side2.setFill(color(0,150,0));
  side3.setFill(color(0,50,0));
  
  necker_cube2.addChild(side2);
  necker_cube2.addChild(side1);
  necker_cube2.addChild(side3);
  
  illusion.beginDraw();
  illusion.clear();
  illusion.background(255);
  illusion.shape(necker_cube1, 0, 0);
  illusion.shape(necker_cube2, 0, 0);
  illusion.endDraw();
  
  
  helpText = "Necker Cube";
}
