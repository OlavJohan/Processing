class Kanon{
  final float BREDDE = 10;
  final float HOYDE = 50;
  final float ROTFART = 3;
  
  float minRot = 0;
  float rotFart;
  Tank minTank;
  
  public Kanon(Tank t){
    rotFart = ROTFART;
    minTank = t;
  }
  
  float tegnKanon(float r){
    rotate(radians(minRot%360));
    rect(0-BREDDE/2,0-5, BREDDE, HOYDE, 13);
    ellipse(0,0,minTank.HOYDE/2,minTank.HOYDE/2);
    return minRot;
  }
  
  public void rotH(){
    float r = (minRot-rotFart)%360;
    if(r<0) r += 360;
    minRot = r;
  }
  public void rotV(){
    minRot = abs((minRot+rotFart)%360);
  }
}