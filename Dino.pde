class Dino {
    float gravity = 10;
    float speed = 5;
    float xpos = 100;
    float ypos = 0;
    float yvel = 0;
    boolean inAir = false;
    int runCount = -5;

    Dino() {

    }

    void show() {
        push();
        rectMode(CENTER);
        if (runCount < 0) {
            image(dinoRun1, xpos + dinoRun1.width/2, groundHeight + height/2 + (ypos - dinoRun1.height));
        } else {
            image(dinoRun2, xpos + dinoRun2.width/2, groundHeight + height/2 + (ypos - dinoRun2.height));
        }

        runCount++;
        if (runCount == 5) {
            runCount = -5;
        }
        
        pop();
    }

    void jump(boolean isJumping) {
        if (isJumping && !inAir) {
            gravity = 1;
            yvel = 20;
        } else {
            gravity = 1.2;
        }
    } 

    void event() {
        if (keyPressed) {
            if (key == 'w') {
                jump(true);
            } else {
                jump(false);
            }
        }
    }

    void move() {
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

    void update() {
        move();
        event();
    }
}