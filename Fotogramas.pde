//clase que se encarga de gestionar la secuencia de fotogramas que va en cada escena / cancion
class Fotogramas{
  boolean on=false;  
  int escenaActiva = 0;
  int NUM_ESCENAS =2;

  Escena[] escenas ;
  Fotogramas(){

    escenas = new Escena[NUM_ESCENAS];
    int i = 0;
    escenas[i++] = new Escena("fotogramas/maskaras/");
    escenas[i++] = new Escena("fotogramas/bacterias/");
  }
  public void setFotogramas(){
    on = !on;

  }
  public void render(){
    if (on) {
      // println("----setFotogramas escenaActiva:"+ escenaActiva);
      escenas[escenaActiva].draw();
    }
  }
  void reset(){

    on = false;

  }
  public void selectEscena(){
    escenaActiva++;
    if (escenaActiva >=escenas.length) escenaActiva =0;
    println("escenaActiva:"+escenaActiva);
  }  
  public void changeEscena(int _num){
    escenaActiva= _num;
    println("escenaActiva:"+escenaActiva);
  }
  public void selectFotogramaAvanzar(){
    escenas[escenaActiva].selectFotogramaAvanzar();
  }
  public void selectFotogramaRetroceder(){
    escenas[escenaActiva].selectFotogramaRetroceder();
  }


}


public class Escena   {
  private PImage b,fondito;
  private int maxpal = 100;
  private int numpal = 0;
  private int numFotogramas = 0;
  private File dir ; 
  private boolean isOrdenados = false;
  private int colorActivo = 0;

  private String[] listado;
  private PImage[] listFotogramas;
  private boolean isDir = false; //estamos sacando las imagenes del directorio?
  private color[] imageColors = new color[maxpal];
  int MAXFOTOGRAMAS = 50;//numero máximo de fotogramas de colores que cargamos con addFotograma
  public int fotogramaActivo = 0;
  //metodo constructor
  Escena(String _path){
    listado = new String[MAXFOTOGRAMAS];
    listFotogramas = new PImage[MAXFOTOGRAMAS];
    addFotogramaDir(_path);

  }
  /*METODOS PUBLICOS-----------------------------------------------------------------*/

  //añade una imagen al set de Colores

  //añade las imagenes de un directorio al set de Colores
  public void addFotogramaDir(String _path){
    isDir = true;
    listado = leerDirectorio(_path);
    numFotogramas= listado.length;
    println("-------------------------");
    println("---numFotogramas:"+ _path+ " "+numFotogramas);
    // selectFotograma(0);
    cargarFotogramas();
  }   
  void cargarFotogramas(){
    for (int i=0; i<numFotogramas; i++) {
      listFotogramas[i] = getFotograma(listado[i]);
    }
    selectFotograma(0);

  }


  //inicia una fotograma de colores numero num del listado.
  public void selectFotograma(int num){
    fotogramaActivo = num;
    println("Fotograma > " + num+ ":" +listado[num]);
    PImage  img = listFotogramas[num];
 //   fondito=new PImage(img .width, img.height);
  //  fondito.copy(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height);

  }
  public void selectFotogramaAvanzar(){
    fotogramaActivo++;
    if (fotogramaActivo >=numFotogramas) fotogramaActivo =0;
    selectFotograma(fotogramaActivo);
  }


  public void selectFotogramaRetroceder(){

    fotogramaActivo--;
    if (fotogramaActivo <0) fotogramaActivo =numFotogramas;
    selectFotograma(fotogramaActivo);
  }

  public void draw(){
    //dibuja en pantalla la imagen que está como activa
    float TINTA = BG_ALFA;
    if ( TINTA <20 ) TINTA = 0;
    if ( isSound ) TINTA = BG_ALFA*o_sound.getLevel();
    else tint(255,TINTA);
    // if (isShift) image(fondito, width+(fondito.width/2), height/2,fondito.width,fondito.height);
    // else
     PImage  img = listFotogramas[fotogramaActivo];
    image(img, width/2, height/2,img.width,img.height);
    //imagenes[imagenActiva].filter(ERODE, 1);
    if (isBlur) img.filter(BLUR, 4);
  }
  PImage getFotograma(String fn){
    PImage fotogramaImg = loadImage(fn);
    return fotogramaImg;
  }

  /*METODOS PRIVADOS-----------------------------------------------------------------*/
  private String [] leerDirectorio(String _path){
    if (isDir) {
      dir = new File(_path);  
    }
    else
    {
      dir = new File(_path);  
    }
    String[] children =  dir.list();
    if (children == null) {
      //println("*******  error en la lectura del directorio >>"+_path);
    } 
    else {
      //println("*******  list >>"+_path +"children.length:"+children.length);    
      for (int i=0; i<children.length; i++) {
        children[i] = _path + children[i];
        // println("*******  fotograma["+i+"] >>"+children[i]);  
      }
    } 
    return children;

  }

}