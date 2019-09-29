//Para el desarrollo del taller se utilizó código de las siguientes fuentes:
//https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image  

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
