/////////////////////////////////////////////
// MIDI-related methods
import themidibus.*; //Import the library
boolean isMidi = true;

MidiBus midi_pad=null;
MidiBus midi_kontrol=null;
MidiBus midi_key=null;
String nano_0 = "PAD";
String nano_1 = "KEYBOARD";
String nano_2 = "SLIDER/KNOB";
int inputDeviceNumber_pad;//NANO_PADK
int inputDeviceNumber_kontrol;//NANO_KORG
int inputDeviceNumber_key;//NANO_KORG
boolean isKontrol =false;
boolean isKeyboard = false;
boolean isPad = false;
void initMIDI() {
  println("<< MIDI  inputs: >>>>>>>>>>>>>>>>>>>>>>");
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  try {  

    //midi_pad = new MidiBus(this, "PAD", "Java Sound Synthesizer", "midi_pad");
    midi_kontrol = new MidiBus(this, "SLIDER/KNOB", "Real Time Sequencer", "midi_kontrol");
//midi_key = new MidiBus(this, "KEYBOARD", "Java Sound Synthesizer", "midi_key");
  }
  catch(Exception e) {
    println("***************MIDI not available.");
    println("***************Exception: "+e.toString()+"\n");
    midi_pad=null;
    midi_kontrol=null;
    midi_key=null;
  }
}

void noteOn(int channel, int pitch, int velocity, String bus_name) {
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  println("Recieved on Bus:"+bus_name);
  if (bus_name == "midi_pad") {
    println("This came from midi_pad");
  } else if (bus_name == "midi_key") {
    println("This came from  midi_key");
  } else if (bus_name == "midi_kontrol") {
    println("This came from  or midi_kontrol");
  }
}

void controllerChange(int channel, int number, int value, long timestamp, String bus_name) {
  println();
  // println("Controller Change:");
  //println("--------");
  // println("Channel:"+channel);
 // println("Number:"+number);
  //println("Value:"+value);
  // println("Recieved on Bus:"+bus_name);
  if (bus_name == "midi_pad") {
    // println("This came from midi_pad");
    controllerIn_pad(number, value);
  } else if (bus_name == "midi_key") {
    // println("This came from  midi_key");
    controllerIn_key(number, value);
  } else if (bus_name == "midi_kontrol") {
    // println("This came from  midi_kontrol");
    controllerIn_kontrol(number, value);
  }
}
/* ------------------------    CONTROLLER IN PAD ---------------------------------------------------------*/
void controllerIn_pad(int num, int valor) {
  try {
    println("-----------------------------------------------------");
    switch(num) {
    case 1: /* c16 */
      presets[1].listener();  //Preset1("01 Particles");
      break;
    case 2: /* c16 */
      presets[2].listener(); //Preset2("02 Lela Art");
      break;
    case 3: /* c16 */
      presets[3].listener();  //Preset3("03 LIA");
      break;
    case 4: /* c16 */
      //  presets[4].listener(); //Preset4("04 motion follow");
      break;
    case 5: /* c12 */
      presets[22].listener(); //Preset22("22 LORD TRIANGLES");
      //presets[23].listener(); //Preset23("23 INFINITE");
      break;
    case 6: /* c12 */
      presets[23].listener(); //Preset23("23 INFINITE");
      break;
    case 7: /* c12 */
      presets[7].listener(); // Preset7("07 pintura");
      break;    
    case 8: /* c12 */
      presets[8].listener(); //Preset8("08 metropop");
      break;   
    case 9: /* c12 */
      presets[9].listener(); //Preset9("09 LInes");
      break;   
    case 10: /* c12 */
      presets[10].listener(); //Preset10("10 Curvature"); 
      break;    
    case 11: /* c12 */
      presets[16].listener();  // Preset16("16 iris"); 
      break;   
    case 12: /* c12 */

      presets[15].listener(); //Preset15("15 Lazos");
      break;   
    case 13: /* c12 */
      presets[14].listener(); // Preset14("14 Triangles"); 

      break;  
    case 14: /* c12 */
      presets[17].listener(); //Preset17("17 carnaval");
      break;   
    case 15: /* c12 */
      presets[25].listener(); //Preset25("25 pollock"); 
      break;      
    case 16: /* c12 */


      break; 
    case 17: /* c12 */
      presets[27].listener();
      // these_walls();
      break;
    case 18: /* c12 */
      presets[6].listener();
      break;
    case 19: /* c12 */
      presets[20].listener(); //Preset20("20 lUCES");
      break; 
    case 20: /* c12 */
      presets[11].listener();
      break; 
    case 21: /* c12 */
      presets[13].listener();
      break; 
    case 23: /* c12 */
      presets[12].listener();
      break;
    case 24: /* c12 */
      presets[21].listener();
      break;

    case 25: /* c12 */

      break;
    case 26: /* c12 */

      break;
    case 27: /* c12 */

      break;
    case 28: /* c12 */

      break;
    case 29: /* c12 */

      break;
    case 30: /* c12 */

      break;
    case 31: /* c12 */

      break;


    case 37: /* c12 */

      break;
    }
  }
  catch(Exception e) {

    println("***************Exception pad: "+e.toString()+"\n");
  }
}
/* ------------------------    CONTROLLER IN PAD ---------------------------------------------------------*/
/* ------------------------    CONTROLLER IN KEY ---------------------------------------------------------*/
void controllerIn_key(int num, int valor) {

  try {
    println("-----------------------------------------------------");
    switch(num) {

    case 18: 
      isBlockLines = !isBlockLines;
      oneColor  =  (valor==127) ? true : false;
      sendConsola("oneColor"+oneColor);
      break; 
    case 77: 
      brush.changeBrush = valor;   
      break; 
    case 19: 
      //      siluetas.selectSiluetaRetroceder();
      sendConsola("selectSiluetaRetroceder()");
      break;
    case 20: 
      //      siluetas.selectSiluetaAvanzar();
      sendConsola("selectSiluetaAvanzar()");
      break;
    case 21: /* c12 */

      // glow = !glow;

      glow  =  (valor==127) ? true : false;
      sendConsola("glow"+glow);
      break; 
    case 22: /* c12 */
      setOFF();
      sendConsola("MIDI >>  setOFF");
      break; 
    case 16: /* c12 */
      o_colores.setPalette();
      break; 

    case 17:
      o_colores.setPalette();


      break;
    case 1: /* c16 */
      if (  brush.isChangeBrush() )  brush.changeImg(0);
      else
        if (BT_22 )   bg.changeImg(0);
      else
        o_colores.setPalette(0);
      break;
    case 2: /* c16 */
      if (  brush.isChangeBrush() )  brush.changeImg(1);
      else
        if (BT_22 )   bg.changeImg(1);
      else
        o_colores.setPalette(1);
      break;
    case 3: /* c16 */
      if (  brush.isChangeBrush() )  brush.changeImg(2);
      else
        if (BT_22)   bg.changeImg(2);
      else
        o_colores.setPalette(2);
      break;
    case 4: /* c16 */
      if (  brush.isChangeBrush() )  brush.changeImg(3);
      else
        if (BT_22 )   bg.changeImg(3);
      else
        o_colores.setPalette(3);
      break;
    case 5: /* c12 */
      if (  brush.isChangeBrush() )  brush.changeImg(4);
      else
        if (BT_22 )   bg.changeImg(4);
      else
        o_colores.setPalette(4);
      break;
    case 6: /* c12 */
      if (  brush.isChangeBrush() )  brush.changeImg(5);
      else
        if (BT_22 )   bg.changeImg(5);
      else
        o_colores.setPalette(5);
      break;
    case 7: /* c12 */
      if (  brush.isChangeBrush() )  brush.changeImg(6);
      else
        if (BT_22 )   bg.changeImg(6);
      else
        o_colores.setPalette(6);
      break;    

    case 8:
      if (  brush.isChangeBrush() )  brush.changeImg(7);

      else if (BT_22 ) bg.changeImg(7);
      else if (BT_13 ) tipoParticula = 0; 
      else  o_colores.setPalette(7);

      break;  
    case 9:
      if (  brush.isChangeBrush() )  brush.changeImg(8);
      else if (BT_13 ) tipoParticula = 1; 
      else
        if (BT_22 )   bg.changeImg(8);
      else  o_colores.setPalette(8);
      break; 
    case 10:

      if (  brush.isChangeBrush() )  brush.changeImg(9);
      else if (BT_13 ) tipoParticula = 2; 
      else
        if (BT_22 )   bg.changeImg(9);
      else  o_colores.setPalette(9);
      break; 
    case 11:
      if (  brush.isChangeBrush() )  brush.changeImg(10);
      else if (BT_13 ) tipoParticula = 3; 
      else
        if (BT_22 )     bg.changeImg(10);
      else  o_colores.setPalette(10);

      break; 
    case 12:
      if (  brush.isChangeBrush() )  brush.changeImg(11);
      else      if (BT_22 )    bg.changeImg(11);
      else if (BT_13) tipoParticula = 4; 
      else  o_colores.setPalette(11);

      break; 
    case 13:
      if (  brush.isChangeBrush() )  brush.changeImg(12);
      else  
        if (BT_22 )   bg.changeImg(12);
      else if (BT_13 ) tipoParticula = 5; 
      else  o_colores.setPalette(12);

      break; 
    case 14:
      if (BT_22 )   bg.changeImg(13);
      else if (BT_13 ) tipoParticula = 6;
      else  o_colores.setPalette(13);

      break; 
    case 15:
      if (  brush.isChangeBrush() )  brush.changeImg(0);
      else
        if (BT_22 )   bg.changeImg(0);
      else
        o_colores.setPalette(0);
      break; 



    case 23: /* c12 */
      //isSound = !isSound;
      isSound  =  (valor==127) ? true : false;
      sendConsola("MIDI >>  isSound:"+isSound);
      break;
    case 24: /* c12 */
      glow = !glow;
      //isBlur = !isBlur;

      //isBlur  =  (valor==127) ? true : false;

      break;

    case 25: /* c12 */
      brush.listener();
      break;     
    case 46: /* c12 */
      o_colores.setPalette();
      break;
    }
  }
  catch(Exception e) {

    println("***************Exception: "+e.toString()+"\n");
  }
}
/* ------------------------    CONTROLLER IN KONTROL ---------------------------------------------------------*/
void controllerIn_kontrol(int num, int valor) {
  try {

    switch(num) {


      //-----------------------knobs inicio----------------
    case 1: 
      KNOB_1 =  map(valor, 0, 127, 0, 100);
      INC = int(map(valor, 0, 127, 0, INCMAX));
      sendConsola("MIDI >> INC:"+INC+ "valor:" + valor);
      RADIO_TOXI = map(valor, 0, 127, 10, 50);
      sendConsola("MIDI >> RADIO_TOXI:"+RADIO_TOXI);

      break;
    case 2: 
      KNOB_2 =  map(valor, 0, 127, 0, 100);
      RADIO = map(valor, 0, 127, 0, RADIOMAXIM);
      //onionData.setParam1(RADIO, "RADIO", RADIOMAXIM);
      sendConsola("MIDI >> RADIO:"+RADIO);

      break;  
    case 3: 
      KNOB_3 =map(valor, 0, 127, 0, 360);
    
      ATRACCION = map(valor, 0, 127, 0, 900);
      sendConsola("MIDI >> ATRACCIONO:"+ATRACCION);
      break;   
    case 4: 
      KNOB_4 = map(valor, 0, 127, 0, 255);
      sendConsola("MIDI >> KNOB_4:"+KNOB_4);
      break;
    case 5: 
      KNOB_5 = map(valor, 0, 127, 0, 255); 
      DAMPING_POINT=  map(valor, 0, 127, 0.0f, 1.0f);
      SPEEDY =  map(valor, 0, 127, 0, 900);
      sendConsola("MIDI >> DAMPING_POINT:"+DAMPING_POINT);
      break; 
    case 6: 
      KNOB_6= map(valor, 0, 127, 0, 255);
        FADER_2 = map(valor, 0, 127, 0, 200);
      SPEEDX =  map(valor, 0, 127, 0, 900);
       sendConsola("MIDI >> FADER_2:"+FADER_2);
      break;
    case 7:
      KNOB_7= map(valor, 0, 127, 1, 200);
      sendConsola("MIDI >> KNOB_7:"+ KNOB_7);
      break;
    case 8:
      KNOB_8= map(valor, 0, 127, 1, 100);
      sendConsola("MIDI >> KNOB_8:"+ KNOB_8);
      STROKE_ALFA = map(valor, 0, 127, 0, 255);   
      sendConsola("MIDI >> STROKE_ALFAA:"+STROKE_ALFA);
      break;   

      //-----------------------knobs FIN----------------  

      //-----------------------botones ----------------
    case 91:  
      if (valor == 127 ) BT_91=true; 
      else BT_91=false;
      sendConsola("MIDI >> BT_91:"+BT_91);
      break;

    case 92: 

      BT_92  =  (valor==127) ? true : false;
      o_fade.setFade();

      break; 
    case 93:  
      TIPO = 4;
      INTCOLOR=4;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_93  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_93);
      break;
    case 94:  
      TIPO = 5;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_94  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_94);
      break;
    case 95: 
      sendConsola("MIDI >>  TIPO:"+ TIPO); 
      BT_94  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_95);

      break;
    case 96: 
      TIPO = 6;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_96  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_96);

      break;
    case 97: 
      TIPO = 1; 
      INTCOLOR=1;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_97  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_97);

      break;
    case 98: 
      TIPO = 2;
      INTCOLOR=2;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_98  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_98);

      break;
    case 99: 
      TIPO = 3; 
      INTCOLOR=3;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_99  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_99);

      break;
    case 100:  
      BT_100  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_100:"+BT_100);

      break;
    case 101:  
      BT_101  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_101);

      break;

      //-----------------------botones ---------------
    case 11: 
      BT_11  =  (valor==127) ? true : false;
      sendConsola("BT_11 >>  "+BT_11);
      break;
    case 12: 
      BT_12  =  (valor==127) ? true : false;
      sendConsola("BT_12 >>  "+BT_12);
      break;
    case 13: 
      BT_13  =  (valor==127) ? true : false;
      sendConsola("BT_13 >>  "+BT_13);
      break;

    case 21: 
      BT_21  =  (valor==127) ? true : false;
      sendConsola("BT_21 >>  "+BT_21);
      break;
    case 22: 
      BT_22  =  (valor==127) ? true : false;
      sendConsola("BT_22 >>  "+BT_22);
      break;
    case 23: 
      BT_23  =  (valor==127) ? true : false;
      sendConsola("BT_23 >>  "+BT_23);
      break;      

    case 31: 
      BT_31  =  (valor==127) ? true : false;
      sendConsola("BT_31 >>  "+BT_31);
      break;
    case 32: 
      BT_32  =  (valor==127) ? true : false;
      sendConsola("BT_32 >>  "+BT_32);
      break;
    case 33: 
      BT_33  =  (valor==127) ? true : false;
      sendConsola("BT_33 >>  "+BT_33);
      break;      

    case 41: 
      BT_41  =  (valor==127) ? true : false;
      sendConsola("BT_41 >>  "+BT_41);
      break;
    case 42: 
      BT_42  =  (valor==127) ? true : false;
      sendConsola("BT_42 >>  "+BT_42);
      break;
    case 43: 
      BT_43  =  (valor==127) ? true : false;
      sendConsola("BT_43 >>  "+BT_43);
      break;      

    case 51: 
      BT_51  =  (valor==127) ? true : false;
      sendConsola("BT_51 >>  "+BT_51);
      break;
    case 52: 
      BT_52  =  (valor==127) ? true : false;
      sendConsola("BT_52 >>  "+BT_52);
      break;
    case 53: 
      BT_53  =  (valor==127) ? true : false;
      sendConsola("BT_53 >>  "+BT_53);
      break;      

    case 61: 
      BT_61  =  (valor==127) ? true : false;
      sendConsola("BT_41 >>  "+BT_61);
      break;
    case 62: 
      BT_62  =  (valor==127) ? true : false;
      sendConsola("BT_52 >>  "+BT_62);
      break;
    case 63: 
      BT_63  =  (valor==127) ? true : false;
      sendConsola("BT_53 >>  "+BT_63);
      break; 

    case 71: 
      BT_71  =  (valor==127) ? true : false;
      sendConsola("BT_71 >>  "+BT_71);
      break;
    case 72: 
      BT_72  =  (valor==127) ? true : false;
      sendConsola("BT_72 >>  "+BT_72);
      break;
    case 73: 
      BT_73  =  (valor==127) ? true : false;
      sendConsola("BT_73 >>  "+BT_73);
      break; 

    case 81: 

      BT_81  =  (valor==127) ? true : false;
      sendConsola("BT_81 >>  "+BT_81);
      break;
    case 82: 
      BT_82  =  (valor==127) ? true : false;
      sendConsola("BT_82 >>  "+BT_82);
      break;
    case 83: 
      BT_83  =  (valor==127) ? true : false;
      sendConsola("BT_83 >>  "+BT_83);
      break; 





      //-----------------------FADERS ---------------
    case 10: 
      FADER_1 = map(valor, 0, 127, 0, 10);
      //  sendConsola("FADER_1 >>  "+FADER_1);
      SPEED = map(valor, 0, 127, 0, 10);
      // sendConsola("MIDI >> SPEED:"+SPEED);
      FORCE = map(valor, 0, 127, -20, 20);
      sendConsola("MIDI >> FORCE:"+FORCE);
      break;

    case 20: 
     // FADER_2 = map(valor, 0, 127, 0, 255);
      //sendConsola("FADER_2 >>  "+FADER_2);
      break;
    case 30: 
      if ( BT_32) {
        SPEED_FADE = map(valor, 0, 127, 0, 10);
        FADER_31 =  map(valor, 0, 127, 0, 255);
        sendConsola("FADER_31  >> FADER_31:"+FADER_31 );
      } else
      {
        SPEED_FADE = map(valor, 0, 127, 0, 10);
        FADER_3 =  map(valor, 0, 127, 0, 200);
        sendConsola("FADER_3  >> FADER_3:"+FADER_3 );
      }

      break;
    case 40: 

      FADER_4 =  map(valor, 0, 127, 0, 255);
      sendConsola("FADER_4  >> FADER_4:"+FADER_4 );

      break;
    case 50: 
      if ( BT_52 ) {

        FADER_51 =  map(valor, 0, 127, 0, 100);
        sendConsola("FADER_51  >> FADER_51:"+FADER_51 );
      } else
      {
        STRENGTH_POINT =  map(valor, 0, 127, 0f, 5.0f);
        sendConsola("MIDI >>STRENGTH_POINT:"+STRENGTH_POINT);
        FADER_5 =  map(valor, 0, 127, 0, 255);
        sendConsola("FADER_5  >> FADER_5:"+FADER_5 );
      }

      break;
    case 60: 
      FADER_6 =  map(valor, 0, 127, 0, 255);
      SPEED_SHIFT = map(valor, 0, 127, 0, 20);
      sendConsola("FADER_6  >> FADER_6:"+FADER_6 );
      break;

    case 70: 
      if ( BT_72 ) { 
        FADER_71 = map(valor, 0, 127, 0, 200);
        sendConsola("FADER_71  >> FADER_71:"+FADER_71 );
      } else
      {
      }
      FADER_7 = map(valor, 0, 127, 0, 200);
      sendConsola("FADER_7 >>  "+FADER_7);
      VOLUMEN  = map(valor, 0, 127, 1, 900);

      break;
    case 80: 
      ALFA = map(valor, 0, 127, 0, 255);
      sendConsola("MIDI >> alfa:"+ALFA);
      FADER_8 = map(valor, 0, 127, 0, 255);
      sendConsola("FADER_8 >>  "+FADER_8);
      break;
    }
  }
  catch(Exception e) {
    println("***************Exception: "+e.toString()+"\n");
  }
}

