void setupDebug() {
  state.startAt(state.GAME);

  canvas.debug = true;
  //for(Player player : game.p) {
  //  player.debug = true;
  //}

  frameRate(600);
  time.debug = true;
  //controller.debug = true;
  //save.debug = true;
  //localization.debug = true;
}
