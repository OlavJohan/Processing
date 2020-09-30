class EkteMoon{
  int storrelse, avstand;
  float xkraft, ykraft, x, y;
  Gravitasjon g;
  Planet mor;
  PImage texture;
  
  public EkteMoon(float x, float y, int storrelse, float xkraft, float ykraft, float g, Planet m){
    this.x = x;
    this.y = y;
    this.xkraft = xkraft;
    this.ykraft = ykraft;
    this.storrelse = storrelse;
    this.g = new Gravitasjon((int)x,(int)y,g);
    mor = m;
    texture = loadImage("moon.jpg");
    texture.resize(storrelse, storrelse);
    texture = fjernFarge(texture, color(255,255,255));
  }
  
  void tegn(){
    strokeWeight(4);
    stroke(90);
    noFill();
    image(texture, x-(storrelse/2), y-(storrelse/2));
    ellipse(x,y,storrelse,storrelse);
    mor.gravitasjon.trekk(this);
    for(Spiller s : spillere) if(!kollidert(s)) g.oppdater((int)x,(int)y);
    x+=xkraft;
    y+=ykraft;
    morAvstand();
  }
  
  boolean kollidert(Spiller s){
    float xd = x-s.x;
    float yd = y-s.y;
    float dist = sqrt((xd*xd)+(yd*yd));
    if(dist <= (storrelse/2)+30) mor.ekteMoonKoli = true;
    return false;
  }
  
  void morAvstand(){
    float xd = x-mor.x;
    float yd = y-mor.y;
    text(""+sqrt((xd*xd)+(yd*yd)), 10, height-30);
  }
  
  
}