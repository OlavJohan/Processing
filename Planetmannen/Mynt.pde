class Mynt{
  int x,y, storrelse;
  boolean tatt;
  Planet planet;
  color gull = color(255,215,0);
  float rot, rotfart = 0.5;
  boolean opp;
  
  public Mynt(int x, int y, Planet min){
    this.x = x;
    this.y = y;
    storrelse = 23;
    tatt = false;
    planet = min;
    rot = 0;
    opp = false;
  }
  
  void tegn(){
    if(tatt) return;
    stroke(150, 120, 0);
    strokeWeight(2);
    fill(gull);
    //pushMatrix();
    //translate(x,y);
    //rotateY(radians(rot));
    ellipse(x,y,rot,storrelse);
    //popMatrix();
    rotosc();
    kollisjon();
    
  }
  
  void kollisjon(){
    Spiller s = spillere.get(0);
    float xd = x-s.x;
    float yd = y-s.y;
    if ( sqrt((xd*xd)+(yd*yd)) <= (storrelse/2)+30) {
      tatt = true;
      planet.alleTatt();
    }
  }
  
  void rotosc(){
    if(opp){
      rot+= rotfart;
      if(rot >= storrelse) opp = false;
    }else{
      rot -= rotfart;
      if(rot <= 1) opp = true;
    }
  }
  
}