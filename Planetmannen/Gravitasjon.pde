class Gravitasjon{
  
  float G = 0.8;
  
  float dist = 1;
  
  int x, y, masse, avstand;
  Planet planet;
  
  
  public Gravitasjon(int x, int y, Planet planet){
    this.x = x;
    this.y = y;
    this.planet = planet;
    masse = (int) ((planet.storrelse/2)*(planet.storrelse/2)*PI);
  }
  
  public Gravitasjon(int x, int y, int avstand, float g){
    this.x = x;
    this.y = y;
    this.avstand = avstand;
    G = g;
  }
  
  public Gravitasjon(int x, int y, float g){
    this.x = x;
    this.y = y;
    G = g;
  }
  
  void oppdater(Spiller s){
    if(innenfor(s))trekk(s);
  }
  
  void oppdater(int x, int y){
    this.x = x;
    this.y = y;
    for(Spiller s : spillere) oppdater(s);
  }
  
  
  boolean innenfor(Spiller s){

    float xd = x-s.x;
    float yd = y-s.y;
    dist = sqrt((xd*xd)+(yd*yd));
    return true;
  }
  
  
  void trekk(Spiller s){    
    
    float xk = (((x - s.x)/dist)*G) / 500;
    float yk = (((y - s.y)/dist)*G) / 500;
    
    s.xkraft += (((x - s.x)/dist)*G) / 500;
    s.ykraft += (((y - s.y)/dist)*G) / 500;
  }
  
  void trekk(EkteMoon s){
    float xk = (((x - s.x)/dist)*G) / 500;
    float yk = (((y - s.y)/dist)*G) / 500;
    s.xkraft += (((x - s.x)/dist)*G) / 500;
    s.ykraft += (((y - s.y)/dist)*G) / 500;
  }
  
}