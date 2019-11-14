// Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
// http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/

PImage label;
PShape can;
float angle;

PShader texShader;
PGraphics pg1,pg2;
PGraphics [] pgs = new PGraphics [2];

int line_length = 300;
int y_initial = 400;

void setup() {
  size(640, 360, P3D);  
  label = loadImage("Kurzgesagt.png");
  texShader = loadShader("texfrag.glsl", "texvert.glsl");
}

void draw() {    
  background(0);
  

  pgs[0] = createIllusion();
  pgs[1] = createIllusion();
  pgs[1].beginDraw();
  pgs[1].image(pgs[0], 0, 0);// merge
  pgs[1].endDraw(); 
  can = createCan(100, 200, 32,pgs[1]);  
    
  shader(texShader);  
    
  translate(width/2, height/2);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
}

PShape createCan(float r, float h, int detail, PGraphics tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}

PGraphics createIllusion() {
  PGraphics illusion = createGraphics(500, 500);
  
  int h = 500-line_length;
  
  illusion.beginDraw();
  
  illusion.clear();
  illusion.background(random(255), random(255), random(255));
  illusion.strokeCap(ROUND);
  illusion.strokeWeight(10);
  illusion.stroke(100,0,0);
  
  illusion.line(h/2,y_initial,500-h/2,y_initial);
  illusion.line(250,y_initial,250,mouseY);
  
  if (mousePressed == true) {
    illusion.strokeWeight(2);
    illusion.stroke(0,200,0);
    illusion.line(250,y_initial,250,y_initial-line_length);
  }
  illusion.endDraw();
  
  return illusion;
}
