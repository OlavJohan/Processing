class Pawn extends Brikke{
    int promotionX;
    public Pawn(boolean b){
        super(b, "pawn");
        promotionX = (white) ? 0 : 7;
    }

    void move(Tile t){
        checkEnPassant(t);
        super.move(t);
        if(tile.tallKor == promotionX) promote();
    }

    ArrayList<Tile> getPsudoMoves(){
        pLegalMoves = new ArrayList<Tile>();
        ArrayList<Tile> temp = brett.getAllPawnOptions(tile, white);
        if(temp.size() == 0) return temp;
        if(! temp.get(0).hasBrick()){
            pLegalMoves.add(temp.get(0));
            if((moves < 1) && ! temp.get(1).hasBrick()) pLegalMoves.add(temp.get(1));
        }
        for(int i = 0; i < temp.size(); i++) {
            Tile t = temp.get(i);
            if  ((t.bokstavKor != tile.bokstavKor && t.hasOpponentBrick(white))) pLegalMoves.add(t);
        }
        addEnPassantOptions();
        return pLegalMoves;
    }

    void addEnPassantOptions(){
        int front = tile.tallKor + ((white) ? -1 : 1);
        for(int i = tile.bokstavKor -1; i < tile.bokstavKor + 2; i += 2){
            if(brett.validIndex(i, front) && brett.tiles[i][front].enPassant == totalMoves) pLegalMoves.add(brett.tiles[i][front]);
        }
    }

    void checkEnPassant(Tile t){
        if(tile == null) return;
        int x = tile.bokstavKor, y = tile.tallKor + ((white) ? -2 : 2);
        if(brett.validIndex(x,y) && t == brett.tiles[x][y]){
            Tile eptile = brett.tiles[tile.bokstavKor][tile.tallKor + ((white) ? -1 : 1)];
            eptile.enPassant = totalMoves + 1;
            eptile.enPassantPawn = this;
        }
    }

    void promote(){
        promo = new PromotionMenu(white, tile);
        focus = Mode.PROMO;
    }

    Brikke getCopy(Tile t){
        Pawn ny = new Pawn(white);
        ny.tile = t;
        ny.moves = moves;
        return ny;
    }

}
