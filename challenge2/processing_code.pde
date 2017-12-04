//using the Serial library from Sketch/Import Library/Serial
import processing.serial.*;

Serial myPort;        // Create object from Serial class
char HEADER = 'H';    // 'H' is the character indicating the beginning o f the message
short LF = 10;        // ASCII code for linefeed
int pH;
int temp;
int rot;
String temperature;
int[] values  = new int[10];
int int_temperature;

void settings() {
  size(1600, 800);
}

void setup() {
  //size(1400, 500);
  
  //IMPORTANT!!! WRITE DOWN YOUR OWN PORT INSTEAD OF "COM1" BEFORE YOU START THE GAME
  myPort = new Serial(this, "COM5", 9600);
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
  frameRate(1);
  
  //axes labels
  text("°C", 10, 200);
  text("Time(s)", 400, 380);
  
  axis(30, 360, 780, 360, 0); //x axis
  axis(30, 340, 30, 20, 1); //y axis
  
  for (int i = 0; i < values.length - 1; i++) {
    values[i] = values[i + 1];
  }
  
  values[values.length - 1] = temp;
  
  for (int k = 1; k <= values.length - 1; k++) {
    line(60 + ((k - 1) * 74), 360 - (values[k-1] * 4), 60 + (k * 74), 360 - (values[k] * 4));
  }
}

void axis(int x1, int y1, int x2, int y2, int numbers) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
  line(30, 20, 30, 360);
  
  int counter = 90;
  
  if (numbers == 1) {
    for (int j = 30; j < height && counter >= 0; j += 40) {
      fill(0, 0, 0);
      text(counter, 30, j - 30);
      stroke(0, 0, 0);
      line(30, j - 30, 770, j - 30);
      counter -= 10;
    }
  }
}