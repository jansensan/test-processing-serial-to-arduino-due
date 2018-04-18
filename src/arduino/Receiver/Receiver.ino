// constants
const int PORT_NUMBER = 9600;

const int UNINIT = -1;
const int LED_ON = 0;
const int LED_OFF = 1;

const int LED_PIN = 13;
const int LED_DURATION = 500;


// vars
int currentState = UNINIT;
int endTime = -1;

boolean isLEDOn = false;


// arduino setup
void setup()  {
  // set pin mode
  pinMode(LED_PIN, OUTPUT);
  
  // init serial communications
  Serial.begin(PORT_NUMBER);
}

void loop() {
  // read serial data
  char serialData;
  if (Serial.available()) {
    serialData = Serial.read();
  }

  // set state accordingly
  if (serialData == 1) {
    currentState = LED_ON;
  } else {
    currentState = LED_OFF;
  }

  // handle states
  switch (currentState) {
    case LED_ON:
      turnOnLED();
      break;
    case LED_OFF:
      turnOffLED();
      break;
  }

  delay(10);
}


// methods definitions
void turnOnLED() {
  // quick exit if already on
  if (isLEDOn) {
    return;
  }

  digitalWrite(LED_PIN, HIGH);
  endTime = millis() + LED_DURATION;
}

void turnOffLED() {
  if (millis() >= endTime) {
    digitalWrite(LED_PIN, LOW);
    isLEDOn = false;
  }
}

