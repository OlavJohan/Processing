class Bishop extends Brikke{

    public Bishop(boolean white){
        super(white, "bishop");
    }

    ArrayList<Tile> getPsudoMoves(){
        pLegalMoves = new ArrayList<Tile>();

        brett.addAllInDiagonal(1, 1, white, tile, pLegalMoves);
        brett.addAllInDiagonal(-1, 1, white, tile, pLegalMoves);
        brett.addAllInDiagonal(-1, -1, white, tile, pLegalMoves);
        brett.addAllInDiagonal(1, -1, white, tile, pLegalMoves);
        return pLegalMoves;
    }

    Brikke getCopy(Tile t){
        Bishop ny = new Bishop(white);
        ny.tile = t;
        ny.moves = moves;
        return ny;
    }

}
