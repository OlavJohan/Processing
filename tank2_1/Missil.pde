class Missil extends Kule{
  Tank tank;
  Tank maal;
  float levetid = 8000;
  float starttid;
  
  public Missil(float x, float y, float rot, color c, Tank tank){
    super(x,y,rot,c,tank);
    this.tank = tank;
    fart = 3;
    starttid = millis();
    storrelse = STORRELSE*2;
  }
  
  void beveg(){
    float avstand = width*height;
    if(maal == null){
      maal = hentMotstander();
    }
    if(x < maal.x) x += fart;
    else x -= fart;
    if(y < maal.y) y+= fart;
    else y-= fart;
    if(millis()-starttid > levetid) forsvinn();
  }
  
  Tank hentMotstander(){
    Tank t = tank;
    while(t == tank) t = tanker[(int)random(tanker.length)];
    if(t.dod) t = hentMotstander();
    return t;
  }
  @Override
  void spillLyd(){
    missilPang.play();
  }
}