PShape rule;

void arc_illusion(){
  noFill();
  rule = createShape();
  rule.beginShape();
  rule.curveVertex(84, 91);
  rule.curveVertex(84, 91);
  rule.curveVertex(68, 19);
  rule.curveVertex(21, 17);
  rule.curveVertex(32, 91);
  rule.curveVertex(32, 91);
  rule.endShape();
  
  
  illusion.beginDraw();
  illusion.clear();
  illusion.background(255);
  illusion.shape(rule, 200, 200);
  illusion.endDraw();
  
  
  helpText = "What arc is longer";
}
