void drawBase() {//drawing a flat, grey box below the model
  pushMatrix();
  translate(0, 500, 0);
  fill(150);
  stroke(0);
  box(700, 5, 700);
  popMatrix();
  noFill();
}
