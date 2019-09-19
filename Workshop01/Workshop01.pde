PGraphics ogImg,cImg;

void setup() {
  size(1000, 562);
  ogImg = createGraphics(500, 281);
  cImg = createGraphics(500, 281);
  
  PImage OGImage = loadImage("Skyrim.jpg");
  OGImage.resize(500, 281);
  
  ogImg.beginDraw();
  ogImg.background(255,100,50);
  ogImg.image(OGImage, 0, 0);
  ogImg.endDraw();
    
  
  cImg.beginDraw();
  cImg.background(255,200,200);
  cImg.image(OGImage, 0, 0);
  cImg.endDraw();
  
  cImg.loadPixels();
    for(int i=0;i<cImg.width*cImg.height;i++){
        color locP = cImg.pixels[i];
        float redValue = red(locP);
        float greenValue = green(locP);
        float blueValue = blue(locP);
        float prom = (redValue+greenValue+blueValue)/3;
        color newP = color(prom, prom, prom);
        cImg.pixels[i] = newP;
    }
  cImg.updatePixels();
}



void draw() {

  image(ogImg, 0, 0);
  image(cImg, 501, 0);
  
}
