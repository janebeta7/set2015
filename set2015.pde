


/* Alba G. Corral */

//*********catch********* ****************** importamos librerias ****************** ****************** *//
int NUM_PRESETS =33;
Boolean isOPENGL = true ;
Boolean isPerformance=false;
Boolean MONITOR = false;
int sizeX = 1920 ;
int sizeY = 1080  ;
int locationXPerformance = 1680;
int locationYPerformance = 0;
int locationX = 0;
int locationY = 0;
int posx ;
int posy;
Movie mov;
/*------------------------R------------------------------------------------------------------------*/
//***************b*** ****************** importamos librerias ****************** ****************** *//
import peasy.*;

import processing.video.*;

import traer.physics.*;
import seltar.motion.*;
import javax.swing.*;
import java.io.*;


import java.awt.Color;
import java.awt.*;
import java.awt.event.*;

import point2line.*; //para calcular las operaciones chungas de las partic
import toxi.math.*;
import janebeta7.*;

import oscP5.*;
import netP5.*;


// ******************   DECLARACION DE PARAMETROS  ************************************//
//----------------OBJETOS
Preset[] presets;
Background bg;

Fade o_fade;
Fotogramas fotogramas;
Brush brush;
Sound_fft o_sound;
Chronometer chrono;
Assets assets;
Siluetas siluetas; //objeto para las maskaras
Colors o_colores;
onionFaceData_Class onionData;
PeasyCam cam;

//----------------VARIABLES

PImage img = new PImage();
PImage maskara, imCa ;
boolean isSendNikka = false;
boolean isCalibrar= false;
boolean isDebug = true;
boolean USARRATON =true;
boolean renderToFrames = false;
boolean glow = false;
int TIPO = 1;
color COLOR_FONDO = #000000;
float ALFA=50;
float BG_ALFA = 255;
int RADIOMAXIM =1000;
boolean isBlur, isSound, isReset = false;
boolean oneColor = false;
float INC=48;
float SCALA = 1;
float CONTADOR=255;

float VOLUMEN  = 100;
float STROKE_ALFA = 40; // normalmente para Strokes
float RADIO = 200;//RADIO DE LOS CIRCULOS
float PINTURA = 150;
float PINTURA_VAL = 400;
float FRAMERATE  =30;
float SPEED  =2;
float SPEED_METROPOP =10;
float SPEEDX  = 0;
float SPEEDY  = 0;

float SPEED_FADE  =3;

float DAMPERVAL = 0.05;
float ATRACCION = 300;
int pixelShiftx=0;
int pixelShifty =1 ;
int shiftDirection = 1;
float  SPEED_SHIFT= 2;
boolean isBlockLines = false;
// SWITCHERS //
boolean isInvert = true;
boolean isSpring = false;
boolean isSeguimiento = false;
boolean isClear = false;
boolean isOnion = true;
boolean isBg = false;
boolean isFade = false;
boolean isCamera=false;

boolean isCursor = false;

int tipoParticula = 1;
float FORCE =0;
float RADIO_TOXI =20;

//----------------------CONTROL_1----------------
float KNOB_1 = 100;
float KNOB_12 = 100;
float FADER_1 =100;
float FADER_11 =100;
float FADER_12 =100;
float FADER_13 =100;
Boolean BT_11 = false;
Boolean BT_12 = false;
Boolean BT_13 = false;
//----------------------CONTROL_2---------------- 
float KNOB_2 = 100;
float FADER_2 =100; 
Boolean BT_21 = false;
Boolean BT_22 = false;
Boolean BT_23 = false;
Boolean isPosition= false;
Boolean isResize = false;
float ancho, alto=0;
//----------------------CONTROL_3----------------
float KNOB_3 = 100;
float FADER_3 =100; 
float FADER_31 =100;

Boolean BT_31 = false;
Boolean BT_32 = false;
Boolean BT_33 = false;
//----------------------CONTROL_4----------------
float KNOB_4 = 100;
float FADER_4 =10; 
float FADER_41=10;
Boolean BT_41 = false;
Boolean BT_42 = false;
Boolean BT_43 = false;
//----------------------CONTROL_5----------------
float KNOB_5 = 255;
float FADER_5 =25; 
float  FADER_51 = 10;
Boolean BT_51 = false;
Boolean BT_52 = false;
Boolean BT_53 = false;
//----------------------CONTROL_6----------------
float KNOB_6 = 100;
float FADER_6 =100; 
Boolean BT_61 = false;
Boolean BT_62 = false;
Boolean BT_63 = false;

//----------------------CONTROL_7----------------
float KNOB_7 = 400;
float FADER_7 = 150;
float FADER_71 = 100;



Boolean BT_71 = false;
Boolean BT_72 = false;
Boolean BT_73 = false;
//----------------------CONTROL_8----------------
float KNOB_8 = 10;
float FADER_8 =100; 
Boolean BT_81 = false;
Boolean BT_82 = false;
Boolean BT_83 = false;
//----------------------botones----------------
Boolean BT_91 = false;
Boolean BT_92 = false;
Boolean BT_93 = false;
Boolean BT_94 = false;
Boolean BT_95 = false;
Boolean BT_96 = false;
Boolean BT_97 = false;
Boolean BT_98 = false;
Boolean BT_99 = false;
Boolean BT_100 = false;
Boolean BT_101 = false;
int INTCOLOR = 0 ;
/*-----pony-----*/
ParticleSystem2 particles;
int nbrParticles = 20;
int vit = 5;
float boxDist = 2;

/*sound*/



PGraphics offscreen;

void settings() {

 println("INIT set....");
//(java.swing.JFrame)frame.getContentPane().setBackground(new java.awt.Color(color(0,0,0)));
fullScreen();  //TWO MONITORS
 
 //
 }
// Called every time a new frame is available to read

void setup() {
  //
 //colorMode(HSB, 100);
  surface.setSize(1920,1080);
  

  
    /*cam = new PeasyCam(this, 1800);
   cam.setMinimumDistance(50);
   cam.setMaximumDistance(500); */
  setupkeys();
  posx = width/2;
  posy= height/2; 
  // if (isPerformance) frame.setLocation(locationXPerformance, locationYPerformance);
  // else frame.setLocation(locationX, locationY);
  imageMode(CENTER);
  background(COLOR_FONDO);
  cursor(CROSS);
  noCursor();
  inicio();
}
void inicio() {
  background(0);
  imCa = loadImage("calibracion.png");
  background(0);
  assets = new Assets();
  o_colores  = new Colors(this); //instanciamos el objeto colores con 100 colores como máximo en cada paleta
  o_colores.addFolder(dataPath("set/"));
  onionData = new onionFaceData_Class(this);
  o_fade = new Fade();
  siluetas = new Siluetas(dataPath("siluetas/"));
  bg = new Background(dataPath("backgrounds/"));

  o_sound = new Sound_fft(this);
  PESO = new float[LONG];

  stroke(0);

  initPresets();


  initMIDI();
}

void initPresets() {

  presets = new Preset[NUM_PRESETS];
  int i = 0;
  presets[i++] = new Presetx("00 vacio----");
  presets[i++] = new Preset1("01 Particles");
  presets[i++] = new Preset2("02 Lela Art");
  presets[i++] = new Preset3("03 LIA");
  presets[i++] = new Preset4("04 motion follow"); //meter el de cortazar!
  presets[i++] = new Preset5("05 metropop physics");
  presets[i++] = new Preset6("06 sillyString----");
  presets[i++] = new Preset7("07 pintura");
  presets[i++] = new Preset8("08 metropop");
  presets[i++] = new Preset9("09 LInes");
  presets[i++] = new Preset10("10 Curvature");  
  presets[i++] = new Preset11("11 soundLines");
  presets[i++] = new Preset12("12 chorros----");
  presets[i++] = new Preset13("13 tentacles----");
  presets[i++] = new Preset14("14 Triangles");   
  presets[i++] = new Preset15("15 Lazos");   
  presets[i++] = new Preset16("16 iris");  
  presets[i++] = new Preset17("17 carnaval");
   presets[i++] = new Presetx("18 vacio----");
  presets[i++] = new Presetx("19 vacio----");
  presets[i++] = new Preset20("20 LUCES");
  presets[i++] = new Preset21("21 pony----");
  presets[i++] = new Preset22("22 LORD TRIANGLES");
  presets[i++] = new Preset23("23 INFINITE");
  presets[i++] = new Presetx("24 vacio----");
  presets[i++] = new Preset25("25 pollock"); 
  presets[i++] = new Presetx("25 vacio----");
  presets[i++] = new Preset27("27 pen  dulo"); 
  presets[i++] = new Preset28("28 noise"); 
  presets[i++] = new Preset29("29 witney");
  presets[i++] = new Presetx("30 vacio");
  presets[i++] = new Preset31("31 curtain");
  presets[i++] = new Preset32("32 niebla");
 //initVideo();
  // presets[i++] = new Preset30("30 tipos"); 
  brush = new Brush("_Brushes_", dataPath("brushes/"));
  //onionData.setParams();
  sendConsola("---------INIT: OK----------------");
  // presets[15].listener();presets[7].listener();presets[11].listener();
}



void draw() {
  
if (BT_96) {
  //println("playvideo");
  // playVideo();
  //displayVideo();
 
}
  //if (isCalibrar) calibrar();
  isSeguimiento =   BT_22;
  if (BT_96 ) setOFF();
  //if (isOPENGL)  frame.setAlwaysOnTop(true);
  if (isPerformance )  frame.setLocation(locationXPerformance, locationYPerformance);
  else if (isPerformance && !BT_93) frame.setLocation(0, 0);
  else frame.setLocation(locationX, locationY);

  // if (!isOPENGL && !isPerformance)   frame.setLocation(0,0);

  o_sound.draw();
  /*try {*/
  // scale(SCALA);

  if (BT_91) { 
    background(COLOR_FONDO);
  }
 
  // osc.info();
  if (glow) {
    if (isOPENGL) glowStuff();
   // else smooth();
  }
   bg.render();
   //videos.render();
  

 
      render();
       //  drawVideo();
  // fotogramas.render();
 
  o_fade.render();
  onionData.draw();
  brush.draw(); 
 
  //if (renderToFrames) renderFrames();

  float vv = map(KNOB_6, 0, 255, 0, 1);
  //vv = 0.6;
  if ( BT_63 ) shiftDirection = 1; 
  else shiftDirection=-1;
  if (BT_62 ) 
  {
    if ( BT_61 ) {
      pixelShiftx = 1*shiftDirection;
      pixelShifty = 0;
    } else
    {
      pixelShiftx = 0;
      pixelShifty = 1*shiftDirection;
    }
    pixelShift(int(pixelShiftx*SPEED_SHIFT), int(pixelShifty*SPEED_SHIFT));
  }

  if (BT_83) mirrorVertical();
  if (BT_82) mirrorHorizontal();
  // drawKeystone();
   siluetas.render();
 
}
/*catch(Exception e) {
 
 sendConsola("***************DRAW EXCEPTION: "+e.toString()+"\n");
 }
 
 
 
 }
 */




void render() {
  // println("tipoParticula:"+tipoParticula);
  for (int i = 0; i < presets.length; i++) {
    presets[i].draw();
  }
}





public void stop() {

  super.stop();
}