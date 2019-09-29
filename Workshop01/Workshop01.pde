//Para el desarrollo del taller se utilizó código de las siguientes fuentes:
//https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image

import processing.video.*;

Movie myMovie;
PImage[] imageList = new PImage[4];
PGraphics ogImg, menu;
PGraphics gsAVG, gsLuma;
PGraphics rgbHist,rgbImg;
PGraphics edgeK,sharpenK,gaussian3K,embossK,gaussian5K,unsharpK;
PGraphics video;

int h_w = 500;
int option = 1;      
int start = 0;
int end = h_w;
int buttons = 100;
int value=0;
int selectedImage = 0;

boolean update = true;
String[] menus = {"AVG","Luma","Histogram","Edge 3x3","Sharpen 3x3","Gaussian 3x3","Emboss 4x4","Gaussian 5x5","Unsharpen 5x5","Video"};

float[][] edgeDetection = {{-1,-1,-1}, 
                           {-1, 8,-1}, 
                           {-1,-1,-1}};
                  
float[][] sharpen = {{ 0,-1, 0}, 
                     {-1, 5,-1}, 
                     { 0,-1, 0}};
                     
float[][] gaussianBlur3x3 = {{ 1/16.,2/16.,2/16.}, 
                             { 2/16.,4/16.,2/16.}, 
                             { 1/16.,2/16.,1/16.}};
                             
float[][] emboss = {{-3,-2,-1, 0}, 
                    {-2,-1, 0, 1}, 
                    {-1, 0, 1, 2}, 
                    { 0, 1, 2, 3}};
                   
float[][] gaussianBlur5x5 = {{ 1/256., 4/256., 6/256., 4/256., 1/256.}, 
                             { 4/256.,16/256.,24/256.,16/256., 4/256.}, 
                             { 6/256.,24/256.,36/256.,24/256., 6/256.}, 
                             { 4/256.,16/256.,24/256.,16/256., 4/256.}, 
                             { 1/256., 4/256., 6/256., 4/256., 1/256.}};
                           

float[][] unsharpMasking = {{ -1/256., -4/256., -6/256., -4/256., -1/256.}, 
                            { -4/256.,-16/256.,-24/256.,-16/256., -4/256.}, 
                            { -6/256.,-24/256.,476/256.,-24/256., -6/256.}, 
                            { -4/256.,-16/256.,-24/256.,-16/256., -4/256.}, 
                            { -1/256., -4/256., -6/256., -4/256., -1/256.}};
                           
                     
void setup() {
  
  size(1100, 500);  
  background(255);
  textAlign(CENTER);
  
  //Original Image
  ogImg = createGraphics(h_w, h_w);
  imageList[0] = loadImage("image.jpg");
  imageList[1] = loadImage("glados.jpg");
  imageList[2] = loadImage("Scifi.jpg");
  imageList[3] = loadImage("flowers.jpg");
  imageList[0].resize(h_w, h_w);
  imageList[1].resize(h_w, h_w);
  imageList[2].resize(h_w, h_w);
  imageList[3].resize(h_w, h_w);
  
  ogImg.beginDraw();
  ogImg.image(imageList[selectedImage], 0, 0); 
  ogImg.endDraw();

  //Menu Buttons
  menu = createGraphics(buttons,h_w);
  menu.beginDraw();
  menu.background(255);
  menu.endDraw();
  
  //B/W
  gsAVG = createGraphics(h_w,h_w);
  gsLuma = createGraphics(h_w, h_w);
  rgbHist = createGraphics(h_w, h_w/2);
  rgbImg = createGraphics(h_w, h_w/2);
  
  //Kernels
  edgeK = createGraphics(h_w, h_w);
  sharpenK = createGraphics(h_w, h_w);
  gaussian3K = createGraphics(h_w, h_w);
  embossK = createGraphics(h_w, h_w);
  gaussian5K = createGraphics(h_w, h_w);
  unsharpK = createGraphics(h_w, h_w);
  
  video = createGraphics(h_w, h_w);
  
  myMovie = new Movie(this, "cuphead (SinVolumen).mp4");
  myMovie.loop();
  
  image(menu, h_w, 0);
}

void draw() {
  
  myMovie.pause();
  
  image(ogImg, 0, 0);
  //Only update buttons when changing option
  if(update){
    myMovie.stop();
    for(int i = 0; i<10;i++){
      if(option-1==i){
        fill(150,150,255);
      }else{
        fill(255);
      }
      square(h_w,buttons/2*i,buttons);
      textSize(12);
      fill(0);
      text(menus[i],h_w+buttons/2,(buttons/2*(i+1))-22);
    }
    update = false;
  }
  
  //Select option
  switch(option){
    case 1:
      gsAVG.beginDraw();
      gsAVG.image(gray(imageList[selectedImage],"avg"), 0, 0);
      gsAVG.endDraw();
      image(gsAVG, h_w+buttons, 0);
    break;
    case 2:
      gsLuma.beginDraw();
      gsLuma.image(gray(imageList[selectedImage],"luma"), 0, 0);
      gsLuma.endDraw();
      image(gsLuma, h_w+buttons, 0);
    break;
    case 3:   
      rgbHistogram();
      image(rgbHist, h_w+buttons, 0);
      image(rgbImg, h_w+buttons, h_w/2);
    break;
    case 4:
      edgeK.beginDraw();
      edgeK.image(kernel_3x3(imageList[selectedImage],edgeDetection), 0, 0);
      edgeK.endDraw();
      image(edgeK, h_w+buttons, 0);
    break;
    case 5:
      sharpenK.beginDraw();
      sharpenK.image(kernel_3x3(imageList[selectedImage],sharpen), 0, 0);
      sharpenK.endDraw();
      image(sharpenK, h_w+buttons, 0);
    break;
    case 6:
      gaussian3K.beginDraw();
      gaussian3K.image(kernel_3x3(imageList[selectedImage],gaussianBlur3x3), 0, 0);
      gaussian3K.endDraw();
      image(gaussian3K, h_w+buttons, 0);
    break;
    case 7:
      embossK.beginDraw();
      embossK.image(kernel_4x4(imageList[selectedImage],emboss), 0, 0);
      embossK.endDraw();
      image(embossK, h_w+buttons, 0);
    break;
    case 8:
      gaussian5K.beginDraw();
      gaussian5K.image(kernel_5x5(imageList[selectedImage],gaussianBlur5x5), 0, 0);
      gaussian5K.endDraw();
      image(gaussian5K, h_w+buttons, 0);
    break;
    case 9:
      unsharpK.beginDraw();
      unsharpK.image(kernel_5x5(imageList[selectedImage],unsharpMasking), 0, 0);
      unsharpK.endDraw();
      image(unsharpK, h_w+buttons, 0);
    break;
    case 10:
      myMovie.play();
      image(video, h_w+buttons, 0, 525, 500);
    break;
    default:
    break;
  };
}

PImage gray(PImage picture,String mode){
  
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
      }
  }
  custom.updatePixels();
  return custom;
}

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

PImage kernel_3x3(PImage picture,float[][] kernel){

  PImage custom = picture.copy();
  
  picture.loadPixels();
  for (int y = 1; y < picture.height-1; y++) { 
    for (int x = 1; x < picture.width-1; x++) { 
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      
      for(int ky = -1; ky <= 1; ky++){
        for(int kx = -1; kx <= 1; kx++){
          int pos = ( y+ky )*picture.width + ( x+kx );
          float valR = red(picture.pixels[pos]);
          float valG = green(picture.pixels[pos]);
          float valB = blue(picture.pixels[pos]);
          sumR += kernel [ky+1][kx+1] * valR;
          sumG += kernel [ky+1][kx+1] * valG;
          sumB += kernel [ky+1][kx+1] * valB;
        }
      }
      custom.pixels[y*picture.width + x] = color(sumR, sumG, sumB);
    }
  }
  custom.updatePixels();
  
  return custom;
}

PImage kernel_4x4(PImage picture,float[][] kernel){

  PImage custom = picture.copy();
  
  picture.loadPixels();
  for (int y = 1; y < picture.height-2; y++) { 
    for (int x = 1; x < picture.width-2; x++) { 
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      
      for(int ky = -1; ky <= 2; ky++){
        for(int kx = -1; kx <= 2; kx++){
          int pos = ( y+ky )*picture.width + ( x+kx );
          float valR = red(picture.pixels[pos]);
          float valG = green(picture.pixels[pos]);
          float valB = blue(picture.pixels[pos]);
          sumR += kernel [ky+1][kx+1] * valR;
          sumG += kernel [ky+1][kx+1] * valG;
          sumB += kernel [ky+1][kx+1] * valB;
        }
      }
      custom.pixels[y*picture.width + x] = color(sumR, sumG, sumB);
    }
  }
  custom.updatePixels();
  
  return custom;
}

PImage kernel_5x5(PImage picture,float[][] kernel){

  PImage custom = picture.copy();
  
  picture.loadPixels();
  for (int y = 2; y < picture.height-2; y++) { 
    for (int x = 2; x < picture.width-2; x++) { 
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      
      for(int ky = -2; ky <= 2; ky++){
        for(int kx = -2; kx <= 2; kx++){
          int pos = ( y+ky )*picture.width + ( x+kx );
          float valR = red(picture.pixels[pos]);
          float valG = green(picture.pixels[pos]);
          float valB = blue(picture.pixels[pos]);
          sumR += kernel [ky+2][kx+2] * valR;
          sumG += kernel [ky+2][kx+2] * valG;
          sumB += kernel [ky+2][kx+2] * valB;
        }
      }
      custom.pixels[y*picture.width + x] = color(sumR, sumG, sumB);
    }
  }
  custom.updatePixels();
  
  return custom;
}

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

void keyPressed() {
  if (keyCode == '0') {
    value=0;
  } else if (keyCode == '1') {
    selectedImage=0;
    value=1;
  } else if (keyCode == '2') {
    selectedImage=1;
    value=2;
  } else if (keyCode == '3') {
    selectedImage=2;
    value=3;
  } else if (keyCode == '4') {
    selectedImage=3;
    value=4;
  } else if (keyCode == '5') {
    value=5;
  } else if (keyCode == '6') {
    value=6;
  } else if (keyCode == '7') {
    value=7;
  } else if (keyCode == '8') {
    value=8;
  } 
  ogImg.beginDraw();
  ogImg.image(imageList[selectedImage], 0, 0); 
  ogImg.endDraw();
}

void mouseClicked() {
  //Check if the click was in the menu zone
  if (mouseX > h_w && mouseX < h_w+buttons) {
    if(mouseY<h_w){
      option = mouseY/50+1;
      update = true;
    }
  }
}

void mousePressed() {
  //Check if the clicks was in the histogram zone
  if(mouseX > h_w+buttons && mouseX < h_w*2+buttons && mouseY > 0 && mouseY < h_w/2 && option==3){
    if (mouseButton == LEFT && mouseX-h_w-buttons<end) {
      start = mouseX-h_w-buttons;
    } else if (mouseButton == RIGHT && mouseX-h_w-buttons>start) {
      end = mouseX-h_w-buttons;
    }
  }
}
