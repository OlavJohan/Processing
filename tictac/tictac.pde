boolean kryss = true;
int[] ruterX = new int[3];
int[] ruterY = new int[3];
boolean[] tatt = new boolean[9];
boolean[] tattAvKryss = new boolean[9];
boolean[] tattAvRunding = new boolean[9];
int restart = 0;
boolean vinner;

void setup(){
  size(800, 800);
  background(255);
  stroke(0);
  strokeWeight(2);
  line(0, height/3, width, height/3);
  line(0, (height/3)+(height/3), width, (height/3)+(height/3));
  line(width/3, height, (width/3), 0);
  line((width/3)+(width/3), height, (width/3)+(width/3), 0);
  vinner = false;
  
  int x = width/6;
  for(int i = 0; i<3; i++){
    ruterX[i] = x;
    x += width/3;
  }
  int y = width/6;
  for(int i = 0; i<3; i++){
    ruterY[i] = y;
    y += width/3;
  }
  for(int i = 0; i<9; i++) { 
    tatt[i] = false; tattAvKryss[i] = false; tattAvRunding[i] = false;
  }
  strokeWeight(1);
  rect(0, 0, 20, 20);
  strokeWeight(2);
  tegnLitePunkt(10, 10);
}

void draw(){
  

}

void mousePressed(){
  if(vinner){
    restart();
  }
  else{
    tegn();
    tegnLitePunkt(10, 10);
  }
}

void tegn(){
  if(mouseX<width/3){
    if(mouseY<height/3){
      if(!tatt[0]) tegnPunkt(ruterX[0], ruterY[0]);
      tatt[0] = true;
      if(kryss) tattAvKryss[0] = true;
      else tattAvRunding[0] = true;
    }else if(mouseY<height/3+height/3){
      if(!tatt[1]) tegnPunkt(ruterX[0], ruterY[1]);
      tatt[1] = true;
      if(kryss) tattAvKryss[1] = true;
      else tattAvRunding[1] = true;
    }else {
      if(!tatt[2]) tegnPunkt(ruterX[0], ruterY[2]);
      tatt[2] = true;
      if(kryss) tattAvKryss[2] = true;
      else tattAvRunding[2] = true;
    }
  }else if(mouseX<width/3+width/3){
    if(mouseY<height/3){
      if(!tatt[3])tegnPunkt(ruterX[1], ruterY[0]);
      tatt[3] = true;
      if(kryss) tattAvKryss[3] = true;
      else tattAvRunding[3] = true;
    }else if(mouseY<height/3+height/3){
      if(!tatt[4])tegnPunkt(ruterX[1], ruterY[1]);
      tatt[4] = true;
      if(kryss) tattAvKryss[4] = true;
      else tattAvRunding[4] = true;
    }else{
      if(!tatt[5])tegnPunkt(ruterX[1], ruterY[2]);
      tatt[5] = true;
      if(kryss) tattAvKryss[5] = true;
      else tattAvRunding[5] = true;
    }
  }else{
    if(mouseY<height/3){
      if(!tatt[6])tegnPunkt(ruterX[2], ruterY[0]);
      tatt[6] = true;
      if(kryss) tattAvKryss[6] = true;
      else tattAvRunding[6] = true;
    }else if(mouseY<height/3+height/3){
      if(!tatt[7])tegnPunkt(ruterX[2], ruterY[1]);
      tatt[7] = true;
      if(kryss) tattAvKryss[7] = true;
      else tattAvRunding[7] = true;
    }else{
      if(!tatt[8])tegnPunkt(ruterX[2], ruterY[2]);
      tatt[8] = true;
      if(kryss) tattAvKryss[8] = true;
      else tattAvRunding[8] = true;
    }
  }
  if(harVunnet(tattAvKryss)){
    skriv("runding vant");
    vinner = true;
  }
  if(harVunnet(tattAvRunding)){
    skriv("kryss vant");
    vinner = true;
  }
  if(ferdig())restart++;
  if(restart >= 2) skriv("trykk en gang til for å restarte");
  if(restart >= 3) restart();
}

void tegnPunkt(int x, int y){
  int s = 20;
  int r = 70;
  point(x, y);
  if(kryss){
    line(x-s, y-s, x+s, y+s);
    line(x+s, y-s, x-s, y+s);
  }else{
    ellipse(x, y, r, r);
  }
  kryss = !kryss;
}

void tegnLitePunkt(int x, int y){
  strokeWeight(1);
  rect(0, 0, 20, 20);
  strokeWeight(2);
  int s = 8;
  int r = 18;
  point(x, y);
  if(kryss){
    line(x-s, y-s, x+s, y+s);
    line(x+s, y-s, x-s, y+s);
  }else{
    ellipse(x, y, r, r);
  }
}

boolean ferdig(){
  boolean retur = true;
  for(boolean b : tatt){
    if(!b) return false;
  }
  return true;
}

void restart(){
  stroke(255);
  strokeWeight(width*height);
  point(width/2, height/2);
  restart = 0;
  setup();
}

void skriv(String s){
  PFont f = createFont("Arial", 30, true);
  textFont(f, 14);
  rect(width/2-100, height/2-40, width/2, height/2-125);
  fill(0);
  text(s, width/2-85, height/2);
  fill(255);
}

boolean harVunnet(boolean[] vinner){
  if(vinner[0] && vinner[3] && vinner[6]) return true;
  if(vinner[1] && vinner[4] && vinner[7]) return true;
  if(vinner[2] && vinner[5] && vinner[8]) return true;
  if(vinner[0] && vinner[1] && vinner[2]) return true;
  if(vinner[3] && vinner[4] && vinner[5]) return true;
  if(vinner[6] && vinner[7] && vinner[8]) return true;
  if(vinner[6] && vinner[4] && vinner[2]) return true;
  if(vinner[0] && vinner[4] && vinner[8]) return true;
  return false;
}