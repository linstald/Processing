/*
Dieses Programm illustriert die Laufzeit einer simplen, rekursiven Funktion.
*/

int counter =0;
void setup() {
  size(1280, 1280);
  translate(0,height/2);
  strokeWeight(1);
  float n = 0.8*width; //1024
  spiral(n);
  println("Elementaroperationen gezählt: "+counter);
  println("Elementaroperationen gerechnet (3*log2(n)): "+3*(log(n)/log(2)));
}

void spiral(float len) { //rekursive funktion, abhängig von len

  if (len<=1) { //Verankerung: len<=1
    return;
  }
  
  line(0, 0, len, 0);
  translate(len,0);
  rotate(HALF_PI);

  counter+=3; //Zählen der Elementaroperationen welche in konstanter Zeit laufen, hier: line, translate, rotate
  
  spiral(len/2); //aufruf der funktion für len/2 
}

/*
Laufzeitanalyse:
spiral(n) hat eine Laufzeit von spiral(n/2) (rekursiver aufruf) + 3 (elementaroperationen)
Wenn also T(n) die Laufzeit von spiral(n) repräsentiert:
T(n) = T(n/2)+3

Zur Vereinfachung nehmen wir an, dass n eine 2er Potenz ist, das heisst: n = 2^k
Durch einsetzen von T(n/2) = T(n/4)+3 in T(n) erhalten wir:
T(n) = (T(n/4)+3)+3

Dieses Verfahren kann man fortsetzen bis T(1) erreicht wurde:
T(n) = ((T(n/8)+3)+3)+3 = (((T(n/16)+3)+3)+3)+3 = ... = log2(n)*3

Man stellt fest, dass man dieses Verfahren genau log2(n) = log2(2^k) = k mal durchgeführt hat und dabei
T(n) = 3*k = 3*log2(n) ergibt.

Somit haben wir die Laufzeit von spiral(n) herausgefunden
in O-Notation ist diese also:
O(3*log2(n)) = O(log2(n)) = O(log(n))
*/
