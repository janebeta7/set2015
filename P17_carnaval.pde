class Preset17 extends Preset {
  int serpentinasNum_int =256;
  boolean isInit=false;

  float setting_v;
  float setting_raRange;
  float setting_maxStroke;
  int setting_colMode;
  Serpentinas[] serpentinass_ar = new Serpentinas[serpentinasNum_int];
  Preset17(String _name) {
    super(_name);
    reset();
  }
  public void f_mousePressed() {
    if (super.on)  setting();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void changeTipo(int tipo) {
    
  }
  public void reset() {
    setting_v = random(0.1, 2);
    setting_raRange = random(0.1, 2);
    setting_maxStroke = random(2, 4);
    //setting_colMode = int(floor(random(0,4)));
    setting_colMode = int(30);

    for (int i=0; i<serpentinasNum_int; i++) {
      serpentinass_ar[i] = new Serpentinas(random(0, width), random(0, height));
      serpentinass_ar[i].initCol();
    }
  }
  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void listener() {
    super.listener();
  }
  void setting() {


    isInit = true;
    float x = mouseX;
    float y = mouseY;

    float v = 5;

    //float rar = random(1,2);
    float rar = 1;
    println("v:"+v);
    println("rar"+rar);
    for (int i=0; i<serpentinasNum_int; i++) {
      serpentinass_ar[i].setPos(x, y);
      serpentinass_ar[i].setV(v);
      serpentinass_ar[i].setRARange(rar);
      serpentinass_ar[i].initCol();
    }
  }
  private void render() {
    if (isInit==true) {
      for (int i=0; i<INC; i++) {
        serpentinass_ar[i].step();
      }
    }
  }
}

class Serpentinas {
  float x, y, v;  //xpos, ypos, speed
  float ox, oy;  //old xpos, ypos
  float r, rv, ra;  //rotation rotSpeed rotAccel
  float raRange;
  float osi;
  float osiV;
  int colR, colG, colB;  // contains rgb
int colorr=255;
  public Serpentinas(float x, float y) {
    this.x = x;
    this.y = y;
    ox = this.x;
    oy = this.y;
    v = 0;
    r = random(0, 360);
    rv = 0;
    ra = 0;
    raRange = 0.5;

    osi = 0;
    osiV = 0.01;


    colR = int(red(o_colores.getColor(0)));
    colG = int(green(o_colores.getColor(0)));
    colB =int(blue(o_colores.getColor(0)));
  }

  void step() {
    colR = int(red(o_colores.getColor(0)));
    colG = int(green(o_colores.getColor(0)));
    colB =int(blue(o_colores.getColor(0)));
    osi += osiV;
    if (osi > 2 * PI) {
      osi -= (PI * 2);
    }
    ox = x;
    oy = y;
    x += cos(r * PI / 180)*map(FADER_3,0,255,0,100);
    y += sin(r * PI / 180)*map(FADER_3,0,255,0,100);

    if (x<0) {
      x = width;
      ox += width;
    }
    if (x>width) {
      x = 0;
      ox -= width;
    }
    if (y<0) {
      y = height;
      oy += height;
    }
    if (y>height) {
      y = 0;
      oy -= height;
    }

    ra = ra*0.009 + random(-raRange, raRange);
    rv = rv * 0.99 + ra;
    r += rv;
 if (BT_32) colorr = o_colores.getColor(0);
    stroke(colorr, KNOB_3);
    
    float  v = cos(osi*4);
    strokeWeight(1);
    line(x, y, ox, oy);
    point(x, y);
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

  public void initCol() {

    colR = int(red(o_colores.getColor()));
    colG = int(green(o_colores.getColor()));
    colB =int(blue(o_colores.getColor()));
  }

  void draw() {

    for (int xx=-1; xx<1; xx++) {
      for (int yy=-1; yy<1; yy++) {
        float d = dist(0, 0, xx, yy);
        if (d!=0) {
          addPixel(int(x+xx), int(y+yy), color(colR/d, colG/d, colB/d));
        }
      }
    }
    //addPixel(int(x), int(y), color(colR, colG, colB));
  }

  //additive color method()
  void addPixel(int x, int y, color col) {

    //pixels[5] = color(255,255,255);
  }
}
