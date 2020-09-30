class Queen extends Brikke{

    public Queen(boolean white){
        super(white, "queen");
    }

    ArrayList<Tile> getPsudoMoves(){
        pLegalMoves = new ArrayList<Tile>();
        brett.addAllInDiagonal(1, 1, white, tile, pLegalMoves);
        brett.addAllInDiagonal(-1, 1, white, tile, pLegalMoves);
        brett.addAllInDiagonal(-1, -1, white, tile, pLegalMoves);
        brett.addAllInDiagonal(1, -1, white, tile, pLegalMoves);
        brett.addAllInLine(1, 0, white, tile, pLegalMoves);
        brett.addAllInLine(0, 1, white, tile, pLegalMoves);
        brett.addAllInLine(-1, 0, white, tile, pLegalMoves);
        brett.addAllInLine(0, -1, white, tile, pLegalMoves);
        return pLegalMoves;
    }

    Brikke getCopy(Tile t){
        Queen ny = new Queen(white);
        ny.tile = t;
        ny.moves = moves;
        return ny;
    }

}
