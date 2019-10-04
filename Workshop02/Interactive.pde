void keyPressed() {
  if (keyCode-48 >= 0 && keyCode-48 <= 9) {
    illusion_number=keyCode-48;
  }
  
  if (keyCode == ENTER) {
    if( illusion_number == 1 && !start_01){
      start_time = millis();
      start_01 = true;
    }
  }
}
