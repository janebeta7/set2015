

class Preset20 extends Preset {
  int xpos=5;
  int numIm = 6;
  PImage[] imagenes =new PImage[numIm] ;
  float a = 0.0;
  float inc= PI/0.5;
  float[] spectrum;              //Arrray to store FFT data
  float r,r1;                    //var for radious
  float v;                       //var for input peak (volume) level from the microphone
  float w;  
  float posx,posy ;
  int tipo_p; 
  int colorr;
  Preset20(String _name) {

    super(_name);

    reset();
  }
  public void changeTipo(int tipo) {
    
  }
  public void start() {
  }
  public void reset() {
    posx = width /2;
    posy = height/2;
    colorr = o_colores.getColor(0);
    imagenes[0] = loadImage("control_7/pyr2.png");
    imagenes[1] = loadImage("control_7/pyr1.png");
    imagenes[2] = loadImage("control_7/pyr3.png");
    imagenes[3] = loadImage("control_7/pyr4.png");
    imagenes[4] = loadImage("control_7/pyr1.png");
    imagenes[5] = loadImage("control_7/pyr1.png");
  }
  public void draw() {

    if (super.on) {
      render();
    }
  }
  public void listener() {
    super.listener();
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };

  private void render() {
    if (BT_31) {
      posx= mouseX;
      posy=mouseY;
    }
    if (BT_32) {//fijamos el tipo y el color
     
      if (oneColor)  //un color solo 
        colorr = o_colores.getColor(0);
      else
        colorr = o_colores.getColor();
    } 
   if (BT_33)  tipo_p=TIPO-1;
    // println("tipo_p"+tipo_p);
    PImage im = imagenes[tipo_p];
    float valx ;
    float valy ;
    v=o_sound.getLevel();                       
    for( int i = 0; i<LONG-1; i++) {          // Use the LiveInput.spectrum[] to display the FFT data 
      tint(colorr,FADER_3);
      noStroke();
      imageMode(CENTER);
      im = imagenes[tipo_p];
      r =  (KNOB_3)*o_sound.get_fft(i)*(VOLUMEN);
      r1 = (KNOB_3/500.0)* o_sound.get_fft(i+1)*(VOLUMEN);
      w=(10.0/100.0)*r;
      valx = acos(a)*xpos;
      valy = sin(a)*xpos;
      image(im,posx+valx,posy+valy,w,w);
      inc = PI/r1;
      a+= SPEED;
      xpos += r/KNOB_3;
    }
    a=0.0;
    xpos=1;
  }
}
