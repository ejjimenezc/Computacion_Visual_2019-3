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
