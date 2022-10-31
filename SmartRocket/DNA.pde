class DNA { // Genotype
   
  PVector[] genes;
  
  float maxforce = 0.1;
  
  DNA() {
    genes = new PVector[lifetime];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = PVector.random2D();
      genes[i].mult(random(0, maxforce));
    }
  }
  
  DNA(PVector[] newGenes) {
    genes = newGenes;
  }
  
  DNA crossover(DNA partner) {
    PVector[] childGenes = new PVector[genes.length];
    int midpoint = int(random(genes.length));
    
    for (int i = 0; i < genes.length; i++) {
      if (i < midpoint) {
        childGenes[i] = genes[i];
      } else {
        childGenes[i] = partner.genes[i];
      }
    }
    return new DNA(childGenes);
  }
  
  void mutate(float mutationRate){
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = PVector.random2D();
        genes[i].mult(random(0, maxforce));
      }
    }
    
  }
  
}
