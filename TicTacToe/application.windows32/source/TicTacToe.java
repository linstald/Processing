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

public class TicTacToe extends PApplet {

public void setup() {
  
  textSize(30);
  rect(0, 0, 200, 200);
  rect(200, 0, 200, 200);
  rect(400, 0, 200, 200);
  rect(0, 200, 200, 200);
  rect(200, 200, 200, 200);
  rect(400, 200, 200, 200);
  rect(0, 400, 200, 200);
  rect(200, 400, 200, 200);
  rect(400, 400, 200, 200);
  fill(255);
  rect(0, 600, 600, 100);
}
int turn=0;
long besetzt1=0;
long besetzt2=0;
long besetzt3=0;
long besetzt4=0;
long besetzt5=0;
long besetzt6=0;
long besetzt7=0;
long besetzt8=0;
long besetzt9=0;
int pruf1;
int pruf2;
int pruf3;
int pruf4;
int pruf5;
int pruf6;
int pruf7;
int pruf8;
int pruf9;
int pruf11;
int pruf12;
int pruf13;
int pruf14;
int pruf15;
int pruf16;
int pruf17;
int pruf18;
int pruf19;

boolean fertig=false;

public void draw() {

  if (turn==0) {
    fill(0);
    text("O ist dran", 200, 650);
  } else {
    fill(0);
    text("X ist dran", 200, 650);
  }
  if (pruf1+pruf2+pruf3==60||pruf4+pruf5+pruf6==150||pruf7+pruf8+pruf9==240||pruf1+pruf5+pruf9==150||pruf3+pruf5+pruf7==150) {
    fill(255);
    rect(0, 600, 600, 100);
    fill(0);
    text("O gewinnt", 200, 650);
    fertig=true;
  }
  if (pruf11+pruf12+pruf13==63||pruf14+pruf15+pruf16==153||pruf17+pruf18+pruf19==243||pruf11+pruf15+pruf19==153||pruf13+pruf15+pruf17==153) {
    fill(255);
    rect(0, 600, 600, 100);
    fill(0);
    text("X gewinnt", 200, 650);
    fertig=true;
  }
  if ((besetzt1+besetzt2+besetzt3+besetzt4+besetzt5+besetzt6+besetzt7+besetzt8+besetzt9)==45) {
    fill(255);
    rect(0, 600, 600, 100);
    fill(0);
    text("Unentschieden", 200, 650);
    fertig=true;
  }
}


public void mouseReleased() {
  if (!fertig) {
    int x = mouseX;
    int y = mouseY;

    fill(255);
    rect(0, 600, 600, 100);

    if (x>=0 && x<200 && y>=0 && y<200 && turn==0 && besetzt1!=1) {
      ellipse(100, 100, 100, 100);
      println("1");
      turn=1;
      besetzt1=1;
      pruf1=10;
      println("turn" + turn);
    } else

      if (x>=200 && x<400 && y>=0 && y<200 && turn==0 && besetzt2!=2) {
        ellipse(300, 100, 100, 100);
        println("2");
        turn=1;
        besetzt2=2;
        pruf2=20;
        
      } else 
      if (x>=400 && x<600 && y>=0 && y<200 && turn==0 && besetzt3!=3) {
        ellipse(500, 100, 100, 100);
        println("3");
        turn=1;
        besetzt3=3;
        pruf3=30;
      } else 

      if (x>=0 && x<200 && y>=200 && y<400 && turn==0 && besetzt4!=4) {
        ellipse(100, 300, 100, 100);
        println("4");
        turn=1;
        besetzt4=4;
        pruf4=40;
      } else

        if (x>=200 && x<400 && y>=200 && y<400 && turn==0 && besetzt5!=5) {
          ellipse(300, 300, 100, 100);
          println("5");
          turn=1;
          besetzt5=5;
          pruf5=50;
        } else

          if (x>=400 && x<600 && y>=200 && y<400 && turn==0 && besetzt6!=6) {
            ellipse(500, 300, 100, 100);
            println("6");
            turn=1;
            besetzt6=6;
            pruf6=60;
          } else

            if (x>=0 && x<200 && y>=400 && y<600 && turn==0 && besetzt7!=7) {
              ellipse(100, 500, 100, 100);
              println("7");
              turn=1;
              besetzt7=7;
              pruf7=70;
            } else

              if (x>=200 && x<400 && y>=400 && y<600 && turn==0 && besetzt8!=8) {
                ellipse(300, 500, 100, 100);
                println("8");
                turn=1;
                besetzt8=8;
                pruf8=80;
              } else

                if (x>=400 && x<600 && y>=400 && y<600 && turn==0 && besetzt9!=9) {
                  ellipse(500, 500, 100, 100);
                  println("9");
                  turn=1;
                  besetzt9=9;
                  pruf9=90;
                } else

                  if (x>=0 && x<200 && y>=0 && y<200 && turn==1 && besetzt1!=1) {
                    line(0, 0, 200, 200);
                    line(0, 200, 200, 0);
                    println("1");
                    turn=0;
                    besetzt1=1;
                    pruf11=11;
                    println("turn" + turn);
                  } else

                    if (x>=200 && x<400 && y>=0 && y<200 && turn==1 && besetzt2!=2) {
                      line(200, 0, 400, 200);
                      line(200, 200, 400, 0);
                      println("2");
                      turn=0;
                      besetzt2=2;
                      pruf12=21;
                    } else 

                    if (x>=400 && x<600 && y>=0 && y<200 && turn==1 && besetzt3!=3) {
                      line(400, 0, 600, 200);
                      line(400, 200, 600, 0);
                      println("3");
                      turn=0;
                      besetzt3=3;
                      pruf13=31;
                    } else

                      if (x>=0 && x<200 && y>=200 && y<400 && turn==1 && besetzt4!=4) {
                        line(0, 200, 200, 400);
                        line(0, 400, 200, 200);
                        println("4");
                        turn=0;
                        besetzt4=4;
                        pruf14=41;
                      } else

                        if (x>=200 && x<400 && y>=200 && y<400 && turn==1 && besetzt5!=5) {
                          line(200, 200, 400, 400);
                          line(200, 400, 400, 200);
                          println("5");
                          turn=0;
                          besetzt5=5;
                          pruf15=51;
                        } else

                          if (x>=400 && x<600 && y>=200 && y<400 && turn==1 && besetzt6!=6) {
                            line(400, 200, 600, 400);
                            line(400, 400, 600, 200);
                            println("6");
                            turn=0;
                            besetzt6=6;
                            pruf16=61;
                          } else

                            if (x>=0 && x<200 && y>=400 && y<600 && turn==1 && besetzt7!=7) {
                              line(0, 400, 200, 600);
                              line(0, 600, 200, 400);
                              println("7");
                              turn=0;
                              besetzt7=7;
                              pruf17=71;
                            } else

                              if (x>=200 && x<400 && y>=400 && y<600 && turn==1 && besetzt8!=8) {
                                line(200, 400, 400, 600);
                                line(200, 600, 400, 400);
                                println("8");
                                turn=0;
                                besetzt8=8;
                                pruf18=81;
                              } else

                                if (x>=400 && x<600 && y>=400 && y<600 && turn==1 && besetzt9!=9) {
                                  line(400, 400, 600, 600);
                                  line(400, 600, 600, 400);
                                  println("9");
                                  turn=0;
                                  besetzt9=9;
                                  pruf19=91;
                                }
  }
}
  public void settings() {  size(600, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "TicTacToe" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
