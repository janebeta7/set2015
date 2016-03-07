class Preset32 extends Preset {
  PImage clouds;
  float TINTA;
  Preset32(String _name) {
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
    noiseDetail(5, 0.4);
    loadPixels();

    // Render the noise to a smaller image, it's faster than updating the entire window.
    clouds = createImage(128, 128, RGB);
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
  private void render() {
    float hue = (noise(millis() * 0.0001) * 200) % 100;
    float cspeed =   map(FADER_1, 0, 10, 0, 0.002);

    float z = millis() * cspeed;
    float dx = millis() * cspeed;

    for (int x=0; x < clouds.width; x++) {
      for (int y=0; y < clouds.height; y++) {
        float cxx = map(KNOB_1, 0, 100, 0, 0.10);
        float n = 500 * (noise(dx + x * cxx, y * 0.01, z) - 0.4);
        float cMode =   map(FADER_8, 0, 255, 0, 100);

        color c = color(cMode, 80 - n, n);
        clouds.pixels[x + clouds.width*y] = c;
      }
    }
    clouds.updatePixels();
    imageMode(CORNER);
    
    if ( BT_13 ) TINTA = FADER_7*o_sound.getLevel()*100;
    else TINTA = 255;
    tint(TINTA, 255);

    image(clouds, 0, 0, width, height);
    imageMode(CENTER);
  }
}

