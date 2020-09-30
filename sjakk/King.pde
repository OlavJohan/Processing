class King extends Brikke{

    RocadeMove rocademoves[];

    public King(boolean white){
        super(white, "king");
        rocademoves = new RocadeMove[2];
    }

    ArrayList<Tile> getPsudoMoves(){
        pLegalMoves = brett.getAllKingOptions(tile, white);
        addRocadeOptions();
        return pLegalMoves;
    }

    void move(Tile t){
        super.move(t);
        if(moves == 1){
            for(RocadeMove r : rocademoves){
                if(r != null && r.kings == t) r.t.place(r.b);
            }
            rocademoves = null;
        }
    }

    void addRocadeOptions(){
        addKingsRocade();
        addQueensRocade();
    }

    void addKingsRocade(){
        if(moves > 0) return;
        int x = tile.bokstavKor, y = tile.tallKor;
        if(brett.tiles[x + 1][y].hasBrick() || brett.tiles[x + 2][y].hasBrick()) return;
        if(brett.tiles[x + 3][y].hasRocadableRook()){
            Tile kingDst = brett.tiles[x + 2][y], rdst = brett.tiles[x + 1][y];
            pLegalMoves.add(kingDst);
            rocademoves[0] = new RocadeMove(rdst, brett.tiles[x + 3][y].brikke, kingDst);
        }
    }

    void addQueensRocade(){
        if(moves > 0) return;
        int x = tile.bokstavKor, y = tile.tallKor;
        if(brett.tiles[x - 1][y].hasBrick() || brett.tiles[x - 2][y].hasBrick() || brett.tiles[x - 3][y].hasBrick()) return;
        if(brett.tiles[x - 4][y].hasRocadableRook()){
            Tile kingDst = brett.tiles[x - 2][y], rdst = brett.tiles[x - 1][y];
            pLegalMoves.add(kingDst);
            rocademoves[0] = new RocadeMove(rdst, brett.tiles[x - 4][y].brikke, kingDst);
        }
    }

    Brikke getCopy(Tile t){
        King ny = new King(white);
        ny.tile = t;
        ny.moves = moves;
        return ny;
    }

}
