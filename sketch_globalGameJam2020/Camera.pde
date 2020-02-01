class Camera {
  PVector pointOfInterest;
  PVector target;
  PVector normalizedFocusPoint;
  Canvas canvas;

  Camera(float x, float y, float zoom, Canvas c) {
    pointOfInterest = new PVector(x, y, zoom);
    target = new PVector(x, y, zoom);
    normalizedFocusPoint = new PVector(0.5, 0.75);
    canvas = c;
  }

  void update() {
    pointOfInterest.lerp(target, 0.1);
  }
  
  void jumpToTarget(float x, float y, float zoom) {
    pointOfInterest.set(x, y, zoom);
  }

  void setPointsOfInterest(PVector[] pointsOfInterest) {
    for (int i = 0; i < pointsOfInterest.length; i++) {
      //TODO
    }
    //target.set(0, 0);
  }

  void begin() {
    pushMatrix();
    translate(canvas.w*normalizedFocusPoint.x, canvas.h*normalizedFocusPoint.y);
    scale(pointOfInterest.z);
    translate(-pointOfInterest.x, -pointOfInterest.y);
  }

  void end() {
    popMatrix();
  }

  boolean canSee(float x, float y, float w, float h) {
    float screenInitialX = pointOfInterest.x - (width * normalizedFocusPoint.x * (1/pointOfInterest.z));
    float screenInitialY = pointOfInterest.y - (height * normalizedFocusPoint.y * (1/pointOfInterest.z));
    float screenFinalX = screenInitialX + width * (1/pointOfInterest.z);
    float screenFinalY = screenInitialY + height * (1/pointOfInterest.z);

    //debug
    //stroke(255, 0, 255);
    //noFill();
    //rect(screenInitialX, screenInitialY, width*(1/pointOfInterest.z)-1, height*(1/pointOfInterest.z)-1);

    return (x+w > screenInitialX &&
            x   < screenFinalX   &&
            y+h > screenInitialY &&
            y   < screenFinalY   );
  }
}
