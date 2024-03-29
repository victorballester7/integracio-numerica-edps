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
  grid_init(&gr, dx, dy, dt, nx, ny, h_pol);

  // open file
  FILE *fp;
  if ((fp = fopen("data/grid.txt", "w")) == NULL) {
    printf("Cannot open the file.\n");
    return 1;
  }

  double w = 1.7, TOL = 1e-6;
  int maxit = 20;

  // compute the solution
  write_grid(&gr, fp);
  for (int i = 1; i < nt; i++) {
    fprintf(fp, "\n");  // To avoid gnuplot detecting an extra datablock.
    CrankNicolsonStep(&gr, w, TOL, maxit, f_pol, g_pol);
    write_grid(&gr, fp);
  }

  // Exercice 4 (measuring the error with polynomial functions)
  double errorLoo = 0;
  for (int i = 0; i < gr.nx + 1; i++) {
    for (int j = 0; j < gr.ny + 1; j++)
      errorLoo = MAX(errorLoo, fabs(gr.u[j * (gr.nx + 1) + i] - g_pol(gr.t, i * gr.dx, j * gr.dy)));
  }
  printf("\nError in norm Loo: %g\n\n", errorLoo);
  printf("We see that the error is small but not 0.\n");

  free_grid(&gr);
  fclose(fp);
  return 0;
}
