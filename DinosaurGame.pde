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
PImage bird1;
PImage bird2;

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
ArrayList<Bird> birds = new ArrayList<Bird>();

void setup() {
    frameRate(60);
    size(1700, 600);
    dinoRun1 = loadImage("data/dinorun0000.png");
    dinoRun2 = loadImage("data/dinorun0001.png");
    dinoDead = loadImage("data/dinoDead0000.png");
    dinoJump = loadImage("data/dinoJump0000.png");
    dinoDuck1 = loadImage("data/dinoduck0000.png");
    dinoDuck2 = loadImage("data/dinoduck0001.png");
    cactusSmall = loadImage("data/cactusSmall0000.png");
    bigCactus = loadImage("data/cactusBig0000.png");
    manySmallCacti = loadImage("data/cactusSmallMany0000.png");
    bird1 = loadImage("data/berd.png");
    bird2 = loadImage("data/berd.png");
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
    if (!dead) {
        if (score > 1000 && random(1) < 0.15) {
            Bird temp = new Bird(tempInt);
            birds.add(temp);
        } else {
            Obstacle temp = new Obstacle(tempInt);
            obstacles.add(temp);
        }
    }
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

    for (int i = 0; i < birds.size(); i++) {
        birds.get(i).show();
        birds.get(i).move(speed, dino.returnDead());
        if (birds.get(i).xpos < 0) {
            birds.remove(i);
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
                birds.clear();
            }
        }
    }
}

void displayScore() {
    dead = dino.returnDead();
    if (!dead) {
        fill(0);
        textFont(font, 32);
        text(score, 10, 30);
        score++;
    } else {
        textFont(font, 50);
        text("You died!", width/4, 100);
        text("You earned " + score + " points.", width/4, 150);
        text("Press R to restart", width/4, 200);
    }
}
