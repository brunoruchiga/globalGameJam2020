void setupDebug() {

  canvas.debug = true;
  for(Player player : game.p) {
    player.debug = true;
  }

  //time.debug = true; 
  //controller.debug = true;
  save.debug = true;

}
