void initVideo() {

  
}
void displayVideo() {
  //tint(255,STROKE_ALFA);
  imageMode(CORNER);
  image(mov, 0, 0);
  imageMode(CENTER);
  println("displayVideo");
 
}
void playVideo() {
  if (mov.available() ) {
    mov.read();
    // A new time position is calculated using the current mouse location:
    float f = map(mouseX, 0, width, 0, 1);
    float t = mov.duration() * f;
    mov.play();
    if (BT_52)
    mov.jump(t);
    mov.speed(0.7);
    //mov.pause();
  }
}

