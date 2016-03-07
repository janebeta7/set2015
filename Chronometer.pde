// Simple class to compute frames-per-second.
class Chronometer
{
  Chronometer()
  {
    lastmillis = 0;
    fcount = 0;  
    interval = 1;
    updated = false;
  }

  Chronometer(int t)
  {
    lastmillis = 0;
    fcount = 0;  
    interval = t;
    updated = false;
  }  

  void update()
  {
    fcount++;      
    int t = millis();
    if (t - lastmillis > interval * 10000)
    {
      fps = float(fcount) / interval;
      time = float(t) / 1000;
      fcount = 0;
      lastmillis = t;
      updated = true;
    }
    else updated = false;
  }

  void printfps()
  {
    //if (updated) println("FPS: " + fps);
  }

  int fcount;
  int lastmillis;
  int interval;
  float fps;
  float time;
  boolean updated;
}

