class Dna {
 int[] genes = new int[maxdur];
 Dna() {
  for (int i = 0; i<maxdur; i++) {
    genes[i] = int(random(5));
  }
 }
 Dna(int[] genes) {
  for (int i = 0; i<genes.length; i++) {
    this.genes[i] = genes[i];
  }
 }
 int mutate() {
   return int(random(5));
 }
 Player crossover (Dna b) {
   int mid = int(random(genes.length));
   int[] newgenes = new int[maxdur];
   for (int i = 0; i<genes.length; i++){
     if (i < mid) {
       newgenes[i] = this.genes[i];
     }else {
       newgenes[i] = b.genes[i];
     }
     float r = random(1);
     if (r<0.01) {
       newgenes[i] = mutate();
     }
   }
   Player child = new Player(start.x, start.y, new Dna(newgenes));
   return child;
 }
}