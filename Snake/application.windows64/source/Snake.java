import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Snake extends PApplet {

//********** SNAKE-SPIEL   **********//
//Ein Snake Spiel mit Kommentaren, um den Code auch zu verstehen.
//
//Anleitung: Sobald der Sketch gestartet wurde, baut sich die Schlange zusammen. Man kann sie mit den Pfeiltasten steuern.
//Das Ziel ist es soviele \u00c4pfel (rote Pixel) zu sammeln wie nur m\u00f6glich. Man darf nicht in sich selber "fahren". Man kann jedoch durch die "W\u00e4nde" des Displays gehen.
//
//Programmiert von: Linus Stalder
//**********************************//

// Variablen deklarieren
IntList koordinatenx = new IntList(); //IntList f\u00fcr die xKoordinaten der Schlange
IntList koordinateny = new IntList(); //...f\u00fcr ykoordinaten
String taste; //variable f\u00fcr den tasteninput
boolean neu; //boolean um die schlange eines l\u00e4nger zu machen und neuen apfel zu generieren
int[][] besetzt; //Array mit Informationen \u00fcber das gesamte KoordinatenRaster: 0=nicht besetzt, 1=besetzt von Schlange, 2=besetzt von Apfel; die Indizes korrespondieren den Koordinaten
boolean finished; //boolean um das Spiel zu beenden
int score; //variable f\u00fcr den Spielstand
int raster; // variable f\u00fcr die breite/l\u00e4nge des rasters

public void setup() {      //void setup:
    //gr\u00f6sse definieren
  stroke(0);        //farbe der border definieren
  background(0xffFFFFFF);    //farbe des hintergrundes definieren
  fill(0xff000000);        //farbe des f\u00fcllens definieren
  taste = "RIGHT";      //variablen initialisieren
  neu = false;
  finished = false;
  score = 0;
  raster = 20;
  frameRate(20);        //frameRate definieren
  textSize(height/((width/height)*4));    //textsize definiere

  for (int i = 0; i<=height/raster; i++) {    //raster erstellen
    line(0, i*raster, width, i*raster);
  }
  for (int j = 0; j<=width/raster; j++) {
    line(j*raster, 0, j*raster, height);
  }
  
  koordinatenx.clear();            //darauf achten, dass die Listen f\u00fcr koordinaten leer sind
  koordinateny.clear();
  
  besetzt = new int[width/raster+2][height/raster+2]; //array besetzt initialisieren --> eines gr\u00f6sser als das Display ist, da man sonst beim seitenwechsel auf einen negativen Index kommt (Error)
  for (int m = 0; m < width/raster+2; m++) {
    for (int n = 0; n < height/raster+2; n++) {
      besetzt[m][n] = 0;
    }
  }
  
  noStroke(); //noStroke um grenze der Rechtecke wegzunehmen
  koordinatenx.append((width/2)/raster); //erste koordinate einf\u00fchren..
  koordinateny.append((height/2)/raster);

  for (int c= 0; c<10; c++) {
    koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)+1); //...um sie hier zu erweitern
    koordinateny.append(koordinateny.get(koordinateny.size()-1));
  }
  neuApfel(); //apfel generieren
}

public void keyPressed() { //funktion zur \u00fcberpr\u00fcfung der tastatureingabe
  switch (keyCode) { //keyCode=gedr\u00fccke Sondertaste
  case RIGHT:
    taste = "RIGHT"; //gewissen Wert der variable taste zuweisen
    break;
  case LEFT:
    taste = "LEFT";
    break;
  case DOWN:
    taste = "DOWN";
    break;
  case UP:
    taste = "UP";
    break;
  }
}

public void mousePressed() { //funktion zur \u00fcberpr\u00fcfung der Mauseingabe
  if (mouseButton==LEFT) { //bei gedr\u00fcckter linker maustaste: noch einmal von vorne (setup())
    fill(0xff000000);
    setup();
  }
}

public void neuApfel() { //funktion f\u00fcr die Generierung des Apfels
  int a = PApplet.parseInt(random(0, width/(raster)-1)); //zufallswerte f\u00fcr die beiden Koordinaten bestimmen (a und b)
  int b = PApplet.parseInt(random(0, height/(raster)-1));

  if (besetzt[a+1][b+1] != 1) { //\u00fcberpr\u00fcfung ob apfelpostion von der schlange besetzt ist
    besetzt[a+1][b+1] = 2; //falls nein nun besetzt von apfel
    fill(0xffFF0000); //zeichne apfel
    rect(a*(raster)+1, b*(raster)+1, (raster-1), (raster-1));
  }
  else {
    neuApfel(); //falls ja mache neuen apfel
  }
}


public void draw() { //funktion die in der sekunde soviel mal ausgef\u00fchrt wird wie in framerate angegeben
  if (finished) { //\u00fcberpr\u00fcfung ob finished bereits eingetroffen ist, d.h. ob das Spiel beendet wird
    fill(0xffFF0000); //bei ja GameOver und Score ausgeben
    textSize((height/((width/height)*4)));
    text("GAME-OVER", 0, height/2);
    fill(0xff0000FF);
    textSize((height/((width/height)*4))/4);
    text("Your Score =" + score, width/3, 2*height/3);
  }
  else { //bei nein
  
    if (taste == "RIGHT") { //falls die taste rechts gedr\u00fcckt ist
      if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1)%(height/raster)] == 0) { //\u00fcberpr\u00fcfe ob an der n\u00e4chsten stelle richtung rechts vom Schlangenkopf noch frei ist
        koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)+1); // falls ja dann f\u00fcge diese stelle in die koordinaten hinzu
        koordinateny.append(koordinateny.get(koordinateny.size()-1));
      }
      else { //bei nein
        if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1)%(height/raster)] == 2) { //\u00fcberpr\u00fcfe ob die stelle vom apfel besetzt ist
          neu = true; //falls ja neu true setzen um neuen apfel zu generieren und schlange gr\u00f6sser zu machen
          koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)+1); //stelle hinzuf\u00fcgen
          koordinateny.append(koordinateny.get(koordinateny.size()-1));
        }
        else { //falls nein --> man ist in ein schlangenst\u00fcck hineingefahren, was heisst das spiel ist fertig
          finished = true;
        }
      }
    }
    
    if (taste == "LEFT") { //analog zu den anderen tasten wie RIGHT
      if (besetzt[(koordinatenx.get(koordinatenx.size()-1)-1+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1)%(height/raster)] == 0) {
        koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)-1); //left
        koordinateny.append(koordinateny.get(koordinateny.size()-1));
      }
      else {
        if (besetzt[(koordinatenx.get(koordinatenx.size()-1)-1+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1)%(height/raster)] == 2) {
          neu = true;
          koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)-1); //left
          koordinateny.append(koordinateny.get(koordinateny.size()-1));
        }
        else {
          finished = true;
        }
      }
    }
    
    if (taste == "DOWN") {
      if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1+1)%(height/raster)] == 0) {
        koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)); //down
        koordinateny.append(koordinateny.get(koordinateny.size()-1)+1);
      }
      else {
        if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1+1)%(height/raster)] == 2) {
          neu = true;
          koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)); //down
          koordinateny.append(koordinateny.get(koordinateny.size()-1)+1);
        }
        else {
          finished = true;
        }
      }
    }
    
    if (taste == "UP") {
      if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)-1+1)%(height/raster)] == 0) {
        koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)); //up
        koordinateny.append(koordinateny.get(koordinateny.size()-1)-1);
      }
      else {
        if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)-1+1)%(height/raster)] == 2) {
          neu = true;
          koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)); //up
          koordinateny.append(koordinateny.get(koordinateny.size()-1)-1);
        }
        else {
          finished = true;
        }
      }
    }
    
    fill(0xff00FF00); //wieder richtige f\u00fcllfarbe definieren
    if (koordinatenx.get(koordinatenx.size()-1)*raster+1>=width) { //\u00fcberpr\u00fcfung ob der schlangenkopf die grenzen \u00fcberschreitet, falls ja setze die x resp. y koordinaten zur\u00fcck
      koordinatenx.set(koordinatenx.size()-1, 0);
    }
    if (koordinatenx.get(koordinatenx.size()-1)*raster+1<=0) {
      koordinatenx.set(koordinatenx.size()-1, width/raster);
    }
    if (koordinateny.get(koordinateny.size()-1)*raster+1>=height) {
      koordinateny.set(koordinateny.size()-1, 0);
    }
    if (koordinateny.get(koordinateny.size()-1)*raster+1<=0) {
      koordinateny.set(koordinateny.size()-1, height/raster);
    }

    rect(koordinatenx.get(koordinatenx.size()-1)*(raster)+1, koordinateny.get(koordinateny.size()-1)*(raster)+1, (raster-1), (raster-1)); //der neue kopf zeichnen
    besetzt[koordinatenx.get(koordinatenx.size()-1)+1][koordinateny.get(koordinateny.size()-1)+1] = 1; //neuer kopf als besetzt markieren

    if (!neu) { //\u00fcberpr\u00fcfung ob KEIN neuer Apfel und die Schlange NICHT gr\u00f6sser werden muss
      fill(0xffFFFFFF); //bei ja setze F\u00fcllfarbe auf weiss
      rect(koordinatenx.get(0)*raster+1, koordinateny.get(0)*raster+1, (raster-1), (raster-1)); //zeichne ein Rechteck mit weisser Farbe an der letzten Stelle der Schlange (l\u00f6schen des letzten Gliedes)
      besetzt[koordinatenx.get(0)+1][koordinateny.get(0)+1] = 0; //das letzte Glied wieder als frei markieren
      koordinatenx.remove(0); //und schlussendlich die koordinaten aus der Liste l\u00f6schen
      koordinateny.remove(0);
    }
    else { //falls ein neuer Apfel generiert werden muss und Schlange gr\u00f6sser werden
      neu = false; //neu gerade falsch setzen
      score++; //score um 1 erh\u00f6hen --> man hat ja einen Apfel gegessen
      neuApfel(); //und schliesslich neuen Apfel essen
      //das letzte Glied wird nicht gel\u00f6scht --> Schlange wird um 1 Glied l\u00e4nger
    }
    
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#000000", "--stop-color=#cccccc", "Snake" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
