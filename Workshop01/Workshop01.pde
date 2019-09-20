PImage OGImage;
PGraphics ogImg;
PGraphics gsAVG, gsLuma;
PGraphics rHist,gHist,bHist;

void setup() {
  size(1500, 843);
  ogImg = createGraphics(500, 281);
  OGImage = loadImage("Scifi.jpg");
  OGImage.resize(500, 281);
  ogImg.beginDraw();
  ogImg.background(255,100,50);
  ogImg.image(OGImage, 0, 0);
  ogImg.endDraw();
  

  gsAVG = createGraphics(500, 281);
  gsLuma = createGraphics(500, 281);
  
  rHist = createGraphics(500, 281);
  gHist = createGraphics(500, 281);
  bHist = createGraphics(500, 281);
  
  
  gs_average();
  gs_luma();
  rgb_hist();
}

void draw() {

  image(ogImg, 500, 0);
  image(gsAVG, 0, 0);
  image(gsLuma, 1000, 0);
  
  image(rHist, 0, 281);
  image(gHist, 500, 281);
  image(bHist, 1000, 281);
  
}

void gs_average(){

  gsAVG.beginDraw();
  gsAVG.background(255,200,200);
  gsAVG.image(OGImage, 0, 0);
  gsAVG.endDraw();
  
  gsAVG.loadPixels();
    for(int i=0;i<gsAVG.width*gsAVG.height;i++){
        color locP = gsAVG.pixels[i];
        float redValue = red(locP);
        float greenValue = green(locP);
        float blueValue = blue(locP);
        float prom = (redValue+greenValue+blueValue)/3;
        color newP = color(prom, prom, prom);
        gsAVG.pixels[i] = newP;
    }
  gsAVG.updatePixels();
}

void gs_luma(){

  gsLuma.beginDraw();
  gsLuma.background(255,200,200);
  gsLuma.image(OGImage, 0, 0);
  gsLuma.endDraw();
  
  gsLuma.loadPixels();
    for(int i=0;i<gsLuma.width*gsLuma.height;i++){
        color locP = gsLuma.pixels[i];
        float redValue = 0.299*red(locP);
        float greenValue = 0.587*green(locP);
        float blueValue = 0.114*blue(locP);
        float prom = redValue+greenValue+blueValue;
        color newP = color(prom, prom, prom);
        gsLuma.pixels[i] = newP;
    }
  gsLuma.updatePixels();
}

void rgb_hist(){
  
  int[] histR = new int[256];
  int[] histG = new int[256];
  int[] histB = new int[256];
  ogImg.loadPixels();
    for(int i=0;i<ogImg.width*ogImg.height;i++){
      color locP = ogImg.pixels[i];
      histR[int(red(locP))]++; 
      histG[int(green(locP))]++; 
      histB[int(blue(locP))]++; 
    }
  ogImg.updatePixels();
  
  rHist.beginDraw();
  rHist.background(150,130,130);
  rHist.stroke(255,0,0);
  int histMax = max(histR);
  print(histMax," ");
  for (int i = 0; i < rHist.width; i += 2) {
    int which = int(map(i, 0, rHist.width, 0, 255));
    int y = int(map(histR[which], 0, histMax, rHist.height, 0));
    rHist.line(i, rHist.height, i, y);
  }
  rHist.endDraw();

  gHist.beginDraw();
  gHist.background(130,150,130);
  gHist.stroke(0,255,0);
  histMax = max(histG);
  print(histMax," ");
  for (int i = 0; i < gHist.width; i += 2) {
    int which = int(map(i, 0, gHist.width, 0, 255));
    int y = int(map(histG[which], 0, histMax, gHist.height, 0));
    gHist.line(i, gHist.height, i, y);
  }
  gHist.endDraw();
  
  bHist.beginDraw();
  bHist.background(130,130,150);
  bHist.stroke(0,0,255);
  histMax = max(histB);
  print(histMax," ");
  for (int i = 0; i < bHist.width; i += 2) {
    int which = int(map(i, 0, bHist.width, 0, 255));
    int y = int(map(histB[which], 0, histMax, bHist.height, 0));
    bHist.line(i, bHist.height, i, y);
  }
  bHist.endDraw();
}
