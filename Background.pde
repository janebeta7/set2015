
class Background {
  String directorio;
  boolean on=false;  
  boolean activar = true; //activar, desactivar

  ArrayList fondos;
  public int activa = 0;
  boolean isBg = false;
  Background(String _directorio) {
    this.directorio = _directorio;
    cargar();
  }
  public void cargar() {
    //cargamos del directorio escogido todas las imagenes y las 
    //metenemos en un array list
    String[] listado = new String[100];
    listado = assets.readFolder(directorio);
    fondos = new ArrayList();
    int len = listado.length;
    if (listado.length > 0) {
      for (int i=0; i<len; i++) {

        fondos.add(new Fondos(listado[i], i));
      }
    }
  }
  public color getColor(int posx, int posy){
     return getFondo().getColor(posx,posy);
  }
  public void setBg() {
    isBg = !isBg;
    println("bg----"+ isBg+ "color fondo"+ hex(COLOR_FONDO) );
  }
  public void render() {
    isBg = BT_21;
    if (isBg) {
      bg();
    }
  }
  void reset() {
    isBg = false;
    activa = -1;
  }
  void changeImg(int _num) {
    if (_num <  fondos.size())  activa= _num;
  }
  void bg() {
    // println("> bg ON");
    float TINTA = 255;
    if ( TINTA <20 ) TINTA = 0;
    if ( BT_23 ) TINTA = FADER_7*o_sound.getLevel()*100;
    tint(TINTA, 255);

    getFondo().display();
  }
  public Fondos getFondo() {
if (activa <0) activa = 0;
    Fondos ftemp = (Fondos) fondos.get(activa);
    return ftemp;
  }
}

public class Fondos {
  private PImage b;
  private String url;
  private int i;
  Fondos(String _url, int _i) {
    this.url = _url;

    this.i = _i;
    load();
  }
  private void load() {
    File file=new File(this.url);
    boolean exists =file.exists(); 
    if (!exists)  println("Fondos > No existe arhivo : "+dataPath(this.url));
    else {
      b = loadImage(url);
      
      // println("- f: "+dataPath(this.url));
    }
  }
   public color getColor(int posx, int posy){
     return b.get(posx, posy);
  }
  private void display() {
    imageMode(CENTER);
    image(b, width/2, height/2, width, height);
  }
}















