//Para el desarrollo del taller se utilizó código de las siguientes fuentes:
//https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image      

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
