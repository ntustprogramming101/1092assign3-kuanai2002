final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24, life, cabbage, soldier;

//soil
PImage soil0, soil1, soil2, soil3, soil4, soil5;
float soilY = 160;
float soilRange = 320;

//stone
PImage stone1, stone2;
final int stoneCount = 8;
int stoneX = 0;
float stoneY = 0;

//move
int down = 0;
int left = 0;
int right = 0;

//groundhog
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
float groundhogX = 320;
float groundhogY = 80;
float groundhogSpeed = 1;

//soildier
int soldierX = 80;
float soldierY = floor(random(4))*80;
float soldierWidth = 80;
float soldierHeight = 80;
float soldierSpeed;

//cabbage
int cabbageX = floor(random(8))*80;
float cabbageY = floor(random(4))*80;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  life = loadImage("img/life.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  playerHealth = 2;
  soldierSpeed = 5;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, soilY - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		for(int x=0; x<width; x+=80){
      for(float y=soilY; y<soilY+soilRange; y+=80){
        image(soil0, x, y);
      }
      for(float y=soilY+soilRange; y<soilY+(2*soilRange); y+=80){
        image(soil1, x, y);
      }
      for(float y=soilY+(2*soilRange); y<soilY+(3*soilRange); y+=80){
        image(soil2, x, y);
      }
      for(float y=soilY+(3*soilRange); y<soilY+(4*soilRange); y+=80){
        image(soil3, x, y);
      }
      for(float y=soilY+(4*soilRange); y<soilY+(5*soilRange); y+=80){
        image(soil4, x, y);
      }
      for(float y=soilY+(5*soilRange); y<soilY+(6*soilRange); y+=80){
        image(soil5, x, y);
      }
    }
    
      
    //Stone 1
    for(int i=0; i<stoneCount; i++){
        stoneX = i*80;
        stoneY = soilY+i*80;
        image(stone1, stoneX, stoneY);
    }
    
    //Stone 2
    for(int i=0; i<stoneCount; i++){
      if(i==2 || i==6){
      stoneX = i*80;
        for(int j=0; j<stoneCount; j++){
          if(j==0 || j==3 || j==4 || j==7){
            stoneY = soilY+(2*soilRange)+j*80;
            image(stone1, -80+stoneX, stoneY);
            image(stone1, stoneX, stoneY);
          }
        }
      }
    }
    
    for(int i=0; i<stoneCount; i++){
      if(i==0 || i==3 || i==4 || i==7){
      stoneX = i*80;
        for(int j=0; j<stoneCount; j++){
          if(j==2 || j==6){
            stoneY = soilY+(2*soilRange)+j*80;
            image(stone1, stoneX, stoneY-80);
            image(stone1, stoneX, stoneY);
          }
        }
      }
    }
    
    //Stone 3
    for(int i=0; i<stoneCount; i++){
      stoneX = -480+(i*80);
      stoneY = soilY+(6*soilRange)-80-i*80;
      image(stone1, stoneX, stoneY);
      image(stone1, stoneX+80, stoneY);
      image(stone1, stoneX+240, stoneY);
      image(stone1, stoneX+320, stoneY);
      image(stone1, stoneX+480, stoneY);
      image(stone1, stoneX+560, stoneY);
      image(stone1, stoneX+720, stoneY);
      image(stone1, stoneX+800, stoneY);
      image(stone1, stoneX+960, stoneY);
      image(stone1, stoneX+1040, stoneY);
      image(stone2, stoneX+80, stoneY);
      image(stone2, stoneX+320, stoneY);
      image(stone2, stoneX+560, stoneY);
      image(stone2, stoneX+800, stoneY);
      image(stone2, stoneX+1040, stoneY);
      
    }
    
    //cabbage
    if(groundhogX < cabbageX+80 && groundhogX+80 > cabbageX
      && groundhogY < cabbageY+soilY+80 && groundhogY+80 > cabbageY+soilY){
      cabbageX = -80;
      cabbageY = soilY-160;
      playerHealth ++;
    }
     image(cabbage, cabbageX, soilY+cabbageY);
     
    //soldier
      if(groundhogX < soldierX && groundhogX+80 > soldierX-80
      && groundhogY < soldierY+soilY+79 && groundhogY+80 > soldierY+soilY){
        playerHealth --;
        groundhogX = 320;
        groundhogY = 80;
        soilY = 160;
        image(groundhogIdle, 320, 80);
        if(playerHealth == 0){
          gameState = GAME_OVER;
        }
      }
      
      image(soldier, soldierX - 80, soldierY+soilY);
      soldierX += soldierSpeed;
      soldierX %= 640+80;

		// Player
      //no move
      if(down == 0 && left == 0 && right == 0){
        image(groundhogIdle, groundhogX, groundhogY);
      }
      
      //down
      if(down > 0){
        if(down == 1){
          if(soilY >= -1440){
            image(groundhogIdle, groundhogX, groundhogY);
            groundhogSpeed = 1;
          }else{
            groundhogY = groundhogY+80;
            image(groundhogIdle, groundhogX, groundhogY);
            groundhogSpeed = 1;
          }
        }else{
          if(soilY >= -1440){
            image(groundhogDown, groundhogX, groundhogY);
            groundhogSpeed += 1;
            soilY -= 80/14.0;
          }else{
            image(groundhogDown, groundhogX, groundhogY+80/15*groundhogSpeed);
            groundhogSpeed += 1;
          }
        }
        down -= 1;
      }
      
      //left
      if(left > 0){
        if(left == 1){
          groundhogX = groundhogX - 80;
          image(groundhogIdle, groundhogX, groundhogY);
          groundhogSpeed = 1;
        }else{
          image(groundhogLeft, groundhogX-80/15*groundhogSpeed, groundhogY);
          groundhogSpeed += 1;
        }
        left -= 1;
      }
      
      //right
        if(right > 0){
        if(right == 1){
          groundhogX = groundhogX + 80;
          image(groundhogIdle, groundhogX, groundhogY);
          groundhogSpeed = 1;
        }else{
          image(groundhogRight, groundhogX+80/15*groundhogSpeed, groundhogY);
          groundhogSpeed += 1;
        }
        right -= 1;
      }

		// Health UI
    for(int i=0; i<playerHealth; i++){
      image(life, 10+i*70, 10);
    }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
        playerHealth = 2;
          image(groundhogIdle, groundhogX, groundhogY);
          cabbageX = floor(random(8))*80;
          cabbageY = floor(random(4))*80;
          soldierY = floor(random(4))*80;
          soilY = 160;
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  if(down>0 || left>0 || right>0){
    return;
  }
  
  if(key == CODED){
    switch(keyCode){
      case DOWN:
      if(groundhogY < 400){
        down = 15;
      }
      break;
        
      case LEFT:
      if(groundhogX > 0){
        left = 15;
      }
      break;
      
      case RIGHT:
      if(groundhogX < 560){
        right = 15;
      }
      break;
        
    }
  }

  
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
