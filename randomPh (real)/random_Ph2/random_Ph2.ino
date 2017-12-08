int pH = 0;
int temp = 0;
int rot = 0;
int finalTemp = 0;
double Thermistor(int RawADC) {
 double Temp;
 Temp = logf(9900*((1023.0/RawADC-1))); 
 Temp = 1 / (0.0006489785099 + 0.0003167232089*Temp-0.0000002644044342*Temp*Temp*Temp);// constants calcuted for specific thermistor (N_09P00103)
 Temp = Temp - 273.15;            // Convert Kelvin to Celcius
 return Temp;
}
int pwmPin = P2_1; // PWM supporting pin
void setup()
{
 pinMode(P1_4, INPUT); 
 pinMode(pwmPin, OUTPUT); // sets the pin as output
 Serial.begin(9600);
}

void loop()
{
  finalTemp= int(Thermistor(analogRead(P1_4)));
  //Serial.print("Temperature: ");
  //Serial.println((Thermistor(analogRead(P1_4))));  // display Celsius
  delay(1000);

if (Thermistor(analogRead(P1_4)) >= 24) {
    analogWrite(pwmPin, 0);
    Serial.println(0);  
  }
  else if (23<=Thermistor(analogRead(P1_4))< 24) {
    analogWrite(pwmPin, 150);
    Serial.println(150);
  }
  else if (20<=Thermistor(analogRead(P1_4))< 23) {
    analogWrite(pwmPin, 180);
    Serial.println(180);
  }
  else if (15<=Thermistor(analogRead(P1_4))< 20) {
    analogWrite(pwmPin, 220);
    Serial.println(222);
  }
  else {
    analogWrite(pwmPin, 255);
    Serial.println(255);  
  }  

    
  // put your main code here, to run repeatedly:
  pH = random(14);
  temp = finalTemp + 20;
  rot = random(1000);
  
  Serial.print('H'); // 'H' is the header marking the beginning of the message
  Serial.print(",");
  Serial.print(pH,DEC);
  Serial.print(",");
  Serial.print(temp,DEC);
  Serial.print(",");  
  Serial.print(rot,DEC);
  Serial.print(","); 
  Serial.println(); //sending a "\n" or LF to mark the end of the message
  delay(500);  //minimum delay needed for the transferring of messages
  
}
