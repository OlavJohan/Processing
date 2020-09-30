class Vegg{
  float KRASJBUFFER = 20;
  float x, y, bredde, lengde;
  boolean horis;
  color f = color(50,50,50);
  float strW = 3;
  Vegg[] kanter;
  
  public Vegg(float x, float y, float bredde, float lengde, boolean h){
    this.x = x;
    this.y = y;
    this.bredde = bredde;
    this.lengde = lengde;
    horis = h;
    if(h) kanter = new Vegg[]{new Vegg(x,y,lengde, h), new Vegg(x+bredde, y, lengde, h)};
    else kanter = new Vegg[]{new Vegg(x,y,bredde, h), new Vegg(x, y+lengde, bredde, h)};
  }
  
  public Vegg(float x, float y, float lengde, boolean h){
    this.x = x;
    this.y = y;
    this.bredde = 0;
    this.lengde = 0;
    if(h) this.lengde = lengde;
    else bredde = lengde;
    horis = !h;
  }
  
  Vegg[] heleVeggen(){ return new Vegg[]{kanter[0], kanter[1], this}; }
  
  void tegn(){
    stroke(f);
    fill(100);
    strokeWeight(strW);
    rect(x,y,bredde,lengde);
  }
  
  boolean sjekkKollisjon(float tx, float ty){
    if(tx > x-KRASJBUFFER && tx < x+bredde+KRASJBUFFER
      && ty > y-KRASJBUFFER && ty < y+lengde+KRASJBUFFER){
        return true;
    }
    return false;
  }
  
  boolean dobbelKollisjon(float tx, float ty, Vegg v){
    if(this != v && tx > x-KRASJBUFFER && tx < x+bredde+KRASJBUFFER
      && ty > y-KRASJBUFFER && ty < y+lengde+KRASJBUFFER){
        return true;
    }
    return false;
  }
}