class Tank{
  final int FART = 8; 
  final int BOOSTFART = 16; 
  final float BOOSTBUFFERTID = 500;
  final float ANTALLBOOST = 500;
  final float BOOSTOEKINTERVALL = 0.2;
  final int SUPERBOOSTFART = 24;
  final int LIV = 5;
  final float BREDDE = 50;
  final float HOYDE = 75;
  final float ROTFART = 5;
  final float SKYTEFORSINKELSE = 500;
  final float TRIKANONSKYTEFORSINKELSE = 250;
  final float ITEMLEVETID = 10000;
  final float SKJOLDLIV = 4;
  final int TRIKANONFART = 2;
  final int ANTALLKULER = 21;
  final int ANTALLMINER = 8;
  float startx, starty, startrot;
  
  String navn;
  int fart;
  int liv;
  int antallVinn = 0;
  float boost;
  float boostTid = 0;
  float boostOekIntervall;
  float skyteforsinkelse;
  color farge;
  float x;
  float y;
  float gx;
  float gy;
  float rot;
  float rotFart;
  float totRot = 0;
  boolean dod = false;
  Scoreboard scoreboard;
 
  boolean trikanon = false;
  boolean skjold = false;
  boolean superboost = false;
  boolean mine = false;
  boolean missil = false;
  float skjoldStarttid = 0;
  float skjoldLiv;
  float trikanonStarttid = 0;
  float superboostStarttid = 0;
  float mineStarttid = 0;
  float missilStarttid = 0;
  
  //Vegg[] vegger;
  Vegg krasjetVegg;
  
  Kanon kanon = new Kanon(this);
  Kule[] kuler = new Kule[ANTALLKULER];
  int kulenr = 0;
  float skytetid = 0;
  
  char[] kontrollere; //opp, hoyre, ned, venstre, skyt, kanonV, kanonH, boost
  boolean[] knappTrykket;
  boolean holdeInneSkyt = false;
  
  public Tank(color rgb, float x, float y, float rot, String kontrollere, Scoreboard s /*Vegg[] v*/){
    fart = FART;
    liv = LIV;
    navn = kontrollere;
    rotFart = ROTFART;
    farge = rgb;
    this.x = x;
    this.y = y;
    this.rot = rot;
    startx = x; starty = y; startrot = rot;
    kontrollerSetup(kontrollere);
    scoreboard = s;
    boost = ANTALLBOOST;
    boostOekIntervall = BOOSTOEKINTERVALL;
    skyteforsinkelse = SKYTEFORSINKELSE;
    skjoldLiv = SKJOLDLIV;
    //vegger = v;
  }
  
  void initTank(){
    x = startx;
    y = starty;
    rot = startrot;
    liv = LIV;
    boost = ANTALLBOOST;
    fart = FART;
    dod = false;
    kanon = new Kanon(this);
    trikanon = false;
    skyteforsinkelse = SKYTEFORSINKELSE;
    skjold = false;
    trikanon = false;
    superboost = false;
    missil = false;
    mine = false;
    skjoldLiv = SKJOLDLIV;
    for(Tank t : tanker){
      for(Kule k : t.kuler){
        try{
          k.forsvinn();
        }catch(Exception e){}
      }
    }
  }
  
  void tegn(){
    if(dod) return;
    lytte();
    veggkollisjon();
    pushMatrix();
    if(x < 1) x = width;
    if(y < 1) y = height;
    translate(x%width,y%height);
    rotate(radians(rot));
    strokeWeight(1);
    stroke(0, 255, 0);
    if(skjold()){
      noFill();
      ellipse(0,0,HOYDE+17,HOYDE+17);
    }
    fill(farge);
    rect(0-BREDDE/2,0-HOYDE/2,BREDDE,HOYDE, 7);
    totRot = (kanon.tegnKanon(rot)+rot)%360;
    popMatrix();
    bevegKuler();
    skjekkKuletreff();
    skrivPoeng();
    sjekkVinner();
    oekBoost();
    haandterItem();
  }
  
  void skyt(){
    if(millis() - skytetid > skyteforsinkelse){
      kuler[kulenr] = nyKule();
      if(!mine)kulenr = (kulenr+1)%kuler.length;
      else kulenr = (kulenr+1)%ANTALLMINER;
      if(trikanon){
        float r = (totRot+15)%360;
        if(r<0) r +=360;
        float s = (totRot-15)%360;
        if(s<0)s+=360;
        kuler[kulenr] = nyKule(r);
        kulenr = (kulenr+1)%kuler.length;
        kuler[kulenr] = nyKule(s);
        kulenr = (kulenr+1)%kuler.length;
      }
      skytetid = millis();
    }
  }
  
  void veggkollisjon(){
    for(Vegg v : vegger) if(v.sjekkKollisjon(x, y)){
      krasjetVegg = v;
      krasjVegg();
    }
  }
  
  void dobbelveggkollisjon(){
    for(Vegg v : vegger) if(v.dobbelKollisjon(x, y, krasjetVegg)){
      krasjetVegg = v;
      krasjDobbelVegg();
    }
  }
  
  void krasjVegg(){
    if(krasjetVegg.horis)y = gy;
    else x = gx;
    //y = gy;
    //x = gx;
    dobbelveggkollisjon();
  }
  
  void krasjDobbelVegg(){
    if(krasjetVegg.horis)y = gy;
    else x = gx;
  }
  
  void haandterItem(){
    if(millis() - trikanonStarttid > ITEMLEVETID){
      trikanon = false;
      skyteforsinkelse = SKYTEFORSINKELSE;
    }
    if(trikanon) skyt();
    if(millis() - skjoldStarttid > ITEMLEVETID){
      skjold = false;
      skjoldLiv = SKJOLDLIV;
    }
    if(millis() - superboostStarttid > ITEMLEVETID){
      fart = FART;
      superboost = false;
    }
    if(!trikanon && superboost) fart = SUPERBOOSTFART;
    if(millis() - mineStarttid > ITEMLEVETID){
      mine = false;
    }
    if(millis() - missilStarttid > ITEMLEVETID){
      missil = false;
    }
  }
  
  void mottaTrikanon(){
    trikanon = true;
    trikanonStarttid = millis();
    mineStarttid = 0;
    missilStarttid = 0;
    skyteforsinkelse = TRIKANONSKYTEFORSINKELSE;
    fart = TRIKANONFART;
  }
  
  void mottaSkjold(){
    skjold = true;
    skjoldStarttid = millis();
  }
  
  void mottaSuperboost(){
    fart = SUPERBOOSTFART;
    superboostStarttid = millis();
    superboost = true;
  }
  
  void mottaMine(){
    mineStarttid = millis();
    trikanonStarttid = 0;
    missilStarttid = 0;
    mine = true;
  }
  
  void mottaMissil(){
    missilStarttid = millis();
    trikanonStarttid = 0;
    mineStarttid = 0;
    missil = true;
  }
  
  void skjekkKuletreff(){
    for(Tank t : tanker){
      for(Kule k : t.kuler){
        try{
          if(kollidert(k.x, k.y, 30) && t != this) bliTruffet(k);
        }catch(Exception e){}
      }
    }
  }
  
  void bliTruffet(Kule k){
    trefflyd.play(1, 2);
    k.forsvinn();
    if(skjold()){
      skjoldLiv--;
      return;
    }
    liv--;
    if(liv == 0) dod = true;
  }
  
  boolean skjold(){
    return skjold && skjoldLiv > 0;
  }
  
  void skrivPoeng(){
    scoreboard.tegn(liv, boost, ANTALLBOOST, antallVinn);
  }
  
  Kule nyKule(){
    if(mine) return new Mine(x,y,totRot,farge,this);
    else if (missil && !trikanon) return new Missil(x,y,totRot,farge,this);
    return new Kule(x,y,totRot,farge,this);
  }
  Kule nyKule(float rot){
    return new Kule(x,y,rot,farge,this);
  }
  
  void bevegKuler(){
    try{
      for(Kule k : kuler){
        k.beveg();
        k.tegn();
      }
    }catch(Exception e){}
  }
  
  boolean kollidert(float x, float y, float avstand){
   if(this.x-x < avstand &&
       this.y-y < avstand &&
       x-this.x < avstand &&
       y-this.y < avstand) return true;
   return false;
 }
 
 void sjekkVinner(){
   for(Tank t : tanker) if(t != this && t.liv > 0) return;
   jegVant();
   vinn.play();
 }
 
 void jegVant(){
   bakgrunn.stop();
   textSize(50);
   stroke(farge);
   fill(255);
   antallVinn++;
   vinner = true;
   text(scoreboard.navn+" VANT!", (width/20)*8, height/2);
   textSize(32);
   text("Trykk ENTER eller museklikk for å starte på nytt", (width/20)*5, (height/3)*2);
 }
 
 void brukBoost(){
   if(boost>0 && !superboost){
     fart = BOOSTFART;
     boost--;
   }
   if(trikanon)fart = TRIKANONFART;
   kjorFrem();
   if(!superboost)fart = FART;
   boostTid = millis();
 }
 
 void oekBoost(){
   if(millis() - boostTid > BOOSTBUFFERTID && boost< ANTALLBOOST) boost += boostOekIntervall;
 }
  
  void lytte(){
    gx = x;
    gy = y;
    if(knappTrykket[7]) brukBoost();
    else if(knappTrykket[0]) kjorFrem();
    if(knappTrykket[1]) rotH();
    if(knappTrykket[2]) kjorBak();
    if(knappTrykket[3]) rotV();
    if(knappTrykket[4] && !holdeInneSkyt){
      skyt();
      holdeInneSkyt = true;
    }
    if(knappTrykket[5]) kanon.rotH();
    if(knappTrykket[6]) kanon.rotV();
  }
  
  
  void keyPressed(){
    for(int i = 0; i<kontrollere.length; i++){
      if(key == kontrollere[i] || key == tilCaps(kontrollere[i])) knappTrykket[i] = true;
    }
  }
  void keyReleased(){
    for(int i = 0; i<kontrollere.length; i++){
      if(key == kontrollere[i] || key == tilCaps(kontrollere[i])) knappTrykket[i] = false;
      if(key == kontrollere[4]) holdeInneSkyt = false;
    }
  }
  
  void kontrollerSetup(String s){
    kontrollere = s.toCharArray();
    knappTrykket = new boolean[kontrollere.length];
  }
  
  public char tilCaps(char c){
    char[] smaa = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','æ','ø','å'};
    char[] stor = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Æ','Ø','Å'};
    int i;
    for(i = 0; i<smaa.length; i++)if(smaa[i] == c) return stor[i];
    for(i = 0; i<stor.length; i++)if(stor[i] == c) return smaa[i];
    return c;
  }
  
  public void kjorFrem(){
    if(trikanon) fart = TRIKANONFART;
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
    x = x%width;
    y = y%height;
  }
  public void kjorBak(){
    if(rot > 90 && rot <= 180){
      y += ((rot-90)/90)*fart;
      x += (abs(((rot-90)/90)-1))*fart;
    }
    if(rot > 180 && rot <= 270) {
      y +=  (abs(((rot-180)/90)-1))*fart;
      x -= ((rot-180)/90)*fart;
    }
    if(rot > 270 && rot <= 359) {
      y -= ((rot-269)/90)*fart;
      x -= (abs(((rot-269)/90)-1))*fart;
    }
    if(rot >= 0 && rot <= 90) {
      y -= (abs((rot/90)-1))*fart;     
      x += (rot/90)*fart;
    }
    x = x%width;
    y = y%height;
  }
  public void rotH(){
    float r = (rot-rotFart)%360;
    if(r<0) r += 360;
    rot = r;
  }
  public void rotV(){
   rot = abs((rot+rotFart)%360);
 }
}