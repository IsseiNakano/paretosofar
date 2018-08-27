class Vector {
  int[] values ;
  Vector pred ;
  Vector succ ;
  Vector() {
  }
  Vector(int[] v) {
    values = v ;
  }
  int[] add(int[] w) {
    int[] v = new int[objectiveNum] ;
    for (int k = 0 ; k < objectiveNum ; k++) {
      v[k] = values[k] + w[k] ;
    }
    return v ;
  }
  int dominate(int[] u) {
    int status = 0 ;
    for (int k = 0 ; k < objectiveNum ; k++) {
      int d = u[k] - values[k] ;
      if (d > 0) status |= 1 ;
      else if (d < 0) status |= 2 ;
      if (status == 3) break ;
    }
    return status ;
  }
  void remove() {
    pred.succ = succ ;
    succ.pred = pred ;
  }
  String toString() {
    return join(nf(values, 0), ", ") ;
  }
}

class VectorSet {
  Vector head ;
  Vector anker ;
  VectorSet() {
    head = new Vector() ;
    reset() ;
  }
  void reset() {
    head.pred = head.succ = head ;
    fixedAll() ;
  }
  void fixedAll() {
    anker = head.pred ;
  }
  void insert(int[] u) {
    Vector vu = new Vector(u) ;
    vu.pred = head.pred ;
    vu.succ = head ;
    vu.pred.succ = head.pred = vu ;
  }
  void remove(Vector v) {
    v.remove() ;
    if (v == anker) anker = v.pred ;
  }
  int size() {
    int total = 0 ;
    for (Vector u = head.succ ; u != head ; u = u.succ)
    total++ ;
    return total ;
  }
  boolean update(VectorSet vs, int[] w) {
    boolean flag = false ;
    for (Vector u = anker.succ ; u != head ; u = u.succ) {
      if (vs.insertTest(u.add(w))) flag = true ;
    }
    return flag ;
  }
  boolean insertTest(int[] v) {
    if (! check(v)) return false ;
    insert(v) ;
    return true ;
  }
  boolean check(int[] u) {
    for (Vector v = head.succ ; v != head ; v = v.succ) {
      int status = v.dominate(u) ;
      if (status <= 1) return false ;
      if (status < 3) remove(v) ;
    }
    return true ;
  }
  String toString() {
    String stg = "" ;
    for (Vector v = head.succ ; v != head ; v = v.succ)
    stg += v + "\n" ;
    return stg + "\n" ;
  }
}
