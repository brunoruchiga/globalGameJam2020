class Player {
  PVector initialPos = new PVector();
  PVector pos = new PVector();
  PVector prevPos = new PVector();
  float speed;
  PVector vel = new PVector();
  PVector acc = new PVector();
  float w, h;
  //Rectangle area;
  int currentPath;
  boolean debug = false;

  Player(float x, float y) {
    w = em;
    h = em;
    initialPos.set(x, y);
    //area = new Rectangle(pos.x, pos.y, w, h);
    reset();
  }

  void reset() {
    pos.set(initialPos);
    prevPos.set(pos.x, pos.y);
    speed = 0.125*em;
    vel.set(0, -speed);
    acc.set(0, 0);
    currentPath = 0;
  }

  void update() {
    prevPos.set(pos);
    
    checkCollision();
    move();
    vel.add(acc);
    pos.add(vel);
    //area.update(pos);
  }
  
  void checkCollision() {
    //println(game.path.contains(pos.x, pos.y, w/2));
    if(!game.paths.get(currentPath).contains(pos.x, pos.y, w/2)) {
      currentPath++;
      game.paths.add(new Path(currentPath, pos.x, pos.y));
    }
  }

  void move() {
    float rotationAngle = TWO_PI/180;
    if (controller.right) {
      vel.rotate(rotationAngle);
    }
    if (controller.left) {
      vel.rotate(-rotationAngle);
    }
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
        rotate(vel.heading());
        stroke(0, 0, 255);
        strokeWeight(1);
        noFill();
        //rect(-w/2, -h/2, w, h);
        ellipse(0, 0, h, w);
        line(0, 0, w, 0);
      }

      stroke(255);
      strokeWeight(3);
      point(0, 0);
      popMatrix();
    }
  }
}
