class Preset6 extends Preset {
  point2D old; //stores the last mouse position
  point2D delta; //mouseAngle
  point2D centre; // the centre of the draw array
  point2D diff; //the difference between the last 2 mouse pos
  point2D target;

  point2D[] oldCoord = new point2D[20];

  float angle, mouseTarget;
  float distance, spread, curSpread;
  boolean firstLoop;

  String arrayCont;
  Preset6(String _name) {
    super(_name);
    reset();
  }
  public void changeTipo(int tipo) {
    
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
    
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    delta = new point2D(0, 0);
    old = new point2D(mouseX, mouseY);
    centre = new point2D(mouseX, mouseY);
    diff = new point2D(0, 0);
    target = new point2D(mouseX, mouseY);
    for (int i=0;i<20;i++) {

      oldCoord[i] = new point2D(mouseX, mouseY);
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
  private void render() {
    strokeWeight(2);
    target.update(mouseX, mouseY);
    diff.update(old.x - target.x, old.y - target.y);
    mouseTarget=atan2(diff.x, diff.y);
    angle+=(mouseTarget-angle)/40;
    centre.update(centre.x+(target.x-centre.x)/40, centre.y+(target.y-centre.y)/40);

    distance = abs(dist(target.x, target.y, old.x, old.y));
    spread = (spread+distance)*0.95;
    curSpread = (spread-curSpread)/40;
    curSpread = curSpread;
    arrayCont = "";
    if (mousePressed) {
      if (mouseButton==LEFT) {
        for (int i=0;i<20;i++) {
          float myX=centre.x+(sin(angle+i)*curSpread*i);
          float myY=centre.y+(cos(angle+i)*curSpread*i);

          point(myX, myY);
          float avgX = (myX+oldCoord[i].x)*0.5;
          float avgY = (myY+oldCoord[i].y)*0.5;
          //float avgY = (myY+oldCoord[i].y)*0.9;
          point(avgX, avgY);

          stroke(o_colores.getColor(0), STROKE_ALFA);
          line(avgX, avgY, oldCoord[i].x, oldCoord[i].y);

          oldCoord[i].update(avgX, avgY);
        }
        old.update(mouseX, mouseY);
      }
    }
    strokeWeight(1);
  }
}

class point2D {
  float x, y;

  point2D(float iX, float iY) {
    x=iX;
    y=iY;
  }


  void update(float iX, float iY) {
    x=iX;
    y=iY;
  }

  point2D copy() {
    return new point2D(x, y);
  }
}
