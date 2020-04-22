package processing.test.lucasamplitudenzaehler;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class LucasAmplitudenzaehler extends PApplet {

/**
 * Grab audio from the microphone input and count if amplitude is great enough
 * 
 * 
 */




ControlP5 cp5;
int count = 0;
boolean timeout = false;
AudioIn input;
Amplitude loudness;
float volume;
float maxCount;

public void setup() {
  
  background(120, 240, 30);
  cp5 = new ControlP5(this);
  cp5.setColorForeground(0xff4695E8);
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
     .setRange(0,200)
     .setValue(50)
     .setSliderMode(Slider.FLEXIBLE)
     .setHandleSize(height/20);
     
  if (hasPermission("android.permission.RECORD_AUDIO")) {
    initialize(true);
  } else {
    requestPermission("android.permission.RECORD_AUDIO", "initialize");
  }
}

public void initialize(boolean granted) {
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

public void draw() {
  if (input == null) {
    // Wait for user to give permission
    return;
  }
  background(120, 240, 30);
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
  fill(0);
  textSize(50);
  text(count, width/2, height/2);
}
  public void settings() {  fullScreen(); }
}
