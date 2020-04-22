//********** SNAKE-SPIEL   **********//
//Ein Snake Spiel mit Kommentaren, um den Code auch zu verstehen.
//
//Anleitung: Sobald der Sketch gestartet wurde, baut sich die Schlange zusammen. Man kann sie mit den Pfeiltasten steuern.
//Das Ziel ist es soviele Äpfel (rote Pixel) zu sammeln wie nur möglich. Man darf nicht in sich selber "fahren". Man kann jedoch durch die "Wände" des Displays gehen.
//
//Programmiert von: Linus Stalder
//**********************************//

// Variablen deklarieren
IntList koordinatenx = new IntList(); //IntList für die xKoordinaten der Schlange
IntList koordinateny = new IntList(); //...für ykoordinaten
String taste; //variable für den tasteninput
boolean neu; //boolean um die schlange eines länger zu machen und neuen apfel zu generieren
int[][] besetzt; //Array mit Informationen über das gesamte KoordinatenRaster: 0=nicht besetzt, 1=besetzt von Schlange, 2=besetzt von Apfel; die Indizes korrespondieren den Koordinaten
boolean finished; //boolean um das Spiel zu beenden
int score; //variable für den Spielstand
int raster; // variable für die breite/länge des rasters

void setup() {      //void setup:
  fullScreen();  //grösse definieren
  stroke(0);        //farbe der border definieren
  background(#FFFFFF);    //farbe des hintergrundes definieren
  fill(#000000);        //farbe des füllens definieren
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
  
  koordinatenx.clear();            //darauf achten, dass die Listen für koordinaten leer sind
  koordinateny.clear();
  
  besetzt = new int[width/raster+2][height/raster+2]; //array besetzt initialisieren --> eines grösser als das Display ist, da man sonst beim seitenwechsel auf einen negativen Index kommt (Error)
  for (int m = 0; m < width/raster+2; m++) {
    for (int n = 0; n < height/raster+2; n++) {
      besetzt[m][n] = 0;
    }
  }
  
  noStroke(); //noStroke um grenze der Rechtecke wegzunehmen
  koordinatenx.append((width/2)/raster); //erste koordinate einführen..
  koordinateny.append((height/2)/raster);

  for (int c= 0; c<10; c++) {
    koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)+1); //...um sie hier zu erweitern
    koordinateny.append(koordinateny.get(koordinateny.size()-1));
  }
  neuApfel(); //apfel generieren
}

void keyPressed() { //funktion zur überprüfung der tastatureingabe
  switch (keyCode) { //keyCode=gedrücke Sondertaste
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

void mousePressed() { //funktion zur überprüfung der Mauseingabe
  if (mouseButton==LEFT) { //bei gedrückter linker maustaste: noch einmal von vorne (setup())
    fill(#000000);
    setup();
  }
}

void neuApfel() { //funktion für die Generierung des Apfels
  int a = int(random(0, width/(raster)-1)); //zufallswerte für die beiden Koordinaten bestimmen (a und b)
  int b = int(random(0, height/(raster)-1));

  if (besetzt[a+1][b+1] != 1) { //überprüfung ob apfelpostion von der schlange besetzt ist
    besetzt[a+1][b+1] = 2; //falls nein nun besetzt von apfel
    fill(#FF0000); //zeichne apfel
    rect(a*(raster)+1, b*(raster)+1, (raster-1), (raster-1));
  }
  else {
    neuApfel(); //falls ja mache neuen apfel
  }
}


void draw() { //funktion die in der sekunde soviel mal ausgeführt wird wie in framerate angegeben
  if (finished) { //überprüfung ob finished bereits eingetroffen ist, d.h. ob das Spiel beendet wird
    fill(#FF0000); //bei ja GameOver und Score ausgeben
    textSize((height/((width/height)*4)));
    text("GAME-OVER", 0, height/2);
    fill(#0000FF);
    textSize((height/((width/height)*4))/4);
    text("Your Score =" + score, width/3, 2*height/3);
  }
  else { //bei nein
  
    if (taste == "RIGHT") { //falls die taste rechts gedrückt ist
      if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1)%(height/raster)] == 0) { //überprüfe ob an der nächsten stelle richtung rechts vom Schlangenkopf noch frei ist
        koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)+1); // falls ja dann füge diese stelle in die koordinaten hinzu
        koordinateny.append(koordinateny.get(koordinateny.size()-1));
      }
      else { //bei nein
        if (besetzt[(koordinatenx.get(koordinatenx.size()-1)+1+1)%(width/raster)][(koordinateny.get(koordinateny.size()-1)+1)%(height/raster)] == 2) { //überprüfe ob die stelle vom apfel besetzt ist
          neu = true; //falls ja neu true setzen um neuen apfel zu generieren und schlange grösser zu machen
          koordinatenx.append(koordinatenx.get(koordinatenx.size()-1)+1); //stelle hinzufügen
          koordinateny.append(koordinateny.get(koordinateny.size()-1));
        }
        else { //falls nein --> man ist in ein schlangenstück hineingefahren, was heisst das spiel ist fertig
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
    
    fill(#00FF00); //wieder richtige füllfarbe definieren
    if (koordinatenx.get(koordinatenx.size()-1)*raster+1>=width) { //überprüfung ob der schlangenkopf die grenzen überschreitet, falls ja setze die x resp. y koordinaten zurück
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

    if (!neu) { //überprüfung ob KEIN neuer Apfel und die Schlange NICHT grösser werden muss
      fill(#FFFFFF); //bei ja setze Füllfarbe auf weiss
      rect(koordinatenx.get(0)*raster+1, koordinateny.get(0)*raster+1, (raster-1), (raster-1)); //zeichne ein Rechteck mit weisser Farbe an der letzten Stelle der Schlange (löschen des letzten Gliedes)
      besetzt[koordinatenx.get(0)+1][koordinateny.get(0)+1] = 0; //das letzte Glied wieder als frei markieren
      koordinatenx.remove(0); //und schlussendlich die koordinaten aus der Liste löschen
      koordinateny.remove(0);
    }
    else { //falls ein neuer Apfel generiert werden muss und Schlange grösser werden
      neu = false; //neu gerade falsch setzen
      score++; //score um 1 erhöhen --> man hat ja einen Apfel gegessen
      neuApfel(); //und schliesslich neuen Apfel essen
      //das letzte Glied wird nicht gelöscht --> Schlange wird um 1 Glied länger
    }
    
  }
}