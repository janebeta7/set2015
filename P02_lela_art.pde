class Preset2 extends Preset {
  color CLR_GRANATE = #97160f; //color para las particulas
  color CLR_TIPO1 = #97160f; //color de tipografía 1
  color CLR_LINEAS = #FFFFFF;//color de las lineas de union 
  final int COUNT =1000; //numero de partículas
  final float MAX_BUBBLE_FORCE = 0.1f;
  final float MAX_MOUSE_FORCE = 0.9f;
  float MOUSE_RADIUS;
  final float DRAG_MULT = 0.02f;
  final float PADDING = 10; //grosor de area de circulo
  final float RADIUS = 40;
  final float DIAMETER = RADIUS*2;
  final float COLLISION_DISTANCE = DIAMETER + PADDING;
  final color burnedColor = color( 255 );
  color coolColor = color( 255, 0, 0);
  PImage img;
  float posxText;
  float posyText ;
  boolean isTesting = false;
  boolean isVideo = false;
  boolean isText = false;
  boolean isRender =false;
  boolean isMoveText = false;
  boolean isMouse =false;
  boolean isFade =false;
  boolean isClear=true;
  Particle7[] particles;
  PImage particulaimg;

  Preset2(String _name) {
    super(_name);
    particulaimg = loadImage("beat/beat2.png");
    particles = new Particle7[COUNT];
    for (int i = 0; i < particles.length; i++) particles[ i ] = new Particle7();
  }
  public void changeTipo(int tipo) {
    
  }
  public void start() {
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
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
    drawParticulas();
    MOUSE_RADIUS=RADIO;
  }
  void drawParticulas() {
    // añadimos la fuerza de repulsion sobre el textorce //
    noFill();
    for (int i = 0; i <  INC; i++) {
      for (int j = 0; j < INC; j++) {

        // make sure we only calculate for the same two particles once //

        //nos asegurtamos que no estamos calculando la misma particula//
        if ( i != j && i<j ) { 

          // calculate a vector pointing from paricle 'i' towards paricle 'j' //
          Vect2 towardsI = particles[ j ].position.subtracted( particles[ i ].position );

          // estan en colision??? //
          if ( towardsI.isLessThan( COLLISION_DISTANCE ) ) {
            if ( !isTesting ) {
              float distance  = towardsI.magnitude();
              //creamos una fuerza hacia la particula j con la magnitud de 1//
              // create a force towards paricle 'j' with the magnitude of 1 //
              Vect2 force = towardsI.divided( distance );
              //escalamos la fuerza hasta el máximo que podamos estar lo mas cerca //
              // scale the force to maximum as they get closer //
              float forceInterpolator = 1 - ( distance / COLLISION_DISTANCE );
              force.scale( forceInterpolator * MAX_BUBBLE_FORCE );
              //añadimos la fuerza a la particula j
              // add force to paricle 'j' //
              particles[ j ].addForce( force );

              // flip the force and add it to paricle 'i' //
              force.flip();
              particles[ i ].addForce( force );

              // display collision line //

              strokeWeight(1);
              if (oneColor)
                stroke( 255, STROKE_ALFA/10);
              else 
                stroke( 0, STROKE_ALFA/10);
              line( particles[ i ].position.x, particles[ i ].position.y, particles[ j ].position.x, particles[ j ].position.y );

              noStroke();
              if (oneColor)
                tint( o_colores.getColor(0), ALFA);
              else 
                tint( o_colores.getColor(), ALFA);
             // tint(o_colores.getColor(), ALFA);
              noStroke();
              imageMode(CENTER);
              // float tam = o_sound.get_fft(i)*PESO[i]*(FADER_7);
               float tam =10;
              
              image(particulaimg, particles[ i ].position.x, particles[ i ].position.y,tam,tam);
              //ellipse(particles[ i ].position.x, particles[ i ].position.y,o_sound.get_fft(i),o_sound.get_fft(i));
            }
          }
        }
      }
    }

    // save mouse position and speed into a vector //

    Vect2 mouse = new Vect2( mouseX, mouseY );
    Vect2 mouseSpeed = new Vect2( mouseX-pmouseX, mouseY-pmouseY );

    // add other forces, update and display //
    for (int i = 0; i < particles.length; i++) {

      // add mouse repulsion force //
      // if( mouseSpeed.isGreaterThan( 0.5 ) ){
      Vect2 towardsBubble = particles[ i ].position.subtracted( mouse );
      if ( towardsBubble.isLessThan( MOUSE_RADIUS ) ) {
        //fill(255);
        //ellipse(mouseX,mouseY,MOUSE_RADIUS,MOUSE_RADIUS);
        float distance = towardsBubble.magnitude();
        float forceInterpolator = 1 - ( distance / MOUSE_RADIUS );
        //Vect2 force = towardsBubble.normalized().scaled( forceInterpolator * MAX_MOUSE_FORCE );
        Vect2 force = towardsBubble.normalized().scaled( forceInterpolator * MAX_MOUSE_FORCE );
        particles[ i ].addForce( force );
      }
      // }

      // add damping //
      particles[ i ].damp( DRAG_MULT );

      // update //
      particles[ i ].update();

      // display //
      if ( isTesting ) particles[ i ].display(i);
    }
  }
}


class Particle7
{
  PImage particulaimg;
  Vect2 position;
  Vect2 velocity;


  Particle7() {
    position = new Vect2( random( width ), random( height ) );
    // position = new Vect2( random( width ), 0 );
    particulaimg = loadImage("beat/beat_2.png");
    velocity = new Vect2();
  }


  void update() {
    // move //
    position.add( velocity );

    // stay in scene //
    reboundEdges();
  }


  void addForce( Vect2 force ) {
    velocity.add( force );
  }


  void damp( float dampMult ) {
    velocity.scale( 1-dampMult );
  }


  void display(int i) {
    noStroke();

    tint( o_colores.getColor(0) );
     float tam = o_sound.get_fft(i)*PESO[i]*(FADER_7);
     //float tam =10;
    image(particulaimg, position.x, position.y, tam,tam);
  }


  void reboundEdges() {
    if ( position.x < 0 ) {
      position.x = 0;
      velocity.x *=-1;
    } 
    else if ( position.x > width-1 ) {
      position.x = width-1;
      velocity.x *=-1;
    }
    if ( position.y < 0 ) {
      position.y = 0;
      velocity.y *=-1;
    } 
    else if ( position.y > height-1 ) {
      position.y = height-1;
      velocity.y *=-1;
    }
  }
}