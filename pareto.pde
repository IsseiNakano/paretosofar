class WeightInfo {
  int[][][] weight ;
  VectorSet[] labels ;
  WeightInfo(String dir, int b, int[] m) {
    weight = new int[vertexNum][vertexNum][objectiveNum] ;
    for (int k = 0 ; k < m.length ; k++) {
      String[] lines = loadStrings(dir + "weight_" + vertexNum + "_" + b + "_" + m[k] + ".csv") ;
      for (int i = 0 ; i < vertexNum ; i++) {
        int[] data = int(float(split(lines[i], ","))) ;
        for (int j = 0 ; j < vertexNum ; j++) {
          weight[i][j][k] = data[j] ;
        }
      }
    }
    labels = new VectorSet[vertexNum] ;
    for (int i = 0 ; i < vertexNum ; i++) {
      labels[i] = new VectorSet() ;
    }
  }
  void reset() {
    for (VectorSet vs : labels) {
      vs.reset() ;
    }
  }
  int size() {
    int total = 0 ;
    for (VectorSet vs : labels)
    total += vs.size() ;
    return total ;
  }
  int update() {
    reset() ;
    int time = millis() ;
    labels[0].insert(new int[objectiveNum]) ;
    while (true) {
      boolean stable = true ;
      for (int i = 0 ; i < vertexNum ; i++) {
        VectorSet li = labels[i] ;
        if (li.anker.succ == li.head) continue ;
        for (int j = 0 ; j < vertexNum ; j++) {
          if (j == i) continue ;
          if (li.update(labels[j], weight[i][j])) stable = false ;
        }
        li.fixedAll() ;
      }
      if (stable) break ;
    }
    return millis() - time ;
  }
}
