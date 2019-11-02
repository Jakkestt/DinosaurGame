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
        float playerLeft = playerX + playerWidth/2;
        float playerRight = playerX - playerWidth/2;
        float thisLeft = xpos - w/2;
        float thisRight = xpos + w/2;
        rectMode(CENTER);
        rect(playerX, playerY, playerWidth, playerHeight);

        if ((playerLeft <= thisRight && playerRight >= thisLeft ) || (thisLeft <= playerRight && thisRight >= playerLeft)) {
            float playerUp = playerY + playerHeight/2;
            float playerDown = playerY - playerHeight/2;
            float thisUp = ypos + h/2;
            float thisDown = ypos - h/2;
            if (playerDown <= thisUp && playerUp >= thisDown) {
                return true;
            }
        }
        return false;
    }
}