class Brett {
    Tile[][] tiles;
    float xStart = XSTART, yStart, bokstavOffset = TEXT_SIZE*0.7;
    PFont font;
    ArrayList<Brikke> svarte, hvite;

    public Brett() {
        tiles = new Tile[8][8];
        yStart = (height/2)-(rutestorrelse*4);
        boolean white = true;
        float x, y;
        font = createFont("fonts/AUGUSTUS.TTF", TEXT_SIZE);
        svarte = new ArrayList<Brikke>();
        hvite = new ArrayList<Brikke>();

        for (int i = 0; i < 8; i++) {
            for (int j = 0; j<8; j++) {
                x = xStart + (i * rutestorrelse);
                y = yStart + (j * rutestorrelse);
                tiles[i][j] = new Tile(white, x, y, i, j);
                if (j != 7) white = !white;
            }
        }
    }

    void draw() {
        String[] alfabet = {"A", "B", "C", "D", "E", "F", "G", "H"};
        String[] tallfabet = {"1", "2", "3", "4", "5", "6", "7", "8"};
        float alfa1 = yStart - bokstavOffset;
        float alfa2 = yStart + (rutestorrelse * 8) + bokstavOffset;
        float tallfa1 = xStart - bokstavOffset;
        float tallfa2 = xStart + (rutestorrelse * 8) + bokstavOffset;
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j<8; j++) {
                tiles[i][j].draw();
            }
        }

        stroke(TEXT_COLOR);
        fill(TEXT_COLOR);
        textFont(font);
        textSize(TEXT_SIZE);
        textAlign(CENTER, CENTER);
        for (int i = 0; i < alfabet.length; i++) {
            text(alfabet[i], xStart + (rutestorrelse/2) + (i * rutestorrelse), alfa1);
            text(alfabet[i], xStart + (rutestorrelse/2)+ (i * rutestorrelse), alfa2);
            text(tallfabet[7 - i], tallfa1, yStart + (rutestorrelse/2) + (i * rutestorrelse));
            text(tallfabet[7 - i], tallfa2, yStart + (rutestorrelse/2) + (i * rutestorrelse));
        }
    }

    Tile getClickedTile() {
        Tile temp = null;
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j<8; j++) {
                if (tiles[i][j].mouseOnMe() ) temp = tiles[i][j];
            }
        }
        return temp;
    }

    ArrayList<Tile> getAllPawnOptions(Tile t, boolean white) {
        ArrayList<Tile> result = new ArrayList<Tile>();
        int mp = (white) ? -1 : 1;
        addIfValid(result, t.bokstavKor, t.tallKor + (1 * mp));
        addIfValid(result, t.bokstavKor, t.tallKor + (2 * mp));
        addIfValid(result, t.bokstavKor + 1, t.tallKor + (1 * mp));
        addIfValid(result, t.bokstavKor - 1, t.tallKor + (1 * mp));
        return result;
    }

    void addIfValid(ArrayList<Tile> result, int x, int y) {
        if (x < 8 && x > -1 && y < 8 && y > -1) result.add(tiles[x][y]);
    }

    void addAllInLine(int addX, int addY, boolean white, Tile t, ArrayList<Tile> list) {
        int x = t.bokstavKor + addX;
        int y = t.tallKor + addY;
        while (true) {
            boolean stopNext = false;
            if (!(x < 8 && x > -1 && y < 8 && y > -1)) return;
            if ( tiles[x][y].brikke != null && tiles[x][y].brikke.white == white ) return;
            if ( tiles[x][y].brikke != null && tiles[x][y].brikke.white != white ) stopNext = true;
            list.add(tiles[x][y]);
            if (stopNext) return;
            x += addX;
            y += addY;
        }
    }

    void addAllInDiagonal(int mulX, int mulY, boolean white, Tile t, ArrayList<Tile> list) {
        int x = t.bokstavKor + (1 * mulX);
        int y = t.tallKor + (1 * mulY);
        while (true) {
            boolean stopNext = false;
            if (!(x < 8 && x > -1 && y < 8 && y > -1)) return;
            if ( tiles[x][y].brikke != null && tiles[x][y].brikke.white == white ) return;
            if ( tiles[x][y].brikke != null && tiles[x][y].brikke.white != white ) stopNext = true;
            list.add(tiles[x][y]);
            if (stopNext) return;
            x += + (1 * mulX);
            y += (1 * mulY);
        }
    }

    ArrayList<Tile> getAllKnightOptions(Tile t, boolean white) {
        int x = t.bokstavKor, y = t.tallKor;
        ArrayList<Tile> opts = new ArrayList<Tile>();
        addIfValid(opts, x-2, y+1);
        addIfValid(opts, x-2, y-1);
        addIfValid(opts, x-1, y-2);
        addIfValid(opts, x+1, y-2);
        addIfValid(opts, x+2, y-1);
        addIfValid(opts, x+2, y+1);
        addIfValid(opts, x+1, y+2);
        addIfValid(opts, x-1, y+2);
        for (int i = 0; i < opts.size(); i++) if (opts.get(i).hasOpponentBrick(!white)) {
            opts.remove(i);
            i--;
        }
        return opts;
    }

    ArrayList<Tile> getAllKingOptions(Tile t, boolean white) {
        int x = t.bokstavKor, y = t.tallKor;
        ArrayList<Tile> opts = new ArrayList<Tile>();
        for (int i = x - 1; i < x + 2; i++) {
            for (int j = y - 1; j < y + 2; j++) {
                addIfValid(opts, i, j);
            }
        }
        for (int i = 0; i < opts.size(); i++) if (opts.get(i).hasOpponentBrick(!white)) {
            opts.remove(i);
            i--;
        }
        return opts;
    }

    boolean validIndex(int x, int y) {
        return (x < 8 && x > -1 && y < 8 && y > -1);
    }

    boolean checkIfCheck(boolean turn){
        for(Brikke bri : getList(turn)) bri.getPsudoMoves();
        Tile opponentKingsTile = getKingTile(!whitesTurn);
        ArrayList<Tile> moves = getAllMoveTiles(whitesTurn);
        if(moves.contains(opponentKingsTile)) return true;
        return false;
    }

    ArrayList<Brikke> getList(boolean b){
        return (b) ? hvite : svarte;
    }

    void initBrikker() {
        initPawns();
        initRooks();
        initKnights();
        initBishops();
        initRoyales();
    }

    void initPawns() {
        for ( int i = 0; i < 8; i++ ) {
            tiles[i][6].place(new Pawn(true));
            tiles[i][1].place(new Pawn(false));
        }
    }

    void initRooks() {
        tiles[0][7].place(new Rook(true));
        tiles[7][7].place(new Rook(true));
        tiles[0][0].place(new Rook(false));
        tiles[7][0].place(new Rook(false));
    }

    void initKnights() {
        tiles[1][7].place(new Knight(true));
        tiles[6][7].place(new Knight(true));
        tiles[1][0].place(new Knight(false));
        tiles[6][0].place(new Knight(false));
    }

    void initBishops() {
        tiles[2][7].place(new Bishop(true));
        tiles[5][7].place(new Bishop(true));
        tiles[2][0].place(new Bishop(false));
        tiles[5][0].place(new Bishop(false));
    }

    void initRoyales() {
        tiles[3][7].place(new Queen(true));
        tiles[4][7].place(new King(true));
        tiles[3][0].place(new Queen(false));
        tiles[4][0].place(new King(false));
    }

    Brett getCopy(){
        Brett ny = new Brett();
        for(int i = 0; i < tiles.length; i++){
            for(int j = 0; j<tiles[0].length; j++){
                ny.tiles[i][j] = tiles[i][j].getCopy(hvite, svarte);
            }
        }
        return ny;
    }
}
