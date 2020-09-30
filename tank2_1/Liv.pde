class Liv extends Item{
  public Liv(){super();}
  
  @Override
  void tegn(){
    pushMatrix();
    translate((int)x-49,(int)y-22);
    noStroke();
    fill(255,0,0);
    beginShape();
    vertex(50, 15); 
    bezierVertex(50, -5, 95, 5, 50, 40); 
    vertex(50, 15); 
    bezierVertex(50, -5, 5, 5, 50, 40); 
    endShape();
    popMatrix();
    sjekkKollisjon();
  }
  
  @Override
  void gi(Tank t){ livlyd.play(8); t.liv++;}
  
  @Override
  Item nyItem(){ return new Liv();}
}