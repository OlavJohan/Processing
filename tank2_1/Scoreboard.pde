class Scoreboard{
  final float BOOSTBAR = 10;
  
  String navn;
  float xliv;
  float yliv;
  float xscore;
  float yscore;
  float xboost;
  float yboost;
  color farge;
  
  public Scoreboard(String n, float xl, float yl, float xb, float yb, float xs, float ys, color c){
    navn = n;
    xliv = xl;
    yliv = yl;
    xscore = xs;
    yscore = ys;
    xboost = xb;
    yboost = yb;
    farge = c;
  }
  
  void tegn(int liv, float boost, float maksboost, int score){
    textSize(32);
    stroke(farge);
    fill(farge);
    strokeWeight(3);
    text(navn+": "+liv, xliv, yliv);
    rect(xboost, yboost, (boost*100)/maksboost, BOOSTBAR);
    textSize(23);
    text("ANTALL SEIRE:  "+score, xscore, yscore);
  }
}