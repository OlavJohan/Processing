class Planet{
  int x, y, storrelse;
  Gravitasjon gravitasjon;
  color skorpe = color(50, 20, 100);
  int skorpen = 1;
  color lavAtmos = color(0, 100, 200);
  color hoyAtmos = color(0, 120, 255);
  color planetfarge = color(0,90, 200);
  color ytterst = 230;
  color is = 255;
  color iskant = 230;
  int isvekt = 7;
  boolean pol;
  Mynt[] mynter;
  boolean alleMynter = false;
  ArrayList<Moon> maner = new ArrayList<Moon>();
  ArrayList<EkteMoon> eManer = new ArrayList<EkteMoon>();
  boolean ekteMoonKoli = false;
  boolean tex = false;
  PImage texture;
  
  public Planet(int x, int y, int s){
    this.x = x;
    this.y = y;
    storrelse = s;
    gravitasjon = new Gravitasjon(x, y, this);
    mynter = new Mynt[0];
    pol = true;
  }
  
  void tegn(){
    
    for(Mynt m : mynter) m.tegn();
    for(Moon m : maner) m.tegn();
    for(EkteMoon m : eManer) m.tegn();
    if(!tex){
      noFill();
      stroke(ytterst);
      strokeWeight(2);
      ellipse(x,y,storrelse+5,storrelse+5);
      stroke(hoyAtmos);
      strokeWeight(2);
      ellipse(x,y,storrelse+3,storrelse+3);
      stroke(lavAtmos);
      ellipse(x,y,storrelse+1,storrelse+1);
      strokeWeight(skorpen);
      stroke(skorpe);
      fill(planetfarge);
      ellipse(x,y,storrelse, storrelse);
      fill(is);
      stroke(iskant);
      strokeWeight(isvekt);
      if(pol)ellipse(x,y-(storrelse/2)+30,(storrelse/3), storrelse/10);
    }else{
      image(texture, x-(storrelse/2), y-(storrelse/2));
    }
    if(alleMynter) portal();
    
    for(Spiller s : spillere) if(!kollidert(s)) gravitasjon.oppdater(s);
  }
  
  boolean kollidert(Spiller s){
    float xd = x-s.x;
    float yd = y-s.y;
    float dist = sqrt((xd*xd)+(yd*yd));
    if(abs(dist) <= (storrelse/2)+30 || ekteMoonKoli) {
      s.xkraft = 0;
      s.ykraft = 0;
      s.dod = true;
      return true; 
    }
    return false;
  }
  
  void alleTatt(){
    alleMynter = true;
    for(Mynt m : mynter) if(!m.tatt) alleMynter = false;
  }
  
  void mottaMynter(Mynt[] m){
    mynter = m;
  }
  
  void portal(){
     stroke(255,255,0);
     strokeWeight(4);
     line(width-2, 0, width-2, height);
     stroke(255,255,0, 191);
     line(width-4, 0, width-4, height);
     stroke(255,255,0, 127);
     line(width-6, 0, width-6, height);
     stroke(255,255,0, 64);
     line(width-8, 0, width-8, height);
     stroke(255,255,0, 32);
     line(width-10, 0, width-10, height);
  }
  
  void setG(float g){
    gravitasjon.G = g;
  }
  
  void endreFarge(color p, color s){
    planetfarge = p;
    skorpe = s;
  }
  
  void endreFarge(color p, color s, int t){
    planetfarge = p;
    skorpe = s;
    skorpen = t;
  }
  
  void nordpol(color n, color e, int i){
    is = n;
    iskant = e;
    isvekt = i;
  }
  
  void pol(boolean p){
    pol = p;
  }
  
  void nyMaane(int storrelse, int avstand, float rotfart){
    maner.add(new Moon(x,y,storrelse, avstand, rotfart));
  }
  
  void nyEkteMaane(float x, float y, int storrelse, float xkraft, float ykraft, float g){
    eManer.add(new EkteMoon(x,y, storrelse, xkraft, ykraft, g, this));
  }
  
  void nyTexture(PImage p, color c){
    texture = fjernFarge(p,c);
    texture.resize(storrelse, storrelse);
    tex = true;
  }
  
  void fjernAtmos(){
    hoyAtmos = 0;
    lavAtmos = 0;
    skorpe = 0;
    skorpen = 0;
    ytterst = 0;
  }
  
}