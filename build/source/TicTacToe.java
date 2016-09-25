import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.test.*; 
import peasy.org.apache.commons.math.*; 
import peasy.*; 
import peasy.org.apache.commons.math.geometry.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TicTacToe extends PApplet {






bigcube rubiks;
button b;
PGraphicsOpenGL pg;
PeasyCam pcam;
int turn = 1, time,p1win = 0, p2win =0, texts = 100;

public void setup()
{
  
  cursor(CROSS);
  pg = (PGraphicsOpenGL)createGraphics(width, height, OPENGL);
  pcam = new PeasyCam(this, 150);
  rubiks = new bigcube();
  b = new button(width-60, 10, 50, 30, color(255), width-60, 30, "reset");
}
public void t(int c, String s,int w,int h)
{
  textSize(20);
  fill(c);
  text(s,w,h);
}
public void draw()
{
  background(0,0,0);
  pointLight(255, 255, 255, pcam.getPosition()[0], pcam.getPosition()[1], pcam.getPosition()[2]);
  rubiks.display();
  pcam.beginHUD();
  b.draw(mouseX,mouseY);
  textSize(20);
  if(turn == 1 || turn == 2)
  {
    time = (millis() - rubiks.start)/1000;
  }
  t(color(255,0,0),"Player1 : " + p1win ,0,height-10);
  t(color(0,0,255),"Player2 : " + p2win,width-110 , height-10);
  t(color(255,255,255),"Time :"+time, width/30, 30);

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


public Cube pickCube(int x, int y) {
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

public void mouseClicked  () {
  if (mouseButton == RIGHT)
  {
    Cube picked = pickCube(mouseX, mouseY);
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

public void mouseMoved()
{
  for(Cube t : rubiks.cubes)
  {
    t.highlight = 0;
  }
  Cube picked = pickCube(mouseX, mouseY);
  if(picked != null)
  {
    picked.highlight = 200;
  }
}
public class bigcube
{
    Cube [] cubes;
    PVector[] locations;
    int start;
    public bigcube()
    {
      this.start = millis();
      cubes = new Cube[27];
      locations= new PVector[27];
      float row = 0;
      float colom = 0;
      float z = 0;
      for (int i = 0; i < cubes.length; i++) {
        if (i % 3 == 0)
        {
          colom = colom - 1;
          row = 0;
        }
        if(i % 9 == 0)
        {
          z = z - 21;
          colom = 1;
          row = 0;
        }
        row = row - 1;
        locations[i] = new PVector(row * 21,colom * 21, z);
        cubes[i] = new Cube("Box " + (i), color(255,255,255), 0xff000000 + i*i+2*i+5,locations[i]);
      }
    }

    public void display()
    {
      for (int i = 0; i < cubes.length; i++)
      {
        this.cubes[i].display();
      }
    }
    public boolean checkwin(int c1,int c2,int c3,
                            int c4,int c5,int c6,
                            int c7,int c8,int c9,int turn)
    {
      if(c1 == c2 && c2 == c3 && c1 == turn )
        return true;
      if(c4 == c5 && c5 == c6 && c4 == turn )
        return true;
      if(c7 == c8 && c8 == c9 && c7 == turn)
        return true;
      if(c1 == c4 && c4 == c7 && c1 == turn)
        return true;
      if(c2 == c5 && c5 == c8 && c2 == turn)
        return true;
      if(c3 == c6 && c6 == c9 && c3 == turn)
        return true;
      if(c1 == c5 && c5 == c9 && c1 == turn)
        return true;
      if(c7 == c5 && c5 == c3 && c7 == turn)
        return true;

      return false;
    }
    public int win(int turn)
    {
      if (checkwin(this.cubes[8].player,this.cubes[7].player,this.cubes[6].player,
                   this.cubes[5].player,this.cubes[4].player,this.cubes[3].player,
                   this.cubes[2].player,this.cubes[1].player,this.cubes[0].player,turn))
      {
            return turn +2;
      }
      if (checkwin(this.cubes[26].player,this.cubes[17].player,this.cubes[8].player,
                   this.cubes[23].player,this.cubes[14].player,this.cubes[5].player,
                   this.cubes[20].player,this.cubes[11].player,this.cubes[2].player,turn))
      {
            return turn +2;
      }
      if (checkwin(this.cubes[6].player,this.cubes[15].player,this.cubes[24].player,
                   this.cubes[3].player,this.cubes[12].player,this.cubes[21].player,
                   this.cubes[0].player,this.cubes[9].player,this.cubes[18].player,turn))
      {
            return turn +2;
      }
      if (checkwin(this.cubes[24].player,this.cubes[25].player,this.cubes[26].player,
                   this.cubes[21].player,this.cubes[22].player,this.cubes[23].player,
                   this.cubes[18].player,this.cubes[19].player,this.cubes[20].player,turn))
      {
            return turn +2;
      }
      if (checkwin(this.cubes[26].player,this.cubes[25].player,this.cubes[24].player,
                   this.cubes[17].player,this.cubes[16].player,this.cubes[15].player,
                   this.cubes[8].player,this.cubes[7].player,this.cubes[6].player,turn))
      {
            return turn +2;
      }
      if (checkwin(this.cubes[2].player,this.cubes[1].player,this.cubes[0].player,
                   this.cubes[11].player,this.cubes[10].player,this.cubes[9].player,
                   this.cubes[20].player,this.cubes[19].player,this.cubes[18].player,turn))
      {
            return turn +2;
      }
      return turn == 1 ? 2:1;
    }
}
public class button
{
  int rx,ry,rw,rh,tx,ty;
  int c;
  String s;
  int texts = 100;
  public button(int rx, int ry, int rw, int rh,int c,int tx,int ty,String s)
  {
    this.rx = rx;
    this.ry = ry;
    this.rw = rw;
    this.rh = rh;
    this.tx = tx;
    this.ty = ty;
    this.s = s;
    this.c = c;
  }
  public void draw(int x ,int y)
  {
    textSize(20);
    this.texts = highlight(x,y);
    fill(0);
    rect(this.rx, this.ry, this.rw, this.rh);
    fill(texts);
    text(this.s,tx,ty);
  }
  public int highlight(int x,int y)
  {
    if (this.rx < x && (this.rx + this.rw) > x && this.ry < y && (this.ry + this.rh) > y)
    {
      return 255;
    }
    return 100;
  }
  public void reset(bigcube c, int x, int y)
  {
    if (this.rx < x && (this.rx + this.rw) > x && this.ry < y && (this.ry + this.rh) > y)
    {
      rubiks = new bigcube();
      time = 0;
      turn = 1;
    }
  }
}
public class Cube
{
    String tag;
    int player = 0;
    boolean alreadypicked = false;
    PVector position [];
    float size = 20;
    int col;
    int pickCol;
    int highlight = 0;
    public Cube(String tag, int col, int pickCol,PVector vector )
    {
      this.position = new PVector[2];
      for(int x =0; x<2;x++)
      {
        this.position[x] = vector;
      }
      this.tag = tag;
      this.col = col;
      this.pickCol = pickCol;
    }

    public void display()
    {
      pushMatrix();
      translate(40,0,40);
      translate(this.position[0].x, this.position[0].y, this.position[0].z);
      stroke(0);
      fill(col);
      stroke(highlight);
      box(size);
      popMatrix();
    }

    public void displayForPicker()
    {
      pg.pushMatrix();
      pg.translate(40,0,40);
      pg.translate(this.position[0].x, this.position[0].y, this.position[0].z);
      pg.stroke(0);
      pg.fill(pickCol);
      pg.box(size);
      pg.popMatrix();
    }
  }
  public void settings() {  size(640, 480,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "TicTacToe" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
