class Tile{
    boolean white, marked;
    color c, m, indicatorColor = color(200, 200, 200);
    Brikke brikke, enPassantPawn;
    float x, y;
    int indicatorSize = 10, bokstavKor, tallKor, enPassant;

    public Tile(boolean b, float x, float y, int boksKor, int tallKor){
        white = b;
        c = (white)? WHITE_TILE : BLACK_TILE;
        m = (white)? MARKED_WHITE_TILE : MARKED_BLACK_TILE;
        this.x = x;
        this.y = y;
        bokstavKor = boksKor;
        this.tallKor = tallKor;
        enPassant = -5;
    }

    void draw(){
        fill(c); stroke(40); strokeWeight(1);
        if(marked) fill(m);
        rect(x, y, rutestorrelse, rutestorrelse);
        if(brikke != null) brikke.draw(marked);
    }

    void place(Brikke b){
        if(brikke != null) brikke.die();
        if(totalMoves == enPassant && b instanceof Pawn) enPassantPawn.die();
        b.move(this);
        marked = false;
        brikke = b;
    }

    boolean mouseOnMe(){
        marked = ((mouseX < x+rutestorrelse && mouseX > x) && (mouseY < y+rutestorrelse && mouseY > y));
        return marked;
    }

    void drawLegalMoveIndicator(){
        if(! showLegalMoves) return;
        int i = (int) (x + (rutestorrelse/2));
        int j = (int) (y + (rutestorrelse/2));
        fill(indicatorColor); stroke(0); strokeWeight(3);
        ellipse(i, j, indicatorSize, indicatorSize);
    }

    void updateBrickPsudoMoves(){
        if(brikke != null && brikke.white == whitesTurn) brikke.setPsudoMoves();
    }

    boolean hasBrick(){
        return brikke != null;
    }

    boolean hasOpponentBrick(boolean white){
        return ( brikke != null && brikke.white != white );
    }

    boolean hasRocadableRook(){
        return brikke != null && brikke.isRocadableRook();
    }

    Tile getCopy(ArrayList<Brikke> hvite, ArrayList<Brikke> svarte){
        Tile ny = new Tile(white, x, y, bokstavKor, tallKor);
        if(brikke != null){
            ny.brikke = brikke.getCopy(ny);
            if(ny.brikke.white) hvite.add(ny.brikke);
            else svarte.add(ny.brikke);
        } // TODO enPassantPawn ikke tatt i betraktning
        return ny;
    }
}
