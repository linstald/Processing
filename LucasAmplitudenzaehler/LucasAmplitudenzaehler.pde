/**
 *Grab audio from the microphone input and count if amplitude is great enough
 * 
 * 
 */

import processing.sound.*;
import controlP5.*;

ControlP5 cp5;
int count = 0;
boolean timeout = false;
AudioIn input;
Amplitude loudness;
float volume;
int maxCount;

void setup() {
  fullScreen();
  background(130);
  textAlign(CENTER);
  cp5 = new ControlP5(this);
  cp5.setColorForeground(#4695E8);
  cp5.setColorBackground(255);
  cp5.setFont(createFont("Verdana", 20));
  
  cp5.addSlider("volume")
   .setRange(0,100)
   .setValue(50)
   .setPosition(width/2-width/4, 2*height/3)
   .setSize(width/2,height/20)
   .setSliderMode(Slider.FLEXIBLE)
   .setHandleSize(100);
   
  cp5.addSlider("maxCount")
     .setPosition(width/2-width/4,2*height/3+height/10)
     .setSize(width/2,height/20)
     .setRange(0,80)
     .setValue(50)
     .setSliderMode(Slider.FLEXIBLE)
     .setHandleSize(height/20);
     
  if (hasPermission("android.permission.RECORD_AUDIO")) {
    initialize(true);
  } else {
    requestPermission("android.permission.RECORD_AUDIO", "initialize");
  }
}

void initialize(boolean granted) {
  if (!granted) {
    return;
  }

  // Create an Audio input and grab the 1st channel
  input = new AudioIn(this, 0);

  // Begin capturing the audio input
  input.start();
  // start() activates audio capture so that you can use it
  
  // Create a new Amplitude analyzer
  loudness = new Amplitude(this);

  // Patch the input to the volume analyzer
  loudness.input(input);
}

void draw() {
  if (input == null) {
    // Wait for user to give permission
    return;
  }
  background(130);
  if (count == 0) {
   background(#FFF305);
  }
  float amplitude = loudness.analyze();
  //println(amplitude);
  if (amplitude>volume/100 && !timeout) {
    count++;
    timeout=true;
  }
  if (amplitude<volume/100) {
   timeout=false; 
  }
  if (count>=maxCount) {
    count = 0;
  }
  fill(255);
  textSize(height/4); 
  text(count, width/2, height/2);
}
