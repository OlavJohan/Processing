class PromotionMenu{
    color f, s, elemcol = color(255), elemHovercol = color(200);
    float x, y, sizex, sizey, elemW, elemH, elemXoff, elemYoff, textSize;
    int strokew;
    String fileend;
    Brikke[] brikker;
    Elem[] elems;
    Tile toPlace;
    boolean white;

    public PromotionMenu(boolean white, Tile toPlace){
        x = brett.xStart + (rutestorrelse / 2);
        y = brett.yStart - (rutestorrelse / 2);
        sizex = rutestorrelse * 7;
        sizey = rutestorrelse * 9;
        elemW = sizex - rutestorrelse;
        elemH = sizey / 5;
        elemXoff = rutestorrelse / 2;
        elemYoff = sizey / 10;
        s = 50;
        strokew = 5;
        fileend = (white ? "H" : "S") + ".png";
        brikker = new Brikke[]{new Queen(white), new Knight(white), new Bishop(white), new Rook(white)};
        for(Brikke bri : brikker) getList(bri.white).remove(bri);
        elems = new Elem[4];
        for (int i = 0; i < elems.length; i++){
            elems[i] = new Elem(x + elemXoff, y + elemYoff + (i * elemH), brikker[i]);
        }
        this.toPlace = toPlace;
        textSize = elemH/3;
        this.white = white;
    }


    void draw(){ // queen, knight, rook, bishop
        fill(f);
        stroke(s);
        strokeWeight(strokew);
        pushMatrix();
        if(!white){
            translate(width, height);
            rotate(radians(180));
        }
        rect(x, y, sizex, sizey);
        hoverEffect();
        for (Elem e : elems){
            e.drawElem();
        }
        popMatrix();
    }

    void onClick(){
        for (Elem e : elems){
            if(e.mouseOnMe()) e.click();
            //else e.kill();
        }
    }

    void hoverEffect(){
        for(Elem e : elems){
            if(e.mouseOnMe()) e.fillColor = elemHovercol;
            else e.fillColor = elemcol;
        }
    }

    class Elem{
        float x, y;
        Brikke b;
        color fillColor;

        public Elem(float x, float y, Brikke b){
            this.x = x;
            this.y = y;
            this.b = b;
            fillColor = elemcol;
        }

        void drawElem(){
            fill(fillColor);
            stroke(s);
            strokeWeight(strokew);
            rect(x, y, elemW, elemH);
            fill(0);
            textFont(brett.font);
            textSize(textSize);
            textAlign(CENTER, CENTER);
            text(b.name, x + (elemW/2), y+(elemH/2));
            float imgX = x + (elemW * 0.05), imgY = y + ((elemH - rutestorrelse)/2);
            image(b.texture, imgX, imgY);

        }

        boolean mouseOnMe(){
            if(white) return ((mouseX < x + elemW && mouseX > x) && (mouseY < y + elemH && mouseY > y));
            float mY = height - mouseY;
            return  ((mouseX < x + elemW && mouseX > x) && (mY < y + elemH && mY > y));
        }

        void click(){
            toPlace.place(b);
            getList(b.white).add(b);
            toPlace = null;
            focus = Mode.GAME;
            brett.checkIfCheck(!whitesTurn);
        }

        void kill(){
            b.die();
        }
    }


}
