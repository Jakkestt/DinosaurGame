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

    void show() {
        push();
        if (dead == true) {
            image(dinoDead, xpos + dinoDead.width/2, groundHeight + height/2 + (ypos - dinoDead.height));
        } else if (duck && ypos == 0) {
            if (runCount < 0) {
               image(dinoDuck1, xpos + dinoDuck1.width/2, groundHeight + height/2 + (ypos - dinoDuck1.height));
            } else {
                 image(dinoDuck2, xpos + dinoDuck2.width/2, groundHeight + height/2 + (ypos - dinoDuck2.height));
            }
        } else {
            if (ypos == 0) {
                if (runCount < 0) {
                    image(dinoRun1, xpos + dinoRun1.width/2, groundHeight + height/2 + (ypos - dinoRun1.height));
                } else {
                    image(dinoRun2, xpos + dinoRun2.width/2, groundHeight + height/2 + (ypos - dinoRun2.height));
                }
            } else {
                image(dinoJump, xpos + dinoJump.width/2, groundHeight + height/2 + (ypos - dinoJump.height));
            }
        }
        
        rect(xpos, ypos, dinoRun1.width, dinoRun1.height);

        runCount++;
        if (runCount == 5) {
            runCount = -5;
        }

        pop();
    }

    void jump(boolean isJumping) {
        if (isJumping && !inAir && !dead) {
            gravity = 1;
            yvel = 20;
            jump = isJumping;
        } else {
            gravity = 1.2;
        }
    } 

    void event() {
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

    void die(boolean isDead) {
        dead = isDead;       
    }

    void duck(boolean isDucking) {
        if (isDucking) {
            if (ypos != 0) {
                gravity = 3;
            }
            duck = isDucking;
        } else {
            duck = false;
        }
    }

    void move() {
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

        for (int i = 0; i< obstacles.size(); i++) {
            if (obstacles.get(i).collided(xpos, ypos +dinoRun1.height/2, dinoRun1.width/2, dinoRun1.height)) {
                dead = true;
            }
        }
    }

    boolean returnDead() {
        return dead;
    }
    
    void update() {
        move();
        event();
    }
}