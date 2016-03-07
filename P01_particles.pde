class Preset1 extends Preset {
  Particle raton;
  Attraction[] atracciones;
  ParticleSystem physics; //objeto de clase ParticleSystem
  Particle[] particles; //array de partículas
  traer.physics.Spring[] springs; //array de partículas
  float velocity = 15.0; //velocidad
  float particleSize = 10; //tamaño de partículas
  float attractStrength = 20.0; //fuerza de catraccion
  int particleAmount = 256; //cantidad de partículas
  boolean attractRepel = false; //repelan las particlas?
  PImage particlePic;
  String[] listado = new String[100];
  String directorio;
  boolean firstMouseClick = false; //primera vez que el mouse hace click?
  float scala = 1; //escala
  Preset1(String _name) {
    super(_name);
    loadAssets(dataPath("_01_particles/"));
    reset();
  }
  public void f_mousePressed() {
    if (super.on)   reset();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  void loadAssets(String _directorio) {
    directorio = _directorio;
    listado = assets.readFolder(directorio);
  }
  public void reset() {
    resetWorld(int(random(0, width)), int(random(0, height)));
  }
  public void changeTipo(int tipo) {
    _changeTipo(tipo);
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
  
    physics.tick(FADER_1);
    if ( TIPO ==2 ) {
      physics.setGravity(0.02);
    }


    else 
      physics.setGravity(0);
    if (BT_11) raton.position().set( super.getX(), super.getY(), 0 );
    drawParticles(); //draw the particles
  }

  void resetWorld(int x, int y) {
    particlePic = loadImage(listado[tipoParticula]); 
    firstMouseClick = true;
    createParticles(x, y);
  }  

  public void _changeTipo (int _tipo) {
    tipoParticula =_tipo;
  }
  void createParticles(int x, int y) {
    physics = new ParticleSystem( 0.005, 0.05 );
    particles = new Particle[particleAmount];
    springs = new  traer.physics.Spring[particleAmount];
    atracciones = new Attraction[particleAmount];
    raton =physics .makeParticle(100.0, width/2, height/2, 0.0);
    raton.makeFixed();
    for (int i = 0; i < particles.length; ++i ) {
      if (TIPO == 1 ) {
        particles[i] = physics.makeParticle( 1.0, mouseX,mouseY, random(-200.0, 200.0) );
      }
      else if (TIPO == 2) {
        particles[i] = physics.makeParticle(300, random(0, width), random(-100, 10), 0);
        particles[i].velocity().add( 0, random(-velocity, velocity), random(-velocity, velocity));
      }
      else if (TIPO == 3) {
        particles[i] = physics.makeParticle( 1.0, mouseX,mouseY, random(-200.0, 200.0) );
       particles[i].velocity().add( random(-velocity, velocity), random(-velocity, velocity), random(-velocity, velocity));
      }
      else if (TIPO == 4) {
        particles[i] = physics.makeParticle( 1.0, random(width),random(height), random(-200.0, 200.0) );
       particles[i].velocity().add( random(-velocity, velocity), random(-velocity, velocity), random(-velocity, velocity));
      }
      else
      {
        particles[i] = physics.makeParticle( 1.0, mouseX, mouseY, random(-200.0, 200.0) );
        //particles[i].position().set( x, y, 0.0 );
        particles[i].velocity().add( random(-velocity, velocity), random(-velocity, velocity), random(-velocity, velocity));
        particles[i].setMass(random(0.1, 3.0));
      }
      atracciones[i] =  physics.makeAttraction( particles[i], raton, attractStrength, 50.0 );
    }
  }
  void drawParticles() {
    noStroke();
    //int num =int(INC);
    int num = int(map(INC, 0, 256, 0, LONG));
    for ( int i = 0; i < num; ++i )
    {
      if (particles[i].position().y() > height) {
        particles[i].position().set( particles[i].position().x(), -100, 0.0 );
      }
      display(particles[i], i);
    }
  }
  void display(Particle p, int num) {
    if (oneColor) tint(o_colores.getColor(0), STROKE_ALFA);
    else
      tint(o_colores.getColor(), STROKE_ALFA);
    float tam = o_sound.get_fft(num)*FADER_7;
    image( particlePic, p.position().x(), p.position().y(), tam, tam); //actually draw something to the screen where the particles are
  }
}
public class Particles {
  private PImage b;
  private String url;
  private int i;
  Particles(String _url, int _i) {
    this.url = _url;
    this.i = _i;
    load();
  }
  private void load() {
    File file=new File(this.url);
    boolean exists =file.exists(); 
    if (!exists)  println("Particles > No existe arhivo : "+this.url);
    else {
      b = loadImage(url);
    }
  }
  private void display() {
    if (oneColor) tint(o_colores.getColor(0), STROKE_ALFA);
    else tint(o_colores.getColor(), STROKE_ALFA);
    image(b, mouseX, mouseY, RADIO, RADIO);
  }
}
