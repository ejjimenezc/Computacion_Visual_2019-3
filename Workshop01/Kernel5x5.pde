//Para el desarrollo del taller se utilizó código de las siguientes fuentes:
//https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image  

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
