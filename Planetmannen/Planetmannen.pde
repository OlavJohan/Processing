import java.util.ArrayList;
import java.util.HashSet;



public final int ANTALL_STJERNER = 15;

ArrayList<Planet> planeter;
Planet iBildet;
ArrayList<Stjerne> stjerner;
ArrayList<Spiller> spillere;
boolean ferdig;

void settings(){
  //size(1280,720, P3D);
  fullScreen(JAVA2D);
}

void setup(){
  //hint(DISABLE_OPTIMIZED_STROKE); //ta denne på hvis P3D
  ferdig = false;
  planeter = new ArrayList<Planet>();
  stjerner = new ArrayList<Stjerne>();
  spillere = new ArrayList<Spiller>();
  for(int i = 0; i<ANTALL_STJERNER; i++) stjerner.add(new Stjerne());
  
  planeter.add(planet1());
  planeter.add(planet3());
  planeter.add(planet2());
  
  
  planeter.add(sortHull());
  
  
  frameRate(60);
  hentPlanet();
  spillere.add(new Spiller(200,200));
}

void draw(){
  background(0);
  tegnStjerner();  
  tegnPlaneter();
  tegnSpillere(); 
  
}

void tegnPlaneter(){
  iBildet.tegn();
}

void tegnStjerner(){
  for(Stjerne s : stjerner) s.tegn();
}

void tegnSpillere(){
  for(Spiller s : spillere) s.tegn();
}

void mouseClicked(){
  if(ferdig) setup();
}

void hentPlanet(){
  
  iBildet = planeter.remove(0);
}

Planet planet1(){
  Planet p = new Planet(width/2, height/2, 500);
  Mynt[] t = {new Mynt(width/4,height /2, p), new Mynt((width/4)*3,height/2, p), new Mynt(width/2,height/7, p), new Mynt(width/2,(height/7)*6, p)};
  p.mottaMynter( t );
  p.nyTexture(loadImage("p1.png"),color(0,0,0));
  return p;
}

Planet planet2(){
  Planet p = new Planet(width/2, height/2, 700);
  Mynt[] t = {new Mynt(width/4,height /2, p), new Mynt((width/4)*3,height/2, p), new Mynt(width/2,height/7, p), new Mynt(width/2,(height/7)*6, p)};
  p.mottaMynter( t );
  p.setG(1.4);
  p.endreFarge(color(200, 0, 255),color(100));
  p.pol(false);
  p.nyTexture(loadImage("p4.png"),color(0,0,0));
  return p;
}

Planet planet3(){
  Planet p = new Planet(width/2, height/2, 250);
  Mynt[] t = {new Mynt(width/3,height /2, p), new Mynt((width/3)*2,height/2, p), new Mynt(width/2,height/5, p), new Mynt(width/2,(height/5)*4, p)};
  p.mottaMynter( t );
  p.setG(1);
  p.pol(false);
  p.endreFarge(color(0, 255, 150),color(255, 0,0), 3);
  //p.nyMaane(70,510,0.1);
  p.nyEkteMaane((width/2)-(p.storrelse*1.5),(height/2)-(p.storrelse*1.5),50,0.001,-1.15,0.3);
  p.nyTexture(loadImage("p2.png"),color(255,255,255));
  return p;
}

Planet sortHull(){
  Planet p = new Planet(width/2, height/2, 100);
  p.pol(false);
  p.setG(25);
  p.endreFarge(0,0, 3);
  p.fjernAtmos();
  return p;
}





PImage fjernFarge(PImage j, color c){
    PImage ny = createImage(j.width, j.height, ARGB);
    j.loadPixels();
    for(int i = 0; i<j.pixels.length; i++){
      if(j.pixels[i] == c) ny.pixels[i] = color(0,0,0,0);
      else ny.pixels[i] = j.pixels[i];
    }
    ny.updatePixels();
    return ny;
  }