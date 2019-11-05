class Obstacle {
    float posX;
    int w;
    int h;
    int type;

    Obstacle(int t) {
        posX = width;
        type = t;
        switch(t) {
        case 0:
            w = 40;
            h = 80;
            break;
        case 1:
            w = 60;
            h = 120;
            break;
        case 2:
            w = 120;
            h = 80;
            break;
        }
    }

    void show() {
        fill(0);
        switch(type) {
        case 0:
            image(cactusSmall, posX - cactusSmall.width/2, height - groundHeight - cactusSmall.height);
            break;
        case 1:
            image(bigCactus, posX - bigCactus.width/2, height - groundHeight - bigCactus.height);
            break;
        case 2:
            image(manySmallCacti, posX - manySmallCacti.width/2, height - groundHeight - manySmallCacti.height);
            break;
        }
        //rect(posX, height/2 + 15, cactusSmall.width, cactusSmall.height);
    }

    boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {

        float playerLeft = playerX - playerWidth/2;
        float playerRight = playerX + playerWidth/2;
        float thisLeft = posX - w/2 ;
        float thisRight = posX + w/2;

        if ((playerLeft<= thisRight && playerRight >= thisLeft ) || (thisLeft <= playerRight && thisRight >= playerLeft)) {
            float playerDown = playerY - playerHeight/2;
            float thisUp = h;
            if (-playerDown <= thisUp) {
                return true;
            }
        }
        return false;
    }

    void move(float speed, boolean isDead) {
        if (!isDead) {
            posX -= speed;
        }
    }
}
