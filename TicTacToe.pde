import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
bigcube rubiks;

PGraphicsOpenGL pg;
PeasyCam pcam;
int turn = 1;
int time;
int p1win = 0;
int p2win = 0;
int textc = 100;
void setup() {
  size(640, 480,P3D);
  cursor(CROSS);
  pg = (PGraphicsOpenGL)createGraphics(width, height, OPENGL);
  pcam = new PeasyCam(this, 150);
  rubiks = new bigcube();
}

void draw() {
  background(0,0,0);
  pointLight(255,255,255,pcam.getPosition()[0],pcam.getPosition()[1],pcam.getPosition()[2]);
  rubiks.display();
  pcam.beginHUD();
  textSize(20);
  reset();
  fill(255, 0, 0);
  text("Player1 : "+p1win,0,height-10);
  fill(0,0,255);
  text("Player2 : "+p2win,width-110,height-10);
  if(turn == 1 || turn == 2)
    time = (millis()-rubiks.start)/1000;
  fill(255, 255, 255);
  text("Time :"+time, width/30, 30);
  if(turn == 1)
  {
    fill(255, 0, 0);
    text("Player " + turn , width/2 - width/10, 30);
  }
  else if(turn == 2)
  {
    fill(0,0,255);
    text("Player " + turn , width/2 - width/10, 30);
  }
  else if(turn ==3)
  {
    fill(255, 0, 0);
    text("Player 1 wins" , width/2 - width/10, 30);
  }
  else if (turn == 4 )
  {
    fill(0,0,255);
    text("Player 2 wins" , width/2 - width/10, 30);
  }

  pcam.endHUD();
  }


Cube pickCube(int x, int y) {
  Cube cube = null;
  pg.projection.set(((PGraphicsOpenGL)g).projection);
  pg.camera.set(((PGraphicsOpenGL)g).camera);
  pg.beginDraw();

  pg.noLights();
  pg.noStroke();
  pg.background(255);
  for (int i = 0; i < rubiks.cubes.length; i++)
    rubiks.cubes[i].displayForPicker();
  int c = pg.get(x, y);
  pg.endDraw();
  for (int i = 0; i < rubiks.cubes.length; i++) {
    if (rubiks.cubes[i].pickCol == c) {
      cube = rubiks.cubes[i];
      break;
    }
  }
  return cube;
}


void mouseClicked  () {
  if (mouseButton == RIGHT)
  {
    Cube picked = pickCube(mouseX, mouseY);
      if (picked != null) {
        if(turn == 1)
        {
          if(!picked.alreadypicked)
          {
            picked.player = turn;
            picked.col = color(255,0,0);
            picked.alreadypicked = !picked.alreadypicked;
            turn = 2;
            turn = rubiks.win(1);
            if(turn == 3)
            {
              p1win = p1win+1;
            }
          }
        }
        else if (turn == 2)
        {
          if(!picked.alreadypicked)
          {
            picked.player = turn;
            picked.col = color(0,0,255);
            picked.alreadypicked = !picked.alreadypicked;
            turn = 1;
            turn = rubiks.win(2);
            if(turn ==4)
            {
              p2win=p2win+1;
            }
          }
        }
      }
  }
  if(mouseButton == LEFT)
  {
    if(mouseX > width-60 && mouseY < 30)
    {
        rubiks = new bigcube();
    }
  }
}
void mouseMoved()
{
  textc = 100;
  for(Cube t : rubiks.cubes)
  {
    t.highlight = 0;
  }
  Cube picked = pickCube(mouseX, mouseY);
  if(picked != null)
  {
    picked.highlight = 200;
  }
  if(mouseX > width-60 && mouseY < 30)
  {
    textc  = 255;
  }
}

void reset()
{
  fill(0);
  rect(width-60,10,50,30);
  fill(textc);
  text("reset",width-60,30);

}
