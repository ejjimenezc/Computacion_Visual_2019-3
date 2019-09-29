void movieEvent(Movie m) {
  m.read();
  
  video.beginDraw();
  if(value==0){
    video.image(m, 0, 0, 525, 500);
  } else if(value==1){
    video.image(gray(m,"avg"), 0, 0, 525, 500);
  } else if(value==2){
    video.image(gray(m,"luma"), 0, 0, 525, 500);
  } else if(value==3){
    video.image(kernel_3x3(m,edgeDetection), 0, 0, 525, 500);
  } else if(value==4){
    video.image(kernel_3x3(m,sharpen), 0, 0, 525, 500);
  } else if(value==5){
    video.image(kernel_3x3(m,gaussianBlur3x3), 0, 0, 525, 500);
  } else if(value==6){
    video.image(kernel_4x4(m,emboss), 0, 0, 525, 500);
  } else if(value==7){
    video.image(kernel_5x5(m,gaussianBlur5x5), 0, 0, 525, 500);
  }  else if(value==8){
    video.image(kernel_5x5(m,unsharpMasking), 0, 0, 525, 500);
  }
  
  video.textSize(30);
  video.text(round(frameRate),10,35);
  video.endDraw();
  
}
