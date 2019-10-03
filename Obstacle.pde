class Obstacle {
    float posX;
    int w;
    int h;
    int speed = 5;

    Obstacle() {
        posX = width;
        w = 40;
        h = 80;
    }

    void show() {
        fill(0);
        rectMode(CENTER);
        rect(posX, height/2 + h, 50, 50);
    }

    void move() {
        posX -= speed;
    }
}