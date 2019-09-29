
void keyPressed() {
  if (keyCode == '0') {
    value=0;
  } else if (keyCode == '1') {
    selectedImage=0;
    value=1;
  } else if (keyCode == '2') {
    selectedImage=1;
    value=2;
  } else if (keyCode == '3') {
    selectedImage=2;
    value=3;
  } else if (keyCode == '4') {
    selectedImage=3;
    value=4;
  } else if (keyCode == '5') {
    value=5;
  } else if (keyCode == '6') {
    value=6;
  } else if (keyCode == '7') {
    value=7;
  } else if (keyCode == '8') {
    value=8;
  } 
  ogImg.beginDraw();
  ogImg.image(imageList[selectedImage], 0, 0); 
  ogImg.endDraw();
}

void mouseClicked() {
  //Check if the click was in the menu zone
  if (mouseX > h_w && mouseX < h_w+buttons) {
    if(mouseY<h_w){
      option = mouseY/50+1;
      update = true;
    }
  }
}

void mousePressed() {
  //Check if the clicks was in the histogram zone
  if(mouseX > h_w+buttons && mouseX < h_w*2+buttons && mouseY > 0 && mouseY < h_w/2 && option==3){
    if (mouseButton == LEFT && mouseX-h_w-buttons<end) {
      start = mouseX-h_w-buttons;
    } else if (mouseButton == RIGHT && mouseX-h_w-buttons>start) {
      end = mouseX-h_w-buttons;
    }
  }
}
