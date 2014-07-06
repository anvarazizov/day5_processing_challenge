import java.util.Calendar;
import gifAnimation.*;

GifMaker gifExport;

// please change this variables
int triangleWidth = 20;
int triangleHeight = 20;

float topX = triangleWidth;
float leftX = topX - triangleWidth;
float rightX = topX + triangleWidth; 
float topY = 0;
float bottomY = triangleHeight;
float h = 360;
float s = 360;
float b = 360;
int actRandomSeed = 0;

int t = 10;

void setup()
{
  size(640, 640);
  smooth();
  noStroke();
  
  frameRate(12);
  gifExport = new GifMaker(this, "sketch.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setDelay(1000/12);  //12fps in ms
  
  randomSeed(actRandomSeed);
  background(#F1F0EB);
  drawTriangles(20, 20, 255);
  
}

void draw()
{
  drawTriangles(20, t + frameCount, 200);
  
   gifExport.addFrame();

  if (frameCount == 120) gifExport.finish(); 
  println(frameCount);
}

void drawTriangles(int _width, int _height, int _hue)
{  
  background(#F1F0EB);
  
  actRandomSeed = (int) random(1, 1000000);
 
  triangleWidth = _width;
  triangleHeight = _height;

  topX = triangleWidth;
  leftX = topX - triangleWidth;
  rightX = topX + triangleWidth; 
  topY = 0;
  bottomY = triangleHeight;
  h = _hue;
  s = _hue;
  b = _hue;
 
  while (topX <= width)
  {
    fill(noise(h)*width/random(2), s / random(2, 3), b - noise(actRandomSeed));
    triangle(topX, topY, rightX, bottomY, leftX, bottomY);
    topX = topX + triangleWidth * 2;
    leftX = leftX + triangleWidth * 2;
    rightX = rightX + triangleWidth * 2;
    
    if (topX >= width && topY <= height)
    {
      topX = triangleWidth; 
      leftX = topX - triangleWidth;
      rightX = topX + triangleWidth; 
      topY = topY + triangleHeight;
      bottomY = bottomY + triangleHeight;
    }
    
    if (topX % width > 20 && topX % width < 180)
    {
      topY = topY + cos(triangleHeight);
      triangleWidth += noise(topY);
      _hue -= 0.1;
      s -= 0.1;
      b -= 0.1;
    }
  } 
}

void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
