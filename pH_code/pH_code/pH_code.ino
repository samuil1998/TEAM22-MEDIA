const int inputPin = P1_2;
const int acidPin = P1_4;
const int basePin = P1_5;
int pH  = 0;
double volt = 0;

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode (inputPin, INPUT);
  pinMode (acidPin, OUTPUT);
  pinMode (basePin, OUTPUT);

}

void loop()
{
  // put your main code here, to run repeatedly:
    volt = analogRead (inputPin);
    
    pH = (volt - 2.8)/(-0.16);
    
    if(pH >= 6)
    {
      digitalWrite(acidPin,HIGH);
      digitalWrite(basePin,LOW);
    }
    if(pH <= 4)
    {
      digitalWrite(acidPin,LOW);
      digitalWrite(basePin,HIGH);
    }
    
    delay(1000);
}
