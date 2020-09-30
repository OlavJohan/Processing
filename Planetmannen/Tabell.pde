class Tabell{
  
  Spiller spiller;
  float fart;
  int f;
  
  public Tabell(Spiller s){
    spiller = s;
  }
  void tegn(){
    textSize(20);
    fart = abs(spiller.xkraft) + abs(spiller.ykraft);
    f = (int) (fart*100);
    text("VEL: "+f, width-120, 20);
    text("FPS: "+(int)frameRate, width-120, 50);
  }
}