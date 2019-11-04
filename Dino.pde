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

    void respawn() {
        dead = false;
        ypos = 0;
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

    boolean returnDead() {
        return dead;
    }

    void update() {
        move();
        event();
    }
}
