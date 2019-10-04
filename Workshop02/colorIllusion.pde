void color_illusion(){
  PImage gray = effect(grayNeg,"luma");
  PImage negative = effect(grayNeg,"negative");
  
  illusion.beginDraw();
  if(!start_01){
    illusion.image(gray,0,0);
  }else{
    illusion.image(negative,0,0);
    
    if(millis()-start_time>=15000){
      start_01 = false;
    }
  }
  illusion.circle(250,250,15);
  illusion.endDraw();
  
  helpText = "Press Enter to start";
}
