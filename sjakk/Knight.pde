class Knight extends Brikke{

    public Knight(boolean white){
        super(white, "knight");
    }

    ArrayList<Tile> getPsudoMoves(){
        pLegalMoves = brett.getAllKnightOptions(tile, white);
        return pLegalMoves;
    }

    Brikke getCopy(Tile t){
        Knight ny = new Knight(white);
        ny.tile = t;
        ny.moves = moves;
        return ny;
    }

}
