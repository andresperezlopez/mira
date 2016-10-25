class Reactive {
  int ERR = -1;
  int OK = 1;

  int w, h;
  int[] matrix;

  int resolution;    // Divides the matrix in different areas horizontally. Range: [1,w]
  float modifier;   // Modifies the value of the matrix.

  Reactive(int w, int h) {
    this.w = w;
    this.h = h;
    matrix = new int[w*h];
    resolution = 1;
    float modifier = 1.0;
  }

  int size() {
    return matrix.length;
  }

  // pos = (1, size)
  int get(int x, int y) {
    if (x > 0 && y > 0 && x <= w && y <= h) { 
      int index = (x-1) + (y-1) * w;
      return matrix[index];
    } 
    return ERR;
  }

  int set(int x, int y, int value) {
    if (x > 0 && y > 0 && x <= w && y <= h) { 
      int index = (x-1) + (y-1) * w;
      matrix[index] = value;

      return OK;
    } 
    return ERR;
  }

  int[] getMatrix() {
    return matrix;
  }

  int setMatrix(int[] newMatrix) {
    if (newMatrix.length == matrix.length) {
      for (int i=0; i<matrix.length; i++) {
        matrix[i] = newMatrix[i];
      }
      return OK;
    }
    return ERR;
  }
  
  int getResolution() {
    return resolution;
  }
  
  void setResolution(int res, int a, int b) {
    resolution = round(map(res, 1, w, a, b));
  }
}

