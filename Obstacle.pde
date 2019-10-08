class Obstacle {
    float posX;
    int w;
    int h;

    Obstacle() {
        posX = width;
        w = 40;
        h = 80;
    }

    void show() {
        fill(0);
        image(cactusSmall, posX, height/2 + 15);
        //rect(posX, height/2 + 15, cactusSmall.width, cactusSmall.height);
    }

    boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
        float playerPosX = playerX + 50 + playerWidth;
        float playerPosY = playerY + height/2 - 15;
        float obstaclePosX = posX + cactusSmall.width/2;
        float obstaclePosY = height/2 + 15;

        //line(playerPosX, playerPosY, obstaclePosX, obstaclePosY);
        if ((playerPosX - obstaclePosX >= -playerWidth && playerPosX - obstaclePosX <= playerWidth)) {
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