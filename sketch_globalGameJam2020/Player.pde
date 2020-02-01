class Player {
  PVector initialPos = new PVector();
  PVector pos = new PVector();
  PVector prevPos = new PVector();
  PVector vel = new PVector();
  float w, h;
  Rectangle area;
  boolean debug = false;

  Player(float x, float y) {
    w = em;
    h = em;
    initialPos.set(x - w/2, y - h/2);
    area = new Rectangle(pos.x, pos.y, w, h);
    reset();
  }
  
  void reset() {
    pos.set(initialPos);
    prevPos.set(pos.x, pos.y);
    vel.set(0, 0);
  }

  void update() {
    prevPos.set(pos);
    move();
    pos.add(vel);
    area.update(pos);
  }
  
  void move() {
    float speed = 0.1*em;
    vel.set(controller.direction).mult(speed);
  }

  void display() {
    pushMatrix(); 
    translate(pos.x, pos.y);
    {
      //
    }
    popMatrix();
  }

  void debug() {
    if (debug) {
      pushMatrix(); 
      {
        translate(pos.x, pos.y);
        stroke(0, 0, 255);
        noFill();
        rect(0, 0, w, h);
      }
      popMatrix();
    }
  }
}
