class ParetoSolution {
  int[][][] weight ;
  PathVec[] pareto ;
  int[] mm ;
   ParetoSolution(int[] m) {
    weight = instanceText(m) ;
    mm = m ;
    // weight = randomWeight() ;
    pareto = new PathVec[nodenum] ;
    for(int j = 0 ; j < nodenum ; j++)  pareto[j] = new PathVec(j, weight[j]) ;
  }
   int bellmanford() {
    reset() ;
    int start = millis() ;
    pareto[0].upd.add(new Vector(new int[objective], -1)) ;
    bellmanfordlayer() ;
    return millis() - start ;
  }
  void bellmanfordlayer() {
    boolean flag = true ;
    while(flag) {
      flag = false ;
      for(PathVec ps : pareto)
        for(PathVec pps : pareto)
          if(ps.index != pps.index)
          if(ps.paretoConstruction(pps)) flag = true ;
      for(PathVec ps : pareto)
        ps.update() ;
      for(int i = 0 ; i < objective ; i++)
        if(negativeobj[i] == true) {
          removeObject(i) ;
          negativeobj[i] = false ;
        }
    }
  }
  void removeObject(int k) {
   for(PathVec ps : pareto)
     ps.removeObject(k) ;
   }
   void reset() {
    for (PathVec vs : pareto) {
      vs.reset() ;
    }
    weight = instanceText(mm) ;
    for(int j = 0 ; j < nodenum ; j++)  pareto[j].w = weight[j] ;
  }
   void update() {
    int time = Integer.MAX_VALUE ; ;
    for(int i = 0 ; i < experimentNum ; i++) {
      int times = bellmanford() ;
      time = min(time, times) ;
      println(times) ;
    }
    println(leng()+","+time) ;
  }
   int leng() {
    int count = 0 ;
    for(PathVec ps : pareto)
     count += ps.leng() ;
    return count ;
  }
   int[][][] instanceText(int[] m) {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dir + "weight_" + nodenum + "_" + bound + "_" + m[k] + ".csv");
      for(int i = 0 ; i < nodenum ; i++){
        String[] values = split(lines[i], ",") ;
        for(int j = 0 ; j < nodenum ; j++) {
          weight[j][i][k] = int(values[j]) ;
        }
      }
    }
    return weight ;
  }
   int[][][] instanceTextF(int[] m) {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dirF + "cost" + m[k] + ".csv");
      for(int i = 0 ; i < nodenum ; i++){
        String[] values = split(lines[i], ",") ;
        for(int j = 0 ; j < nodenum ; j++) {
          weight[j][i][k] = int(values[j]) ;
        }
      }
    }
    return weight ;
  }
   int[][][] randomWeight() {
    int[][][] weight = new int[nodenum][nodenum][objective] ;
    for (int k = 0 ; k < nodenum ; k++) {
      for(int i = 0 ; i < nodenum ; i++){
        for(int j = 0 ; j < objective; j++) {
          weight[k][i][j] = int(random(bound)) ;
        }
      }
    }
    return weight ;
  }
 }
