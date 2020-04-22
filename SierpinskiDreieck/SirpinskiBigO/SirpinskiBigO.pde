double counter=0;
void setup() {
  size(1000, 1000);

  float w = 1000;
  float h = (w/2)*sqrt(3);
    
  sirpinski(w/2, w/4, height-h/2);
  float lb = log(w/2)/log(2);
  float po = pow(w/2,lb);
  println(lb + " "+po+" "+counter);
  println(counter/pow(w/2, lb));
}

void sirpinski(float n, float x, float y) {
  
  if(n<=1) {                        // T(1) = 1
    counter++;                      //
    return;                         //
  }                                 //
                                    //
  float h = sqrt(3)*(n/2);          // O(1)
  counter++;                        //
                                    //
  line(x, y, x+n, y);               // O(1)
  line(x, y, x+n/2, y+h);           // O(1)
  line(x+n, y, x+n/2, y+h);         // O(1)
  counter+=3;                       //
                                    //
  sirpinski(n/2, x-n/4, y+h/2);     // T(n/2)
  sirpinski(n/2, x+n/4, y-h/2);     // T(n/2)
  sirpinski(n/2, x+3*n/4, y+h/2);   // T(n/2)
                                    //
                                    // Total:
                                    // T(n) = 3*T(n/2) + 4 (für n>1)
                                    // T(n) = 1 (für n = 1)
                                    //
                                    // ergibt: O(n^(log2(n))
}
