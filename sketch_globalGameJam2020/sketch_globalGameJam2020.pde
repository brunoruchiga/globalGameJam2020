boolean mobileBuild = true;
int numberOfPlayers = 1;
//import android.view.MotionEvent;

State state;
Canvas canvas; 
float em; 
Camera camera; 
Time time; 
Game game; 
Controller controller;
Menu menu;
Localization localization;
Save save;
PFont font, fontBig, fontSmall;

void settings() {
  if (mobileBuild) { 
    //fullScreen(P3D);
    fullScreen(P3D);
  } else { 
    //size(360, 640, P3D);
    size(540, 960, P3D);
    //fullScreen(P3D);
  }
}

void setup() {
  orientation(PORTRAIT);
  state = new State();
  state.startAt(state.HOME);
  canvas = new Canvas(9/16.0);
  em = canvas.w/20;
  camera = new Camera(canvas.w/2, canvas.h/2, 1, canvas);
  time = new Time();
  game = new Game();
  controller = new Controller();
  localization = new Localization();
  save = new Save();
  menu = new Menu();

  font = createFont("Roboto-Bold.ttf", em);
  fontBig = createFont("Roboto-Bold.ttf", 2*em);
  fontSmall = createFont("Roboto-Bold.ttf", 0.75*em);

  setupDebug();
}

void draw() {
  time.update();
  time.debug();

  canvas.begin();
  {
    ///////////////////////
    if (state.is(state.SPLASH_SCREEN)) {
    }

    ///////////////////////
    if (state.is(state.HOME)) {
      background(0);

      //fill(255);
      //textAlign(CENTER, CENTER);
      //textFont(fontBig);
      //text(getText("gameName"), canvas.w/2, 3*em);

      menu.update();
    }

    ///////////////////////
    if (state.is(state.CONFIG)) {
    }

    ///////////////////////
    if (state.is(state.GAME)) {
      game.update();
      game.display();
    }

    ///////////////////////
    if (state.is(state.CREDITS)) {
    }
  }
  canvas.end();
  canvas.debug();

  controller.debug();
  controller.clearInputs();
}

//public boolean onTouchEvent (MotionEvent event) {
//  println(event.getPointerCount());
//  println("Hello");
//  return super.onTouchEvent(event);
//}
