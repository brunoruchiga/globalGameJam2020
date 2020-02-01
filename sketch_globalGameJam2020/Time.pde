class Time {
  int prevMillis;
  int deltaMillis;
  float scaleFactor;
  boolean debug;

  Time() {
    prevMillis = 0;
    deltaMillis = 1000/60;
    scaleFactor = 1.0;
  }

  void update() {
    deltaMillis = millis() - prevMillis;
    deltaMillis = min(deltaMillis, 1000/10); //clamp to min of 10fps
    scaleFactor = deltaMillis * 60/1000.0;

    prevMillis = millis();
  }

  void debug() {
    if (debug) {
      println("[Time]", "ScaleFactor: " + scaleFactor, "FrameRate: " + frameRate);
    }
  }
}
