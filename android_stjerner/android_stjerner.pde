import java.util.ArrayList;
ArrayList<Stjerne> stjerner;
ArrayList<Galakse> galakser;

public final int ANTALL_STJERNER = 30;
public final int ANTALL_GALAKSER = 30;

float rot = 0;

void setup(){
  fullScreen(OPENGL);
  //size(500, 1000);
  stjerner = new ArrayList<Stjerne>();
  galakser = new ArrayList<Galakse>();
  for(int i = 0; i<ANTALL_STJERNER; i++) stjerner.add(new Stjerne());
  for(int i = 0; i<ANTALL_GALAKSER; i++) galakser.add(new Galakse());

}

void draw(){
  background(0);
  pushMatrix();
  translate(width/2,height);
  rotate(radians(rot));
  for(Stjerne s : stjerner) s.tegn();
  for(Galakse g : galakser) g.tegn();
  popMatrix();
  rot+=0.005;
  //fill(255);
  //text(frameRate, width/2, height/2);
}