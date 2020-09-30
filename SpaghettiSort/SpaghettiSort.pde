float antall = 800, rot = 0, camX, camY, camZ;
Spaghetti[] usortert;
ArrayList<Spaghetti> sortert;
int hand = 0, colorbit = 200;
long starttid;


void setup(){
    //size(800, 800, P3D);
    fullScreen(P3D);
    antall = width/4;
    strokeWeight(4);
    noCursor();
    noSmooth();
    camX = width/2; camY = height/2; camZ = (height/2.0) / tan(PI*30.0 / 180.0);
    Spaghetti[] s = lagSpaghetti();
    usortert = s;
    s[0] = null;
    hand = 0;
    sortert = new ArrayList<Spaghetti>((int)antall);
    tegnSpaghetti(s);
    starttid = System.nanoTime();
    colorMode(HSB, colorbit);
}

void draw(){
    camera(camX, camY, camZ, mouseX, mouseY, 0, 0, 1, 0);
    translate(width/2, 0);
    rotateY(radians(rot));
    rot+= 0.5;
    background(255, 0, 255);
    tegnSpaghetti(usortert);
    tegnHand();
    senkHand();    
    if(sortert.size() == antall-1) setup();
}

void senkHand(){
    hand++;
    stroke(hand%colorbit, 255,255);
    for(int i = 0; i<antall; i++){
        if(usortert[i] != null && height-usortert[i].lengde == hand){
            sortert.add(usortert[i]);
            usortert[i] = null;
        }
    }
}

void tegnHand(){
    line(-(width/2), hand, width/2, hand);
}

void tegnSpaghetti(Spaghetti[] s){
    float x = (width/antall)/2;
    for(Spaghetti spa : sortert){
        stroke(spa.lengde%colorbit, 255,255);
        spa.tegn(x);
        x += width/antall;
    }
    for(Spaghetti spa : s){
        if(spa == null) continue;
        stroke(spa.lengde%colorbit, 255,255);
        spa.tegn(x);
        x += width/antall;
    }
}

Spaghetti[] lagSpaghetti(){
    Spaghetti[] s = new Spaghetti[(int)antall];
    for(int i = 0; i<antall; i++) s[i] = new Spaghetti();
    return s;
}