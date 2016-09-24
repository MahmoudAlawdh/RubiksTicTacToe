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
