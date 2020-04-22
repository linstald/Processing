class Population {

  Player[] popul; 
  int reachcount;
  color best = color(#00FF30);
  color main = color(#1800FF, 150);
  ArrayList<Dna> mates = new ArrayList<Dna>();
  
  Population(int entities) {
    popul = new Player[entities];
    for (int i = 0; i<popul.length; i++) {
      popul[i] = new Player(start.x, start.y);
    }
  }

  void update() {
    reachcount = 0;
    for (int i = 0; i<popul.length; i++) {
      popul[i].update();
      if (popul[i].fitness ==1 ) {
        popul[i].show(best);
      } else {
        popul[i].show(main);
      }
      if (popul[i].reached) {
        reachcount++;
      }
    }
  }
  void newpopul() {
    calcFitness();
    putinmates();
    mate();
  }
  void calcFitness() {
    for (int i = 0; i<popul.length; i++) {
      popul[i].calcFitness();
    }
    float maxfit = 0;
    for (int i = 0; i<popul.length; i++) {
      if (popul[i].fitness>maxfit) {
        maxfit =  popul[i].fitness;
      }
    }
    for (int i = 0; i<popul.length; i++) {
      popul[i].fitness /= maxfit;
    }
  }

  Dna getBestDna() {
    Dna best = new Dna(popul[0].dna.genes);
    for (int i = 0; i<popul.length; i++) {
      if (popul[i].fitness==1) {
        best = new Dna(popul[i].dna.genes);
      }
    }
    return best;
  }

  void putinmates() {
    if (mates.size()<100000) {
      for (int i = 0; i<popul.length; i++) {
        int n;
        if (popul[i].fitness == 1) {
          mates.add(popul[i].dna);
          n = int(mates.size()/2);
        } else {
          n = int(popul[i].fitness*10);
        }
        for (int j= 0; j<n; j++) {
          mates.add(popul[i].dna);
        }
      }
    } else {
      mates.clear();
      mates.add(getBestDna());
    }
  }

  void mate() {
    println(mates.size());
    for (int i = 0; i< popul.length; i++) {
      Dna a = mates.get(int(random(mates.size()-1)));
      Dna b = mates.get(int(random(mates.size()-1)));
      popul[i] = a.crossover(b);
    }
  }
}
