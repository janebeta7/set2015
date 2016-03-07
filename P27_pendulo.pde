class Preset27 extends Preset {


  Motion mf, m;
  float angle = 0.0; // Current angle
  float speed = 0.09; // Speed of motion
  float radius = 360.0; // Range of motion
  float sx = 5.0;
  float sy = 2.0;
  float hh = 0;
  color col;
  Preset27(String _name) {
    super(_name);
    reset();
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void changeTipo(int tipo) {
    
  }
  public void reset() {
    mf = new Motion(width/2, height/2);
    mf.setConstant(10);
    m = new Motion(width/2, height/2);
    m.setConstant(1000);
  }
  public void draw() {
    if (super.on) {

      render();
    }
  }
    public void start(){
  }
  public void listener() {
    super.listener();
  }
  private void render() {
     if (BT_94) reset();
    m.setConstant(map(FADER_3,0,255,9000,0));
    mf.setConstant(10);
   if (BT_31)  mf.followTo(mouseX, mouseY);
   else mf.followTo(width/2,height/2);
    mf.move();

    m.springTo(mf.getX(), mf.getY());
    m.move();


    angle += map(SPEED, 0, 10, 0, 0.05); // Update the 

    float x =  m.getX();
    float y = m.getY();

    fill(o_colores.getColor(0), FADER_3);
    noStroke();
    ellipse(m.getX(), m.getY(), m.getDistance()*3, m.getDistance()*3);


    float x2 = x + cos(angle ) * map(KNOB_2,0,100,0,500) ;
    float y2 = y + sin(angle) * map(KNOB_2,0,100,0,500);
   
      /*stroke(o_colores.getColor(0), KNOB_7);
      if (oneColor ) fill(o_colores.getColor(0), FADER_3); 
      else fill(0,FADER_3);
      ellipse(x2, y2, RADIO, RADIO); // Draw larger circle*/
    
    //line 
    if (hh<100) {
      hh+=1;
    } 
    else {
      hh--;
    }

    col = color(255, 255, 100+hh, 5);
    stroke(o_colores.getColor(0), KNOB_3);
    line(x, y, x2, y2);
  }
}

/*float KNOB_3 = 100;
 float FADER_3 =3; 
 Boolean BT_23 = true;
 Boolean BT_3 = true;
 */
