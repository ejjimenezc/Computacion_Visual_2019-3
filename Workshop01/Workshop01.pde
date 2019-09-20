PImage OGImage;
PGraphics ogImg;
PGraphics gsAVG, gsLuma;
PGraphics rHist,gHist,bHist;
PGraphics rImg,gImg,bImg;
PGraphics kImg;

int h_w = 300;

int[][] edge_1 = {  { 1, 0,-1},
                    { 0, 0, 0},
                    {-1, 0, 1}  };

void setup() {
  size(1600, 900);
  ogImg = createGraphics(h_w, h_w);
  OGImage = loadImage("Scifi.jpg");
  OGImage.resize(h_w, h_w);
  ogImg.beginDraw();
  ogImg.background(255,100,50);
  ogImg.image(OGImage, 0, 0);
  ogImg.endDraw();
  

  gsAVG = createGraphics(h_w,h_w);
  gsLuma = createGraphics(h_w, h_w);
  
  rHist = createGraphics(h_w, h_w);
  gHist = createGraphics(h_w, h_w);
  bHist = createGraphics(h_w, h_w);
  
  rImg = createGraphics(h_w, h_w);
  gImg = createGraphics(h_w, h_w);
  bImg = createGraphics(h_w, h_w);
  
  
  kImg = createGraphics(h_w, h_w);
  
  
  gs_average();
  gs_luma();
  rgb_hist();
  kernel();
}

void draw() {

  image(ogImg, h_w, 0);
  image(gsAVG, 0, 0);
  image(gsLuma, h_w*2, 0);
  
  image(rHist, 0, h_w);
  image(gHist, h_w, h_w);
  image(bHist, h_w*2, h_w);
  
  image(rImg, 0, h_w*2);
  image(gImg, h_w, h_w*2);
  image(bImg, h_w*2, h_w*2);
  
  
  image(kImg, h_w*3, 0);
  
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
  
  rImg.beginDraw();
  rImg.background(255,200,200);
  rImg.image(OGImage, 0, 0);
  rImg.endDraw();
  
  gImg.beginDraw();
  gImg.background(255,200,200);
  gImg.image(OGImage, 0, 0);
  gImg.endDraw();
  
  bImg.beginDraw();
  bImg.background(255,200,200);
  bImg.image(OGImage, 0, 0);
  bImg.endDraw();
  
  rImg.loadPixels();
    for(int i=0;i<rImg.width*rImg.height;i++){
      color locP = rImg.pixels[i];
      histR[int(red(locP))]++; 
      histG[int(green(locP))]++; 
      histB[int(blue(locP))]++; 
      rImg.pixels[i] = color(red(locP), 0, 0);
    }
  rImg.updatePixels();
  

  gImg.loadPixels();
    for(int i=0;i<gImg.width*gImg.height;i++){
      color locP = gImg.pixels[i]; 
      gImg.pixels[i] = color( 0, green(locP),0);
    }
  gImg.updatePixels();
  
  bImg.loadPixels();
    for(int i=0;i<bImg.width*bImg.height;i++){
      color locP = bImg.pixels[i]; 
      bImg.pixels[i] = color( 0, 0, blue(locP));
    }
  bImg.updatePixels();
  
  rHist.beginDraw();
  rHist.background(150,130,130);
  rHist.stroke(255,0,0);
  int histMax = max(histR);
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
  for (int i = 0; i < bHist.width; i += 2) {
    int which = int(map(i, 0, bHist.width, 0, 255));
    int y = int(map(histB[which], 0, histMax, bHist.height, 0));
    bHist.line(i, bHist.height, i, y);
  }
  bHist.endDraw();
}


void kernel(){
  kImg.beginDraw();
  kImg.background(255,200,200);
  kImg.image(OGImage, 0, 0);
  kImg.endDraw();

  int k_size = kImg.width*kImg.height;
  int k_h =kImg.height;
  int k_w =kImg.width;

  kImg.loadPixels();
  
  for(int p=k_w+1;p<k_size-k_w-1;p++){
    
    float redValue = 0.0;
    float greenValue = 0.0;
    float blueValue = 0.0;
    
    int[][] mat = {  { p-h_w-1, p-h_w, p-h_w+1},
                     { p-1,     p,     p+1},
                     { p+h_w-1, p+h_w, p+h_w+1}};
    
    for(int x=0;x<3;x++){
      for(int y=0;y<3;y++){
        redValue += red(kImg.pixels[mat[x][y]])*edge_1[x][y];
        greenValue +=green(kImg.pixels[mat[x][y]])*edge_1[x][y];
        blueValue += blue(kImg.pixels[mat[x][y]])*edge_1[x][y];
      }
    }
                     
    kImg.pixels[p] = color( redValue, greenValue,blueValue);
  }
  kImg.updatePixels();
  
}
