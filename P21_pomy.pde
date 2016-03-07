class Preset21 extends Preset {
  int numParticulas = 20;
  float vitesse = 5;
  float sombra = 255;
  float distancia = 2;

  Preset21(String _name) {
    super(_name);
    reset();
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    createParticleSystem();
  }
  public void changeTipo(int tipo) {
    
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
    numParticulas = int(map(FADER_3, 0, 255, 10, 500));
    vitesse = map(FADER_4, 0, 255, 5, 30);
    distancia = map(FADER_5, 0, 255, 0.50, 2);
    cambiarNumParticulas(numParticulas); //numero de particulas 0-500
    if (BT_41) cambiarVitesse(vitesse);
    cambiarShadow(sombra);
    cambiarDistance(distancia);


    particles.update();
  }
  //=========================================
  void createParticleSystem() {
    //=========================================
    background(0);
    particles = new ParticleSystem2 ();
    particles.setBorderBounce(true, true, true, true);

    for (int i = 0; i < nbrParticles; i ++) {
      Particle3 particle = new Particle3(
      new PVector (random(150, width-20), random(20, height-20)), 
      new PVector (random(-vit, vit), random(-vit, vit))                                       
        );
      particles.addParticle(particle);
    }
  }
  //=========================================
  void verifDistance(int nbPart) {
    //=========================================
    if (particles.traceTriangles) {
      //Verifier taille triangles / nombres de particules pour ne pas ralentir l'ordinateur
      if (nbPart<=70)particles.distPoint = boxDist;
      else if (nbPart>70 && nbPart <=130)particles.distPoint = boxDist * 0.8;
      else if (nbPart>130 && nbPart <=300)particles.distPoint = boxDist * 0.6;
      else particles.distPoint = boxDist * 0.4;
    }
    else particles.distPoint = boxDist;
  }
  void cambiarNumParticulas(int val) {
    try { 
      verifDistance(val);

      if (val > particles.nbParticle) {//on ajoute des particules 
        int ajout = val - particles.nbParticle;
        particles.addParticle(ajout);
      }
      else if (val < particles.nbParticle) {
        int soust = particles.nbParticle - val;
        particles.removeParticle(soust);
      }
    }
    catch(Exception e) {
      println("***************DRAW EXCEPTION pony: "+e.toString()+"\n");
    }
  }
  /*shaking*/
  void cambiarVitesse(float valor) {
    particles.changeVit = true;
    particles.vitesse = valor;
  }
  void cambiarShadow(float valor) {
    particles.shadowLevel = valor ;
  }
  void cambiarDistance(float valor) {
    boxDist = valor;
    int nbPart = particles.nbParticle;
    verifDistance(nbPart);
  }
}

class Particle3 {

  PVector pos;
  public PVector vel;
  PVector acc;
  float max_vel = 800;
  float bounce = -1;
  int taille = 5;
  Boolean affBoules = true;

  //=========================================
  Particle3 (PVector p, PVector v, PVector a, float _bounce) {
    //=========================================
    pos = p.get();
    vel = v.get();
    acc = a.get();
    bounce = _bounce;
  }

  //=========================================
  Particle3 (PVector p, PVector v, PVector a) {
    //=========================================
    pos = p.get();
    vel = v.get();
    acc = a.get();
  }

  //=========================================
  Particle3 (PVector p, PVector v) {
    //=========================================
    pos = p.get();
    vel = v.get();
    acc = new PVector(0, 0);
  }

  //=========================================
  Particle3 (PVector p) {
    //=========================================
    pos = p.get();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  //=========================================
  void update() {
    //=========================================
    vel.add(acc);
    vel.limit(max_vel);
    pos.add(vel);
  }

  //=========================================
  void render(Boolean aff) {
    //=========================================
    update();
    noStroke();
    fill(o_colores.getColor(), 70);
    if (aff)ellipse (pos.x, pos.y, taille, taille);
  }
}

class ParticleSystem2 {

  ArrayList particles; 
  boolean ps_up, ps_right, ps_down, ps_left;
  ArrayList history;

  //DIFFERENTS PARAMETRES D AFFICHAGE
  Boolean traceTraits = true;
  Boolean traceTriangles = true;
  Boolean traceParticle = false;
  Boolean changeVit = false;  

  int nbParticle = 20;
  float vitesse = 5;
  float shadowLevel = 255;
  float distPoint = 2;
  float contourTriangle = 20;

  //=========================================
  ParticleSystem2() {
    //=========================================
    particles = new ArrayList();
    history = new ArrayList();
  }

  //=========================================
  ParticleSystem2(PVector origine, int nbr) {
    //=========================================
    particles = new ArrayList();
    for (int i = 0; i < nbr; i++)particles.add( new Particle3(origine) );
  }

  //=========================================
  ParticleSystem2( PVector origine, PVector vel, int nbr) {
    //=========================================
    particles = new ArrayList();
    for (int i = 0; i < nbr; i++)particles.add( new Particle3(origine, vel) );
  }

  //=========================================
  ParticleSystem2( PVector origine, PVector vel, PVector acc, int nbr) {
    //=========================================
    particles = new ArrayList();
    for (int i = 0; i < nbr; i++)particles.add( new Particle3(origine, vel, acc) );
  } 

  //=========================================
  void update() { 
    //=========================================   
    history = new ArrayList();// on vide le tableau precedent

      
    //On  deplace les particules
    if (changeVit) {
      changeVit = false;
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle3 p = (Particle3) particles.get(i);
        PVector t = p.pos;
        history.add(t);
        border(p);
        p.vel = new PVector (random(-vitesse, vitesse), random(-vitesse, vitesse));
        p.render(traceParticle);
      }
    }
    else {
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle3 p = (Particle3) particles.get(i);
        PVector t = p.pos;
        history.add(t);
        border(p);
        p.render(traceParticle);
      }
    }
    verifTraits();//si on veut des traits entre les points
  }


  //========================================= 
  void verifTraits() { //function pour tracer les traits entre les différents points
    //=========================================

    for (int i=0; i<history.size();i++) {
      ArrayList joints = new ArrayList();
      PVector t = (PVector) history.get(i);

      for (int q=0; q<history.size(); q++) {
        if (q != i) {
          PVector v = (PVector) history.get(q);
          float joinchance = q/history.size() + t.dist(v)/60;
          stroke(255, 70);

          //On trace la ligne et on ajoute le point pour la verif triangle
          if (joinchance < distPoint) {
            if (traceTraits)line(t.x, t.y, v.x, v.y);
            if (traceTriangles)joints.add(q);
          }
          //si la boucle est finit on verifie pour le point les triangles
          if (q == history.size()-1)if (joints.size()>=2)traceTriangle(i, joints);
        }
      }
    }
  }



  //=========================================
  void traceTriangle(int num, ArrayList joints) { //function pour tracer les triangles entre les points
    //=========================================
    // num correspond au point traité au début & le array au différents points avec lesquels il se racodent
    // On doit donc vérifier si les différents points se racordent entre eux
    PVector p = (PVector)history.get(num);

    for (int i=0; i<joints.size();i++) {
      int p1 = (Integer) joints.get(i);
      PVector t = (PVector)history.get(p1);
      for (int l = i+1; l<joints.size(); l++) {
        int p2 = (Integer) joints.get(l);
        PVector v = (PVector)history.get(p2);
        float joinchance = l/history.size() + t.dist(v)/60;
        if (joinchance < distPoint) {
          strokeWeight(1);
          stroke(o_colores.getColor(0), STROKE_ALFA);
          fill(o_colores.getColor(), ALFA);
          // triangle(t.x, t.y, v.x, v.y, p.x, p.y);
          quad(t.x+RADIO, t.y+RADIO, v.x+RADIO, v.y+RADIO, p.x+RADIO, p.y+RADIO,p.x+RADIO, p.y+RADIO);
        }
      }
    }
  }

  //=========================================
  void addParticle(Particle3 p) {
    //=========================================
    particles.add(p);
  }

  //=========================================
  void addParticle(int nb) {
    //=========================================
    for (int i = 1; i<=nb ; i++) {
      Particle3 p = new Particle3(new PVector (random(150, width-20), random(20, height-20)), new PVector (random(-vit, vit), random(-vit, vit)));
      particles.add(p);
      nbParticle = particles.size();
    }
  }

  //=========================================
  void removeParticle(int nb) {
    //=========================================
    for (int i = 1; i <= nb; i++) {
      particles.remove(i);
      nbParticle = particles.size();
    }
  }

  //=========================================
  void setBorderBounce( boolean _up, boolean _right, boolean _down, boolean _left) {
    //=========================================
    ps_up = _up;
    ps_right = _right;
    ps_down = _down;
    ps_left = _left;
  }

  //=========================================
  void border(Particle3 p) { 
    //=========================================  
    if ( p.pos.x < 0 && ps_left ) p.vel.x*= p.bounce;
    if ( p.pos.x > width && ps_right ) p.vel.x*= p.bounce;
    if ( p.pos.y < 0 && ps_up ) p.vel.y*= p.bounce;
    if ( p.pos.y > height && ps_down ) p.vel.y*= p.bounce;
  }
}
