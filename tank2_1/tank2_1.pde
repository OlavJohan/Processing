import processing.sound.*;
import controlP5.*;
SoundFile skyt;
SoundFile bakgrunn;
SoundFile vinn;
SoundFile itemlyd;
SoundFile livlyd;
SoundFile trefflyd;
SoundFile missilPang;
SoundFile minePang;

Tank[] tanker;

int ANTALLSPILLERE = 2;
final float ITEMSANNSYNLIGHET = 400;
int BANE = 0;

boolean vinner;
boolean nyttSpill = true;
boolean enter = false;

int fargeIndex = 0;
color[] farger = new color[]{color(255, 0, 0), color(0, 100, 255), color(0, 200, 0), color(255, 0, 255), color(255)};

String kntr1 = "wasd qe2";
String kntr2 = "8456079/";
String kntr3 = "pløæ,oå+";
String kntr4 = "";

Liv liv = new Liv();
Mineitem mine = new Mineitem();
Skjold skjold = new Skjold();
Superboost superboost = new Superboost();
Trikanon trikanon = new Trikanon();
Missilitem missil = new Missilitem();
Item[] ting;

Vegg[] vegger;
Vegg[][] baner;
Instillinger in;

void settings(){
  fullScreen(P2D);
  //size(1400, 800, P2D);
}

void setup(){
  surface.setTitle("Tank 2.1");
  skyt = new SoundFile(this, "pang.mp3");
  bakgrunn = new SoundFile(this, "usa.mp3");
  vinn = new SoundFile(this, "champ.mp3");
  itemlyd = new SoundFile(this, "item.mp3");
  livlyd = new SoundFile(this, "liv.mp3");
  trefflyd = new SoundFile(this, "treff.mp3");
  missilPang = new SoundFile(this, "missilPang.mp3");
  minePang = new SoundFile(this, "minePang.mp3");
  //size(1400,800);
  //fullScreen();
  baner = new Vegg[][]{bane0(), bane1(), bane2(), bane3(), bane4(), bane5()};
  vegger = baner[BANE];
  if(nyttSpill) {
    opprettSpillere(ANTALLSPILLERE);
    in = new Instillinger();
  }
  else initTanker();
  nyttSpill = false;
  vinner = false;
  ting = new Item[]{liv, liv, skjold, skjold, skjold, skjold, trikanon, mine, mine, superboost, superboost, superboost, superboost, missil};
  for(Item i : ting) i.forsvinn();
  bakgrunn.loop();
}

void draw(){
  if(vinner){
    if(mousePressed || enter){
      vinn.stop();
      setup();
    }
  }else{
    tegnBakgrunn();
    tegnVegger();
    tegnTanker();
    fiksItems();
    enter = false;
  }
}

void initTanker(){
  for(Tank t : tanker) t.initTank();
}

void fiksItems(){
  int i = (int)random(0, (ting.length));
  if((int)random(0, ITEMSANNSYNLIGHET) == 50) ting[i] = ting[i].nyItem();
  for(Item j : ting) j.tegn();
}

void bliFokus(){
  frame.toFront();
  frame.requestFocus();
}

void opprettSpillere(int ant){
  Scoreboard  sbSpiller1 = new Scoreboard("wasd", 10, 25, 10, 35, 10, 75,farger[fargeIndex]);
  Tank spiller1 = new Tank(farger[fargeIndex++], width/2, height/3, 170, kntr1, sbSpiller1 /*vegger*/);
  fargeIndex = fargeIndex%farger.length;
  Scoreboard sbSpiller2 = new Scoreboard("numpad", width-200, 25, width-200, 35, width-200, 75, farger[fargeIndex]);
  Tank spiller2 = new Tank(farger[fargeIndex++], width/2, (height/3)*2, 350, kntr2, sbSpiller2 /*vegger*/);
  fargeIndex = fargeIndex%farger.length;
  Scoreboard sbSpiller3 = new Scoreboard("pløæ", width-200, height-60, width-200, height-50, width-200, height-10, farger[fargeIndex]);
  Tank spiller3 = new Tank(farger[fargeIndex++], (width/3)*2, height/2, 270, kntr3, sbSpiller3 /*vegger*/);
  fargeIndex = fargeIndex%farger.length;

  Tank[] alle = new Tank[]{spiller1, spiller2, spiller3};
  if(ant >= alle.length) ant = alle.length;
  if(ant < 2) ant = 2;
  tanker = new Tank[ant];
  for(int i = 0; i<ant; i++) {
    i = i%alle.length;
    tanker[i] = alle[i];
  }
}

void tegnBakgrunn(){
  background(0);
}

void tegnTanker(){
  for(Tank t : tanker) t.tegn();
}

void tegnVegger(){
  for(Vegg v : vegger) v.tegn();
}

void keyPressed(){
  if(key == ENTER || key == RETURN) enter = true;
  if(key == '|' || key == '§'){
    in.getSurface().setLocation(width/2, height/2);
    in.getSurface().setVisible(true);
  }
  for(Tank t : tanker) t.keyPressed();
}

void keyReleased(){
  for(Tank t : tanker) t.keyReleased();
}

Vegg[] bane0(){ return new Vegg[]{};}

Vegg[] bane1(){
  Vegg vegg1 = new Vegg(40, height/2, width/4, 40, true);
  Vegg vegg2 = new Vegg(((width/4)*3)-40, height/2, width/4, 40, true);
  return bliTotalvegger(new Vegg[]{vegg1, vegg2});
}

Vegg[] bane2(){
  Vegg vegg1 = new Vegg(0, 0, (width/2)-50, 40, true);
  Vegg vegg2 = new Vegg((width/2)+50, 0, width/2, 40, true);
  Vegg vegg3 = new Vegg(0, height-40, (width/2)-50, 40, true);
  Vegg vegg4 = new Vegg((width/2)+50, height-40, width/2, 40, true);

  Vegg vegg5 = new Vegg(0, 0, 40, (height/2)-50, false);
  Vegg vegg6 = new Vegg(0, (height/2)+50, 40, height/2, false);
  Vegg vegg7 = new Vegg(width-40, 0, 40, (height/2)-50, false);
  Vegg vegg8 = new Vegg(width-40, (height/2)+50, 40, height/2, false);

  return bliTotalvegger(new Vegg[]{vegg1, vegg2, vegg3, vegg4, vegg5, vegg6, vegg7, vegg8});
}

Vegg[] bane3(){
  Vegg vegg1 = new Vegg(0,0,width,1,true);
  Vegg vegg2 = new Vegg(0,height,width,1,true);
  Vegg vegg3 = new Vegg(0,0,0,height,false);
  Vegg vegg4 = new Vegg(width,0,width,height,false);

  return bliTotalvegger(new Vegg[]{vegg1,vegg2,vegg3,vegg4});
}

Vegg[] bane4(){
  Vegg vegg1 = new Vegg(0,0,width,1,true);
  Vegg vegg2 = new Vegg(0,height,width,1,true);
  Vegg vegg3 = new Vegg(0,0,0,height,false);
  Vegg vegg4 = new Vegg(width,0,width,height,false);

  Vegg vegg5 = new Vegg(((width/2)-5)-width/4, ((height/2)-100)-height/4, 10, 200, false);
  Vegg vegg6 = new Vegg(((width/2)-100)-width/4, (height/2)-height/4, 200, 10, true);
  Vegg vegg7 = new Vegg(((width/2)-5)+width/4, ((height/2)-100)+height/4, 10, 200, false);
  Vegg vegg8 = new Vegg(((width/2)-100)+width/4, (height/2)+height/4, 200, 10, true);
  Vegg vegg9 = new Vegg(((width/2)-5), ((height/2)-70), 10, 140, false);
  Vegg vegg10 = new Vegg(((width/2)-70), (height/2), 140, 10, true);

  Vegg vegg11 = new Vegg(width/5, (height/5)*4, 5, 70, false);
  Vegg vegg12 = new Vegg((width/5)-70, (height/5)*4, 5, 70, false);
  Vegg vegg13 = new Vegg((width/5)-70, (height/5)*4, 70, 5, true);

  return bliTotalvegger(new Vegg[]{vegg1,vegg2,vegg3,vegg4,vegg5,vegg6,vegg7,vegg8,vegg9,vegg10, vegg11,vegg12,vegg13});
}

Vegg[] bane5(){
  Vegg vegg1 = new Vegg(width/8, height/8, (width/8)*6, 2, true);
  Vegg vegg2 = new Vegg(width/8, height/8, 2, (height/8)*6, false);
  Vegg vegg3 = new Vegg((width/8)*7, height/8, 2, (height/8)*6, false);
  return bliTotalvegger(new Vegg[]{vegg1,vegg2,vegg3});
}

Vegg[] bliTotalvegger(Vegg[] enkeltVegger){
  Vegg[] totalVegger = new Vegg[0];
  for(Vegg v : enkeltVegger) totalVegger = (Vegg[])concat(totalVegger, v.heleVeggen());
  return totalVegger;
}

void tegnGrid(){
  stroke(0,255,0);
  strokeWeight(1);
  line(width/3, height, width/3, 0);
  line((width/3)*2, height, (width/3)*2, 0);
  line(width, height/3, 0, height/3);
  line(width, (height/3)*2, 0, (height/3)*2);
}
