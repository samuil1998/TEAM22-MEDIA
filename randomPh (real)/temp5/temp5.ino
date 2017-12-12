#define SERIESRESISTOR 10000 // value of resistor
#include <math.h>
#define THERMISTORPIN P1_4 // output A0
int finalTemp = 0;
double Thermistor(int RawADC) {
 double Temp;
 Temp = logf(9900*((1023.0/RawADC-1))); 
 Temp = 1 / (0.0006489785099 + 0.0003167232089*Temp-0.0000002644044342*Temp*Temp*Temp);// constants calcuted for specific thermistor (N_09P00103)
 Temp = Temp - 273.15;            // Convert Kelvin to Celcius
 return Temp;
}
int pwmPin = P2_1; // PWM supporting pin
void setup() {
 pinMode(P1_4, INPUT); 
 pinMode(pwmPin, OUTPUT); // sets the pin as output
 Serial.begin(9600); // begin
}
void loop() {
  finalTemp= int(Thermistor(analogRead(P1_4)));
  Serial.print("Temperature: ");
  Serial.println((Thermistor(analogRead(P1_4))));  // display Celsius
  delay(1000);

if (finalTemp >= 23) {
    analogWrite(pwmPin, 0);
    Serial.println(0);  
  }
  else if (finalTemp< 23 && finalTemp>=22) {
    analogWrite(pwmPin, 150);
    Serial.println(150);
  }
  else if (finalTemp< 22 && finalTemp>=20) {
    analogWrite(pwmPin, 180);
    Serial.println(180);
  }
  else if (finalTemp< 20 && finalTemp>=15) {
    analogWrite(pwmPin, 220);
    Serial.println(220);
  }
  else {
    analogWrite(pwmPin, 255);
    Serial.println(255);  
  }  
}
