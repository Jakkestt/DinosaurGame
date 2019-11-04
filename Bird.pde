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

    void show() {
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

    void move(float speed, boolean dead) {
        if (!dead) {
            xpos -= speed;
        }
    }

    boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {
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
