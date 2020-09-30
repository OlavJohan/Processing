import controlP5.*;

PFont font;

class Instillinger extends PApplet{
  boolean forste = false;
  ControlP5 cp;
  Button b;
  Textfield antallSpillere;
  Textfield bane;
  
  public Instillinger(){
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  
  void settings(){
      size(400,400);
  }
  
  void setup(){
    surface.setTitle("Instillinger");
    cp = new ControlP5(this);
    font = createFont("arial", 20);
    antallSpillere = new Textfield(cp, "Antall Spillere");
    antallSpillere
    .setPosition(20, 20)
      .setSize(200, 40)
        .setFont(font)
          .setFocus(true)
            .setColor(color(255));
     
     
     bane = new Textfield(cp, "Bane");
     bane
    .setPosition(20, 100)
      .setSize(200, 40)
        .setFont(font)
          .setColor(color(255));
          
     b = new Button(cp, "OK");
     b.setPosition(20, 200)
      .setSize(200, 40)
        .setFont(font);
  }
  
  void draw(){
    background(100);
    stroke(0);
    if(b.isPressed()){
      int antals = (int)bliTall(antallSpillere.getText());
      if(ANTALLSPILLERE != antals){
        ANTALLSPILLERE = (int)bliTall(antallSpillere.getText());
        opprettSpillere(ANTALLSPILLERE);
      }
      BANE = (int)bliTall(bane.getText());
      if(BANE >= baner.length) BANE = baner.length-1;
      if(BANE < 0) BANE = 0;
      vegger = baner[BANE];
      //bliFokus();
      this.getSurface().setVisible(false);
      this.getSurface().setLocation(-1000,-1000);
      b = new Button(cp, "OK");
      b.setPosition(20, 200)
      .setSize(200, 40)
        .setFont(font);
    }
  }
  
  float bliTall(String s){
    int i = 0;
    try{
      i = Integer.parseInt(s);
    }catch(Exception e) {}
    return i;
  }
}