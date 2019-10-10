Dino dino;

PImage dinoRun1;
PImage dinoRun2;
PImage cactusSmall;
PImage dinoDead;
PImage dinoJump;
PImage dinoDuck1;
PImage dinoDuck2;
PImage bigCactus;
PImage manySmallCacti;

PFont font;

int groundHeight = 250;
int playerXpos = 150;
int obstacleTime = 0;
int minObsTime = 60;
int randomAddition = 0;
float speed = 4;
int score = 0;
boolean dead = false;

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

void setup() {
    frameRate(60);
    size(1000, 600);
    dinoRun1 = loadImage("dinorun0000.png");
    dinoRun2 = loadImage("dinorun0001.png");
    dinoDead = loadImage("dinoDead0000.png");
    dinoJump = loadImage("dinoJump0000.png");
    dinoDuck1 = loadImage("dinoduck0000.png");
    dinoDuck2 = loadImage("dinoduck0001.png");
    cactusSmall = loadImage("cactusSmall0000.png");
    bigCactus = loadImage("cactusBig0000.png");
    manySmallCacti = loadImage("cactusSmallMany0000.png");
    font = loadFont("RuneScape-UF-48.vlw");
    dino = new Dino();
}

void draw() {
    background(255);
    displayScore();
    dino.show();
    dino.update();
    line(0, groundHeight + 70, width, groundHeight + 70);
    updateObstacle();
    if (dead) {
        respawn();
    }
}

void addObstacle() {
    int tempInt;
    tempInt = floor(random(3));
    Obstacle temp = new Obstacle(tempInt);
    obstacles.add(temp);
    randomAddition = floor(random(60, 120));
}

void moveObstacle() {
    for (int i = 0; i < obstacles.size(); i++) {
        obstacles.get(i).show();
        obstacles.get(i).move(speed, dino.returnDead());
        if (obstacles.get(i).posX < 0) {
            obstacles.remove(i);
            i--;
        }
    }

    speed += 0.02;
}

void updateObstacle() {
    obstacleTime++;
    if (obstacleTime > minObsTime + randomAddition) {
        addObstacle();
        obstacleTime = 0;
    }

    moveObstacle();

}

void respawn() {
    if (dead) {
        if (keyPressed) {
            if (key == 'r') {
                dino.respawn();
                score = 0;
                speed = 4;
                obstacles.clear();
            }
        }
    }
}

void displayScore() {
    dead = dino.returnDead();
    push();
    textFont(font, 32);
    fill(0);
    text(score, 10, 30);
    pop();
    if (!dead) {
        score++;
    }
}