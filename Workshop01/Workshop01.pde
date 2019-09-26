PImage ogImage;
PGraphics ogImg, menu;
PGraphics gsAVG, gsLuma;
PGraphics rgbHist,rgbImg;
PGraphics edgeKernel,sharpenKernel,gaussianKernel,embossKernel;

int h_w = 500;
int option = 1;
                    
float[][] edge = {{ 0, 1, 0}, 
                  { 1,-4, 1}, 
                  { 0, 1, 0}};
                  
float[][] sharpen = {{ 0,-1, 0}, 
                     {-1, 5,-1}, 
                     { 0,-1, 0}};
                     
float[][] gaussian_blur = {{ 0.0625,0.125,0.0625}, 
                           { 0.1250,0.250,0.1250}, 
                           { 0.0625,0.125,0.0625}};
                           
                           
float[][] emboss = {{-2,-1, 0}, 
                   {-1, 0, 1}, 
                   { 0, 1, 2}};
                     
void setup() {
  
  size(1050, 500);  //Background Size
  background(0);
  ogImg = createGraphics(h_w, h_w);
  ogImage = loadImage("Scifi.jpg");  //Load original image
  //ogImage = loadImage("https" + "://processing.org/tutorials/color/imgs/hsb.png");
  ogImage.resize(h_w, h_w); //Resize original image
  ogImg.beginDraw();
  ogImg.image(ogImage, 0, 0);  //Draw original image on his own canvas
  ogImg.endDraw();

  
  menu = createGraphics(50,h_w);
  menu.beginDraw();
  menu.background(200,200,100);
  menu.endDraw();
  
  
  gsAVG = createGraphics(h_w,h_w);
  gsLuma = createGraphics(h_w, h_w);
  
  rgbHist = createGraphics(h_w*3, h_w);
  rgbImg = createGraphics(h_w*3, h_w);
  
  
  edgeKernel = createGraphics(h_w, h_w);
  sharpenKernel = createGraphics(h_w, h_w);
  gaussianKernel = createGraphics(h_w, h_w);
  embossKernel = createGraphics(h_w, h_w);
  
  
  gray_scale();
  rgbHistogram();
  kernels();
  
}

void draw() {

  clear();
  image(ogImg, 0, 0);
  image(menu, h_w, 0);
  switch(option){
    case 1:
      image(gsAVG, h_w+50, 0);
    break;
    case 2:
      image(gsLuma, h_w+50, 0);
    break;
    case 3:
      image(rgbHist, h_w+50, 0);
    break;
    case 4:
      image(edgeKernel, h_w+50, 0);
    break;
    case 5:
      image(sharpenKernel, h_w+50, 0);
    break;
    case 6:
      image(gaussianKernel, h_w+50, 0);
    break;
    case 7:
      image(embossKernel, h_w+50, 0);
    break;
    case 8:
    break;
    case 9:
    break;
    case 10:
      //video
    break;
    default:
    
    break;
    

  };

  for(int i = 0; i<20;i++){
    square(h_w,50*i,50);
  }
  fill(255,255,0);
  square(h_w,50*(option-1),50);
  fill(255);
}

void gray_scale(){
  PImage customAVG = ogImage.copy();
  PImage customLuma = ogImage.copy();
  
  ogImage.loadPixels();
  for(int i=0;i<ogImage.width*ogImage.height;i++){
      float redVal = red(ogImage.pixels[i]);
      float greenVal = green(ogImage.pixels[i]);
      float blueVal = blue(ogImage.pixels[i]);
      customAVG.pixels[i] = color((redVal+greenVal+blueVal)/3);
      customLuma.pixels[i] = color(redVal*0.299+greenVal*0.587+blueVal*0.114);
  }
  customAVG.updatePixels();
  customLuma.updatePixels();
  
  gsAVG.beginDraw();
  gsAVG.image(customAVG, 0, 0);
  gsAVG.endDraw();
  
  gsLuma.beginDraw();
  gsLuma.image(customLuma, 0, 0);
  gsLuma.endDraw();
}

void rgbHistogram(){
  int[] histR = new int[256];
  int[] histG = new int[256];
  int[] histB = new int[256];
  int transparency = 70;
  
  PImage customR = ogImage.copy();
  PImage customG = ogImage.copy();
  PImage customB = ogImage.copy();
  
  ogImage.loadPixels();
  for(int i=0;i<ogImage.width*ogImage.height;i++){
    color localP = ogImage.pixels[i];
    histR[int(red(localP))]++; 
    histG[int(green(localP))]++; 
    histB[int(blue(localP))]++; 
    customR.pixels[i] = color(red(localP), 0, 0);
    customG.pixels[i] = color(0, green(localP), 0);
    customB.pixels[i] = color(0, 0, blue(localP));
  }
  customR.updatePixels();
  customG.updatePixels();
  customB.updatePixels();
  
  rgbHist.beginDraw();
  rgbHist.background(220,220,220);
  int histMaxR = max(histR);
  int histMaxG = max(histG);
  int histMaxB = max(histB);
  for (int i = 0; i < rgbHist.width; i++) {
    int which = int(map(i, 0, rgbHist.width, 0, 255));
    int y_r = int(map(histR[which], 0, histMaxR, rgbHist.height, 0));
    int y_g = int(map(histG[which], 0, histMaxG, rgbHist.height, 0));
    int y_b = int(map(histB[which], 0, histMaxB, rgbHist.height, 0));
    rgbHist.stroke(255,0,0,transparency);
    rgbHist.line(i, rgbHist.height, i, y_r);
    rgbHist.stroke(0,255,0,transparency+50);
    rgbHist.line(i, rgbHist.height, i, y_g);
    rgbHist.stroke(0,0,255,transparency);
    rgbHist.line(i, rgbHist.height, i, y_b);
  }
  rgbHist.tint(255, 126);
  rgbHist.endDraw();
  
  rgbImg.beginDraw();
  rgbImg.image(customR, 0, 0);
  rgbImg.image(customG, h_w, 0);
  rgbImg.image(customB, h_w*2, 0);
  rgbImg.endDraw();
  
}

void kernels(){
  edgeKernel.beginDraw();
  edgeKernel.image(kernel_3x3(ogImage,edge), 0, 0);
  edgeKernel.endDraw();
  
  sharpenKernel.beginDraw();
  sharpenKernel.image(kernel_3x3(ogImage,sharpen), 0, 0);
  sharpenKernel.endDraw();
  
  
  gaussianKernel.beginDraw();
  gaussianKernel.image(kernel_3x3(ogImage,gaussian_blur), 0, 0);
  gaussianKernel.endDraw();
  
  embossKernel.beginDraw();
  embossKernel.image(kernel_3x3(ogImage,emboss), 0, 0);
  embossKernel.endDraw();
}


PImage kernel_3x3(PImage picture,float[][] kernel){

  PImage custom = picture.copy();
  
  ogImage.loadPixels();
  for (int y = 1; y < ogImage.height-1; y++) { 
    for (int x = 1; x < ogImage.width-1; x++) { 
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      
      for(int ky = -1; ky <= 1; ky++){
        for(int kx = -1; kx <= 1; kx++){
          int pos = ( y+ky )*ogImage.width + ( x+kx );
          float valR = red(ogImage.pixels[pos]);
          float valG = green(ogImage.pixels[pos]);
          float valB = blue(ogImage.pixels[pos]);
          sumR += kernel [ky+1][kx+1] * valR;
          sumG += kernel [ky+1][kx+1] * valG;
          sumB += kernel [ky+1][kx+1] * valB;
        }
      }
      custom.pixels[y*ogImage.width + x] = color(sumR, sumG, sumB);
    }
  }
  custom.updatePixels();
  
  return custom;
}

void mouseClicked() {
  if (mouseX > h_w && mouseX < h_w+50) {
    if(mouseY<h_w){
      println(mouseY);
      option = mouseY/50+1;
    }
  }
}

//https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image
