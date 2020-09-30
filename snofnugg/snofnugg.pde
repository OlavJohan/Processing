final int ANTALL_FNUGG = 500;
final int ANTALL_STJERNER = 15;
final boolean LAGRE = false;

Fnugg[] fnugg = new Fnugg[ANTALL_FNUGG];
Stjerne stjerner[] = new Stjerne[ANTALL_STJERNER];

void setup(){
  size(1800, 900, P3D);
  for(int i = 0; i<ANTALL_FNUGG; i++){
    fnugg[i] = new Fnugg();
  }
  noSmooth();
  stroke(230, 230, 255);
  for(int i = 0; i<ANTALL_STJERNER; i++) stjerner[i] = new Stjerne();
}

void draw(){
  background(0);
  for(Stjerne s : stjerner) s.tegn();
  for(Fnugg f : fnugg) f.draw();  
  println(frameRate);
  
  if(LAGRE) saveFrame("/imgs/line-######.png");
}
