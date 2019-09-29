void rgbHistogram(){

  int[] hist = new int[256];
  
  PImage gray_image = gray(imageList[selectedImage],"luma");
  PImage highlight = gray(imageList[selectedImage],"luma");
  
  int x1 = int(map(start, 0, rgbHist.width, 0, 255));
  int x2 = int(map(end, 0, rgbHist.width, 0, 255));
    
  gray_image.loadPixels();
  for(int i=0;i<gray_image.width*gray_image.height;i++){
    int localValue = int(red(gray_image.pixels[i]));
    hist[localValue]++; 
    if(localValue<x1 || localValue > x2){
      highlight.pixels[i]=color(0);
    }
  }
  highlight.updatePixels();
  
  rgbHist.beginDraw();
  rgbHist.background(150);
  int histMax = max(hist);
  for (int i = 0; i < rgbHist.width; i++) {
    int which = int(map(i, 0, rgbHist.width, 0, 255));
    int y = int(map(hist[which], 0, histMax, rgbHist.height, 0));
    if(i>start && i<end){rgbHist.stroke(255);}else{rgbHist.stroke(80);}
    rgbHist.line(i, rgbHist.height, i, y);   
  }
  rgbHist.strokeWeight(3);
  rgbHist.stroke(0,255,0);
  rgbHist.line(start, rgbHist.height, start, 0);
  rgbHist.stroke(255,255,0);
  rgbHist.line(end, rgbHist.height, end, 0);
  rgbHist.endDraw();
  
  gray_image.resize(h_w/2,h_w/2);
  highlight.resize(h_w/2,h_w/2);

  rgbImg.beginDraw();
  rgbImg.image(gray_image, 0, 0);
  rgbImg.image(highlight, h_w/2, 0);
  rgbImg.endDraw();
  
}
