class Item {
  PVector pos;
  float r;
  float pickedTimer = 0;
  boolean active;

  Item(float x, float y) {
    pos = new PVector(x, y);
    r = 0.5*em;
    active = true;
  }

  void collect() {
    active = false;
    pickedTimer = 500;
  }
  void display() {
    //update
    pickedTimer = pickedTimer - time.deltaMillis;

    pushMatrix(); 
    {
      translate(pos.x, pos.y, 15);

      if (active) {

        float size = r*2 + 0.33*r*(sin(millis()*0.01));
        float ringSize = r*2 + 0.33*r*(sin((millis()*0.01)+PI)) + 0.4*em;

        stroke(cyan);
        strokeWeight(0.15*em);
        noFill();
        ellipse(0, 0, ringSize, ringSize);

        fill(cyan);
        noStroke();
        ellipse(0, 0, size, size);
      }


      if (pickedTimer > 0 && pickedTimer < 500) {
        stroke(cyan);
        strokeWeight(0.3*em);
        noFill();
        ellipse(0, 0, (pickedTimer/500)*3*em, (pickedTimer/500)*3*em);
      }
    }
    popMatrix();
  }
}
