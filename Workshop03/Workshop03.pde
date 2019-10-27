import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;
// Grid antialiasing
int antialiasing_div = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;
boolean antialiasingEffect = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 9;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  push();
  scene.applyTransformation(node);
  triangleRaster();
  pop();
}

float edge(PVector a, PVector b, float pX, float pY ){
  return (pX-a.x)*(b.y-a.y)-(pY-a.y)*(b.x-a.x);
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  int d = round(pow(2,n));

  PVector[] v = { new PVector(node.location(v1).x(),node.location(v1).y()),
                  new PVector(node.location(v2).x(),node.location(v2).y()),
                  new PVector(node.location(v3).x(),node.location(v3).y())};
  
  push();
  noStroke();
  for(int x=-d;x<=d;x++){
    for(int y=-d;y<=d;y++){
      PVector avgColor = new PVector(255, 255, 255);
      float alpha = 255;
      float W1 = edge(v[0],v[1],x,y)/edge(v[0],v[1],v[2].x,v[2].y);
      float W2 = edge(v[1],v[2],x,y)/edge(v[1],v[2],v[0].x,v[0].y);
      float W3 = edge(v[2],v[0],x,y)/edge(v[2],v[0],v[1].x,v[1].y);
      float r = W1*255;
      float g = W2*255;
      float b = W3*255;
      float avgP = r+g+b/3;
      if (W1 >= 0 && W2 >= 0 && W3 >= 0) {
        avgColor.set(avgColor.x - W1*avgP, avgColor.y - W2*avgP, avgColor.z - W3*avgP);
      }
      else{
        alpha -= avgP;
      }
      if(avgColor == new PVector(255, 255, 255)) {
        noFill();
      } else {
        fill(round(avgColor.x), round(avgColor.y), round(avgColor.z), alpha);
      }
      
      /*float l0 = edge(v[0],v[1],x,y)/edge(v[0],v[1],v[2].x,v[2].y);
      float l1 = edge(v[1],v[2],x,y)/edge(v[1],v[2],v[0].x,v[0].y);
      float l2 = edge(v[2],v[0],x,y)/edge(v[2],v[0],v[1].x,v[1].y);
      
      float r = l1*255;
      float g = l2*255;
      float b = l0*255;
      
      fill(r, g, b);*/
      if(W1>=0 && W2>=0 && W3>=0){
        square(x, y, 1);
      }
    };
  };
  pop();
  
 
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  push();

  if(shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }
  beginShape(TRIANGLES);
  if(shadeHint)
    fill(255, 0, 0);
  else
    stroke(255, 0, 0);
  vertex(v1.x(), v1.y());
  if(shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());
  if(shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());

  pop();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
}
