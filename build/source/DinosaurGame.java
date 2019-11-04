import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DinosaurGame extends PApplet {

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

public void setup() {
    frameRate(60);
    
    dinoRun1 = loadImage("dinorun0000.png");
    dinoRun2 = loadImage("dinorun0001.png");
    dinoDead = loadImage("dinoDead0000.png");
    dinoJump = loadImage("dinoJump0000.png");
    dinoDuck1 = loadImage("dinoduck0000.png");
    dinoDuck2 = loadImage("dinoduck0001.png");
    cactusSmall = loadImage("cactusSmall0000.png");
    bigCactus = loadImage("cactusBig0000.png");
    manySmallCacti = loadImage("cactusSmallMany0000.png");
    bird1 = loadImage("berd.png");
    bird2 = loadImage("berd.png");
    font = loadFont("RuneScape-UF-48.vlw");
    dino = new Dino();
}

public void draw() {
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

public void addObstacle() {
    int tempInt;
    tempInt = floor(random(3));
    if (score > 1000 && random(1) < 5) {
        Bird temp = new Bird(tempInt);
        birds.add(temp);
    } else {
        Obstacle temp = new Obstacle(tempInt);
        obstacles.add(temp);
    }
    randomAddition = floor(random(60, 120));
}

public void moveObstacle() {
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

    speed += 0.02f;
}

public void updateObstacle() {
    obstacleTime++;
    if (obstacleTime > minObsTime + randomAddition) {
        addObstacle();
        obstacleTime = 0;
    }

    moveObstacle();

}

public void respawn() {
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

public void displayScore() {
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
class Bird {
    float w = 60;
    float h = 50;
    float xpos;
    float ypos;
    int flapCount = 0;
    int typeOfBird;
    boolean dead;

    Bird(int type) {
        xpos = width;
        typeOfBird = type;
        switch(type) {
        case 0:
            ypos = 10 + h/2;
            break;
        case 1:
            ypos = 100;
            break;
        case 2:
            ypos = 180;
            break;
        }
    }

    public void show() {
        rectMode(CENTER);
        if (flapCount < 0) {
            image(bird1, xpos - bird1.width/2, height - groundHeight - (ypos + bird1.height - 20));
        } else {
            image(bird2, xpos - bird2.width/2, height - groundHeight - (ypos + bird2.height - 20));
        }

        flapCount++;
        if (flapCount > 15) {
            flapCount = -15;
        }
    }

    public void move(float speed, boolean dead) {
        if (!dead) {
            xpos -= speed;
        }
    }

    public boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
        float playerXpos = playerX + 50;
        float playerYpos = playerY + 50;
        float birdXpos = xpos - bird1.width/2 + 50;
        float birdYpos = height - groundHeight - (ypos + bird1.height - 20) + 50;
        //rect(playerXpos, playerYpos, playerWidth, playerHeight);
        //rect(birdXpos, birdYpos, bird1.width, bird1.height);
        //push();
        //fill(0);
        //text(birdYpos, 100, 30);
        //text(playerYpos + playerHeight/2, 100, 60);
        //pop();

        if (birdXpos - playerWidth <= playerXpos && birdXpos + playerWidth >= playerXpos) {
            if (playerYpos + playerHeight/2 >= birdYpos - bird1.height/2 && playerYpos - playerHeight/2 <= birdYpos + bird1.height/2) {
                return true;
            }
        }
        return false;
    }
}
class Dino {
    float gravity = 10;
    float speed = 5;
    float xpos = 100;
    float ypos = 0;
    float yvel = 0;
    boolean inAir = false;
    int runCount = -5;
    boolean dead = false;
    boolean duck = false;
    boolean jump = false;

    Dino() {

    }

    public void show() {
        //rect(playerXpos - dinoDead.width/2, height - groundHeight + (ypos - dinoDead.height), dinoRun1.width, dinoRun1.height);
        if (dead == true) {
            image(dinoDead, playerXpos - dinoDead.width/2, height - groundHeight + (ypos - dinoDead.height));
        } else if (duck && ypos == 0) {
            if (runCount < 0) {
                image(dinoDuck1, playerXpos - dinoDuck1.width/2, height - groundHeight - (ypos + dinoDuck1.height));
            } else {
                image(dinoDuck2, playerXpos - dinoDuck2.width/2, height - groundHeight - (ypos + dinoDuck2.height));
            }
        } else {
            if (ypos == 0) {
                if (runCount < 0) {
                    image(dinoRun1, playerXpos - dinoRun1.width/2, height - groundHeight - (ypos + dinoRun1.height));
                } else {
                    image(dinoRun2, playerXpos - dinoRun2.width/2, height - groundHeight - (ypos + dinoRun2.height));
                }
            } else {
                image(dinoJump, playerXpos - dinoJump.width/2, height - groundHeight + (ypos - dinoJump.height));
            }
        }

        //rect(xpos + 50, ypos + height/2 - 15, dinoRun1.width, dinoRun1.height);

        runCount++;
        if (runCount == 5) {
            runCount = -5;
        }
    }

    public void jump(boolean isJumping) {
        if (isJumping && !inAir && !dead) {
            gravity = 1;
            yvel = 20;
            jump = isJumping;
        } else {
            gravity = 1.2f;
        }
    }

    public void event() {
        if (keyPressed) {
            if (key == 'w') {
                jump(true);
            } else if (key == 's') {
                duck(true);
            } else if (key == 'j') {
                die(true);
            }
        } else {
            duck(false);
        }
    }

    public void die(boolean isDead) {
        dead = isDead;
    }

    public void respawn() {
        dead = false;
        ypos = 0;
    }

    public void duck(boolean isDucking) {
        if (isDucking) {
            if (ypos != 0) {
                gravity = 3;
            }
            duck = isDucking;
        } else {
            duck = false;
        }
    }

    public void move() {
        if (!dead) {
            ypos -= yvel;
            if (ypos < 0) {
                yvel -= gravity;
                inAir = true;
            } else {
                yvel = 0;
                ypos = 0;
                inAir = false;
            }
        }

        for (int i = 0; i < birds.size(); i++) {
            if (duck && ypos == 0) {
                if (birds.get(i).collided(playerXpos - dinoDuck1.width/2, height - groundHeight + (ypos - dinoDuck1.height), dinoDuck1.width, dinoDuck1.height)) {
                    dead = true;
                }
            } else {
                if (birds.get(i).collided(playerXpos - dinoRun1.width/2, height - groundHeight + (ypos - dinoRun1.height), dinoRun1.width, dinoRun1.height)) {
                    dead = true;
                }
            }
        }
    }

    public boolean returnDead() {
        return dead;
    }

    public void update() {
        move();
        event();
    }
}
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

    public void show() {
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

    public boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {

        float playerPosX = playerX + playerWidth;
        float playerPosY = playerY + playerHeight*2;
        float obstaclePosX = posX;
        float obstaclePosY = height/2;

        //line(playerX + playerWidth, playerY + playerHeight*2, posX, height/2);
        if (playerPosX - obstaclePosX >= -playerWidth && playerPosX - obstaclePosX <= playerWidth) {
            float playerDown = playerY - playerHeight/2;
            if (-playerDown <= h) {
                return true;
            }
        }

        return false;
    }

    public void move(float speed, boolean isDead) {
        if (!isDead) {
            posX -= speed;
        }
    }
}
  public void settings() {  size(1000, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DinosaurGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
