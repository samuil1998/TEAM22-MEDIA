//using the Serial library from Sketch/Import Library/Serial
import processing.serial.*;

Serial myPort;        // Create object from Serial class
char HEADER = 'H';    // 'H' is the character indicating the beginning o f the message
short LF = 10;        // ASCII code for linefeed
int pH;
int temp;
int rot;

void setup() {
  //size(1400, 500);
  
  //IMPORTANT!!! WRITE DOWN YOUR OWN PORT INSTEAD OF "COM1" BEFORE YOU START THE GAME
  myPort = new Serial(this, "COM1", 9600);
}


//this part reads the serial port to get data from the Arduino and assign it to variables
void serialEvent(Serial myPort) {

  String message = myPort.readStringUntil(LF); // read serial data

  if (message != null) 
  {
    String [] data  = message.split(","); //split the message into commas
    if (data[0].charAt(0) == HEADER)  //check for header
    {       
      for ( int i = 1; i < data.length-1; i++) { // skip the header and terminating cr and lf
        int value = Integer.parseInt(data[i]);
        
        if (i == 1) //first value is the light one
        {
          pH = value;
        }
        
        if (i == 2) //second one comes from the potentiometer
        {
          temp = value;
        }
        
        if (i == 2) //second one comes from the potentiometer
        {
          rot = value;
        }
        
      }
    }
  }
}