Dino dino;
PImage dinoRun1;
PImage dinoRun2;
int groundHeight = 100;
int playerXpos = 150;
int obstacleTime = 0;
int minObsTime = 60;

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

void setup() {
    frameRate(60);
    size(800, 400);
    dinoRun1 = loadImage("dinorun0000.png");
    dinoRun2 = loadImage("dinorun0001.png");
    dino = new Dino();
}

void draw() {
    background(255);
    dino.show();
    dino.update();
    line(0, height/2 + 85, 800, height/2 + 85);
    updateObstacle();
}

void addObstacle() {
    Obstacle temp = new Obstacle();
    obstacles.add(temp);
}

void moveObstacle() {
    for (int i = 0; i < obstacles.size(); i++) {
        obstacles.get(i).show();
        obstacles.get(i).move();
    }
}

void updateObstacle() {
    obstacleTime++;
    if (obstacleTime > minObsTime) {
        addObstacle();
        obstacleTime = 0;
    }

    moveObstacle();

}