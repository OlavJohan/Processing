abstract class Brikke{
    Tile tile;
    color c, s, m, ms;
    ArrayList<Tile> pLegalMoves;
    boolean white;
    int moves = -1;
    PImage texture;
    String name;

    public Brikke(boolean white, String fileroot){
        this.white = white;
        pLegalMoves = new ArrayList<Tile>();
        if(white){
            c = WHITE_BRICK;
            s = BLACK_BRICK;
            m = MARKED_WHITE_BRICK;
            ms = MARKED_BLACK_BRICK;
        }else{
            s = WHITE_BRICK;
            c = BLACK_BRICK;
            ms = MARKED_WHITE_BRICK;
            s = MARKED_BLACK_BRICK;
        }
        String filename = fileroot + ((white) ? "H" : "S") + ".png";
        name = fileroot.replace(fileroot.charAt(0), ((""+fileroot.charAt(0)).toUpperCase().charAt(0)));
        texture = loadImage(filename);
        texture.resize((int)rutestorrelse, (int)rutestorrelse);
        getList(white).add(this);
    }

    void move(Tile t){
        moves++;
        pLegalMoves = new ArrayList<Tile>();
        if(tile != null) tile.brikke = null;
        tile = t;
    }

    void setPsudoMoves(){
        toMark = pLegalMoves;
    }
    abstract ArrayList<Tile> getPsudoMoves();

    void draw(boolean marked){
        float x, y;
        fill(c); stroke(s);
        if(marked) {
            fill(m); stroke(ms);
        }
        drawTexture();
    }

    void drawTexture(){
        float drawX = tile.x;
        float drawY = tile.y;
        if(white){
            image(texture, drawX, drawY);
            return;
        }
        pushMatrix();
        translate(drawX + rutestorrelse, drawY + rutestorrelse);
        rotate(radians(180));
        image(texture, 0, 0);
        popMatrix();
    }

    void die(){
        getList(white).remove(this);
        if(tile != null && tile.brikke == this) tile.brikke = null;
        tile = null;
        println("i died");
    }

    boolean isRocadableRook(){
        return false;
    }

    abstract Brikke getCopy(Tile t);
}
