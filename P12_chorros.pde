class Preset12 extends Preset {
  Campo campo;
  color  colorTallo ;
  Preset12(String _name) {
    super(_name);
    campo=new Campo();
  }
  public void f_mousePressed() {
    if (super.on) {
      campo.initFlores(false);
    }
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    campo=new Campo();
  }
  public void changeTipo(int tipo) {
    
  }
  public void draw() {

    if (super.on) {
      render();
    }
  }
  public void start() {
  }
  public void listener() {
    super.listener();
    reset();
  }

  private void render() {

    campo.draw();
  }
}



class Flor {
  float x, y;     // x and y location
  //
  int angle = 0;
  int tam, id ;
  color colores;
  Tallo tallo;
  public boolean dibujaOtra = false;
  color  colorTallo;
  Flor(int _id, int _tam, color _colores, color _colorTallo, boolean _auto) {
    this.id = _id;
    this.colores = _colores;
    this.colorTallo = _colorTallo;
    this.tam = _tam;  
    println("Flor init , id:"+id+", tamanio:"+tam);
    tallo= new Tallo(colorTallo,_auto);
  }

  void go(int _tam, color _colores) {
    this.tam = _tam;  
    this.colores = _colores;
    if (tallo.ends) {
      dibujaOtra = true;
    }
    else
    {
      dibujaOtra = false;
      tallo.draw();
    }
    if (dibujaOtra) {
      tallo= new Tallo(colorTallo,true);
    }
  }

  // Display ball as an ellipse
}

public class Campo {
  Flor[] flores = new Flor[500];
  public int contFlores =0 ;
  public int tamanio = 10;
  color colorTallo;
  PApplet parent;
  Campo(PApplet p) {
    parent = p;
    initFlores(false);
  } 
  Campo() {
    //parent = p;
    initFlores(true);
  } 
  void draw() {
    for (int i=0;i<contFlores;i++) {
      tamanio = int(RADIO);
      flores[i].go(tamanio, o_colores.getColor());
    }
  }

  void initFlores(boolean _auto) {
    println("contFlores:"+contFlores);

    flores[contFlores] = new Flor(contFlores, (int) random(tamanio), o_colores.getColor(), o_colores.getColor(),_auto);
    contFlores = (contFlores + 1) % flores.length;  // note the use of modulo
  }
}

class Tallo {

  Motion m;
  float Angle = PI, Strokeweight = 5, longitud;
  public boolean ends = false;
  color colorTallo ;
  PApplet parent;
  int direccion = 1;

  Tallo(color _colorTallo,boolean auto) {
    colorTallo = _colorTallo;
    iniciaTallo(auto);
    //println("Tallo >> init");
  }
  void draw() {
    drawTallo();
  }
  void iniciaTallo(boolean auto) {
    float posx ;
    if (auto)  posx = random(width);
    else
      posx = mouseX;

    float posy =height;
    if (!BT_33) {
      posy =0;
      direccion = -1;
    }
    m = new Motion(posx,posy);
    Angle = PI;
    Strokeweight = 1;
    longitud = random(100, height-400);
  }

  void drawTallo() {

    if (direccion == 1) {
      if ((int) m.getY() > longitud)   renderT(); 
      else ends = true;
    }
    else //direccion = -1;
    {
      if ((int) m.getY() < longitud)  renderT();  
      else ends = true;
    }
  }
  void renderT() {
    ///println("direccion:"+direccion);
    Angle += radians(random(-0.1, 0.1));
    Strokeweight += random(-0.1, 0.1);
    m.moveDir(Angle, 2*direccion);
    m.setVelocity(map(SPEED,0,10,0,3));
    m.move();
    //println("m.getY():"+m.getY());

    stroke(colorTallo,FADER_3);
    strokeWeight(KNOB_3);
    strokeJoin(ROUND);
    line(m.getPX(), m.getPY(), m.getX(), m.getY());
    strokeWeight(1);
  }
  public  float getX() {
    return m.getX();
  }
  public  boolean isEnd() {
    return ends;
  }
  public  float getY() {
    return m.getY();
  }
}
