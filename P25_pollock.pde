class Preset25 extends Preset {
  int timer;
  int lastX;
  int lastY;
  int lastDripX;
  int lastDripY;
  PImage img;
  Preset25(String _name) {
    super(_name);
    reset();
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };

  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void changeTipo(int tipo) {
    
  }
  public void listener() {
    super.listener();
  }
  public void reset() {
    timer = 0;
    lastX = lastDripX = mouseX;
    lastY = lastDripY = mouseY;
    strokeJoin(ROUND);
  }
  private void render() {
    if (oneColor) 
     fill(o_colores.getColor(0),ALFA);
    else 
    fill(o_colores.getColor(),ALFA);
    float d = dist(lastDripX, lastDripY, mouseX, mouseY);
    if (d > 200)
    {
      int numDrips = (int)random(3);
      randomCircles(mouseX, mouseY, numDrips, 2, 10, 10, 30);
      lastDripX = mouseX;
      lastDripY = mouseY;
    }
    int dx = abs(mouseX - lastX);
    int dy = abs(mouseY - lastY);
    if ((dx == 0) && (dy == 0))
    {
      strokeWeight(RADIO);
      
    }
    else if (dist(mouseX,mouseY, lastX,lastY) < 2 )
    {
      strokeWeight(10);
    }
    else
    {
      
      strokeWeight(150/(dx+dy+15));
      timer = 0;
    }
      stroke(o_colores.getColor(0),KNOB_3);
    // else fill(o_colores.getColor((int)map(KNOB_3, 0, 100, 0, 4)), ALFA);
    line(mouseX,mouseY, lastX,lastY);
      strokeWeight(1);
    lastX = mouseX;
    lastY = mouseY;

    if (timer > 15)
    {
      //clouds(15, 30, 10, 20);
      timer = (int)random(-50,15);
    }
    timer++;
  }
  void randomCircles(int x, int y, int numCircles, int minSize, int maxSize, int minDist, int maxDist)
  {
    for(int i=0; i<numCircles; i++)
    {
      float r = minSize + random(maxSize-minSize);
      float offsetX = minDist + random(maxDist - minDist);
      float offsetY = minDist + random(maxDist - minDist);
      float flipX = random(1);
      if (flipX > 0.5) offsetX *= -1;
      float flipY = random(1);
      if (flipY > 0.5) offsetY *= -1;
      fill(o_colores.getColor(),255);
      ellipse(x+offsetX, y+offsetY, r, r);
    }
  }

  void clouds(int minmin, int minmax, int maxmin, int maxmax)
  {

    float minsize = random(minmin,minmax);
    float maxsize = minsize + random(maxmin,maxmax);

    for(int i=0; i<6; i++)
    {
      pushMatrix();
      translate(mouseX, mouseY);
      rotate(radians(random(360))); 
      beginShape();
      vertex(0, 0);
      bezierVertex(0, 0+random(minsize,maxsize), 0+random(minsize,maxsize), 0, 0, 0);
      bezierVertex(0, 0-random(minsize,maxsize), 0-random(minsize,maxsize), 0, 0, 0);
      bezierVertex(0+random(minsize,maxsize), 0, 0, 0-random(minsize,maxsize), 0, 0);
      bezierVertex(0-random(minsize,maxsize), 0, 0, 0+random(minsize,maxsize), 0, 0);
      endShape();
      popMatrix();
    }
  }
}
