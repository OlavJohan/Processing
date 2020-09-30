class Stjerne{
  final int ANTALL_PR_STJERNE = 100;
  int[] x,y;
  int lys, str;
  boolean up = false;
  
  public Stjerne(){
    x = new int[ANTALL_PR_STJERNE];
    y = new int[ANTALL_PR_STJERNE];
    for(int i = 0; i<x.length; i++){
      x[i] = (int)random(0, width);
      if(random(0,50) > 4) y[i] = (int)random(0, height);
      else y[i] = (int)random( (height/20)*9, (height/20)*11);
    }
    
    
    
    float ran = random(0, 60);
    if(ran <= 43) str = 1;
    else str = 2;
    
    lys = (int)random(100, 256);
    if(random(0,50) > 25) up = true;
  }
  
  void tegn(){
    stroke(lys, lys, 150);
    strokeWeight(str);
    for(int i = 0; i<x.length; i++) point(x[i],y[i]);
    osc();
  }
  
  void osc(){
    if(up){
      lys++;
      if(lys >= 255){
        lys = 255;
        up = false;
      }
    }else{
      lys--;
      if(lys < 20) up = true;
    }
  }
  
}
