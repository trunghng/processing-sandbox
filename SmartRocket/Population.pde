class Population {

  float mutationRate;
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;

  Population(float mr, int popsize) {
    mutationRate = mr;
    population = new Rocket[popsize];
    matingPool = new ArrayList<Rocket>();
    generations = 0;

    for (int i = 0; i < popsize; i++) {
      population[i] = new Rocket();
    }
  }

  void live() {
    for (int i = 0; i < population.length; i++) {
      population[i].run();
    }
  }

  void fitness() {
    for (Rocket rocket : population) {
      rocket.fitness();
    }
  }

  void selection() {
    matingPool.clear();

    float maxFitness = getMaxFitness();

    for (int i = 0; i < population.length; i++) {
      float normalizedFitness = map(population[i].getFitness(), 0, maxFitness, 0, 1);
      int n = (int)(normalizedFitness * 100);
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }

  void reproduction() {
    for (int i = 0; i < population.length; i ++) {
      // Select parent
      int a = int(random(0, matingPool.size()));
      int b = int(random(0, matingPool.size()));
      Rocket partnerA = matingPool.get(a);
      Rocket partnerB = matingPool.get(b);
      DNA partnerAGene = partnerA.getDNA();
      DNA partnerBGene = partnerB.getDNA();

      // Crossover
      DNA childGene = partnerAGene.crossover(partnerBGene);

      // Mutation
      childGene.mutate(mutationRate);

      // Overwrite population with the new one
      population[i] = new Rocket(childGene);
    }
    generations++;
  }

  float getMaxFitness() {
    float maxFitness = 0;
    for (Rocket rocket : population) {
      float rocketFitness = rocket.getFitness();
      if (rocketFitness > maxFitness) {
        maxFitness = rocketFitness;
      }
    }
    return maxFitness;
  }

  int getGenerations() {
    return generations;
  }
}
