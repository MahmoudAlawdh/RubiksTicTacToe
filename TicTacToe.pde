import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

bigcube rubiks;
button b;
PGraphicsOpenGL pg;
PeasyCam pcam;
int turn = 1, time,p1win = 0, p2win =0, texts = 100;

void setup()
{
  size(640, 480,P3D);
  cursor(CROSS);
  pg = (PGraphicsOpenGL)createGraphics(width, height, OPENGL);
  pcam = new PeasyCam(this, 150);
  rubiks = new bigcube();
  b = new button(width-60, 10, 50, 30, color(255), width-60, 30, "reset");
}
void t(color c, String s,int w,int h)
{

  textSize(20);
  fill(c);
  text(s,w,h);
}

void draw()
{

  background(0,0,0);
  pointLight(255, 255, 255, pcam.getPosition()[0], pcam.getPosition()[1], pcam.getPosition()[2]);
  rubiks.display();
  pcam.beginHUD();
  b.draw(mouseX,mouseY);

  if(turn == 1 || turn == 2)
  {
    time = (millis() - rubiks.start)/1000;
  }

  t(color(255,0,0),"Player1 : " + p1win ,0,height-10);
  t(color(0,0,255),"Player2 : " + p2win,width-110 , height-10);
  t(color(255,255,255),"Time :"+time, width/30, 30);

  if(turn == 1)
  {
    t(color(255,0,0),"Player " + turn , width/2 - width/10, 30);
  }
  else if(turn == 2)
  {
    t(color(0,0,255),"Player " + turn , width/2 - width/10, 30);
  }
  else if(turn ==3)
  {
    t(color(255,0,0),"Player 1 wins" , width/2 - width/10, 30);
  }
  else if (turn == 4 )
  {
    t(color(255,0,0),"Player 2 wins" , width/2 - width/10, 30);
  }

  pcam.endHUD();
}

void mouseClicked  () {
  if (mouseButton == RIGHT)
  {
    Cube picked = rubiks.pickCube(mouseX, mouseY);
    if (picked != null) {
      if(!picked.alreadypicked)
        {
          picked.player = turn;
          if(turn == 1)
            picked.col = color(255,0,0);
          else if(turn == 2)
            picked.col = color(0,0,255);
          picked.alreadypicked = !picked.alreadypicked;
          if(turn == 1)
          {
            turn = 2;
            turn = rubiks.win(1);
          }
          else if (turn == 2)
          {
            turn = 1;
            turn = rubiks.win(2);
          }
          if(turn == 3)
          {
            p1win = p1win+1;
          }
          else if (turn == 4)
          {
            p2win=p2win+1;
          }
        }
    }
  }
  if(mouseButton == LEFT)
  {
    b.reset(rubiks,mouseX,mouseY);
  }
}

void mouseMoved()
{
  for(Cube t : rubiks.cubes)
  {
    t.highlight = 0;
  }
  Cube picked = rubiks.pickCube(mouseX, mouseY);
  if(picked != null)
  {
    picked.highlight = 200;
  }
}
