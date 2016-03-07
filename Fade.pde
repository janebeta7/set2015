//clase que controla el fade in y el fade out
class Fade {
  boolean on=false;  
  Fade() {
    println("Fade >> init Fade");
  }
  public void render() {

    if (on==true)  fade();
  }

  public void setFade() {

    on =!on;
    sendConsola("Fade >> setFade:"+on);
    //println("Fade >> setFade:"+on);
  }
  private void fade() {
    //println("fading");
    noStroke();
    if (!BT_22) fill(COLOR_FONDO,map(FADER_2,0,255,0,255));
    else fill(255,map(FADER_2,0,255,0,255));
    rectMode(CORNER);
    rect(0,0,width,height);
    //println("width"+width);
  }
}

