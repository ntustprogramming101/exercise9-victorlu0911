class Net {
  PImage img;
  int size = 128;
  int x, y;
  int ySpeed = 6;
  boolean isAlive = false;
  
  Net () {
    img = loadImage("img/net.png");
    x = 0;
    y = - size;
  }
  
  void display () {
    if(isAlive){
      image(img, x, y, size, size);
    }
  }
  
  void move () {
    if(isAlive){
      y += ySpeed;
      if(y > height) isAlive = false;
    }
  }
  
  void drop(int x) {
    if(!isAlive){
      this.x = x - size / 2;
      y = - size;
      isAlive = true;
    }
  }
  
  boolean isHit(Fish fish){
    float ax, ay, aw, ah, bx, by, bw, bh;
    ax = fish.x;  bx = this.x;
    ay = fish.y;  by = this.y;
    aw = fish.w;  bw = this.size;
    ah = fish.h;  bh = this.size;

    return  ax + aw > bx &&    // a right edge past b left
          ax < bx + bw &&    // a left edge past b right
          ay + ah > by &&    // a top edge past b bottom
          ay < by + bh;
  }
}
