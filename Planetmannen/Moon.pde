/*


KREVER P3D
KREVER P3D
KREVER P3D
KREVER P3D
KREVER P3D
KREVER P3D


*/

class Moon{
  Gravitasjon g;
  int x,y, storrelse, avstand, trueX, trueY;
  float rot, rotFart;
  
  public Moon(int x, int y, int storrelse, int avstand, float rotFart){
    this.x = x;
    this.y = y;
    this.storrelse = storrelse;
    this.avstand = avstand;
    this.rotFart = rotFart;
    g = new Gravitasjon(x,y, avstand, 1);
  }
  
  void tegn(){
    pushMatrix();
    translate(x,y);
    rotate(radians(rot));
    strokeWeight(3);
    stroke(150);
    fill(190);
    ellipse(0, avstand, storrelse, storrelse);
    trueX = (int)modelX(0,avstand,0);
    trueY = (int)modelY(0,avstand,0);
    popMatrix();
    g.oppdater(trueX, trueY);
    rot+=rotFart;
  }
}