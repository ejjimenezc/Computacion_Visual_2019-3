void color_illusion(){
  PImage gray = effect(grayNeg,"luma");
  PImage negative = effect(grayNeg,"negative");
  
  illusion.beginDraw();
  if(!start_01){
    illusion.image(gray,0,0);
  }else{
    illusion.image(negative,0,0);
    
    if(millis()-start_time>=20000){
      start_01 = false;
    }
  }
  
  illusion.strokeWeight(1);
  illusion.stroke(255);
  illusion.fill(0);
  illusion.circle(250,250,15);
  illusion.endDraw();
  
  helpText = "Presiona Enter para continuar, mira fijamente el punto negro, despues de 20 segundos se imprime la imagen a blanco y negro, pero"+
  "se deberia ver una imagen a color por poco tiempo.";
}
