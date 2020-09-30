char[] styre = {'w','a','s','d'};
boolean[] trykket = new boolean[styre.length];
boolean kollisjonskant = false;

class Spiller{
  float x, y;
  
  float xkraft, ykraft, jetkraft;
  
  int bredde = 30, hoyde = 30, rot;
  
  color farge = color(255,255,200);
  color kant = color(100,100,150);
  color hjelmglass = color(255,215,0);
  
  Tabell tabell;
  
  
  
  boolean dod = false;
  float doEffekt = 2;
  
  boolean jetOsc = true;
  int jetOscTid = 0;
  
  public Spiller(int x, int y){
    this.x = x;
    this.y = y;
    xkraft = 0;
    ykraft = 0;
    jetkraft = 0.002;
    tabell = new Tabell(this);
  }
  
  void tegn(){
    kantpos();
    if(dod){
      if(doEffekt > width*4) {
        ferdig = true;
        textSize(38);
        text("Trykk ENTER, SPACE eller her for å spille igjen", (width/100)*33,height/2);
      }
      noFill();
      stroke(255,0,0);
      strokeWeight(2);
      ellipse(x,y,doEffekt,doEffekt*=1.2);
      return;
    }
    beveg();
    pushMatrix();
    translate(x, y);
    rotate(radians(rot));
    stroke(kant);
    strokeWeight(2);
    fill(farge);
    pushMatrix();
    rotate(radians(45));
    rect(0-(bredde/2)-7,0-(hoyde/2)+20,bredde/4,hoyde/2, 3);
    rotate(radians(270));
    rect(0-(bredde/2)+31,0-(hoyde/2)+20,bredde/4,hoyde/2, 3);
    popMatrix();
    rect(0-(bredde/2)+8,0-(hoyde/2)+28,bredde/4,hoyde/2, 3);
    rect(0-(bredde/2)+15,0-(hoyde/2)+28,bredde/4,hoyde/2, 3);
    rect(0-(bredde/2),0-(hoyde/2),bredde,hoyde, 3);
    ellipse(0,-25,20,20);
    strokeWeight(1);
    stroke(30);
    fill(hjelmglass);
    ellipse(4, -25, 8, 13);
    popMatrix();
    strokeWeight(1);
    stroke(255);
    noFill();
    if(kollisjonskant) ellipse(x,y,60,60);
    flyt();
    tabell.tegn();
  }
  
  
  void kantpos(){
    if(y < 0) y = height;
    else if(y > height) y = 0;
    if(x<0) x = width;
    else if(x > width) {
      if(iBildet.alleMynter) hentPlanet();
      else x =0;
    }
    
  }
  
  void beveg(){
    if(trykket[0]) {
      ykraft-=jetkraft;
      jetOpp();
    }
    if(trykket[1]){
      xkraft-=jetkraft;
      jetVenstre();
    }
    if(trykket[2]) {
      ykraft+=jetkraft;
      jetNed();
    }
    if(trykket[3]) {
      xkraft+=jetkraft;
      jetHoyre();
    }
  }
  
  void flyt(){
    x+=xkraft;
    y+=ykraft;
  }
  
  void tegnJet(int x, int y, boolean hori){
    int jet = (jetOsc)? 20 : 25;
    if(millis()-jetOscTid > 100){
      jetOsc = !jetOsc;
      jetOscTid = millis();
    }
    stroke(130);
    strokeWeight(1);
    fill(170);
    if(hori) ellipse(x, y, jet, 5);
    else ellipse(x, y, 5, jet);
  }
  
  void jetNed(){
    tegnJet((int)x-11, (int)y-15, false);
    tegnJet((int)x+12, (int)y-15, false);
  }
  
  void jetOpp(){
    tegnJet((int)x-11, (int)y+15, false);
    tegnJet((int)x+12, (int)y+15, false);
  }
  
  void jetHoyre(){
    tegnJet((int)x-11, (int)y+12, true);
    tegnJet((int)x-11, (int)y-12, true);
  }
  
  void jetVenstre(){
    tegnJet((int)x+11, (int)y+12, true);
    tegnJet((int)x+11, (int)y-12, true);
  }
}



void keyPressed(){
  for(int i = 0; i<styre.length; i++){
    if(key == styre[i]) trykket[i] = true;
  }
}

void keyReleased(){
  if(key == ENTER || key == RETURN || key == ' ') mouseClicked();
  for(int i = 0; i<styre.length; i++){
    if(key == styre[i]) trykket[i] = false;
  }
  if(key == 'k') kollisjonskant = !kollisjonskant;
}