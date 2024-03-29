int illusion_number = 1;
PGraphics illusion, help;
PImage grayNeg;
boolean start_01 = false;
int start_time;

String helpText;

void setup() {
  size(500,600,P3D);
  
  illusion = createGraphics(500, 500);
  help = createGraphics(500, 100);
  grayNeg = loadImage("gray.jpg");
  grayNeg.resize(500,500);
}


void draw(){
  clear();
  
  switch(illusion_number){
    case 1:
      color_illusion();
    break;
    case 2:
      necker();
    break;
    case 3:
      t_illusion();
    break;
    default:
      illusion_number = 1;
    break;
  }
  
  help.beginDraw();
  help.clear();
  help.background(100,150,100);
  help.textSize(14);
  fill(0);
  help.text(helpText, 10, 20,480,300);
  help.endDraw();
  image(illusion, 0, 0);
  image(help, 0, 500);
}
