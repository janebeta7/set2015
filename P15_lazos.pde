// ---------------- PARTICLE SYSTEM
float GRAVEDAD = 0.2f;
float DRAG = 0.05f;
float STRENGTH = 0.1f; 
//float DAMPING = 1.1f;
float DAMPING = 0.001f;
float RESTLENGHT =1;
boolean isGRAVITY = false;
//float STRENGTH_POINT = 0.0008f;
float STRENGTH_POINT = 0.4f;   
float DAMPING_POINT = 1.0f;
PImage imgTexture ;
class Preset15 extends Preset {



  java.util.Vector tendrils;
  traer.physics.ParticleSystem physics;
  traer.physics.Particle mouse;
  int greyer;
  boolean drawing;
  boolean nothingDrawn;

  T3ndril tt;
  Preset15(String _name) {

    super(_name);
    // physics = new traer.physics.ParticleSystem( 0.0f, 0.05f );
    physics = new traer.physics.ParticleSystem( GRAVEDAD, DRAG );
    //imgTexture = loadImage("berlin-1.jpg");
    //imgTexture = loadImage("brushes/brush6.png");
    textureMode(NORMAL);
    mouse = physics.makeParticle();
    mouse.makeFixed();

    tendrils = new java.util.Vector();
    drawing = false;
    greyer = 255;
  }
public void changeTipo(int tipo) {
    
  }
  public void reset() {
    if (super.on) {

      physics.clear();
      tendrils = new java.util.Vector();
    }
  }
  public void f_mousePressed() {
    if (super.on) {
      dibujar();
    }
  };
  public void f_mouseDrag() {
    if (super.on) {
      try {
        ((T3ndril)tendrils.lastElement()).addPoint( new Vector3D( mouseX, mouseY, 0 ) );
      }
      catch(Exception e) {

        sendConsola("***************DRAW EXCEPTION LAZOS: "+e.toString()+"\n");
      }
    }
  };
  public void f_mouseReleased() { 
    if (super.on) {
      drawing = false;
    }
  };
  public void draw() {
    if (super.on) {
      render();
    }
  }

  public void listener() {
    super.listener();
  }

  private void render() {
    try {
      if (BT_94) reset();
      //if (BT_51) reset();
      // bg.changeImg(6);

      if (BT_12) mouse.makeFree(); 
      else
        mouse.position().set( mouseX, mouseY, 0 );
      float sp = map(SPEED, 0, 10, 0, 1);
      physics.tick(sp);

      physics.setGravity(0);

      if ( greyer >= 64 )
        greyer *= 0.9;
      //background( 0 );

      drawOldGrey();
    }
    catch(Exception e) {

      sendConsola("***************DRAW EXCEPTION LAZO: "+e.toString()+"\n");
    }
  }
  void borrar() {
    physics = new traer.physics.ParticleSystem( 0.0f, 0.05f );

    mouse = physics.makeParticle();
    mouse.makeFixed();

    tendrils = new java.util.Vector();
    drawing = false;
    greyer = 255;
  }
  void dibujar() {
    drawing = true;
    Vector3D v3d = new Vector3D( mouseX, mouseY, 0 );
    tt = new T3ndril( physics, v3d, mouse, o_colores.getColor(0) );
    tendrils.add(tt );
  }
  void drawOldGrey()
  {
    if (BT_51) stroke( 0, STROKE_ALFA); 
    else stroke( 255, STROKE_ALFA);

    // stroke( 0  ,STROKE_ALFA);
    //stroke( o_colores.devuelveColores(0) ,STROKE_ALFA );

    //dibuja los demas elementos

    //drawElastic( (T3ndril)tendrils.firstElement(), true, 255 );
    for ( int i = 0; i < tendrils.size ()-1; ++i )
    {
      T3ndril t = (T3ndril)tendrils.get( i );

      drawElastic( t, false, o_colores.getColor(0), o_colores.getColor());
    }
    stroke( 255, STROKE_ALFA );

    if ( tendrils.size()-1 >= 0 )
      drawElastic( (T3ndril)tendrils.lastElement(), true, 255, 0);
  }

  void drawElastic( T3ndril t, boolean move, color colorr, color colorr2)
  {

    for ( int i = 0; i < t.particles.size ()-1; ++i )
    {
      Vector3D firstPoint = ((Particle)t.particles.get( i )).position();
      Vector3D paraMiElipse1 = ((Particle)t.particles.get( t.particles.size()-1 )).position();
      Vector3D paraMiElipse2 = ((Particle)t.particles.get(0)).position();
      Vector3D firstAnchor =  i < 1 ? firstPoint : ((Particle)t.particles.get( i-1 )).position();
      Vector3D secondPoint = i+1 < t.particles.size() ? ((Particle)t.particles.get( i+1 )).position() : firstPoint;
      Vector3D secondAnchor = i+2 < t.particles.size() ? ((Particle)t.particles.get( i+2 )).position() : secondPoint;

      traer.physics.Spring s = (traer.physics.Spring)t.springs.get( i );
      s.setStrength(STRENGTH_POINT);
      s.setDamping( DAMPING_POINT);
if (BT_13 ) { //MAKE FREE
// physics.removeSpring(s);
}
      //s.setRestLength(STRENGTH_POINT);

      int indice = i % LONG;


      // noStroke();
      // stroke(0,STROKE_ALFA);
      //curveTightness(0);

      if (!BT_52 && !BT_53) {
        //fill(colorr, ALFA);
        if (oneColor) fill(0, ALFA);
        else fill(colorr, ALFA);
        //ellipse(paraMiElipse1.x(), paraMiElipse1.y(), RADIO, RADIO);
        curve( firstAnchor.x(), firstAnchor.y(), 
        firstPoint.x(), firstPoint.y(), 
        secondPoint.x(), secondPoint.y(), 
        secondAnchor.x(), secondAnchor.y() );
      } else if (BT_52)
      {
        float colorrAlfa = (o_sound.get_fft(indice)*pow(FADER_7,2));
         fill(colorr2, colorrAlfa);
         beginShape();
         vertex(firstAnchor.x(), firstAnchor.y());
         vertex( firstPoint.x(), firstPoint.y());
         vertex(secondPoint.x(), secondPoint.y());
         vertex( secondAnchor.x(), secondAnchor.y());
         endShape(CLOSE);

       
        
          if (oneColor) stroke(255, KNOB_4);
          else  if (BT_51)  stroke(0, KNOB_4);  stroke(o_colores.getColor(0), KNOB_4);
          
          line(secondPoint.x(), secondPoint.y(), secondAnchor.x(), secondAnchor.y());
        }
        if (BT_53) {
         

          float tam = constrain(o_sound.get_fft(indice)*FADER_7, 0, RADIO);

          if (random(1) > 0.95 ){
            fill(o_colores.getColor(), ALFA);
          ellipse(secondPoint.x(), secondPoint.y(), tam, tam);
          
          }
       
          if (oneColor) stroke(255, KNOB_4);
          else  if (BT_51)  stroke(0, KNOB_4);
          else 
            stroke(o_colores.getColor(0), KNOB_4);
          line(secondPoint.x(), secondPoint.y(), secondAnchor.x(), secondAnchor.y());
          /* beginShape();
           texture(imgTexture);
           vertex(firstAnchor.x(), firstAnchor.y());
           vertex( firstPoint.x(), firstPoint.y());
           vertex(secondPoint.x(), secondPoint.y());
           vertex( secondAnchor.x(), secondAnchor.y());
           endShape();*/
        }
      }
    }
  }

  class T3ndril
  {
    java.util.Vector particles;
    java.util.Vector springs;
    traer.physics.ParticleSystem physics;
    color colorr ;
    Particle thisParticle;
    // T3ndril tt = new T3ndril( physics, v3d, mouse,o_colores.devuelveColores() );
    public T3ndril(traer.physics.ParticleSystem pp, Vector3D firstPoint, traer.physics.Particle followPoint, color colorr )

    {
      println("NEW T3NDRIL");
      particles = new java.util.Vector();
      springs = new java.util.Vector();
      colorr = this.colorr;
      physics = pp;
      Particle firstParticle = pp.makeParticle( 1.0f, firstPoint.x(), firstPoint.y(), firstPoint.z() );
      particles.add( firstParticle );
      // RESTLENGHT = map(FADER_6,0,255,0.1f,15f);
      physics.makeSpring( followPoint, firstParticle, STRENGTH, DAMPING, RESTLENGHT  );
    }

    public void addPoint( Vector3D p )
    {
       thisParticle = physics.makeParticle( 1.0f, p.x(), p.y(), p.z() );
      springs.add( physics.makeSpring( ((Particle)particles.lastElement()), 
      thisParticle, 
      STRENGTH_POINT, DAMPING_POINT, 
      ((Particle)particles.lastElement()).position().distanceTo( thisParticle.position() ) ) );
      particles.add( thisParticle );
    }
    
  }
