// ****OPTIONS****
boolean showLegalMoves = true;
int timerMinutes = 3;
// ***************


final color WHITE_TILE          = color(152, 103, 62),
            BLACK_TILE          = color(91, 68, 62),
            MARKED_WHITE_TILE   = color(142, 93, 52),
            MARKED_BLACK_TILE   = color(101, 78, 72),
            WHITE_BRICK         = color(255),
            BLACK_BRICK         = color(0),
            MARKED_WHITE_BRICK  = color(220),
            MARKED_BLACK_BRICK  = color(35),
            TEXT_COLOR          = color(255);

final int XSTART = 40;
float rutestorrelse, checkSignOpacity = 0;
Brett brett;
Tile marked;
ArrayList<Tile> toMark;
boolean whitesTurn;
int totalMoves, TEXT_SIZE = 22;
PromotionMenu promo;
Mode focus;
Timer[] timers;
void setup() {
    //size(800, 1000);
    size(540, 960);
    //size(1080, 2160);
    //fullScreen();
    rutestorrelse = ((min(width, height))-(XSTART*2))/8;
    TEXT_SIZE = (int)rutestorrelse/5;
    brett = new Brett();
    brett.initBrikker();
    marked = null;
    toMark = new ArrayList<Tile>();
    whitesTurn = true;
    totalMoves = 0;
    focus = Mode.GAME;
    timers = new Timer[]{new Timer(true, timerMinutes), new Timer(false, timerMinutes)};

    //siste i setup
    for(Brikke bri : getList(true)) bri.getPsudoMoves();
}

void draw() {
    switch(focus){
        case GAME:
            background(0);
            brett.draw();
            for (Tile t : toMark) t.drawLegalMoveIndicator();
            break;
        case PROMO:
            promo.draw();
        break;
        case SETTINGS:

        break;
    }
    for(Timer t : timers) t.drawAndUpdate();
    alertCheck();
}

void mouseReleased() {
    switch(focus){
        case GAME:
            Tile t = brett.getClickedTile();
            ArrayList<Tile> old = toMark;
            toMark = new ArrayList<Tile>();
            if ( t == null ) marked = null;
            else if ( old.contains(t)) makeMove(t);
            else markTile(t);
            break;
        case PROMO:
            promo.onClick();

            break;
        case SETTINGS:

            break;
    }
}

void makeMove(Tile t) {
    t.place(marked.brikke);
    marked = null;
    if(brett.checkIfCheck(whitesTurn)) checkSignOpacity = 400;
    whitesTurn = !whitesTurn;
    totalMoves++;
    for(Brikke bri : getList(whitesTurn)) bri.getPsudoMoves();
    for(Timer ti : timers) ti.toggleTurn(whitesTurn);
}

void markTile(Tile t) {
    marked = t;
    marked.updateBrickPsudoMoves();
}

ArrayList<Brikke> getList(boolean white) {
    return brett.getList(white);
}

enum Mode{
    GAME,
    PROMO,
    SETTINGS
}



ArrayList<Tile> getAllMoveTiles(boolean white){
    ArrayList<Tile> moves = new ArrayList<Tile>();
    for(Brikke bri : getList(white)) moves.addAll(bri.pLegalMoves);
    return moves;
}


Tile getKingTile(boolean white){
    ArrayList<Brikke> brs = getList(white);
    println(brs.size());
    for(Brikke sett : brs) if(sett instanceof King) return sett.tile;
    return null;
}

void alertCheck(){
    if(checkSignOpacity > 0){
        pushMatrix();
        if(!whitesTurn){
            translate(width, height);
            rotate(radians(180));
        }
        fill(color(255, 200, 200), checkSignOpacity);
        textFont(brett.font);
        textSize(100);
        textAlign(CENTER, CENTER);
        text("CHECK!", width/2, height/2);
        checkSignOpacity-= 10;
        popMatrix();
    }
}
