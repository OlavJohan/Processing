class Item{
  float x;
  float y;
  float starttid;
  float levetid;
  int storrelse = 15;
  float[]f = new float[3];
  boolean[] opp  = new boolean[3];
  
  public Item(){
    x = random(10, width-10);
    y = random(10, height-10);
    starttid = millis();
    levetid = random(8000, 12000);
    f[0] = 40; f[2] = 170; f[2] =254;
    for(boolean b : opp) b = true;
  }
  
  void tegn(){
    f[0] = oppOgNed(f[0], 0); f[1] = oppOgNed(f[1], 1); f[2] = oppOgNed(f[2], 2);
    fill(f[0], f[2], f[2]);
    stroke(f[0], f[2], f[2]);
    ellipse(x, y, storrelse, storrelse);
    sjekkKollisjon();
  }
  
  void forsvinn(){
    x = -1000;
    y = -1000;
  }
  
  void sjekkKollisjon(){
    for(Tank t : tanker) if(t.kollidert(x,y,40)){
      forsvinn();
      //println(this);
      gi(t);
    }
  }
  
  void gi(Tank t){itemlyd.play(3);}
  
  float oppOgNed(float f, int i){
    if(opp[i]) f+=3;
    else f-=3;
    if(f >= 255) opp[i] = false;
    if(f <= 0) opp[i] = true;
    
    return f;
  }
  
  Item nyItem(){ return new Item();}
  
  String toString() { return getClass().getName();}
}