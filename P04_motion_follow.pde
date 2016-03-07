class Preset4 extends Preset {

  float angle = 0.0; // Current angle
  float speed = 0.01; // Speed of motion
  float radius = 180.0; // Range of motion
  float sx = 5.0;
  float sy = 2.0;
  float hh = 0;
  float tam = 50;
  float posx, posy;
  color colorr;
  Motion mf, m;

  float xpos, ypos;              // Starting position of centipede
  float xspeed = random(0, 20);  // Speed of the centipede
  float yspeed = random(0, 20);  // Speed of the centipede

  float xdirection = 1;  // Left or Right (-1,1)
  float ydirection = 1;  // Top to Bottom
  int sc = 105;
  float myAngle = 0;



  //particulas
  Particle spring;
  Attraction[] atracciones;
  ParticleSystem physics; //objeto de clase ParticleSystem
  Particle[] particles; //array de partículas
  traer.physics.Spring[] springs; //array de partículas
  float velocity = 35.0; //velocidad
  float particleSize = 100; //tamaño de partículas
  float attractStrength =5.0; //fuerza de atraccion
  int particleAmount = 10; //cantidad de partículas
  boolean attractRepel = false; //repelan las particlas?
  PImage particlePic;
  boolean firstMouseClick = false; //primera vez que el mouse hace click?
  float scala = 1; //escala  

  Preset4(String _name) {
    super(_name);
    reset();
  }
  public void changeTipo(int tipo) {
    
  }
  public void setVar(String nombreVariable,boolean valor) {
  }
  public void f_mousePressed() {
    resetWorld();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    particlePic = loadImage("beat/beat_1.png");

    mf = new Motion(width/2, height/2);
    mf.setConstant(50);
    m = new Motion(width/2, height/2);
    m.setConstant(1000);
    // particles

    resetWorld();
  }
  public void start() {
  }
  public void draw() {
    if (super.on) {
      posx = super.getX();
      posy =super.getY();
      render();
    }
  }
  public void listener() {
    super.listener();
  }
  private void render() {

    //particlesE-------------------------------------------------------
    angle += speed; // Update the 
    float sinval = sin(angle/sy);
    float cosval = cos(angle);
    float x2 = mf.getX() + cos(angle * sx) * ATRACCION ;
    float y2 = mf.getY() + sin(angle * sy) * ATRACCION;

    //strokeWeight(mf.getDistance());
    mf.followTo(mouseX, mouseY);
    mf.move();
    m.springTo(mf.getX(), mf.getY());
    m.move();



    //ellipse(mf.getX(),mf.getY(),o_sound.getMedia(0,50),o_sound.getMedia(0,50));
    
      stroke(255, STROKE_ALFA);
      //stroke(255,STROKE_ALFA*o_sound.getLevel());
      strokeWeight(3);
      //stroke(255,255,255,map(ALFA,0,255,0,50));
      fill(255);
      line(m.getX(), m.getY(), mf.getX(), mf.getY());
      line(mf.getX()-200, mf.getY()-200, m.getX(), m.getY());

      stroke(o_colores.getColor(0), map(ALFA, 0, 255, 0, 30));
      line(mf.getX()+100, mf.getY()-100, m.getX(), m.getY());
      line(mf.getX()+200, mf.getY()+200, m.getX(), m.getY());//segunda linea roja mas larga
      strokeWeight(1);
    

    spring.position().set(mf.getX(), mf.getY(), 0 );
    //particles-----------------------------------------------------
    physics.tick(SPEED);
    drawParticles(); //draw the particles
  }

  public void resetWorld() {
    physics = new ParticleSystem( 0.005, 0.05 );
    physics.setGravity(0.0);
    //create an array to hold the particle objects
    particles = new Particle[particleAmount];
    springs = new  traer.physics.Spring[particleAmount];
    atracciones = new Attraction[particleAmount];
    spring =physics.makeParticle(100.0, width, 0, 0.0); //SPRING
    spring.makeFixed();
    //birth some particle objects
    for (int i = 0; i < particles.length; ++i ) {
      particles[i] = physics.makeParticle( 1.0, mf.getX(), mf.getY(), random(-200.0, 200.0) );
      particles[i].velocity().add(  random(0, velocity), random(-velocity, velocity), 0);
      atracciones[i] =  physics.makeAttraction( particles[i], spring, attractStrength, 50.0 );
    }
  }
  void drawParticles() {

    noStroke();

    for ( int i = 0; i < 10; ++i )
    {
      atracciones[i].setStrength(ATRACCION);
      if (particles[i].position().y() > height+20 ) particles[i].position().set( particles[i].position().x(), -100, 0 ); 
      display(particles[i], i);
    }
  }
  void display(Particle p, int num) {
    colorr = o_colores.getColor(0);
    tint(colorr, STROKE_ALFA);
    //KNOB_3 =map(valor, 0, 127, 0, 10);
    float rradio =map(KNOB_3, 0, 10, 0, 200);
     rradio = random(rradio);
    image( particlePic, p.position().x(), p.position().y(), rradio, rradio); //actually draw something to the screen where the particles are
  }
}
