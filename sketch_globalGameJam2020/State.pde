class State {
  int current;
  int initial;

  // Constants
  int SPLASH_SCREEN = 0;
  int HOME = 1;
  int CONFIG = 2;
  int GAME = 3;
  int CREDITS = 4;

  void startAt(int state) {
    current = state;
    initial = state;
  }

  void goTo(int state) {
    current = state;
  }

  void next() {
    current++;
  }

  void previous() {
    current--;
  }

  void reset() {
    current = initial;
  }

  boolean is(int state) {
    return state == current;
  }
}
