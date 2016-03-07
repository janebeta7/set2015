

class Preset7 extends Preset {
  int xpos=5;
  PImage[] imagenes =new PImage[5] ;
  float a = 0.0;
  float inc= PI/0.5;
  float[] spectrum;              //Arrray to store FFT data
  float r, r1;                    //var for radious
  float v;                       //vtr for input peak (volume) level from the microphone
  float w;  
  float posx, posy ;
  int tipo_p; 
  int colorr;
  Preset7(String _name) {

    super(_name);

    reset();
  } 
  public void changeTipo(int tipo) {
    
  }
  public void reset() {
    posx = width /2;
    posy = height/2;
    colorr = o_colores.getColor(0);
    imagenes[0] = loadImage("control_7/c7_01.png");
    imagenes[1] = loadImage("control_7/c7_02.png");
    imagenes[2] = loadImage("control_7/c7_03.png");
    imagenes[3] = loadImage("control_7/c7_04.png");
    imagenes[4] = loadImage("control_7/c7_02_mira.png");
    
    o_colores.setPalette(1);
    o_colores.getColor(0);
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
    if (BT_71) {
      posx= mouseX;
      posy=mouseY;
    }
    if (BT_73) {//fijamos el tipo y el color
      tipo_p=TIPO;
    } 
    if (BT_72) {
      if (oneColor)  //un color solo 
        colorr = o_colores.getColor(0);
      else
        colorr = o_colores.getColor();
    }
    PImage im = imagenes[3];
    float valx ;
    float valy ;

    v=o_sound.getLevel();                       
    for ( int i = 0; i<LONG-1; i++) {          // Use the LiveInput.spectrum[] to display the FFT data 

      tint(colorr, FADER_3);
      noStroke();
      imageMode(CENTER);
      if (tipo_p == 2) {
        im = imagenes[2];
        r =  (KNOB_7/10)*o_sound.get_fft(i)*KNOB_3;
        r1 = (KNOB_7/1000.0)* o_sound.get_fft(i+1)*KNOB_3;
        w=(10.0/100.0)*r;


        valx = tan(a)*xpos;
        valy = cos(a)*xpos;
        image(im, posx+valx, posy+valy, w, w);
      }
      else if ( tipo_p == 3) {
        im = imagenes[3];
        r =  (KNOB_7)*o_sound.get_fft(i)*FADER_7;
        r1 = (KNOB_7/1000.0)* o_sound.get_fft(i+1)*FADER_7;
        w=(10.0/100.0)*r;
        valx = acos(a)*xpos;
        valy = sin(a)*xpos;
        image(im, posx+valx, posy+valy, w, w);
      }
      else if ( tipo_p == 4) {
        r =  (KNOB_7/10)*o_sound.get_fft(i)*FADER_7;
        r1 = (KNOB_7/1000.0)* o_sound.get_fft(i+1)*FADER_7;
        w=(10.0/400.0)*r;

        im = imagenes[1];
        valx = sin(a)*xpos;
        valy = cos(a)*xpos;
        image (im, posx+cos(a)*xpos, posy+atan(a)*xpos, w, w);
      }
      else  if ( tipo_p == 5) {
        im = imagenes[4];
        r =  (KNOB_7/10)*o_sound.get_fft(i)*FADER_7;
        r1 = (KNOB_7/1000.0)* o_sound.get_fft(i+1)*FADER_7;
        w=(10.0/400.0)*r;

        valx = cos(a)*xpos;
        valy = sin(a)*xpos;
        image(im, posx+valx, posy+valy, w, w);
      }    
      else
      {
        r =  (KNOB_7/10)*o_sound.get_fft(i)*FADER_7;
        r1 = (KNOB_7/1000.0)* o_sound.get_fft(i+1)*FADER_7;
        w=(10.0/100.0)*r;

        valx = sin(a)*xpos;
        valy = cos(a)*xpos;
        image(im, posx+valx, posy+valy, w, w);
      }

      inc = PI/r1;
      a+= SPEED;
      if (BT_13 ) a+= 0;
      xpos += r/KNOB_4;
    }
    a=0.0;
    xpos=1;
  }
}
