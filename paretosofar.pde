// String dir = "../../../../data/" ;
String dir = "/Users/nakano/Desktop/instanceData/" ;
final int vertexNum = 500 ;
final int bound = 300 ;
final int objectiveNum = 3 ;

void setup() {
  int[] m = {0,1,2} ;
  singleInstanceExperiment(m) ;
  exit() ;
}

void fullExperiment() {

}

void singleInstanceExperiment(int[] m) {
  WeightInfo wi = new WeightInfo(dir, bound, m) ;
  int time = Integer.MAX_VALUE ; ;

  for (int i = 0 ; i < 10 ; i++) {
    int times = wi.update() ;
    time = min(time, times) ;
    println(times) ;
  }
  println(wi.size() + "," + time) ;
}
