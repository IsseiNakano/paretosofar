class Vector {
  int[] pathweight ;
  Vector pre ;
  Vector follow ;
  int prenode ;
  Vector nodevec ;
  Vector() {
    pre = this ;
    follow = this ;
  }
  Vector(int[] weight, int node) {
    pathweight = weight ;
    prenode = node ;
  }
  Vector(int[] weight, int node, Vector vec) {
    pathweight = weight ;
    prenode = node ;
    nodevec = vec ;
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
  void removeObject(int k) {
    for (Vector v = follow ; v != this ; v = v.follow)
      v.pathweight[k] = 0 ;
  }
  void removeObject(Vector k) {
    for (Vector v = follow ; v != this ; v = v.follow)
      k.removecheck(v.pathweight) ;
  }
  void removecheck(int[] u) {
    for (Vector v = follow ; v != this ; v = v.follow) {
      int status = v.dominate(u) ;
      if (status == 2) v.remove() ;
    }
  }
}
 class PathVec {
  Vector dummy ;
  int index ;
  int[][] w ;
  Vector upd ;
  Vector vs ;
  PathVec() {
  }
  PathVec(int i, int[][] wei) {
    index = i ;
    w = wei ;
    dummy = new Vector() ;
    upd = new Vector() ;
    vs = new Vector() ;
  }
  boolean paretoConstruction(PathVec pps) {
    boolean flag = false ;
    for(Vector s = pps.upd.follow ; s != pps.upd ; s = s.follow) {
      int[] path = s.calculation(w[pps.index]) ;
      if(check(path))
        if(negativeCheck(path, pps.index, s)) {
          vs.add(new Vector(path, pps.index, s)) ;
          flag = true ;
        }
    }
    return flag ;
  }
  boolean check(int[] path) {
    if (dummy.check(path))
      if (upd.check(path))
        if (vs.check(path))
          return true ;
    return false ;
  }
  boolean negativeCheck(int[] path, int ppsindex, Vector s) {
    boolean flag = true ;
    for(Vector v = s ; v.prenode != -1 ; v = v.nodevec)
      if(v.prenode == ppsindex)
        for(int i = 0 ; i < objective ; i++)
          if(v.pathweight[i] > path[i]) {
            negativeobj[i] = true ;
            flag = false ;
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
  }
  void removeObject(int k) {
    for(int i = 0 ; i < w.length ; i++)
      w[i][k] = 0 ;
    dummy.removeObject(k) ;
    upd.removeObject(k) ;
    vs.removeObject(k) ;
    removeObject() ;
  }
  void removeObject() {
    dummy.removeObject(dummy) ;
    upd.removeObject(upd) ;
    vs.removeObject(vs) ;
    dummy.removeObject(upd) ;
    dummy.removeObject(vs) ;
    upd.removeObject(dummy) ;
    upd.removeObject(vs) ;
    vs.removeObject(dummy) ;
    vs.removeObject(upd) ;
  }
}
