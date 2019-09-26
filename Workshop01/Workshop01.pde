PImage ogImage;
PGraphics ogImg, menu;
PGraphics gsAVG, gsLuma;
PGraphics rgbHist,rgbImg;
PGraphics edgeKernel,sharpenKernel,gaussianKernel,embossKernel;


int h_w = 500;
int option = 1;      
int range_a = 0;
int range_b = h_w;

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
  
  rgbHist = createGraphics(h_w, h_w/2);
  rgbImg = createGraphics(h_w, h_w/2);
  
  
  edgeKernel = createGraphics(h_w, h_w);
  sharpenKernel = createGraphics(h_w, h_w);
  gaussianKernel = createGraphics(h_w, h_w);
  embossKernel = createGraphics(h_w, h_w);
  
  
  gray_scale();
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
      rgbHistogram();
      image(rgbHist, h_w+50, 0);
      image(rgbImg, h_w+50, h_w/2);
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

void gray_scale(){  
  gsAVG.beginDraw();
  gsAVG.image(gray(ogImage,"avg"), 0, 0);
  gsAVG.endDraw();
  
  gsLuma.beginDraw();
  gsLuma.image(gray(ogImage,"luma"), 0, 0);
  gsLuma.endDraw();
}

void rgbHistogram(){
  
  int start = min(range_a,range_b);
  int end = max(range_a,range_b);
  
  int[] hist = new int[256];
  
  PImage gray_image = gray(ogImage,"luma");
  PImage highlight = gray(ogImage,"luma");
  
  gray_image.loadPixels();
  for(int i=0;i<gray_image.width*gray_image.height;i++){
    color localP = gray_image.pixels[i];
    hist[int(red(localP))]++; 
  }
  
  rgbHist.beginDraw();
  rgbHist.background(100,100,100);
  int histMax = max(hist);
  for (int i = 0; i < rgbHist.width; i++) {
    int which = int(map(i, 0, rgbHist.width, 0, 255));
    int y_r = int(map(hist[which], 0, histMax, rgbHist.height, 0));
    rgbHist.stroke(200,200,200);
    rgbHist.line(i, rgbHist.height, i, y_r);
  }
  rgbHist.endDraw();
  
  //gray_image.loadPixels();
  //for(int j=0;i<gray_image.width*gray_image.height;i++){
  //  color localP = gray_image.pixels[i];
  //  hist[int(red(localP))]++; 
  //}
  
  gray_image.resize(h_w/2,h_w/2);
  
  
  
  
  rgbImg.beginDraw();
  rgbImg.image(gray_image, 0, 0);
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
      option = mouseY/50+1;
    }
  }
}

//https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image
