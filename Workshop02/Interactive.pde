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
  
  if (keyCode == ENTER) {
    if(illusion == 1 && !start_01){
      start_time = millis();
      start_01 = true;
    }
  }
}
