void color_illusion(){
  PImage gray = effect(grayNeg,"luma");
  PImage negative = effect(grayNeg,"negative");
  
  illussion.beginDraw();
  if(!start_01){
    illussion.image(gray,0,0);
  }else{
    illussion.image(negative,0,0);
    
    if(millis()-start_time>=15000){
      start_01 = false;
    }
  }
  illussion.circle(250,250,15);
  illussion.endDraw();
  
  helpText = "Press Enter to start";
}
