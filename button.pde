public class button
{
  int rx,ry,rw,rh,tx,ty;
  color c;
  String s;
  int texts = 100;
  public button(int rx, int ry, int rw, int rh,color c,int tx,int ty,String s)
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
