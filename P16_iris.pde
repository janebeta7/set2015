class Preset16 extends Preset {
  int stageWidth_int = 1024;//ancho de la pantalla
  int stageHeight_int = 768;//alto de la pantallsa
  int warmNum_int = 256;//numero de warms
  boolean isInit=false;//esta INiciado ? no
  PImage bg;
  float setting_v;//v , vector?
  float setting_raRange;//ra, radio?
  float setting_maxStroke;//maximo de borde
  int setting_colMode;//Modo de color


  Warm[] warms_ar = new Warm[warmNum_int];//nuevo array de 20 warms
  Preset16(String _name) {
    super(_name);
    reset();
  }
  public void changeTipo(int tipo) {
    
  }
  public void f_mousePressed() {
    if (super.on) {
      setting(mouseX,mouseY);
      println("mousePressed");
    }
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    setting_v = random(0.1,2);//aleatorio de 0.1 a 2
    setting_v = 0.1;//aleatorio de 0.1 a 2
    setting_raRange = random(0.1,2);//aleatorio de 0.1 a 2(radianes)
    setting_maxStroke = random(2,5);//aleatorio de 2 a 6
    setting_colMode = int(floor(random(0,4)));//modo de color 0 a 4

      for(int i=0; i<warmNum_int; i++) {
      warms_ar[i] = new Warm(random(0,stageWidth_int),random(0,stageHeight_int),setting_maxStroke);
      warms_ar[i].initCol();
    }

    setting(0,0);
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
    if(isInit==true) {
      int num=int(KNOB_5);  
      for(int i=0; i<num; i++) {
        warms_ar[i].step();
        warms_ar[i].step();
      }
    }
  }
  void setting(float _x,float _y) {


    isInit = true;
    float x = _x;
    float y = _y;

    float v = random(1,5);
    v = 0.5;
    float rar = random(0.1,2);
    int num=int(map(KNOB_5,0,255,0,warmNum_int));
    for(int i=0; i<num; i++) {
      warms_ar[i].setPos(x,y);
      warms_ar[i].setV(v);
      warms_ar[i].setRARange(rar);
    }
  }
}

class Warm {
  int colorr=255;
  float x, y, v;  //xpos, ypos, speed
  float ox, oy;  //old xpos, ypos
  float r, rv, ra;  //rotation rotSpeed rotAccel
  float raRange;
  float osi;
  float osiV;
  int colR, colG, colB;  // contains rgb
  float setting_maxStroke;
  public Warm(float x, float y,float setting_maxStroke) {
    this.setting_maxStroke = setting_maxStroke;
    this.x = x;
    this.y = y;
    ox = this.x;
    oy = this.y;
    v = 0;
    r = random(0,360);
    rv = 0;
    ra = 0;
    raRange = 0.5;

    osi = 0;
    osiV = 0.002;
  }

  void step() {

    float osiV_constante = map(SPEED_SHIFT,0,10,0,0.009);
    osi += osiV_constante;//velocidad
    //osi += osiV;//velocidad
    if(osi > 2 * PI) {
      osi -= (PI * 2);
    }
    ox = x;
    oy = y;
    x += cos(r * PI / 180)*v;
    y += sin(r * PI / 180)*v;

    if(x<0) {
      x = width;
      ox += width;
    }
    if(x>width) {
      x = 0;
      ox -= width;
    }
    if(y<0) {
      y = height;
      oy += height;
    }
    if(y>height) {
      y = 0;
      oy -= height;
    }


    float constante_raRange = map(RADIO,0,900,0.1,2);
    float constante_ra = map(KNOB_5,0,900,0.01,0.9);
    ra = ra*constante_ra  + random(-constante_raRange,constante_raRange );//0.9 0.01

    // ra = ra*0.5 + random(-raRange,raRange);//0.9 0.01
    rv = rv * 0.9 + ra;//0.9 0.04
    r += rv;

    // stroke(color(colR+cos(osi*4)*40, colG+cos(osi*4)*40, colB+cos(osi*4)*40,200));
    if (BT_52) colorr = o_colores.getColor(0);
    stroke(colorr,FADER_5);

    strokeWeight(cos(osi*5)*setting_maxStroke+setting_maxStroke);
    line(x,y, ox, oy);
    point(x,y);
    strokeWeight(1);
    // draw();
  }

  void setV(float v) {
    this.v = v;
  }

  void setRARange(float rar) {
    this.raRange = rar;
  }

  void setPos(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void initCol() {
  }

  void draw() {

    for(int xx=-1; xx<1; xx++) {
      for(int yy=-1; yy<1; yy++) {
        float d = dist(0,0,xx,yy);
        if(d!=0) {
          addPixel(int(x+xx), int(y+yy), color(colR/d, colG/d, colB/d));
        }
      }
    }
    //addPixel(int(x), int(y), color(colR, colG, colB));
  }

  //additive color method()
  void addPixel(int x, int y, color col) {
    if (x<0 || x>width-1) return;
    if (y<0 || y>height-1) return;
    color crntCol = get(x, y);

    int crntr = crntCol>>16 &0xff;
    int crntg = crntCol>>8 &0xff;
    int crntb = crntCol &0xff;
    int newr = col>>16 &0xff;
    int newg = col>>8 &0xff;
    int newb = col&0xff;
    int setr = int(constrain((crntr + newr)*0.8, 0, 255));
    int setg = int(constrain((crntb + newb)*0.8, 0, 255));
    int setb = int(constrain((crntg + newg)*0.8, 0, 255));


    set(x,y, color(setr,setg,setb));
    //pixels[5] = color(255,255,255);
  }
}
