PImage effect(PImage picture,String mode){
  
  PImage custom = picture.copy();
  picture.loadPixels();
  for(int i=0;i<picture.width*picture.height;i++){
      float redVal = red(picture.pixels[i]);
      float greenVal = green(picture.pixels[i]);
      float blueVal = blue(picture.pixels[i]);
      if(mode.equals("avg")){
        custom.pixels[i] = color((redVal+greenVal+blueVal)/3);
      }
      else if(mode.equals("luma")){
        custom.pixels[i] = color(redVal*0.299+greenVal*0.587+blueVal*0.114);
      }else if(mode.equals("negative")){
        custom.pixels[i] = color(255-redVal,255-greenVal,255-blueVal);
      }
  }
  custom.updatePixels();
  return custom;
}
