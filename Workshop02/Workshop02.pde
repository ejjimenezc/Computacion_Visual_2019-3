int illusion = 1;

void setup(){
  size(600,600);
  background(255,200,150);
}

void draw(){

    switch(illusion){
      case 1:
      break;
      case 2:
      break;
      case 3:
      break;
      case 4:
      break;
      case 5:
      break;
      case 6:
      break;
      case 7:
      break;
      case 8:
      break;
      case 9:
      break;
      case 0:
      break;
      default:
        illusion = 1;
      break;
    }
  
}

void keyPressed() {
  if (keyCode == '0') {
    illusion=0;
  } else if (keyCode == '1') {
    illusion=1;
  } else if (keyCode == '2') {
    illusion=2;
  } else if (keyCode == '3') {
    illusion=3;
  } else if (keyCode == '4') {
    illusion=4;
  } else if (keyCode == '5') {
    illusion=5;
  } else if (keyCode == '6') {
    illusion=6;
  } else if (keyCode == '7') {
    illusion=7;
  } else if (keyCode == '8') {
    illusion=8;
  } else if (keyCode == '9') {
    illusion=9;
  } 
}
