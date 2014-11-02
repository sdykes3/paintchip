/* This drawing application is a simulation of removing paint from a wall. I 
   thought that this would be a fun project idea because, as you remove layers, 
   it is always interesting to see what is underneath, which colors the previous 
   owners painted this same wall, etc.
   
   The actual aspects of paint-scraping that I wanted to convey are, not only the 
   multiple unknown layers, but also the act of trying to chip away persistent paint. 
   The effectiveness of the scraping tool is designed to simulate the relative 
   difficulty of the real-life version of this task. As such it is often necessary 
   to go over a spot multiple times in order to get the effect you want, or to drag 
   faster (to simulate applying more force) in order to remove any paint.
   
   That being said, the best way to use this program is to drag the cursor in a 
   horizontal direction, since that is how the scraping tool is oriented. Therefore, 
   the program is designed for that to be the most effective motion.
   
   Have fun!
*/
 
PGraphics pg0;
PGraphics pg1;
PGraphics pg2;
PGraphics pg3;
PGraphics pg4;
PGraphics pg00;
PGraphics pg10;
PGraphics pg20;
PGraphics pg30;
PGraphics pg40;
PGraphics currentP;
PGraphics currentPShadow;
 
color layerColor0;
color layerColor1;
color layerColor2;
color layerColor3;
color layerColor4;
color layerShadow0;
color layerShadow1;
color layerShadow2;
color layerShadow3;
color layerShadow4;
 
int sizeX;
int sizeY;
 
void setup()
{
 sizeX = 525;
 sizeY = 675;
 size(sizeX, sizeY);
 smooth();
 frameRate(30); 
 noCursor();
 
 pg0 = createGraphics(sizeX, sizeY);
 pg1 = createGraphics(sizeX, sizeY);
 pg2 = createGraphics(sizeX, sizeY);
 pg3 = createGraphics(sizeX, sizeY);
 pg4 = createGraphics(sizeX, sizeY);
 pg00 = createGraphics(sizeX, sizeY);
 pg10 = createGraphics(sizeX, sizeY);
 pg20 = createGraphics(sizeX, sizeY);
 pg30 = createGraphics(sizeX, sizeY);
 pg40 = createGraphics(sizeX, sizeY);
 
 colorMode(HSB, 100);
 layerColor0 = color(random(100),30,100);
 layerColor1 = color(random(50,75),30,100);
 layerColor2 = color(random(0,25),30,100);
 layerColor3 = color(random(75,100),30,100);
 layerColor4 = color(random(25,50),30,100);
 layerShadow0 = color(hue(layerColor0),30,75);
 layerShadow1 = color(hue(layerColor1),30,75);
 layerShadow2 = color(hue(layerColor2),30,75);
 layerShadow3 = color(hue(layerColor3),30,75);
 layerShadow4 = color(hue(layerColor4),30,75);
 colorMode(RGB);
 
 pg0.beginDraw();
 pg0.background(layerColor0);
 pg0.endDraw();
 pg00.beginDraw();
 pg00.background(layerShadow0);
 pg00.endDraw();
 pg1.beginDraw();
 pg1.background(layerColor1);
 pg1.endDraw();
 pg10.beginDraw();
 pg10.background(layerShadow1);
 pg10.endDraw();
 pg2.beginDraw();
 pg2.background(layerColor2);
 pg2.endDraw();
 pg20.beginDraw();
 pg20.background(layerShadow2);
 pg20.endDraw();
 pg3.beginDraw();
 pg3.background(layerColor3);
 pg3.endDraw();
 pg30.beginDraw();
 pg30.background(layerShadow3);
 pg30.endDraw();
 pg4.beginDraw();
 pg4.background(layerColor4);
 pg4.endDraw();
 pg40.beginDraw();
 pg40.background(layerShadow4);
 pg40.endDraw();
}
 
void draw()
{ 
 background(70,70,70);
 
 image(pg00, 1, 1); 
 image(pg0, 0, 0); 
 //image(pg10, 1, 1); 
 image(pg1, 0, 0);
 image(pg20, 1, 1); 
 image(pg2, 0, 0);
 //image(pg30, 1, 1); 
 image(pg3, 0, 0);
 image(pg40, 1, 1); 
 image(pg4, 0, 0); 
 
 
  //Wall Moulding
  stroke(65);
  color white = #FFFFFF;
  color darkerWhite = #CFCECC;;
  fill(white);
  rect(0,420,sizeY,35);
  fill(darkerWhite);
  rect(0,450,sizeY,5);
  line(0,425,sizeX,425);
  
  //Scraping Tool
  stroke(20);
  fill(51);
  rect(mouseX+1, mouseY+1, 60, 40);
  triangle(mouseX+61, mouseY+41, mouseX+61, mouseY+1, mouseX+91, mouseY+21);
  fill(255,20,20);
  rect(mouseX+81, mouseY+14, 55, 15); 
}
 
 
void mouseDragged()
{
  
  if( (abs(mouseY - pmouseY)) > 50 ) {
    return;
  }
  if( (abs(mouseX - pmouseX)) > 25 ) {
    return;
  }
  if( ((abs(mouseX - pmouseX)) < 10) && ((abs(mouseY - pmouseY)) < 30) ) {
    return;
  }
  
  color colorHere = get(mouseX,mouseY);
  float compareHere = hue(colorHere);
  float compare0 = hue(layerColor0);
  float compare1 = hue(layerColor1);
  float compare2 = hue(layerColor2);
  float compare3 = hue(layerColor3);
  float compare4 = hue(layerColor4);
 
  if(compareHere == compare0) {
    currentP = pg0;
    currentPShadow = pg00;
  }
  else if(compareHere == compare1) {
    currentP = pg1;
    currentPShadow = pg10;
  }
  else if(compareHere == compare2) {
    currentP = pg2;
    currentPShadow = pg20;
  }
  else if(compareHere == compare3) {
    currentP = pg3;
    currentPShadow = pg30;
  }
  else if(compareHere == compare4) {
    currentP = pg4;
    currentPShadow = pg40;
  }
  else {
    currentP = pg0; 
    currentPShadow = pg00;
  }
 
  currentP.beginDraw();
  scrape(mouseX, mouseY, currentP);
  currentP.endDraw();
  
  currentPShadow.beginDraw();
  scrape(mouseX, mouseY, currentPShadow);
  currentPShadow.endDraw();
}
 
void scrape(int x, int y, PGraphics p) 
{
  color clear = color(0,0,0,0);
  for (int i=0; i<40; i++)
  {
    for (int j=0; j<10; j++)
    {
      p.set(x+j, y+i, clear);
    } 
  } 
}

