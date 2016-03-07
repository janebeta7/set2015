class Preset29 extends Preset {
  int   nbrPoints = 400;
  int   cx, cy;
  float crad;
  float cycleLength;
  float startTime;
  int   counter =0 ;
  float   speed_whitney = 1;

  boolean classicStyle = false;

  //
  float posx, posy ;
  int colorr;
  Preset29(String _name) {
    super(_name);
    reset();
  }
  public void changeTipo(int tipo) {
    
  }
  public void f_mousePressed() {
    if (super.on) {
      classicStyle = !classicStyle;
      if (classicStyle)
        cycleLength = 15*60;
      else
        cycleLength = 2000*15*60;
      speed_whitney = (2*PI*nbrPoints) / cycleLength;
    }
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    cx = width/2;
    cy = height/2;
    colorr = 255;
    crad = (min(width, height)/2) * 0.95;
    if (classicStyle)
      cycleLength = 15*60;
    else
      cycleLength = 2000*15*60;
    speed_whitney = (2*PI*nbrPoints) / cycleLength;
   //println("speed_whitney;"+speed_whitney);
   // speed_whitney =  map(FADER_6, 0, 127, 0, 1);
    startTime = -random(cycleLength);
    colorr = o_colores.getColor(0);
  }
  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void listener() {
    super.listener();
  }
  private void render() {
    //
    if (BT_61) {
      cx= mouseX;
      cy=mouseY;
    }
    if (BT_62) {//fijamos el tipo y el color
       //tipo_p=TIPO;
    } 
    if (BT_63) {
      if (oneColor)  //un color solo 
        colorr = o_colores.getColor(0);
      else
        colorr = o_colores.getColor();
    }
    //
    /* fill(colorr, KNOB_7);
     // fill(hue,.5,1-r/2);
     rect(0, 0, width, height);*/
    startTime = -(cycleLength*RADIO) / (float) height;
    float timer = (millis()*.001 - startTime)*speed_whitney;

    //background(0);
    counter = int(timer / cycleLength);
    nbrPoints = int(map(KNOB_6, 0, 255, 0, 2000));
    for (int i = 0; i < nbrPoints; ++i)
    {

      float r = i/(float)nbrPoints;
      if ((counter & 1) == 0)
        r = 1-r;

      float a = timer * r; // pow(i * .001,2);
      // float a = timer*2*PI/(cycleLength/i); //same thing
      float len = i*crad/(float)nbrPoints;
      float rad = max(1, len*.03);
      if (!classicStyle)
        len *= sin(a*timer);  // big fun!
      int x = (int) (cx + cos(a)*len);
      int y = (int) (cy + sin(a)*len);
      float hue = r + timer * .01;
      hue -= int(hue);
      //fill(hue,.5,1-r/2);
      //fill(o_colores.getColor(), STROKE_ALFA);
      fill(colorr, STROKE_ALFA);
 smooth();
      ellipse(x, y, 2, 2);
    }
  }
}
