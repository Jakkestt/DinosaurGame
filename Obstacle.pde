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
        rectMode(CENTER);
        image(cactusSmall, posX, height/2 + 15);
    }

    void move(float speed) {
        posX -= speed;
    }
}