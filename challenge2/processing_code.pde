//using the Serial library from Sketch/Import Library/Serial
import processing.serial.*;

Serial myPort;        // Create object from Serial class
char HEADER = 'H';    // 'H' is the character indicating the beginning o f the message
short LF = 10;        // ASCII code for linefeed
int pH;
int temp;
int rot;
String temperature;
int[] temps  = new int[10];
int[] phs  = new int[10];
int[] rpms  = new int[10];
int int_temperature;

void settings() {
  size(1920, 800);
}

void setup() {
  //size(1920, 400);
  
  //IMPORTANT!!! WRITE DOWN YOUR OWN PORT INSTEAD OF "COM1" BEFORE YOU START THE GAME
  myPort = new Serial(this, "COM7", 9800);
}

//this part reads the serial port to get data from the Arduino and assign it to variables
void serialEvent(Serial myPort) {

  String message = myPort.readStringUntil(LF); // read serial data

  if (message != null) 
  {
    String [] data  = message.split(","); //split the message into commas
    if (data[0].charAt(0) == HEADER) {   
      
      for ( int i = 1; i < data.length-1; i++) { // skip the header and terminating cr and lf
        int value = Integer.parseInt(data[i]);
        
        if (i == 1) //first value is the light one
        {
          pH = value;
        }
        
        if (i == 2) //second one comes from the potentiometer
        {
          temp = value;
          println(temp);
        }
        
        if (i == 3) //second one comes from the potentiometer
        {
          rot = value;
        }
        
      }
    }
  }
}

void draw() {
  background(255);
  stroke(0);
  frameRate(2);
  
  //GRAPH 1
  
  
  //axes labels
  text("°C", 10, 200);
  text("Time(s)", 300, 380);
  
  axis(30, 360, 630, 360, 0, 0, 0); //x axis
  axis(30, 340, 30, 20, 1, 630, 80); //y axis
  
  for (int i = 0; i < temps.length - 1; i++) {
    temps[i] = temps[i + 1];
  }
  
  temps[temps.length - 1] = temp;
  
  for (int k = 1; k <= temps.length - 1; k++) {
    line(60 + ((k - 1) * 60), 360 - (temps[k-1] * 4), 60 + (k * 60), 360 - (temps[k] * 4));
  }
  
  //GRAPH 2
  
  int g2x = 650;
  //axes labels
  text("pH", 10 + g2x, 200);
  text("Time(s)", 300 + g2x, 380);
  
  axis(30 + g2x, 360, 630 + g2x, 360, 0, 0, 0); //x axis
  axis(30 + g2x, 360, 30 + g2x, 20, 1, 630 + g2x, 16); //y axis
  
  for (int i = 0; i < phs.length - 1; i++) {
    phs[i] = phs[i + 1];
  }
  
  phs[phs.length - 1] = pH;
  
  for (int k = 1; k <= phs.length - 1; k++) {
    line(60 + ((k - 1) * 60) + g2x, 360 - (phs[k-1] * 20), 60 + (k * 60) + g2x, 360 - (phs[k] * 20));
  }
  
  //GRAPH 3
  
  int g3x = 1300;
  //axes labels
  text("rpm", 10 + g3x, 200);
  text("Time(s)", 300 + g3x, 380);
  
  axis(30 + g3x, 360, 630 + g3x, 360, 0, 0, 0); //x axis
  axis(30 + g3x, 360, 30 + g3x, 20, 1, 630 + g3x, 1600); //y axis
  
  for (int i = 0; i < phs.length - 1; i++) {
    rpms[i] = rpms[i + 1];
  }
  
  rpms[rpms.length - 1] = rot;
  
  for (int k = 1; k <= phs.length - 1; k++) {
    line(60 + ((k - 1) * 60) + g3x, 360 - (rpms[k-1] * 0.2), 60 + (k * 60) + g3x, 360 - (rpms[k] * 0.2));
  }
}

void axis(int x1, int y1, int x2, int y2, int numbers, int xend, int maxy) {
  int step = maxy / 8;
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
  line(x1, 20, x1, 360);
  
  int counter1 = maxy + step;
  
  if (numbers == 1) {
    for (int j = 30; j < height && counter1 >= 0; j += 40) {
      fill(0, 0, 0);
      text(counter1, x1, j - 30);
      stroke(0, 0, 0);
      line(x1, j - 30, xend, j - 30);
      counter1 -= step;
    }
  }
}