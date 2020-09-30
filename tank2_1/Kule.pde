class Kule{
  final int STORRELSE = 6;
  final int EGENFART = 19;

  float x;
  float y;
  float rot;
  float storrelse;
  color farge;
  float fart;
  boolean sprett;
  boolean forsvinn = false;

  public Kule(float x, float y, float rot, color c, Tank tank){
    this.x=x;
    this.y=y;
    this.rot=rot;
    farge = c;
    fart = EGENFART+tank.fart;
    sprett = true;
    storrelse = STORRELSE;
    if(millis() > 500) spillLyd();
  }

  void tegn(){
    stroke(farge);
    fill(farge);
    strokeWeight(storrelse);
    point(x,y);
    sjekkVeggKollisjon();
  }

  public void beveg(){
    if(rot > 90 && rot <= 180){
      y -= ((rot-90)/90)*fart;
      x -= (abs(((rot-90)/90)-1))*fart;
    }
    if(rot > 180 && rot <= 270) {
      y -=  (abs(((rot-180)/90)-1))*fart;
      x += ((rot-180)/90)*fart;
    }
    if(rot > 270 && rot <= 359) {
      y += ((rot-269)/90)*fart;
      x += (abs(((rot-269)/90)-1))*fart;
    }
    if(rot >= 0 && rot <= 90) {
      y += (abs((rot/90)-1))*fart;
      x -= (rot/90)*fart;
    }
    //kulerGaarRundt();
  }

  public void forsvinn(){
    x = -1000;
    y = -1000;
    rot = 180;
    fart = 0;
    forsvinn = true;
  }

  void sprett(Vegg v){
    if(v.horis)rot += 180 - (rot*2);
    else rot -= (rot*2);
    rot += 360;
    rot = rot%360;
  }

  void sjekkVeggKollisjon(){
    for(Vegg v : vegger) if(v.sjekkKollisjon(x, y) && sprett){
      sprett(v);
      sprett = false;
    }else if(v.sjekkKollisjon(x,y)) forsvinn();
  }

  void kulerGaarRundt(){
    if(x < 0) x += width;
    if(y<0) y+= height;
    x = x%width;
    y = y%height;
    if(forsvinn) forsvinn();
  }

  Kule bliNull(){
    return null;
  }

  void spillLyd(){
    skyt.play(8, 0.4);
  }

}
