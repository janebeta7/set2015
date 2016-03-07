class Preset13 extends Preset {
  Monster monster; 
  Preset13(String _name) {
    super(_name);
    reset();
  }
  public void f_mousePressed() {
    if (super.on) {
      reset();
    }
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    monster = new Monster(180, int(RADIO));
  }
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
  public void start() {
  }
  private void render() {
    pushMatrix();
    translate(width/2, height/2);
    monster.draw();
    popMatrix();
  }
}

class Monster 
{ 
  int maxMonsterSize; 
  int numEyes; 
  float angle; 

  Eye[] eyes; 

  Monster(int nEyes, int mSize) 
  { 
    numEyes = nEyes; 
    maxMonsterSize = mSize; 

    angle = 360 / numEyes; 

    eyes = new Eye[nEyes]; 

    if (TIPO ==1) {
      for (int i = 0; i < numEyes; i++) { 
        float eyeDistance = maxMonsterSize/2-10; 

        //float eyeDistance = random(100, 250); 
        float x = cos(radians(i*angle)) * eyeDistance; 
        float y = sin(radians(i*angle)) * eyeDistance; 
        eyes[i] = new Eye(x, y, eyeDistance, random(0, 50), random(0, 550));
      }
    }
    if (TIPO ==2) {
      for (int i = 0; i < numEyes; i++) { 
        float eyeDistance = maxMonsterSize/2-10; 
        //float eyeDistance = random(100, 250); 
        float x = (float)(width*2)/(LONG-1)*i*FADER_3; 
        float y = sin(radians(i*angle)) * eyeDistance; 
        eyes[i] = new Eye(x, y, eyeDistance, random(0, 50), random(0, 550));
      }
    }
  } 

  void draw() 
  { 
    //float alfa = 255;

    float alfa =pow(STROKE_ALFA, 2)*o_sound.getLevel();


    strokeWeight(1); 
    noFill(); 
    float separacion = 0; 
    int fuerzaX = int(SPEEDX) ; 
    int fuerzaY = int(SPEEDY); 
    angle= RADIO;
    separacion = map(KNOB_1, 0, 100, 0, 1000);
    ;
    for (int i = 0; i < numEyes; i++) { 
      int fft = i % 47;
     
      eyes[i].setFuerzas( o_sound.get_fft(fft)*VOLUMEN, o_sound.get_fft(fft)*VOLUMEN);
   
      float x1 = cos(radians(i*angle)) * separacion;
      float y1 = sin(radians(i*angle)) * separacion;

      float cx1 = cos(radians(i*angle)) * (separacion + (eyes[i].eyeDistance/2-eyes[i].addContadorX()));
      float cy1 = sin(radians(i*angle)) * (separacion + (eyes[i].eyeDistance/2-eyes[i].addContadorY()));

      float cx2 = cos(radians(i*angle)) * (eyes[i].eyeDistance - (eyes[i].eyeDistance/2-eyes[i].addContadorX()));
      float cy2 = sin(radians(i*angle))* (eyes[i].eyeDistance - (eyes[i].eyeDistance/2-eyes[i].addContadorY()));

      float x2 = cos(radians(i*angle)) * (eyes[i].eyeDistance );
      float y2 = sin(radians(i*angle)) * (eyes[i].eyeDistance );

      if (cy1 == 0.0) {
        // cy1 = y1 + (eyes[i].eyeDistance/2-300); // stiff tentacle problem
        // float cy1 = sin(radians(i*angle)) * (frecuencia + (eyes[i].eyeDistance/2));
      }

      if (cy2 == 0.0) {
        //cy2 = y2 + (eyes[i].eyeDistance - (eyes[i].eyeDistance/2-100)); // stiff tentacle problem
      }
      if (BT_51)  stroke(o_colores.getColor(),ALFA);
      else  stroke(o_colores.getColor(0), alfa);
      bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);
    } 
    noStroke(); 

    // tentacles end 
    fill(0); 
    for (int i = 0; i < numEyes; i++) { 
      float x = cos(radians(i*angle)) * (eyes[i].eyeDistance ); 
      float y = sin(radians(i*angle)) * (eyes[i].eyeDistance ); 
      fill(o_colores.getColor(0)); 
      ellipse(x, y, 5, 5);
    } 

    // monster eyes 
    for (int i = 0; i < numEyes; i++) { 
      // eyes[i].update(); 
      // eyes[i].draw();
    } 

    // monster mouth 
    /* fill(255); 
     
     beginShape(); 
     for (int i = 0; i < 30; i++) { 
     float teethAngle = 360/30; 
     if (i % 2 == 0) { 
     float x = cos(radians(i*teethAngle)) * 40; 
     float y = sin(radians(i*teethAngle)) * 40; 
     vertex(x, y); 
     } else { 
     float teethSize = random(20, 22); 
     float x = cos(radians(i*teethAngle)) * teethSize; 
     float y = sin(radians(i*teethAngle)) * teethSize; 
     vertex(x, y); 
     } 
     } 
     endShape(CLOSE); 
     */
  }
} 
class Eye
{
  float eyeSize;
  float pupilSize;
  float eyeDistance;
  float eyeX;
  float eyeY;
  float pupilX;
  float pupilY;
  float contadorX  = 0;
  float contadorY  = 0;
  float fuerzaX = 0  ;
  float fuerzaY =  0;
  Eye(float x, float y, float e, float _fuerzaX, float _fuerzaY)
  {
    eyeSize = 1;
    pupilSize = 1;
    eyeX = x;
    eyeY = y;
    eyeDistance = e;

    pupilX = eyeX;
    pupilY = eyeY;
    fuerzaX = _fuerzaX ;
    fuerzaY = _fuerzaY ;
  }
  float  addContadorX() {

    contadorX= contadorX + TWO_PI/100; 
    float oscilacionX = sin(contadorX) * fuerzaX ;

    return oscilacionX;
  }
  float  addContadorY() {

    contadorY= contadorY + TWO_PI/100; 
    float oscilacionY = sin(contadorY) * fuerzaY ;

    return oscilacionY;
  }
  void  setFuerzas(float x, float y ) {
    fuerzaX = x;
    fuerzaY = y ;
  }
  void update()
  {
    float mY = map(mouseY, 0, height, -eyeSize/4, eyeSize/4);
    pupilY = eyeY + mY;

    float mX = map(mouseX, 0, height, -eyeSize/4, eyeSize/4);
    pupilX = eyeX + mX;
  }

  void draw()
  {
    // stroke around eyeball
    fill(255);
    ellipse(eyeX, eyeY, eyeSize + 1, eyeSize + 1);

    // eyeball
    fill(0);
    ellipse(eyeX, eyeY, eyeSize, eyeSize);


    for (int i=0; i<10; i ++) {
      // pupil
      fill(map(i, 0, 10, 100, 255), 0, 0);
      ellipse(pupilX, pupilY, pupilSize-(i*2), pupilSize-(i*2));
    }
  }
}
