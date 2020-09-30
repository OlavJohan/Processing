class Rook extends Brikke{

    public Rook(boolean white){
        super(white, "rook");
    }


    ArrayList<Tile> getPsudoMoves(){
        pLegalMoves = new ArrayList<Tile>();
        brett.addAllInLine(1, 0, white, tile, pLegalMoves);
        brett.addAllInLine(0, 1, white, tile, pLegalMoves);
        brett.addAllInLine(-1, 0, white, tile, pLegalMoves);
        brett.addAllInLine(0, -1, white, tile, pLegalMoves);
        return pLegalMoves;
    }

    boolean isRocadableRook(){
        return moves < 1;
    }

    Brikke getCopy(Tile t){
        Rook ny = new Rook(white);
        ny.tile = t;
        ny.moves = moves;
        return ny;
    }

}
