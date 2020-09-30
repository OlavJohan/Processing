class Galakse{
  int x,y,str, rot;
  
  public Galakse(){
    x = (int)random(0-height, height);
    y = (int)random(0-height, height);
    str = (int)random(20, 50);
    rot =  (int)random(0, 259);
  }
  
  void tegn(){
    pushMatrix();
    translate(x,y);
    rotate(radians(rot));    
    noFill();
    strokeWeight(2);
    int op = 100, s=1;
    for(; op>0; op-=7){
      stroke(160,160,210, op);
      ellipse(0,0,s,s/2);
      s++;
    }
    
    popMatrix();
  }
  
}