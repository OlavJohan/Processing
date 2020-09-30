class Mine extends Kule{
  public Mine(float x, float y, float rot, color c, Tank t){
    super(x,y,rot,c,t);
    this.x=x;
    this.y=y;
    this.rot=rot;
    farge = c;
    fart = 0;
    sprett = false;
    storrelse = 3;
  }
  
  @Override
  void beveg(){}
  
  @Override
  void tegn(){
    stroke(farge);
    fill(farge);
    strokeWeight(storrelse);
    star(x, y, 2, 6, 5); 
    sjekkVeggKollisjon();
  }
 
  
  void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  @Override
  void spillLyd(){
    minePang.play();
  }
}