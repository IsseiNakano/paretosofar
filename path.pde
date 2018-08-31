class Vector {
  int[] pathweight ;
  Vector pre ;
  Vector follow ;
  Vector() {
    pre = this ;
    follow = this ;
  }
  Vector(int[] weight) {
    pathweight = weight ;
  }
  void add(Vector a) {
    a.pre = this ;
    follow.pre = a ;
    a.follow = follow ;
    follow = a ;
  }
  void remove() {
    pre.follow = follow ;
    follow.pre = pre ;
  }
  void clear() {
    pre = this ;
    follow = this ;
  }
  boolean isEmpty(){
    return follow == this ;
  }
  void addAll(Vector a, Vector b) {
    pre.follow = a ;
    a.pre = pre ;
    pre = b ;
    b.follow = this ;
  }
  int[] calculation(int[] weight) {
    int[] value = new int[objective];
    for(int i = 0 ; i < objective ; i++)
      value[i] = pathweight[i] + weight[i] ;
    return value ;
  }
  int dominate(int[] u) {
    int status = 0 ;
    for (int k = 0 ; k < objective ; k++) {
      int d = u[k] - pathweight[k] ;
      if (d > 0) status |= 1 ;
      else if (d < 0) status |= 2 ;
      if (status == 3) break ;
    }
    return status ;
  }
  boolean check(int[] u) {
    for (Vector v = follow ; v != this ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status == 2) v.remove() ;
    }
    return true ;
  }
  boolean eqweight(int[] u) {
    for(int i = 0 ; i < objective ; i++)
      if(pathweight[i] != u[i])
        return false ;
    return true ;
  }
  boolean addInt(int[] u) {
    for(Vector v = follow ; v != this ; v = v.follow)
      if(v.eqweight(u))
        return false ;
    return true ;
  }
  boolean domi(int[] u) {
    for (Vector v = follow ; v != this ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status == 1) return false ;
      if (status == 2) v.remove() ;
    }
    return true ;
  }
}

class PathVec {
  Vector dummy ;
  int index ;
  int[][] w ;
  Vector upd ;
  Vector vs ;
  int mini[] ;
  Vector minis ;
  PathVec minipre ;
  PathVec() {
  }
  PathVec(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new Vector() ;
    upd = new Vector() ;
    vs = new Vector() ;
    minis = new Vector() ;
    mini = new int[objective] ;
    minipre = sss ;
  }
  void add(int[] wei) {
    dummy.pre.add(new Vector(wei)) ;
  }
  boolean paretoConstruction(PathVec pps) {
    boolean flag = false ;
    for(Vector s = pps.upd.follow ; s != pps.upd ; s = s.follow) {
      int[] path = s.calculation(w[pps.index]) ;
      if (minis.domi(path))
      if (dummy.check(path))
      if (upd.check(path))
      if (vs.check(path)) {
        // solutionin++ ;
        vs.add(new Vector(path)) ;
        flag = true ;
      }
    }
    return flag ;
  }
  int leng() {
    int count = 0 ;
    for(Vector s = dummy.follow ; s != dummy ; s = s.follow)
      count++ ;
    return count ;
  }
  void update() {
    if(!upd.isEmpty()) {
      dummy.addAll(upd.follow, upd.pre) ;
      upd.clear() ;
    }
    if(!vs.isEmpty()) {
      upd.addAll(vs.follow, vs.pre) ;
      vs.clear() ;
    }
  }
  void reset() {
    dummy.clear() ;
    upd.clear() ;
    vs.clear() ;
    minis.clear() ;
    minipre = sss ;
  }
  int negativeCycleCheck(PathVec pps, int k) {
    if(mini[k] > pps.mini[k] + w[pps.index][k]) {
      int[] value = new int[objective];
      for(int i = 0 ; i < objective ; i++)
        value[i] = pps.mini[i] + w[pps.index][i] ;
      mini = value ;
      if(minipre == pps) return 3 ;
      minipre = pps ;
      return 2 ;
    }
    if(mini[k] == pps.mini[k] + w[pps.index][k]) {
      for(int i = 0 ; i < objective ; i++) {
        if(mini[i] > pps.mini[i] + w[pps.index][i]) {
          int[] value = new int[objective];
          for(int j = 0 ; j < objective ; j++)
            value[j] = pps.mini[j] + w[pps.index][j] ;
          mini = value ;
          if(minipre == pps) return 3 ;
          minipre = pps ;
          return 2 ;
        } else if (mini[i] < pps.mini[i] + w[pps.index][i]) {
          return 1 ;
        }
      }
    }
    return 1 ;
  }
  void removeObject(int k) {
    for(int i = 0 ; i < w.length ; i++)
      w[i][k] = 0 ;
  }
  void miniZero() {
    int[] value = new int[objective];
    for(int i = 0 ; i < objective ; i++)
      value[i] = 0 ;
    mini = value ;
  }
  void miniClear() {
    int[] value = new int[objective];
    for(int i = 0 ; i < objective ; i++)
      value[i] = maxint ;
    mini = value ;
  }
  void conversion() {
    if(minis.check(mini))
      minis.add(new Vector(mini)) ;
  }
  void updAddMinis() {
    upd.addAll(minis.follow, minis.pre) ;
  }
  int minileng() {
    int count = 0 ;
    for(Vector s = minis.follow ; s != minis ; s = s.follow)
      count++ ;
    return count ;
  }
  void minishow() {
    for(Vector s = minis.follow ; s != minis ; s = s.follow)
      println(s.pathweight) ;
  }
}
