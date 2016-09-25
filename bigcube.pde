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

    public Cube pickCube(int x, int y)
    {
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
