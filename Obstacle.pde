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
        rect(posX, height/2 + 15, cactusSmall.width, cactusSmall.height);
    }

    boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
        line(playerX, playerY, posX, height/2);
        return false;
    }
    void move(float speed, boolean isDead) {
        if (!isDead) {
            posX -= speed;
        }
    }
}