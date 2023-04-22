#include <math.h>

#include "../include/functions.h"
#include "../include/grRDF.h"

int main(int argc, char *argv[]) {
  double dx, dy, dt, tf;
  int nx, ny, nt;
  grRDF gr;
  if (argc != 7 || sscanf(argv[1], "%lf", &dx) != 1 || sscanf(argv[2], "%lf", &dy) != 1 || sscanf(argv[3], "%d", &nx) != 1 || sscanf(argv[4], "%d", &ny) != 1 || sscanf(argv[5], "%lf", &dt) != 1 || sscanf(argv[6], "%lf", &tf) != 1) {
    printf("Execute as ./bin/main dx dy nx ny dt tf\n");
    return -1;
  }
  nt = (int)ceil(tf / dt) + 1;

// Uncomment the following line to use the polynomial functions
#define ex2  // polynomial functios (as a sample)
#ifdef ex2
#define F f_pol
#define G g_pol
#define H h_pol
#else  // ex3 is defined, which include the real functions for the heat equation problem
#define F f
#define G g
#define H h
#endif

  grRDF_init(&gr, dx, dy, dt, nx, ny, H);
  FILE *fp;
  if ((fp = fopen("data/grid.txt", "w")) == NULL) {
    printf("Cannot open the file.\n");
    return 1;
  }

  grRDF_escriure(&gr, fp);
  for (int i = 1; i < nt; i++) {
    fprintf(fp, "\n");  // To avoid gnuplot detecting an extra datablock.
    grRDF_pasCalExpl(&gr, F, G);
    grRDF_escriure(&gr, fp);
  }

  // Exercice 2
  double errorL1 = 0;
  for (int i = 0; i < gr.nx + 1; i++) {
    for (int j = 0; j < gr.ny + 1; j++)
      errorL1 += fabs(gr.u[(gr.nx + 1) * i + j] - G(gr.t, i * gr.dx, j * gr.dy));
  }
  printf("Error in L1: %lf\n", errorL1);

  // Exercice 3b
  // Execute with (for example) ./bin/main 0.01 0.01 5 5 0.01 10
  // We obtain (large) negative values which are physically impossible because the temperature at the plate is at 0ºC at the beginning and we are heating (not cooling) the plate!

  // Exericie 3c
  // ?????????
  fclose(fp);
  return 0;
}
