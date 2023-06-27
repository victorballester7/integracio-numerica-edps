#include <time.h>

#include "../include/functions.h"
#include "../include/grid.h"

int main(int argc, char *argv[]) {
  double dx, dy, dt, tf;
  int nx, ny, nt;
  Grid gr;

  if (argc != 7 || sscanf(argv[1], "%lf", &dx) != 1 || sscanf(argv[2], "%lf", &dy) != 1 || sscanf(argv[3], "%d", &nx) != 1 || sscanf(argv[4], "%d", &ny) != 1 || sscanf(argv[5], "%lf", &dt) != 1 || sscanf(argv[6], "%lf", &tf) != 1) {
    printf("Execute as ./bin/main dx dy nx ny dt tf\n");
    return -1;
  }

  // change of variable
  tf *= k / (c * rho);
  dt *= k / (c * rho);

  nt = (int)ceil(tf / dt) + 1;

  // initialize grid
  grid_init(&gr, dx, dy, dt, nx, ny, h);

  // open file
  FILE *fp;
  if ((fp = fopen("data/grid.txt", "w")) == NULL) {
    printf("Cannot open the file.\n");
    return 1;
  }

  double w = 1.7, TOL = 1e-10;
  int maxit = 200;

  // compute the solution
  clock_t t_init = clock();
  write_grid(&gr, fp);
  for (int i = 1; i < nt; i++) {
    fprintf(fp, "\n");  // To avoid gnuplot detecting an extra datablock.
    CrankNicolsonStep(&gr, w, TOL, maxit, f, g);
    write_grid(&gr, fp);
  }

  clock_t t_end = clock();

  printf("Time employed: %lf\n", ((double)(t_end - t_init)) / CLOCKS_PER_SEC);
  fclose(fp);
  return 0;
}
